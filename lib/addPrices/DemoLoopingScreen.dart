import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:keemat_controller/Provider/ChangedPrices.dart';
import 'package:keemat_controller/addPrices/updatePrices.dart';
import 'package:keemat_controller/const/const.dart';
import 'package:keemat_controller/const/dbHelpers.dart';
import 'package:keemat_controller/const/decoration.dart';
import 'package:keemat_controller/const/fuelModal.dart';
import 'package:keemat_controller/const/modals.dart';
import 'package:keemat_controller/main.dart';
import 'package:keemat_controller/places/placeLogics.dart';
import 'package:keemat_controller/places/places.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:percent_indicator/linear_percent_indicator.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class DemoLoopingScreen extends StatefulWidget {
  @override
  _DemoLoopingScreenState createState() => _DemoLoopingScreenState();
}

class _DemoLoopingScreenState extends State<DemoLoopingScreen> {
  List<Petrol> _petrolData = new List();
  List<Diesel> _dieselData = new List();
  List<Gold> _goldData = new List();
  List<Silver> _silverData = new List();
  List<LPG> _lpgData = new List();
  List<StateData> _stateData = new List<StateData>();
  String _city = '';
  String _cityCode = '';
  int _stateCounter = 0; 
  int _cityCounter = 1;
  bool _showUpdateButton = false;
  double _goldPrice = 0;
  double _silverPrice = 0;

  //changes
  List<FuelModel> _changedFuelPrices = new List();
  double _changedGoldPrice = 0.0;
  double _changedSilverPrice = 0.0;
  double _changedLpgPrice = 0.0;

  @override
  void initState() {
    _callOnInit();
    super.initState();
  }

  _callOnInit() async {
    await _clearScreenForLooping().then((value) {
      if (_stateCounter == 0) { 
        final provider = Provider.of<ChangedPrices>(context, listen: false);
        setState(() {
          _changedFuelPrices = provider.getFuelChanges;
          _changedGoldPrice = provider.getGoldPrice;
          _changedSilverPrice = provider.getSilverPrice;
          _changedLpgPrice = provider.getLpgPrice;
        });
        print('fetched provider values');
      }
    }).then((value) {
      _fetchDB();
    });
  }

  Future<void> _clearScreenForLooping() async {
    setState(() {
      _cityCounter = 1;
      _city = statesSwitch(stateOptions[_stateCounter].code)[0].city;
      _cityCode = statesSwitch(stateOptions[_stateCounter].code)[0].code;
      _petrolData.clear();
      _dieselData.clear();
      _goldData.clear();
      _silverData.clear();
      _lpgData.clear();
      _stateData.clear();
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: Scaffold(
        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
        appBar: AppBar(
          title: txtHeading('State Loop Updater', 20,
              Theme.of(context).highlightColor, FontWeight.bold),
          leading: Visibility(
            visible: _showUpdateButton,
            child: BackButton(
              onPressed: () {
                //TODO
              },
            ),
          ),
          automaticallyImplyLeading: false,
        ),
        body: Container(
          height: mediaHeight(0.9, context),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            child: Column(
              children: <Widget>[
                Container(
                  width: double.infinity,
                  decoration: boxColored(context),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 15),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: mediaWidth(0.7, context),
                          child: txtHeading(
                              stateOptions[_stateCounter].state,
                              15,
                              Theme.of(context).highlightColor.withOpacity(0.7),
                              FontWeight.w800),
                        ),
                        Spacer(),
                        txtHeading(stateOptions[_stateCounter].code, 15,
                            Theme.of(context).indicatorColor, FontWeight.w500),
                      ],
                    ),
                  ),
                ),
                sizedHeight(15),
                Row(
                  children: <Widget>[
                    decoPriceDisplayer(
                        'Gold',
                        _changedGoldPrice.toStringAsFixed(2),
                        yellowColor,
                        context),
                    Spacer(),
                    decoPriceDisplayer('Silver', _changedSilverPrice.toString(),
                        Colors.cyanAccent, context)
                  ],
                ),
                sizedHeight(10),
                Row(
                  children: <Widget>[
                    decoPriceDisplayer(
                        'Petrol',
                        _changedFuelPrices[_stateCounter]
                            .petrol
                            .toStringAsFixed(2),
                        Colors.lightGreenAccent,
                        context),
                    Spacer(),
                    decoPriceDisplayer(
                        'Diesel',
                        _changedFuelPrices[_stateCounter]
                            .diesel
                            .toStringAsFixed(2),
                        Colors.lightBlueAccent,
                        context)
                  ],
                ),
                Spacer(),
                CircularPercentIndicator(
                  radius: mediaWidth(0.6, context),
                  animation: true,
                  animationDuration: 1000,
                  curve: Curves.easeIn,
                  progressColor: greenColor,
                  backgroundColor:
                      Theme.of(context).indicatorColor.withOpacity(0.2),
                  percent: (_cityCounter == 1)
                      ? 0
                      : ((_cityCounter) /
                          statesSwitch(stateOptions[_stateCounter].code)
                              .length),
                  animateFromLastPercent: true,
                  center: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      sizedHeight(30),
                      txtHeading(
                          (((_cityCounter == 1)
                                          ? 0
                                          : (_cityCounter) /
                                              statesSwitch(stateOptions[
                                                          _stateCounter]
                                                      .code)
                                                  .length) *
                                      100)
                                  .toStringAsFixed(0) +
                              '%',
                          25,
                          Theme.of(context).highlightColor,
                          FontWeight.w500),
                      sizedHeight(20),
                      txtHeading(
                          "$_cityCounter / ${statesSwitch(stateOptions[_stateCounter].code).length}",
                          12,
                          Theme.of(context).indicatorColor,
                          FontWeight.w500),
                    ],
                  ),
                ),
                Spacer(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Future<bool> onpopScope() {
    return Future.value(false);
  }

  _fetchDB() {
    FirebaseFirestore.instance
        .collection('Prices')
        .doc('State')
        .collection('${stateOptions[_stateCounter].code}')
        .doc('$_cityCode')
        .get()
        .then((qrysnap) {
      Petrol petrolData = new Petrol(
        list1Y: getPetrolPrices('Prices', qrysnap),
      );
      Diesel dieselData = new Diesel(
        list1Y: getDieselPrices('Prices', qrysnap),
      );
      Gold goldData = new Gold(
        list1Y: getGoldPrices('Prices', qrysnap),
      );
      Silver silverData = new Silver(
        list1Y: getSilverPrices('Prices', qrysnap),
      );
      LPG lpgData = new LPG(
        list1Y: getLPGPrices('Prices', qrysnap),
      );
      setState(() {
        _petrolData.add(petrolData);
        _dieselData.add(dieselData);
        _goldData.add(goldData);
        _silverData.add(silverData);
        _lpgData.add(lpgData);
      });
    }).then((value) {
      _petrolData[0].list1Y.sort((a, b) => a.date.compareTo(b.date));
      _dieselData[0].list1Y.sort((a, b) => a.date.compareTo(b.date));
      _goldData[0].list1Y.sort((a, b) => a.date.compareTo(b.date));
      _silverData[0].list1Y.sort((a, b) => a.date.compareTo(b.date));
      _lpgData[0].list1Y.sort((a, b) => a.date.compareTo(b.date));
    }).then((value) {
      _addToDB();
    });
  }

  _addToDB() {
    List localList = [];
    double petrolPrice =
        _petrolData[0].list1Y[_petrolData[0].list1Y.length - 1].price +
            _changedFuelPrices[_stateCounter].petrol;
    double dieselPrice =
        _dieselData[0].list1Y[_dieselData[0].list1Y.length - 1].price +
            _changedFuelPrices[_stateCounter].petrol;
    double lpgPrice = _lpgData[0].list1Y[_lpgData[0].list1Y.length - 1].price +
        _changedLpgPrice;
    double goldPrice =
        _goldData[0].list1Y[_goldData[0].list1Y.length - 1].price +
            _changedGoldPrice;
    double silverPrice =
        _silverData[0].list1Y[_silverData[0].list1Y.length - 1].price +
            _changedSilverPrice;
    var date = DateTime(
            _silverData[0].list1Y[_silverData[0].list1Y.length - 1].date.year,
            _silverData[0].list1Y[_silverData[0].list1Y.length - 1].date.month,
            _silverData[0].list1Y[_silverData[0].list1Y.length - 1].date.day)
        .add(Duration(days: 1));
    for (int i = 0; i < 1; i++) {
      localList.add({
        'Date': date,
        'Petrol': petrolPrice,
        'Diesel': dieselPrice,
        'Gold': goldPrice,
        'Silver': silverPrice,
        'LPG': lpgPrice,
      });
    }
    FirebaseFirestore.instance
        .collection('Prices')
        .doc('State')
        .collection('${stateOptions[_stateCounter].code}')
        .doc('$_cityCode')
        .set(
      {
        'Prices': FieldValue.arrayUnion(localList),
      },
      SetOptions(merge: true),
    ).then((value) {
      _addToLocalList(petrolPrice, dieselPrice);
    });
  }

  _addToLocalList(double petrol, double diesel) async {
    setState(() {
      _stateData.add(StateData(
        city: _city,
        code: _cityCode,
        diesel: diesel,
        petrol: petrol,
      ));
    });
    if (_cityCounter == 1) {
      setState(() {
        _goldPrice = _goldData[0].list1Y[_goldData[0].list1Y.length - 1].price +
            _changedGoldPrice;
        _silverPrice =
            _silverData[0].list1Y[_silverData[0].list1Y.length - 1].price +
                _changedSilverPrice;
      });
    }
    await Future.delayed(Duration(milliseconds: 200), () {
      _removeFromDB();
    });
  }

  _removeFromDB() {
    List localList = [];
    double petrol = _petrolData[0].list1Y[0].price;
    double diesel = _dieselData[0].list1Y[0].price;
    double gold = double.parse(_goldData[0].list1Y[0].price.toStringAsFixed(0));
    double silver =
        double.parse(_silverData[0].list1Y[0].price.toStringAsFixed(0));
    double lpg = double.parse(_lpgData[0].list1Y[0].price.toStringAsFixed(0));
    var date = DateTime(_petrolData[0].list1Y[0].date.year,
        _petrolData[0].list1Y[0].date.month, _petrolData[0].list1Y[0].date.day);

    for (int i = 0; i < 1; i++) {
      localList.add({
        'Date': date,
        'Petrol': petrol,
        'Diesel': diesel,
        'Gold': gold,
        'Silver': silver,
        'LPG': lpg,
      });
    }
    FirebaseFirestore.instance
        .collection('Prices')
        .doc('State')
        .collection('${stateOptions[_stateCounter].code}')
        .doc('$_cityCode')
        .set(
      {
        'Prices': FieldValue.arrayRemove(localList),
        'Log': DateTime.now(),
      },
      SetOptions(merge: true),
    ).then((value) {
      _resetSettings();
    });
  }

  _resetSettings() {
    if (_cityCounter != statesSwitch(stateOptions[_stateCounter].code).length) {
      setState(() {
        _cityCounter++;
        _dieselData.clear();
        _petrolData.clear();
        _lpgData.clear();
        _goldData.clear();
        _silverData.clear();
        _cityCode =
            statesSwitch(stateOptions[_stateCounter].code)[_cityCounter - 1]
                .code;
        _city = statesSwitch(stateOptions[_stateCounter].code)[_cityCounter - 1]
            .city;
        Future.delayed(Duration(milliseconds: 500), () {
          _fetchDB();
        });
      });
    } else {
      _uploadStateData();
      print('all cities done');
    }
  }

  _uploadStateData() {
    List localList = [];
    for (int i = 0; i < _stateData.length; i++) {
      localList.add({
        'City': _stateData[i].city,
        'Code': _stateData[i].code,
        'Petrol': double.parse(_stateData[i].petrol.toStringAsFixed(2)),
        'Diesel': double.parse(_stateData[i].diesel.toStringAsFixed(2)),
      });
    }
    FirebaseFirestore.instance
        .collection('Compare')
        .doc('Data')
        .collection('States')
        .doc('${stateOptions[_stateCounter].code}')
        .set(
      {
        'Prices': FieldValue.arrayUnion(localList),
        'Gold': _goldPrice,
        'Silver': _silverPrice,
        'State': '${stateOptions[_stateCounter].state}',
        'Code': '${stateOptions[_stateCounter].code}',
        'Log': DateTime.now(),
      },
      SetOptions(merge: false),
    ).then((value) {
      print('state data uploaded');
      if (_stateCounter == (stateOptions.length - 1)) {
        print('last state');
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (_) => MyHomePage()));
      } else {
        //_nextState();
        _navigateBack();
      }
    });
  }

  _navigateBack() {
    setState(() {
      _stateCounter++;
    });
    _callOnInit();
  }

  _nextState() {
    return showMaterialModalBottomSheet(
      context: context,
      isDismissible: false,
      backgroundColor:
          Theme.of(context).scaffoldBackgroundColor.withOpacity(0.7),
      builder: (context) => Container(
        decoration: BoxDecoration(
          color: Theme.of(context).backgroundColor,
          boxShadow: [
            BoxShadow(
              color: Colors.black26.withOpacity(0.5),
              blurRadius: 12,
              offset: Offset(0, 4),
            )
          ],
        ),
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              Container(
                width: mediaWidth(0.9, context),
                child: txtHeading(
                    '${stateOptions[_stateCounter].state} Updated',
                    20,
                    Theme.of(context).highlightColor,
                    FontWeight.bold),
              ),
              sizedHeight(5),
              Container(
                width: mediaWidth(0.9, context),
                child: txtHeading(
                    'All the cities were updated successfully along with the state compared prices Index.',
                    10,
                    Theme.of(context).indicatorColor,
                    FontWeight.w500),
              ),
              sizedHeight(35),
              Row(
                children: <Widget>[
                  Spacer(),
                  GestureDetector(
                    onTap: () {
                      //Navigator.pop(context);
                      _navigateBack();
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Theme.of(context).accentColor,
                      ),
                      child: Padding(
                        padding:
                            EdgeInsets.symmetric(horizontal: 12, vertical: 12),
                        child: Center(
                          child: txtHeading('Next State', 13,
                              Colors.black26.withOpacity(0.4), FontWeight.w700),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
