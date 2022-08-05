import 'package:flutter/material.dart';
import 'package:keemat_controller/addPrices/DemoCheckScreen.dart';
import 'package:keemat_controller/addPrices/addMoreDays.dart';
import 'package:keemat_controller/addPrices/indiaPricer.dart';
import 'package:keemat_controller/addPrices/updatePrices.dart';
import 'package:keemat_controller/logDisplayer/cityLog.dart';
import 'package:keemat_controller/main.dart';

toStatePriceSetter(BuildContext context) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => UpdatePrices(
                stateIndex: 0,
                goldText: '0',
                silverText: '0',
                dieselText: '0',
                lpgText: '0',
                petrolText: '0',
                silverChanged: false,
                petrolChanged: false,
                lpgChanged: false,
                goldChanged: false,
                dieselChanged: false,
              )));
}

toIndiaPriceSetter(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => IndiaPricer()));
}

toAddMoreDays(BuildContext context) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => AddMoreDays(
                state: 'Andaman Nicobar Islands',
                stateCode: 'AN',
                stateIndex: 0,
              )));
}

toHome(BuildContext context) {
  Navigator.push(context, MaterialPageRoute(builder: (_) => MyHomePage()));
}

demoScreen(BuildContext context) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => DemoCheckScreen(
               
              )));
}

logScreen(BuildContext context) {
  Navigator.push(
      context,
      MaterialPageRoute(
          builder: (_) => CityLog(
               
              )));
}
