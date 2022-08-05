import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:keemat_controller/const/const.dart';
import 'package:keemat_controller/const/decoration.dart';
import 'package:keemat_controller/places/placeLogics.dart';
import 'package:keemat_controller/places/places.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class CityLog extends StatefulWidget {
  @override
  State<CityLog> createState() => _CityLogState();
}

class _CityLogState extends State<CityLog> {
  bool _isDataLoaded = false;
  String _stateCode = '';
  String _state = '';
  List<LogModel> _logList = new List();

  @override
  void initState() {
    setState(() {
      _state = stateOptions[0].state;
      _stateCode = stateOptions[0].code;
      loadLogs();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 12),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              txtHeading(
                  'State', 12, Theme.of(context).indicatorColor, FontWeight.w500),
              sizedHeight(7),
              GestureDetector(
                onLongPress: () {
                  setState(() {
                    _isDataLoaded = false;
                    _logList.clear();
                  });
                  _stateOptionsDialog();
                },
                child: Container(
                  width: double.infinity,
                  decoration: boxColored(context),
                  child: Padding(
                    padding:
                        const EdgeInsets.symmetric( vertical: 15, horizontal: 12),
                    child: Row(
                      children: <Widget>[
                        Container(
                          width: mediaWidth(0.7, context),
                          child: txtHeading(
                              _state,
                              15,
                              Theme.of(context).highlightColor.withOpacity(0.7),
                              FontWeight.w800),
                        ),
                        Spacer(),
                        Icon(
                          Icons.keyboard_arrow_down,
                          color: Theme.of(context).highlightColor.withOpacity(0.7),
                          size: 19,
                        )
                      ],
                    ),
                  ),
                ),
              ),
              sizedHeight(25),
              Expanded(
                  child: _isDataLoaded
                      ? ListView.builder(
                        itemCount: _logList.length,
                        scrollDirection: Axis.vertical,
                        shrinkWrap: true,
                        padding: EdgeInsets.symmetric(vertical: 12),
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.only(bottom: 12),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: <Widget>[
                                txtAlphabet(_logList[index].city, 16,
                                    Theme.of(context).highlightColor, FontWeight.bold),
                                txtAlphabet(dateFormatFullYear(_logList[index].date) + ' @ ' + timeFormat(_logList[index].date), 13,
                                    Theme.of(context).indicatorColor, FontWeight.w500),
                                    txtAlphabet( _logList[index].code + ' --- $index', 13,
                                    Theme.of(context).indicatorColor, FontWeight.w500),
                                    Divider(
                                      color:  Theme.of(context).highlightColor.withOpacity(0.25),
                                    ),
                              ],
                            ),
                          );
                        })
                      : Center(
                          child: CircularProgressIndicator(),
                        ))
            ],
          ),
        ),
      ),
    );
  }

  void loadLogs() {
    FirebaseFirestore.instance
        .collection('Prices')
        .doc('State')
        .collection('$_stateCode')
        .orderBy('Log', descending: true)
        .get()
        .then((qrysnap) {
      qrysnap.docs.forEach((docsnap) {
        setState(() {
          _logList.add(LogModel(
            city: docsnap.data()['City'],
            code: docsnap.data()['Code'],
            date: docsnap.data()['Log'].toDate(),
          ));
        });
      });
    }).then((value) {
      setState(() {
        _isDataLoaded = true;
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
                          });
                          loadLogs();
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
}

class LogModel {
  String city, code;
  dynamic date;

  LogModel({this.city, this.code, this.date});
}
