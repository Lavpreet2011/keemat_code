import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:keemat_controller/Provider/changeTheme.dart';
import 'package:keemat_controller/const/const.dart';
import 'package:keemat_controller/const/dbHelpers.dart';
import 'package:keemat_controller/const/fuelModal.dart';
import 'package:keemat_controller/const/modals.dart';
import 'package:keemat_controller/navigators/allNavigations.dart';
import 'package:keemat_controller/places/places.dart';

class IndiaPricer extends StatefulWidget {
  @override
  _IndiaPricerState createState() => _IndiaPricerState();
}

class _IndiaPricerState extends State<IndiaPricer> {
  List<IndiaSetter> _pricesIndia = new List();
  List<MinMaxPetrol> _petrolData = new List();
  List<MinMaxDiesel> _dieselData = new List();
  int _stateCounter = 0;
  String _stateCode = '';

  @override
  void initState() {
    setState(() {
      _stateCode = stateOptions[_stateCounter].code;
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: appBar(),
      floatingActionButton: floatingActionButton(),
      body: SingleChildScrollView(
        child: Container(
          child: ListView.builder(
              itemCount: _pricesIndia.length,
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              physics: NeverScrollableScrollPhysics(),
              itemBuilder: (BuildContext context, int index) {
                return Container(
                  child: Column(
                    children: <Widget>[
                      Row(
                        children: <Widget>[
                          txtHeading(_pricesIndia[index].state, 14,
                              Theme.of(context).highlightColor, FontWeight.w700)
                        ],
                      ),
                      txtHeading(
                          'Min Petrol : ${_pricesIndia[index].minPetrol}',
                          12,
                          Theme.of(context).highlightColor,
                          FontWeight.w700),
                      txtHeading(
                          'Max Petrol : ${_pricesIndia[index].maxPetrol}',
                          12,
                          Theme.of(context).highlightColor,
                          FontWeight.w700),
                      txtHeading(
                          'Min Diesel : ${_pricesIndia[index].minDiesel}',
                          12,
                          Theme.of(context).highlightColor,
                          FontWeight.w700),
                      txtHeading(
                          'Max Diesel : ${_pricesIndia[index].maxDiesel}',
                          12,
                          Theme.of(context).highlightColor,
                          FontWeight.w700)
                    ],
                  ),
                );
              }),
        ),
      ),
    );
  }

  _fetchData() {
    double goldPrice = 0;
    double silverPrice = 0;
    String state = '';
    FirebaseFirestore.instance
        .collection('Compare')
        .doc('Data')
        .collection('States')
        .doc('$_stateCode')
        .get()
        .then((qrysnap) {
      MinMaxPetrol petrolData = new MinMaxPetrol(
        minMax: getminMaxPetrol('Prices', qrysnap),
      );
      MinMaxDiesel dieselData = new MinMaxDiesel(
        minMax: getminMaxDiesel('Prices', qrysnap),
      );
      goldPrice = qrysnap.data()['Gold'];
      silverPrice = qrysnap.data()['Silver'];
      state = qrysnap.data()['State'];
      setState(() {
        _petrolData.add(petrolData);
        _dieselData.add(dieselData);
      });
    }).then((value) {
      _petrolData[0].minMax.sort((a, b) => a.price.compareTo(b.price));
      _dieselData[0].minMax.sort((a, b) => a.price.compareTo(b.price));
    }).then((value) {
      print(_petrolData[0].minMax[0].price);
      setState(() {
        _pricesIndia.add(new IndiaSetter(
          stateCode: _stateCode,
          state: state,
          gold: goldPrice,
          silver: silverPrice,
          minPetrol: _petrolData[0].minMax[0].price,
          maxPetrol:
              _petrolData[0].minMax[_petrolData[0].minMax.length - 1].price,
          minDiesel: _dieselData[0].minMax[0].price,
          maxDiesel:
              _dieselData[0].minMax[_dieselData[0].minMax.length - 1].price,
        ));
      });
    }).then((value) {
      print('max price' + _pricesIndia[0].minPetrol.toString());
      _clearAndCheck();
    });
  }

  _clearAndCheck() async {
    if (_stateCounter != stateOptions.length - 1) {
      setState(() {
        _petrolData.clear();
        _dieselData.clear();
        _stateCounter++;
      });
      await Future.delayed(Duration(milliseconds: 200), () {
        _stateCode = stateOptions[_stateCounter].code;
        Future.delayed(Duration(milliseconds: 200), () {
          _fetchData();
        });
      });
    } else {
      print('proceeding to make list');
      _makeUploadList();
    }
  }

  _makeUploadList() {
    List localList = [];
    for (int i = 0; i < _pricesIndia.length; i++) {
      localList.add({
        'State': _pricesIndia[i].state,
        'Code': _pricesIndia[i].stateCode,
        'Gold': _pricesIndia[i].gold,
        'Silver': _pricesIndia[i].silver,
        'PetrolMin': _pricesIndia[i].minPetrol,
        'PetrolMax': _pricesIndia[i].maxPetrol,
        'DieselMin': _pricesIndia[i].minDiesel,
        'DieselMax': _pricesIndia[i].maxDiesel,
      });
      if (i == _pricesIndia.length - 1) {
        print('adding list');
        _addToDb(localList);
      }
    }
  }

  _addToDb(List localList) {
    FirebaseFirestore.instance.collection('Compare').doc('IND').set(
      {
        'Prices': FieldValue.arrayUnion(localList),
        'Log': DateTime.now(),
      },
      SetOptions(merge: false),
    ).then((value) {
      print('data uploaded of india');
    });
  }

  FloatingActionButton floatingActionButton() {
    return FloatingActionButton.extended(
      onPressed: () {
        _fetchData();
      },
      backgroundColor: Theme.of(context).accentColor,
      label: txtHeading(
          'Fetch Data', 14, Colors.black26.withOpacity(0.35), FontWeight.w700),
    );
  }

  AppBar appBar() {
    return AppBar(
      automaticallyImplyLeading: false,
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      elevation: 0,
      titleSpacing: 10,
      leading: BackButton(
        color: Theme.of(context).highlightColor,
        onPressed: (){
          toHome(context);
        },
      ),
      title: txtHeading(
          'India Pricer', 16, Theme.of(context).accentColor, FontWeight.w600),
      actions: <Widget>[
        Row(
          children: <Widget>[
            ChangeThemeButton(),
            sizedWidth(15),
          ],
        ),
      ],
    );
  }
}
