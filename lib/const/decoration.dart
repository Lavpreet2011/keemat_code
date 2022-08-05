import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:keemat_controller/const/const.dart';
import 'package:keemat_controller/const/designLogics.dart';
import 'package:keemat_controller/const/graphs.dart';
import 'package:keemat_controller/const/modals.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';

final numFormat = new NumberFormat("#,##0", "en_US");

boxColored(BuildContext context) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    color: Theme.of(context).backgroundColor,
    boxShadow: [
      BoxShadow(
        color: Theme.of(context).primaryColor,
        blurRadius: 12,
        spreadRadius: 1,
        offset: Offset(0, 4),
      ),
    ],
  );
}

boxBorderColored(double width, BuildContext context) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 7,
        offset: Offset(0, 3),
      ),
    ],
    border: Border.all(
        color: Theme.of(context).indicatorColor.withOpacity(0.2), width: width),
  );
}

boxBorder(double width, BuildContext context) {
  return BoxDecoration(
    borderRadius: BorderRadius.circular(10),
    border: Border.all(
        color: Theme.of(context).indicatorColor.withOpacity(0.2), width: width),
  );
}

boxRadiusOnlyBelow(BuildContext context) {
  return BoxDecoration(
    borderRadius: BorderRadius.only(
      bottomLeft: Radius.circular(10),
      bottomRight: Radius.circular(10),
    ),
    color: Theme.of(context).backgroundColor,
    boxShadow: [
      BoxShadow(
        color: Colors.black26,
        blurRadius: 7,
        offset: Offset(0, 10),
      ),
    ],
  );
}

heading(String txt, BuildContext context) {
  return Row(
    children: <Widget>[
      txtHeading('$txt', 17, Theme.of(context).highlightColor.withOpacity(0.7),
          FontWeight.bold),
      Spacer(),
    ],
  );
}

durationDesign(int selectedIndex, int index, String short, String long,
    bool lastIndex, Function() fun, BuildContext context) {
  return Flexible(
    flex: (selectedIndex == index) ? 2 : 1,
    child: GestureDetector(
      onTap: fun,
      child: Container(
        decoration: BoxDecoration(
          color: (selectedIndex == index)
              ? Theme.of(context).backgroundColor
              : Colors.transparent,
          border: Border(
            right: BorderSide(
                color: Theme.of(context).indicatorColor.withOpacity(0.2),
                width: lastIndex ? 0 : 1),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Center(
            child: txtAlphabet(
                (selectedIndex == index) ? long : short,
                12,
                (selectedIndex == index)
                    ? Theme.of(context).accentColor
                    : Theme.of(context).indicatorColor,
                FontWeight.w500),
          ),
        ),
      ),
    ),
  );
}

price(int index, double priceNow, double priceNext) {
  double priced = 0;
  priced = priceNow - priceNext;
  if (priced > 0) {
    return txtNumber(
        '+' + priced.toStringAsFixed(2), 10, redColor, FontWeight.w300);
  } else if (priced < 0) {
    return txtNumber(
        priced.toStringAsFixed(2), 10, greenColor, FontWeight.w300);
  } else {
    return txtNumber(
        priced.toStringAsFixed(1), 10, yellowColor, FontWeight.w500);
  }
}

yestedDayPriceBox(double price, double priceChange, BuildContext context) {
  return Container(
    decoration: boxBorderColored(1, context),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 20),
      child: Row(
        children: <Widget>[
          txtAlphabet("Yesterday's Price", 14,
              Theme.of(context).primaryColorLight, FontWeight.w400),
          Spacer(),
          Center(
            child: txtAlphabet(
                '₹ ' + yesterDayPrice(price, priceChange).toStringAsFixed(2),
                17,
                Theme.of(context).primaryColorLight,
                FontWeight.w400),
          )
        ],
      ),
    ),
  );
}

seperationLine() {
  return Container(
    height: 1,
    color: Colors.grey[600].withOpacity(0.2),
    width: double.infinity,
  );
}

seperationLineDark(BuildContext context) {
  return Container(
    height: 1,
    color: Theme.of(context).indicatorColor.withOpacity(0.2),
    width: double.infinity,
  );
}

mainPriceBox(List<Record> list, String txt, bool fuel, BuildContext context) {
  return Column(
    children: <Widget>[
      sizedHeight(10),
      Container(
        width: mediaWidth(0.95, context),
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  Column(
                    children: <Widget>[
                      sizedHeight(fuel ? 18 : 14),
                      txtNumber(
                          '₹',
                          25,
                          Theme.of(context).highlightColor.withOpacity(0.65),
                          FontWeight.w600),
                    ],
                  ),
                  sizedWidth(5),
                  Container(
                    width: mediaWidth(0.6, context),
                    child: FittedBox(
                      child: Text(
                          fuel
                              ? list[0].price.toStringAsFixed(2)
                              : numFormat.format(list[0].price),
                          style: GoogleFonts.cabin(
                              color: Theme.of(context).highlightColor,
                              fontWeight: FontWeight.bold)),
                    ),
                  ),
                ],
              ),
              Spacer(flex: 2),
              Column(
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: BackdropFilter(
                      filter: new ImageFilter.blur(
                        sigmaX: 40.0,
                        sigmaY: 40.0,
                      ),
                      child: Container(
                        decoration: BoxDecoration(
                          color: priceChangeBG(list[0].price - list[1].price)
                              .withOpacity(0.25),
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 7, vertical: 8),
                          child: Row(
                            children: <Widget>[
                              Lottie.asset(
                                'assets/lottie/${priceChangeImage(list[0].price - list[1].price)}.json',
                                height: 15,
                                fit: BoxFit.fitHeight,
                                animate: true,
                                repeat: true,
                              ),
                              sizedWidth(7),
                              txtNumber(
                                  fuel
                                      ? prefixSign(
                                          list[0].price - list[1].price)
                                      : prefixSignNonFuel(
                                          list[0].price - list[1].price),
                                  12,
                                  priceChangeBG(list[0].price - list[1].price),
                                  FontWeight.bold),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  sizedHeight(15),
                ],
              ),
              Spacer()
            ],
          ),
        ),
      ),
    ],
  );
}

titleRecentRevisions(bool showListView, BuildContext context, Function() fun) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.only(
        topRight: Radius.circular(10),
        topLeft: Radius.circular(10),
      ),
      color: Theme.of(context).backgroundColor,
    ),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 17),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              sizedWidth(10),
              txtAlphabet('Recent Price Revisions', 17,
                  Theme.of(context).primaryColorLight, FontWeight.w600),
              Spacer(),
              GestureDetector(
                onTap: fun,
                child: Container(
                  decoration: boxBorderColored(1, context),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Center(
                      child: Icon(
                        showListView ? Icons.insert_chart : Icons.list,
                        color: Theme.of(context).accentColor,
                        size: 17,
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ],
      ),
    ),
  );
}

priceDirInfo(String txt, Color color, BuildContext context) {
  return Row(
    mainAxisAlignment: MainAxisAlignment.center,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      Container(
        height: 7,
        width: 7,
        color: color,
      ),
      sizedWidth(5),
      txtAlphabet('$txt', 10, Theme.of(context).indicatorColor, FontWeight.w400)
    ],
  );
}

priceInfoBox(String txt, BuildContext context) {
  return Container(
    width: mediaWidth(0.95, context),
    child: Padding(
      padding: EdgeInsets.all(12),
      child: Text.rich(TextSpan(
        text: '$txt ',
        style: txtStyle(9, Theme.of(context).indicatorColor, FontWeight.w400),
        // children: <InlineSpan>[
        //   TextSpan(
        //     text: 'To know all depending factors click here'.tr,
        //     style: txtStyle(
        //         9, Theme.of(context).indicatorColor, FontWeight.w600),
        //   )
        // ]
      )),
    ),
  );
}

//to be edited
cheapExpensiveBox(List<Record> list, bool fuel, BuildContext context) {
  return Container(
    width: mediaWidth(0.95, context),
    decoration: boxBorder(1, context),
    child: Column(
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
          child: Row(
            children: <Widget>[
              Text.rich(
                TextSpan(
                  text: 'Expensive'.tr,
                  style: txtStyle(
                      12, Theme.of(context).indicatorColor, FontWeight.w500),
                  children: <InlineSpan>[
                    TextSpan(
                      text:
                          ': ${dateFormatFullYear(_setCheapExp(list)[list.length - 1].date)}',
                      style: txtStyle(12, Theme.of(context).indicatorColor,
                          FontWeight.w400),
                    ),
                  ],
                ),
              ),
              Spacer(),
              txtNumber(
                  '₹ ' +
                      (fuel
                          ? _setCheapExp(list)[list.length - 1]
                              .price
                              .toStringAsFixed(2)
                          : numFormat.format(
                              _setCheapExp(list)[list.length - 1].price)),
                  14,
                  Theme.of(context).highlightColor,
                  FontWeight.w600)
            ],
          ),
        ),
        Container(
          height: 1,
          width: double.infinity,
          color: Theme.of(context).indicatorColor.withOpacity(0.2),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
          child: Row(
            children: <Widget>[
              Text.rich(
                TextSpan(
                  text: 'Cheaper'.tr,
                  style: txtStyle(
                      12, Theme.of(context).indicatorColor, FontWeight.w500),
                  children: <InlineSpan>[
                    TextSpan(
                      text:
                          ': ${dateFormatFullYear(_setCheapExp(list)[0].date)}',
                      style: txtStyle(12, Theme.of(context).indicatorColor,
                          FontWeight.w400),
                    ),
                  ],
                ),
              ),
              Spacer(),
              txtNumber(
                  '₹ ' +
                      (fuel
                          ? _setCheapExp(list)[0].price.toStringAsFixed(2)
                          : numFormat.format(_setCheapExp(list)[0].price)),
                  14,
                  Theme.of(context).highlightColor,
                  FontWeight.w600)
            ],
          ),
        ),
        Container(
          height: 1,
          width: double.infinity,
          color: Theme.of(context).indicatorColor.withOpacity(0.2),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
          child: Row(
            children: <Widget>[
              Text.rich(
                TextSpan(
                  text: 'Price Difference'.tr,
                  style: txtStyle(
                      12, Theme.of(context).indicatorColor, FontWeight.w500),
                ),
              ),
              Spacer(),
              txtNumber(
                  '₹ ' +
                      (fuel
                          ? (_setCheapExp(list)[list.length - 1].price -
                                  _setCheapExp(list)[0].price)
                              .toStringAsFixed(2)
                          : numFormat.format(
                              (_setCheapExp(list)[list.length - 1].price -
                                  _setCheapExp(list)[0].price))),
                  14,
                  Theme.of(context).highlightColor,
                  FontWeight.w600)
            ],
          ),
        ),
      ],
    ),
  );
}

_setCheapExp(List<Record> _list) {
  _list.sort((a, b) => a.price.compareTo(b.price));
  return _list;
}

goldCaratsOp(int selectedIndex, int index, String short, String long,
    bool lastIndex, Function() fun, BuildContext context) {
  return Flexible(
    flex: (selectedIndex == index) ? 2 : 1,
    child: GestureDetector(
      onTap: fun,
      child: Container(
        decoration: BoxDecoration(
          color: (selectedIndex == index)
              ? Theme.of(context).backgroundColor
              : Colors.transparent,
          border: Border(
            right: BorderSide(
                color: Theme.of(context).indicatorColor.withOpacity(0.2),
                width: lastIndex ? 0 : 1),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Center(
            child: txtAlphabet(
                (selectedIndex == index) ? long : short,
                12,
                (selectedIndex == index)
                    ? Theme.of(context).highlightColor
                    : Theme.of(context).indicatorColor,
                FontWeight.w500),
          ),
        ),
      ),
    ),
  );
}

revisionsListDeco(
    bool visi, List<Record> list, bool fuel, BuildContext context) {
  return Visibility(
    visible: visi,
    child: revisionsBoxes(revisionsCalculator(list), fuel, context),
  );
}

gradientCases(String code) {
  switch (code) {
    case 'G':
      return goldGradient;
      break;
    case 'S':
      return silverGradient;
      break;
  }
}

gradientCasesArea(String code) {
  switch (code) {
    case 'G':
      return goldGradient.map((color) => color.withOpacity(0.3)).toList();
      break;
    case 'S':
      return silverGradient.map((color) => color.withOpacity(0.3)).toList();
      break;
  }
}

vehRecordsDataBox(String title, String value, BuildContext context) {
  return Container(
    height: 40,
    decoration: BoxDecoration(
      color: Theme.of(context).backgroundColor,
      boxShadow: [
        BoxShadow(
          color: Colors.black26,
          blurRadius: 4,
        ),
      ],
    ),
    child: Padding(
      padding: const EdgeInsets.only(left: 15, right: 10),
      child: Row(
        children: <Widget>[
          txtHeading(
              '$title',
              10,
              Theme.of(context).highlightColor.withOpacity(0.5),
              FontWeight.w500),
          Spacer(),
          txtNumber(
              '$value', 11, Theme.of(context).highlightColor, FontWeight.w700),
        ],
      ),
    ),
  );
}

tabTextDecoration(
    int index, String txt, int selectedTab, BuildContext context) {
  return txtHeading(
      '$txt',
      14,
      (selectedTab == index)
          ? Theme.of(context).accentColor
          : Theme.of(context).indicatorColor,
      (selectedTab == index) ? FontWeight.w800 : FontWeight.w600);
}

comparePriceBox(String title, BuildContext context, Function() func) {
  return InkWell(
    onTap: func,
    child: Container(
      decoration: boxColored(context),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: Column(
          children: <Widget>[
            Row(
              children: <Widget>[
                Container(
                  width: mediaWidth(0.65, context),
                  child: txtHeading(
                      '$title',
                      13,
                      Theme.of(context).highlightColor.withOpacity(0.7),
                      FontWeight.w500),
                ),
                Spacer(),
                Icon(
                  Icons.chevron_right,
                  color: Theme.of(context).indicatorColor,
                  size: 20,
                ),
              ],
            ),
          ],
        ),
      ),
    ),
  );
}

todayPriceBoxAll(String title, double priceToday, double priceYest, bool fuel,
    BuildContext context) {
  return Container(
    decoration: boxBorder(1, context),
    child: Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 12),
      child: Column(
        children: <Widget>[
          Row(
            children: <Widget>[
              txtHeading('$title', 16, Theme.of(context).highlightColor,
                  FontWeight.w800),
              Spacer(),
              txtNumber(
                  '₹ ' +
                      (fuel
                          ? priceToday.toStringAsFixed(2)
                          : numFormat.format(priceToday)),
                  16,
                  Theme.of(context).highlightColor,
                  FontWeight.w500),
            ],
          ),
          sizedHeight(2),
          Row(
            children: <Widget>[
              txtHeading('${_returnPriceWay(priceToday, priceYest)}', 11,
                  Theme.of(context).indicatorColor, FontWeight.w500),
              Spacer(),
              txtHeading(
                  fuel
                      ? prefixSign(priceToday - priceYest)
                      : prefixSignNonFuel(priceToday - priceYest),
                  11,
                  priceColors(priceToday - priceYest),
                  FontWeight.w500),
            ],
          )
        ],
      ),
    ),
  );
}

_returnPriceWay(double priceToday, double priceYest) {
  if (priceToday > priceYest) {
    return 'price increased'.tr;
  } else if (priceToday < priceYest) {
    return 'price decreased'.tr;
  } else {
    return 'no change in price'.tr;
  }
}

decoIndiaList(BuildContext context) {
  return BoxDecoration(
      border: Border(
    left: BorderSide(
        color: Theme.of(context).indicatorColor.withOpacity(0.2), width: 1),
    right: BorderSide(
        color: Theme.of(context).indicatorColor.withOpacity(0.2), width: 1),
    top: BorderSide(
        color: Theme.of(context).indicatorColor.withOpacity(0.2), width: 1),
  ));
}

endofList(int index, int length, BuildContext context) {
  if (index == length) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        txtHeading('END OF LIST', 12,
            Theme.of(context).highlightColor.withOpacity(0.3), FontWeight.w400),
      ],
    );
  } else {
    return sizedHeight(0);
  }
}

decoPriceDisplayer(
    String txt, String value, Color color, BuildContext context) {
  return Container(
    width: (mediaWidth(1, context) - 40) / 2,
    decoration: BoxDecoration(
        color: color.withOpacity(0.2), borderRadius: BorderRadius.circular(5)),
    child: Padding(
      padding: const EdgeInsets.all(10.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          txtHeading('$txt', 12, color, FontWeight.w500),
          txtNumber('$value', 12, color, FontWeight.w700)
        ],
      ),
    ),
  );
}
