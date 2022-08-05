import 'dart:convert';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:keemat_controller/const/const.dart';
import 'package:keemat_controller/const/decoration.dart';
import 'package:keemat_controller/const/modals.dart';
import 'package:keemat_controller/places/placeLogics.dart';
import 'package:keemat_controller/places/places.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class AddPrices extends StatefulWidget {
  @override
  _AddPricesState createState() => _AddPricesState();
}

class _AddPricesState extends State<AddPrices> {
  List<Prices> pricesFromApi = new List<Prices>();
  String _state = '';
  String _stateCode = '';
  String _city = '';
  String _cityCode = '';
  int _cityCounter = 1;
  bool _settingData = false;

  @override
  void initState() {
    _state = stateOptions[0].state;
    _stateCode = stateOptions[0].code;
    _city = anCities[0].city;
    _cityCode = anCities[0].code;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: txtHeading('Add to Database', 25,
            Theme.of(context).highlightColor, FontWeight.bold),
      ),
      floatingActionButton: Visibility(
        visible: !_settingData,
        child: FloatingActionButton.extended(
          onPressed: () {
            setState(() {
              _settingData = true;
            });
            getApiData();
          },
          label: txtHeading(
              'Get Data', 14, Theme.of(context).highlightColor, FontWeight.w800),
          backgroundColor: Theme.of(context).accentColor,
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: AnimatedSwitcher(
            duration: Duration(milliseconds: 100),
            child: _settingData
                ? Center(
                    child: CircularProgressIndicator(),
                  )
                : Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 25),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        txtHeading('State', 12,
                            Theme.of(context).indicatorColor, FontWeight.w500),
                        sizedHeight(7),
                        GestureDetector(
                          onTap: () {
                            _stateOptionsDialog();
                          },
                          child: Container(
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
                                        _state,
                                        15,
                                        Theme.of(context)
                                            .highlightColor
                                            .withOpacity(0.7),
                                        FontWeight.w800),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Theme.of(context)
                                        .highlightColor
                                        .withOpacity(0.7),
                                    size: 19,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        sizedHeight(25),
                        txtHeading('City', 12, Theme.of(context).indicatorColor,
                            FontWeight.w500),
                        sizedHeight(7),
                        GestureDetector(
                          onTap: () {
                            _cityOptionsDialog();
                          },
                          child: Container(
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
                                        _city,
                                        15,
                                        Theme.of(context)
                                            .highlightColor
                                            .withOpacity(0.7),
                                        FontWeight.w800),
                                  ),
                                  Spacer(),
                                  Icon(
                                    Icons.keyboard_arrow_down,
                                    color: Theme.of(context)
                                        .highlightColor
                                        .withOpacity(0.7),
                                    size: 19,
                                  )
                                ],
                              ),
                            ),
                          ),
                        ),
                        sizedHeight(20),
                        Row(
                          children: <Widget>[
                            Column(
                              children: <Widget>[
                                txtHeading(
                                    'City Count',
                                    12,
                                    Theme.of(context).indicatorColor,
                                    FontWeight.w500),
                                sizedHeight(7),
                                txtHeading(
                                    '$_cityCounter / ${statesSwitch(_stateCode).length}',
                                    14,
                                    Theme.of(context)
                                        .highlightColor
                                        .withOpacity(0.7),
                                    FontWeight.w800)
                              ],
                            ),
                            Spacer(),
                            Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                txtHeading(
                                    'Completed',
                                    12,
                                    Theme.of(context).indicatorColor,
                                    FontWeight.w500),
                                sizedHeight(7),
                                txtHeading(
                                    ((_cityCounter - 1) /
                                                (statesSwitch(_stateCode)
                                                    .length) *
                                                100)
                                            .toStringAsFixed(1) +
                                        '%',
                                    14,
                                    Theme.of(context)
                                        .highlightColor
                                        .withOpacity(0.7),
                                    FontWeight.w800)
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
          ),
        ),
      ),
    );
  }

  _incCounter() {
    if (_cityCounter == statesSwitch(_stateCode).length) {
      print('its the last city of the state');
    } else {
      setState(() {
        _cityCounter++;
        _city = statesSwitch(_stateCode)[_cityCounter - 1].city;
        _cityCode = statesSwitch(_stateCode)[_cityCounter - 1].code;
      });
    }
    setState(() {
      _settingData = false;
      pricesFromApi.clear();
    });
  }

  _addToDB() {
    List localList = [];
    for (int i = 0; i < 370; i++) {
      localList.add({
        'Date': DateTime(
                DateTime.now().year, DateTime.now().month, DateTime.now().day)
            .subtract(Duration(days: i + 1)),
        'Petrol': double.parse(pricesFromApi[i].petrol.toStringAsFixed(2)),
        'Diesel': double.parse(pricesFromApi[i].diesel.toStringAsFixed(2)),
        'Gold': double.parse(pricesFromApi[i].gold.toStringAsFixed(0)),
        'Silver': double.parse(pricesFromApi[i].silver.toStringAsFixed(0)),
        'LPG': double.parse(pricesFromApi[i].lpg.toStringAsFixed(0)),
      });
    }
    FirebaseFirestore.instance
        .collection('Prices')
        .doc('State')
        .collection('$_stateCode')
        .doc('$_cityCode')
        .set(
      {
        'Prices': FieldValue.arrayUnion(localList),
        'State': '$_state',
        'City': '$_city',
        'Code': '$_cityCode',
        'Log': DateTime.now(),
      },
      SetOptions(merge: true),
    ).then((value) {
      print('added');
      _incCounter();
    });
  }

  void getApiData() async {
    PricesApi.getPrices().then((response) {
      setState(() {
        final parsed = json.decode(response.body).cast<Map<String, dynamic>>();
        pricesFromApi =
            parsed.map<Prices>((json) => Prices.fromMap(json)).toList();
        Future.delayed(Duration(seconds: 2), () {
          print('adding to db now');
          setState(() {
            _addToDB();
          });
        });
      });
    });
  }

  _stateOptionsDialog() {
    return showMaterialModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).backgroundColor.withOpacity(0.3),
      builder: (context) => Container(
        height: mediaHeight(0.8, context),
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            sizedHeight(15),
            Row(
              children: <Widget>[
                sizedWidth(15),
                txtHeading('Select a State/UT', 18,
                    Theme.of(context).highlightColor, FontWeight.bold),
                Spacer(),
              ],
            ),
            sizedHeight(15),
            seperationLine(),
            Flexible(
              child: Container(
                width: double.infinity,
                child: ListView.builder(
                    itemCount: stateOptions.length,
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.zero,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            _state = stateOptions[index].state;
                            _stateCode = stateOptions[index].code;
                            _cityCounter = 1;
                            _city =
                                statesSwitch(stateOptions[index].code)[0].city;
                            _cityCode =
                                statesSwitch(stateOptions[index].code)[0].code;
                          });
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 20),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: mediaWidth(0.8, context),
                                child: txtHeading(
                                    stateOptions[index].state,
                                    15,
                                    Theme.of(context).indicatorColor,
                                    FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }

  _cityOptionsDialog() {
    return showMaterialModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).backgroundColor.withOpacity(0.3),
      builder: (context) => Container(
        height: mediaHeight(0.8, context),
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            sizedHeight(15),
            Row(
              children: <Widget>[
                sizedWidth(15),
                txtHeading('Select a City/Town', 18,
                    Theme.of(context).highlightColor, FontWeight.bold),
                Spacer(),
              ],
            ),
            sizedHeight(15),
            seperationLine(),
            Flexible(
              child: Container(
                width: double.infinity,
                child: ListView.builder(
                    itemCount: statesSwitch(_stateCode).length,
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.zero,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            _city = statesSwitch(_stateCode)[index].city;
                            _cityCode = statesSwitch(_stateCode)[index].code;
                          });
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 20),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: mediaWidth(0.8, context),
                                child: txtHeading(
                                    statesSwitch(_stateCode)[index].city,
                                    15,
                                    Theme.of(context).indicatorColor,
                                    FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}

class PricesApi {
  static Future getPrices() {
    return http.get(
        'https://script.google.com/macros/s/AKfycbzWHGwWCWOMaU9d9tak_wQq6WJkMzJiLpUOQjAFUSk_hxYnTfEBoX4OZhclG93kyqnG/exec');
  }
}
