import 'package:flutter/material.dart';
import 'package:keemat_controller/Provider/ChangedPrices.dart';
import 'package:keemat_controller/addPrices/DemoLoopingScreen.dart';
import 'package:keemat_controller/const/const.dart';
import 'package:keemat_controller/places/places.dart';
import 'package:provider/provider.dart';

class DemoResultScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<ChangedPrices>(context);
    return Scaffold(
      floatingActionButton: FloatingActionButton(onPressed: (){
      Navigator.push(context, MaterialPageRoute(builder: (_)=> DemoLoopingScreen()));
      },),
        body: SafeArea(
      child: ListView.builder(
          padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
          itemCount: stateOptions.length,
          scrollDirection: Axis.vertical,
          shrinkWrap: true,
          itemBuilder: (BuildContext context, int index) {
            return Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  txtAlphabet(stateOptions[index].state, 20, Colors.blue,
                      FontWeight.bold),
                  txtAlphabet(
                      'Petrol : ${provider.getFuelChanges[index].petrol.toStringAsFixed(2)}',
                      15,
                      Colors.red,
                      FontWeight.w600),
                  txtAlphabet(
                      'Diesel : ${provider.getFuelChanges[index].diesel.toStringAsFixed(2)}',
                      15,
                      Colors.red,
                      FontWeight.w600),
                  txtAlphabet(
                      'Gold : ${provider.getGoldPrice.toStringAsFixed(2)}',
                      15,
                      Colors.red,
                      FontWeight.w600),
                  Divider(),
                ],
              ),
            );
          }),
    ));
  }
}
