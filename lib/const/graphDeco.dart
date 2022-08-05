import 'dart:ui';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:keemat_controller/const/const.dart';
import 'package:keemat_controller/const/decoration.dart';
import 'package:keemat_controller/const/designLogics.dart';
import 'package:keemat_controller/const/graphs.dart';
import 'package:keemat_controller/const/modals.dart';

final numFormat = new NumberFormat("#,##0", "en_US");

//graph settings
flGridData(BuildContext context) {
  return FlGridData(
    show: true,
    drawVerticalLine: false,
    getDrawingHorizontalLine: (value) {
      return FlLine(
        color: Theme.of(context).indicatorColor.withOpacity(0.1),
        strokeWidth: 1,
      );
    },
  );
}

loadingGraph(BuildContext context) {
  return LineChartData(
      gridData: flGridData(context),
      borderData: FlBorderData(show: false),
      minX: 0,
      minY: 0,
      maxX: 0,
      maxY: 0,
      lineTouchData: LineTouchData(
        enabled: false,
      ),
      lineBarsData: [
        LineChartBarData(
          spots: [
            FlSpot(0, 0),
          ],
          isCurved: true,
          barWidth: 5,
          isStrokeCapRound: true,
          dotData: FlDotData(
            show: false,
          ),
        )
      ]);
}

//graph box
graphBoxSpecial(LineChartData chart, double oldPrice, double latestPrice,
    bool fuel, BuildContext context) {
  return Column(
    children: <Widget>[
      Container(
        height: 280,
        width: double.infinity,
        decoration: boxRadiusOnlyBelow(context),
        child: Padding(
          padding:
              const EdgeInsets.only(top: 22, left: 8, right: 25, bottom: 15),
          child: LineChart(chart),
        ),
      ),
      Padding(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Row(
          children: <Widget>[
            Spacer(flex: 1),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                txtAlphabet('That time'.tr, 12, Theme.of(context).indicatorColor,
                    FontWeight.w300),
                sizedHeight(5),
                txtNumber(
                    '₹ ' +
                        (fuel
                            ? oldPrice.toStringAsFixed(2)
                            : numFormat.format(oldPrice)),
                    14,
                    Theme.of(context).highlightColor,
                    FontWeight.bold),
              ],
            ),
            Spacer(flex: 2),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                txtAlphabet('Changed now'.tr, 12, Theme.of(context).indicatorColor,
                    FontWeight.w300),
                sizedHeight(5),
                Row(
                  children: <Widget>[
                    fuel
                        ? priceDouble(latestPrice - oldPrice, 14)
                        : priceNonFuel(latestPrice - oldPrice, 14),
                    txtNumber(
                        ' ( ' + pricePer(oldPrice, latestPrice) + '% )',
                        14,
                        priceColors(latestPrice - oldPrice),
                        FontWeight.w400)
                  ],
                )
              ],
            ),
            Spacer(flex: 1)
          ],
        ),
      )
    ],
  );
}

//graph gradients
graphGradient(double oldPrice, double newPrice) {
  if (newPrice > oldPrice) {
    return redGradient;
  } else {
    return greenGradient;
  }
}

graphGradientArea(double oldPrice, double newPrice) {
  if (newPrice > oldPrice) {
    return redGradient.map((color) => color.withOpacity(0.3)).toList();
  } else {
    return greenGradient.map((color) => color.withOpacity(0.3)).toList();
  }
}

setGradient(double priced, BuildContext context) {
  if (priced > 0) {
    return [redColor.withOpacity(0.65), Theme.of(context).backgroundColor];
  } else if (priced < 0) {
    return [greenColor.withOpacity(0.65), Theme.of(context).backgroundColor];
  } else {
    return [
      Colors.grey[700].withOpacity(0.65),
      Theme.of(context).backgroundColor
    ];
  }
}

setGradientLinear(double priced, BuildContext context) {
  if (priced > 0) {
    return [redColor.withOpacity(0.5), redColor];
  } else if (priced < 0) {
    return [greenColor.withOpacity(0.5), greenColor];
  } else {
    return [Colors.grey[700].withOpacity(0.5), Colors.grey[700]];
  }
}

//bar graph
recentRevisions(
    double newPrice, double oldPrice, var date, BuildContext context) {
  return Flexible(
      child: Column(
    mainAxisAlignment: MainAxisAlignment.end,
    crossAxisAlignment: CrossAxisAlignment.center,
    children: <Widget>[
      txtNumber(prefixSign(newPrice - oldPrice), 11,
          priceColors(newPrice - oldPrice), FontWeight.w600),
      sizedHeight(5),
      ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(5), topRight: Radius.circular(5)),
        child: BackdropFilter(
          filter: new ImageFilter.blur(
            sigmaX: 40.0,
            sigmaY: 40.0,
          ),
          child: AnimatedContainer(
            width: 35,
            height: (((newPrice - oldPrice).abs() / 10) * 150) + 1,
            duration: Duration(milliseconds: 100),
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: setGradient(newPrice - oldPrice, context),
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(5), topRight: Radius.circular(5)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black26,
                    blurRadius: 7,
                    offset: Offset(0, 2),
                  )
                ]),
          ),
        ),
      ),
      sizedHeight(5),
      Text.rich(TextSpan(
          text: date.day.toString(),
          style:
              txtStyle(10, Theme.of(context).indicatorColor, FontWeight.w700),
          children: <InlineSpan>[
            TextSpan(
              text: '/' + date.month.toString(),
              style: txtStyle(
                  10, Theme.of(context).indicatorColor, FontWeight.w400),
            )
          ]))
    ],
  ));
}

//linearGradient
linearGradient(double priced) {
  if (priced > 0) {
    return [
      Colors.redAccent[100].withOpacity(0.7),
      redColor.withOpacity(0.7),
    ];
  } else if (priced < 0) {
    return [
    Color(0xff77ff85).withOpacity(0.7),
      greenColor.withOpacity(0.7),
    ];
  } else {
    return [
      yellowColor,
      yellowColor,
    ];
  }
}

goldOptionsBox(double price, BuildContext context) {
  return Container(
    height: 230,
    width: mediaWidth(0.95, context),
    decoration: boxRadiusOnlyBelow(context),
    child: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Column(
          children: <Widget>[
            Spacer(),
            Row(
              children: <Widget>[
                Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    txtNumber('₹ ' + numFormat.format(price), 14,
                        Theme.of(context).accentColor, FontWeight.w600),
                    sizedHeight(5),
                    txtAlphabet('10 ' + 'gram'.tr, 12, Theme.of(context).indicatorColor,
                        FontWeight.w400)
                  ],
                ),
                Spacer(),
                Container(
                  height: 50,
                  width: 1,
                  color: Theme.of(context).indicatorColor.withOpacity(0.2),
                ),
                Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    txtNumber('₹ ' + numFormat.format(price * 0.8), 14,
                        Theme.of(context).accentColor, FontWeight.w600),
                    sizedHeight(5),
                    txtAlphabet('8 ' + 'gram'.tr, 12, Theme.of(context).indicatorColor,
                        FontWeight.w400)
                  ],
                ),
                Spacer(),
              ],
            ),
            Spacer(),
            Row(
              children: <Widget>[
                Spacer(flex: 2),
                Container(
                  height: 1,
                  width: mediaWidth(0.25, context),
                  color: Theme.of(context).indicatorColor.withOpacity(0.2),
                ),
                Spacer(flex: 4),
                Container(
                  height: 1,
                  width: mediaWidth(0.25, context),
                  color: Theme.of(context).indicatorColor.withOpacity(0.2),
                ),
                Spacer(flex: 2),
              ],
            ),
            Spacer(),
            Row(
              children: <Widget>[
                Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    txtNumber('₹ ' + numFormat.format(price * 0.4), 14,
                        Theme.of(context).accentColor, FontWeight.w600),
                    sizedHeight(5),
                    txtAlphabet('4 ' + 'gram'.tr, 12, Theme.of(context).indicatorColor,
                        FontWeight.w400)
                  ],
                ),
                Spacer(),
                sizedWidth(5),
                Container(
                  height: 50,
                  width: 1,
                  color: Theme.of(context).indicatorColor.withOpacity(0.2),
                ),
                Spacer(),
                sizedWidth(5),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    txtNumber('₹ ' + numFormat.format(price * 0.1), 14,
                        Theme.of(context).accentColor, FontWeight.w600),
                    sizedHeight(5),
                    txtAlphabet('1 ' + 'gram'.tr, 12, Theme.of(context).indicatorColor,
                        FontWeight.w400)
                  ],
                ),
                Spacer(),
              ],
            ),
            Spacer(),
          ],
        ),
        Image.asset('assets/images/gold.png', width: mediaWidth(0.15, context), fit: BoxFit.fitWidth,)
      ],
    ),
  );
}

silverOptionsBox(double price, BuildContext context) {
  return Container(
    height: 230,
    width: mediaWidth(0.95, context),
    decoration: boxColored(context),
    child: Stack(
      alignment: Alignment.center,
      children: <Widget>[
        Column(
          children: <Widget>[
            Spacer(),
            Row(
              children: <Widget>[
                Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    txtNumber('₹ ' + numFormat.format(price), 14,
                        Color(0xffA9A9A9), FontWeight.w600),
                    sizedHeight(5),
                    txtAlphabet('1 ' + 'kilogram'.tr, 12, Theme.of(context).indicatorColor,
                        FontWeight.w400)
                  ],
                ),
                Spacer(),
                Container(
                  height: 50,
                  width: 1,
                  color: Theme.of(context).indicatorColor.withOpacity(0.2),
                ),
                Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    txtNumber('₹ ' + numFormat.format(price * 0.5), 14,
                        Color(0xffA9A9A9), FontWeight.w600),
                    sizedHeight(5),
                    txtAlphabet('500 ' + 'gram'.tr, 12, Theme.of(context).indicatorColor,
                        FontWeight.w400)
                  ],
                ),
                Spacer(),
              ],
            ),
            Spacer(),
            Row(
              children: <Widget>[
                Spacer(flex: 2),
                Container(
                  height: 1,
                  width: mediaWidth(0.25, context),
                  color: Theme.of(context).indicatorColor.withOpacity(0.2),
                ),
                Spacer(flex: 4),
                Container(
                  height: 1,
                  width: mediaWidth(0.25, context),
                  color: Theme.of(context).indicatorColor.withOpacity(0.2),
                ),
                Spacer(flex: 2),
              ],
            ),
            Spacer(),
            Row(
              children: <Widget>[
                Spacer(),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    txtNumber('₹ ' + numFormat.format(price * 0.1), 14,
                        Color(0xffA9A9A9), FontWeight.w600),
                    sizedHeight(5),
                    txtAlphabet('100 ' + 'gram'.tr, 12, Theme.of(context).indicatorColor,
                        FontWeight.w400)
                  ],
                ),
                Spacer(),
                Container(
                  height: 50,
                  width: 1,
                  color: Theme.of(context).indicatorColor.withOpacity(0.2),
                ),
                Spacer(),
                sizedWidth(5),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    txtNumber('₹ ' + numFormat.format(price * 0.01), 14,
                        Color(0xffA9A9A9), FontWeight.w600),
                    sizedHeight(5),
                    txtAlphabet('10 ' + 'gram'.tr, 12, Theme.of(context).indicatorColor,
                        FontWeight.w400)
                  ],
                ),
                Spacer(),
              ],
            ),
            Spacer(),
          ],
        ),
        Image.asset('assets/images/silver.png', width: mediaWidth(0.15, context), fit: BoxFit.fitWidth,)
      ],
    ),
  );
}

graphOptionsDeco(int index, List<Record> list7D, List<Record> list1M, List<Record> list3M, List<Record> list6M, List<Record> list1Y, bool fuel, String gCode, BuildContext context){
  return IndexedStack(
    index: index,
    alignment: Alignment.center,
    children: <Widget>[
      graphBoxSpecial(
          chartPetrol7D(
              list7D,
              fuel, gCode,
              context),
          list7D[list7D.length - 1].price,
          list7D[0].price,
          fuel,
          context),
      graphBoxSpecial(
          chartPetrol1M(
              list1M,
              fuel, gCode,
              context),
          list1M[list1M.length - 1].price,
          list7D[0].price,
          fuel,
          context),
      graphBoxSpecial(
          chartPetrol3M(
              list3M,
              fuel, gCode,
              context),
          list3M[list3M.length - 1].price,
          list7D[0].price,
          fuel,
          context),
      graphBoxSpecial(
          chartPetrol6M(
              list6M,
              fuel, gCode,
              context),
         list6M[list6M.length - 1]
              .price,
          list7D[0].price,
          fuel,
          context),
      graphBoxSpecial(
          chartPetrol1Y(
              list1Y,
              fuel, gCode,
              context),
         list1Y[list1Y.length - 1]
              .price,
          list7D[0].price,
          fuel,
          context),
    ],
  );
}