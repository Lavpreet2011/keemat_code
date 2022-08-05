import 'dart:ui';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:keemat_controller/const/const.dart';

final numFormat = new NumberFormat("#,##0", "en_US");

previewAmount(String txt, double value, bool format, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
    child: Row(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            txtHeading(
                '$txt',
                13,
                Theme.of(context).highlightColor.withOpacity(0.6),
                FontWeight.w500),
          ],
        ),
        Spacer(),
        txtNumber(
            '₹ ' +
                (format ? numFormat.format(value) : value.toStringAsFixed(2)),
            14,
            Theme.of(context).highlightColor,
            FontWeight.w600),
      ],
    ),
  );
}

previewSuffix(String txt, String suffix, double value, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
    child: Row(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            txtHeading(
                "$txt",
                13,
                Theme.of(context).highlightColor.withOpacity(0.6),
                FontWeight.w500),
          ],
        ),
        Spacer(),
        Text.rich(TextSpan(
            text: value.toStringAsFixed(1),
            style: txtStyleNumber(
                14, Theme.of(context).highlightColor, FontWeight.w600),
            children: <InlineSpan>[
              TextSpan(
                text: ' $suffix',
                style: txtStyleNumber(
                    14, Theme.of(context).highlightColor, FontWeight.w100),
              )
            ])),
      ],
    ),
  );
}

previewSuffixFormatted(
    String txt, String suffix, double value, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
    child: Row(
      children: <Widget>[
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            txtHeading(
                "$txt",
                13,
                Theme.of(context).highlightColor.withOpacity(0.6),
                FontWeight.w500),
          ],
        ),
        Spacer(),
        Text.rich(TextSpan(
            text: numFormat.format(value),
            style: txtStyleNumber(
                14, Theme.of(context).highlightColor, FontWeight.w600),
            children: <InlineSpan>[
              TextSpan(
                text: ' $suffix',
                style: txtStyleNumber(
                    14, Theme.of(context).highlightColor, FontWeight.w100),
              )
            ])),
      ],
    ),
  );
}

tipBox(String title, String subtitle, Color color, BuildContext context) {
  return ClipRRect(
    borderRadius: BorderRadius.circular(5),
    child: BackdropFilter(
      filter: new ImageFilter.blur(
        sigmaX: 60.0,
        sigmaY: 60.0,
      ),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(5),
          color: color.withOpacity(0.2),
        ),
        child: Padding(
          padding: const EdgeInsets.all(12.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              txtAlphabet('$title', 14, color, FontWeight.w600),
              sizedHeight(3),
              txtNumber(
                  '$subtitle', 10, color.withOpacity(0.75), FontWeight.w400)
            ],
          ),
        ),
      ),
    ),
  );
}

calOptTxt(String txt, String subtxt, BuildContext context, Function() fun) {
  return InkWell(
    onTap: fun,
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
      child: Row(
        children: <Widget>[
          Container(
            width: 35,
              child: Center(
                  child: Image.asset(
            'assets/images/${imgCalOptCases(txt)}.png',
            color: Theme.of(context).accentColor,
            height: 25,
            fit: BoxFit.fitHeight,
          ))),
          sizedWidth(15),
          Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              txtHeading(
                  '$txt'.tr,
                  14,
                  Theme.of(context).highlightColor.withOpacity(0.7),
                  FontWeight.bold),
              sizedHeight(3),
              Container(
                width:
                    mediaWidth(0.9, context) - 55,
                child: txtAlphabet('$subtxt', 9,
                    Theme.of(context).indicatorColor, FontWeight.w400),
              )
            ],
          ),
        ],
      ),
    ),
  );
}

imgCalOptCases(String op){
  switch (op){
    case 'Distance':
      return 'distance';
      break;
    case 'Fuel Expenses':
      return 'money';
      break;
    case 'Fuel Economy':
      return 'fuel';
      break;
  }
}

logicCalOpt(int index) {
  switch (index) {
    case 0:
      return 'Distance';
      break;
    case 1:
      return 'Fuel Expenses';
      break;
    case 2:
      return 'Fuel Economy';
      break;
  }
}
