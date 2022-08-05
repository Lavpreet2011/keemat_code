import 'dart:ui';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:keemat_controller/Provider/themeProvider.dart';
import 'package:keemat_controller/const/const.dart';
import 'package:keemat_controller/const/decoration.dart';
import 'package:keemat_controller/const/designLogics.dart';
import 'package:keemat_controller/const/graphDeco.dart';
import 'package:keemat_controller/const/modals.dart';
import 'package:provider/provider.dart';

final numFormat = new NumberFormat("#,##0", "en_US");

LineChartData chartPetrol7D(
    List<Record> list, bool fuel, String gCode, BuildContext context) {
  List<Record> localList = new List();
  list.forEach((element) {
    localList.add(Record(date: element.date, price: element.price));
  });
  localList.sort((a, b) => a.price.compareTo(b.price));
  if (localList.length > 0) {
    return LineChartData(
        minX: 0,
        minY: 0,
        maxX: (list.length - 1).toDouble(),
        maxY: 10,
        gridData: flGridData(context),
        titlesData: chartTitles(list, localList, '7D', context),
        borderData: FlBorderData(show: false),
        lineTouchData: LineTouchData(enabled: false),
        lineBarsData: [
          barData(list[list.length - 1].price, list[0].price, list, localList,
              false, fuel, gCode)
        ]);
  } else {
    return loadingGraph(context);
  }
}

LineChartData chartPetrol1M(
    List<Record> list, bool fuel, String gCode, BuildContext context) {
  List<Record> localList = new List();
  list.forEach((element) {
    localList.add(Record(date: element.date, price: element.price));
  });
  localList.sort((a, b) => a.price.compareTo(b.price));
  if (localList.length > 0) {
    return LineChartData(
        minX: 0,
        minY: 0,
        maxX: (list.length - 1).toDouble(),
        maxY: 10,
        gridData: flGridData(context),
        titlesData: chartTitles(list, localList, '1M', context),
        borderData: FlBorderData(show: false),
        lineTouchData: LineTouchData(enabled: false),
        lineBarsData: [
          barData(list[list.length - 1].price, list[0].price, list, localList,
              false, fuel, gCode)
        ]);
  } else {
    return loadingGraph(context);
  }
}

LineChartData chartPetrol3M(
    List<Record> list, bool fuel, String gCode, BuildContext context) {
  List<Record> localList = new List();
  list.forEach((element) {
    localList.add(Record(date: element.date, price: element.price));
  });
  localList.sort((a, b) => a.price.compareTo(b.price));
  if (localList.length > 0) {
    return LineChartData(
        minX: 0,
        minY: 0,
        maxX: (list.length - 1).toDouble(),
        maxY: 10,
        gridData: flGridData(context),
        titlesData: chartTitles(list, localList, '3M', context),
        borderData: FlBorderData(show: false),
        lineTouchData: LineTouchData(enabled: false),
        lineBarsData: [
          barData(list[list.length - 1].price, list[0].price, list, localList,
              false, fuel, gCode)
        ]);
  } else {
    return loadingGraph(context);
  }
}

LineChartData chartPetrol6M(
    List<Record> list, bool fuel, String gCode, BuildContext context) {
  List<Record> localList = new List();
  list.forEach((element) {
    localList.add(Record(date: element.date, price: element.price));
  });
  localList.sort((a, b) => a.price.compareTo(b.price));
  if (localList.length > 0) {
    return LineChartData(
        minX: 0,
        minY: 0,
        maxX: (list.length - 1).toDouble(),
        maxY: 10,
        gridData: flGridData(context),
        titlesData: chartTitles(list, localList, '6M', context),
        borderData: FlBorderData(show: false),
        lineTouchData: LineTouchData(enabled: false),
        lineBarsData: [
          barData(list[list.length - 1].price, list[0].price, list, localList,
              false, fuel, gCode)
        ]);
  } else {
    return loadingGraph(context);
  }
}

LineChartData chartPetrol1Y(
    List<Record> list, bool fuel, String gCode, BuildContext context) {
  List<Record> localList = new List();
  list.forEach((element) {
    localList.add(Record(date: element.date, price: element.price));
  });
  localList.sort((a, b) => a.price.compareTo(b.price));
  if (localList.length > 0) {
    return LineChartData(
        minX: 0,
        minY: 0,
        maxX: (list.length - 1).toDouble(),
        maxY: 10,
        gridData: flGridData(context),
        titlesData: chartTitles(list, localList, '1Y', context),
        borderData: FlBorderData(show: false),
        lineTouchData: LineTouchData(enabled: false),
        lineBarsData: [
          barData(list[list.length - 1].price, list[0].price, list, localList,
              false, fuel, gCode)
        ]);
  } else {
    return loadingGraph(context);
  }
}

//bar graph
revisions7D(List<Record> list, BuildContext context) {
  return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.circular(10),
          bottomRight: Radius.circular(10),
        ),
        color: Theme.of(context).backgroundColor,
        boxShadow: [
          BoxShadow(
            color: Colors.black26,
            blurRadius: 7,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.only(
          top: 20,
          bottom: 20,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            sizedWidth(20),
            recentRevisions(
                list[6].price, list[7].price, list[6].date, context),
            sizedWidth(12),
            recentRevisions(
                list[5].price, list[6].price, list[5].date, context),
            sizedWidth(12),
            recentRevisions(
                list[4].price, list[5].price, list[4].date, context),
            sizedWidth(12),
            recentRevisions(
                list[3].price, list[4].price, list[3].date, context),
            sizedWidth(12),
            recentRevisions(
                list[2].price, list[3].price, list[2].date, context),
            sizedWidth(12),
            recentRevisions(
                list[1].price, list[2].price, list[1].date, context),
            sizedWidth(12),
            recentRevisions(
                list[0].price, list[1].price, list[0].date, context),
            sizedWidth(20),
          ],
        ),
      ));
}

monthChanges(List<Record> list, double width, bool fuel, BuildContext context){
  List priceDifference = new List();
  for (int i = 0; i < list.length - 1; i++) {
    priceDifference.add((list[i].price).abs());
  }
  priceDifference.sort((a, b) => a.compareTo(b));

  return Container(
    width: double.infinity,
    decoration: boxBorder(1, context),
    child: ListView.builder(
        scrollDirection: Axis.vertical,
        itemCount: list.length - 1,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        padding: EdgeInsets.symmetric(horizontal: 3, vertical: 20),
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: <Widget>[
                  Container(
                    width: (Provider.of<ThemeProvider>(context, listen: false).getLangCode == 0) ? 45 : 55,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: <Widget>[
                        Text.rich(TextSpan(
                        text: 
                        (Provider.of<ThemeProvider>(context, listen: false).getLangCode == 0) ? 
                        monthOptions(list[index].date.month)
                            .toString().substring(0,3) : monthOptions(list[index].date.month)
                            .toString().tr,
                        style: txtStyle(10, Theme.of(context).indicatorColor,
                            FontWeight.w500),
                        children: <InlineSpan>[
                          TextSpan(
                            text: '-' +
                                list[index]
                                    .date
                                    .year
                                    .toString()
                                    .substring(2, 4),
                            style: txtStyle(
                                10,
                                Theme.of(context)
                                    .indicatorColor,
                                FontWeight.w400),
                          )
                        ])),
                      ],
                    )
                  ),
                  sizedWidth(6),
                  ClipRRect(
                    borderRadius: BorderRadius.only(
                      topRight: Radius.circular(5),
                      bottomRight: Radius.circular(5),
                    ),
                    child: BackdropFilter(
                      filter: new ImageFilter.blur(
                        sigmaX: 60.0,
                        sigmaY: 60.0,
                      ),
                      child: Container(
                        height: 12,
                        width: ((((list[index].price).abs() /
                                    priceDifference[
                                        priceDifference.length - 1]) *
                                mediaWidth(width, context))) +
                            1,
                        decoration: BoxDecoration(
                          gradient: LinearGradient(
                              colors: linearGradient(list[index].price),
                              begin: Alignment.centerLeft,
                              end: Alignment.centerRight),
                          borderRadius: BorderRadius.only(
                            topRight: Radius.circular(5),
                            bottomRight: Radius.circular(5),
                          ),
                        ),
                      ),
                    ),
                  ),
                  sizedWidth(7),
                  txtNumber(
                      fuel
                          ? prefixSign(list[index].price)
                          : prefixSignNonFuel(list[index].price),
                      10,
                      priceColMonths(list[index].price),
                      FontWeight.w600),
                ],
              ),
              sizedHeight((index != list.length - 2) ? 15 : 0),
            ],
          );
        }),
  );
}

//days direction
directionDays(List<Record> list, BuildContext context) {
  return Container(
    decoration: boxBorder(1, context),
    child: Padding(
      padding: const EdgeInsets.symmetric(vertical: 15),
      child: Column(
        children: <Widget>[
          Container(
            width: mediaWidth(1, context),
            child: GridView.builder(
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 7,
                    mainAxisSpacing: 7,
                    crossAxisSpacing: 7,
                    childAspectRatio: 1),
                itemCount: 28,
                shrinkWrap: true,
                physics: NeverScrollableScrollPhysics(),
                padding: EdgeInsets.symmetric(horizontal: 15),
                itemBuilder: (BuildContext context, int index) {
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
                          color: priceChangeBG(
                                  list[index].price - list[index + 1].price)
                              .withOpacity(0.2),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: <Widget>[
                            txtNumber(
                                list[index].date.day.toString(),
                                15,
                                priceChangeBG(
                                    list[index].price - list[index + 1].price),
                                FontWeight.bold),
                            txtAlphabet(
                                monthOptions(list[index].date.month)
                                    .toString()
                                    .substring(0, 3),
                                8,
                                priceChangeBG(
                                    list[index].price - list[index + 1].price),
                                FontWeight.w400)
                          ],
                        ),
                      ),
                    ),
                  );
                }),
          ),
          sizedHeight(15),
          Container(
              height: 1,
              width: double.infinity,
              color: Theme.of(context).indicatorColor.withOpacity(0.2)),
          sizedHeight(15),
          Row(
            children: <Widget>[
              Spacer(),
              priceDirInfo('Increased'.tr, redColor, context),
              Spacer(),
              priceDirInfo('Decreased'.tr, greenColor, context),
              Spacer(),
              priceDirInfo('Unchanged'.tr, yellowColor, context),
              Spacer(),
            ],
          )
        ],
      ),
    ),
  );
}

//list changes
revisionsList7D(List<Record> list, BuildContext context) {
  return Container(
    width: double.infinity,
    decoration: BoxDecoration(
      border: Border.all(
          color: Theme.of(context).indicatorColor.withOpacity(0.5), width: 1),
      borderRadius: BorderRadius.circular(5),
    ),
    child: ListView.builder(
        itemCount: 7,
        shrinkWrap: true,
        physics: NeverScrollableScrollPhysics(),
        scrollDirection: Axis.vertical,
        padding: EdgeInsets.all(0),
        itemBuilder: (BuildContext context, int index) {
          return Column(
            children: <Widget>[
              sizedHeight(6),
              Container(
                child: Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  child: Row(
                    children: <Widget>[
                      Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: <Widget>[
                          txtAlphabet(
                              dateFormatFullYear(list[index].date),
                              12,
                              Theme.of(context).indicatorColor,
                              FontWeight.w600),
                          sizedHeight(2),
                          txtAlphabet(
                              weekdayAllOptions(list[index].date.weekday),
                              10,
                              Theme.of(context)
                                  .indicatorColor
                                  .withOpacity(0.75),
                              FontWeight.w400),
                        ],
                      ),
                      Spacer(),
                      ClipRRect(
                        borderRadius: BorderRadius.circular(5),
                        child: BackdropFilter(
                          filter: new ImageFilter.blur(
                            sigmaX: 40.0,
                            sigmaY: 40.0,
                          ),
                          child: Container(
                            width: 50,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(5),
                              color: priceChangeBG(
                                      list[index].price - list[index + 1].price)
                                  .withOpacity(0.25),
                            ),
                            child: Padding(
                              padding: const EdgeInsets.symmetric(vertical: 8),
                              child: Center(
                                  child: price(index, list[index].price,
                                      list[index + 1].price)),
                            ),
                          ),
                        ),
                      ),
                      sizedWidth(10),
                      Container(
                          width: 60,
                          child: Center(
                            child: txtAlphabet(
                                '₹ ' + list[index].price.toStringAsFixed(2),
                                12,
                                Colors.white,
                                FontWeight.w600),
                          ))
                    ],
                  ),
                ),
              ),
              sizedHeight(6),
              Container(
                height: (index != 6) ? 1 : 0,
                width: double.infinity,
                color: Theme.of(context).indicatorColor.withOpacity(0.5),
              ),
            ],
          );
        }),
  );
}

chartTitles(List<Record> list, List<Record> localList, String duration,
    BuildContext context) {
  return FlTitlesData(
    show: true,
    bottomTitles: SideTitles(
      showTitles: true,
      reservedSize: 15,
      getTextStyles: (value) =>
          txtStyle(8, Theme.of(context).indicatorColor, FontWeight.w400),
      getTitles: (value) {
        return bottomTitlesCases(duration, value.toInt(), list);
      },
      margin: 8,
    ),
    leftTitles: SideTitles(
      showTitles: true,
      getTextStyles: (value) =>
          txtStyle(8, Theme.of(context).indicatorColor, FontWeight.w400),
      getTitles: (value) {
        return leftTitles(value.toInt(), localList);
      },
      margin: 12,
      reservedSize: 20,
    ),
  );
}

bottomTitlesCases(String duration, int value, List<Record> list) {
  switch (duration) {
    case '7D':
      return bottomTitles7D(value, list);
      break;
    case '1M':
      return bottomTitles1M(value, list);
      break;
    case '3M':
      return bottomTitles3M(value, list);
      break;
    case '6M':
      return bottomTitles6M(value, list);
      break;
    case '1Y':
      return bottomTitles1Y(value, list);
      break;
  }
}

barData(double highPrice, double lowPrice, List<Record> list,
    List<Record> localList, bool showDots, bool fuel, String gCode) {
  return LineChartBarData(
      spots: fuel
          ? showingSections(list, localList)
          : showingSectionsNonFuel(list, localList),
      isCurved: true,
      colors: fuel ? graphGradient(highPrice, lowPrice) : gradientCases(gCode),
      barWidth:
          fuel ? (list.length > 175) ? 3 : 4 : (list.length > 175) ? 2 : 3,
      isStrokeCapRound: true,
      dotData: FlDotData(
        show: showDots,
      ),
      belowBarData: BarAreaData(
        show: true,
        colors: fuel
            ? graphGradientArea(highPrice, lowPrice)
            : gradientCasesArea(gCode),
      ));
}

leftTitles(int value, List<Record> localList) {
  double highestPrice = localList[localList.length - 1].price + 1;
  double lowestPrice = localList[0].price - 1;
  double difference = highestPrice - lowestPrice;

  if (difference > 3) {
    switch (value.toInt()) {
      case 0:
        return (lowestPrice).toStringAsFixed(0);
        break;
      case 3:
        return ((difference * (1 / 3)) + lowestPrice).toStringAsFixed(0);
        break;
      case 6:
        return ((difference * (2 / 3)) + lowestPrice).toStringAsFixed(0);
        break;
      case 9:
        return ((difference * (3 / 3)) + lowestPrice).toStringAsFixed(0);
        break;
      default:
        return '';
        break;
    }
  } else {
    switch (value.toInt()) {
      case 0:
        return (lowestPrice).toStringAsFixed(0);
        break;
      case 9:
        return (highestPrice).toStringAsFixed(0);
        break;
      default:
        return '';
        break;
    }
  }
}

bottomTitles7D(int value, List<Record> list) {
  switch (value.toInt()) {
    case 0:
      return dateGraph12(list[7].date);
      break;
    case 1:
      return dateGraph12(list[6].date);
      break;
    case 2:
      return dateGraph12(list[5].date);
      break;
    case 3:
      return dateGraph12(list[4].date);
      break;
    case 4:
      return dateGraph12(list[3].date);
      break;
    case 5:
      return dateGraph12(list[2].date);
      break;
    case 6:
      return dateGraph12(list[1].date);
      break;
    case 7:
      return dateGraph12(list[0].date);
      break;
    default:
      return '';
      break;
  }
}

bottomTitles1M(int value, List<Record> list) {
  switch (value.toInt()) {
    case 0:
      return dateGraph12(list[30].date);
      break;
    case 5:
      return dateGraph12(list[25].date);
      break;
    case 10:
      return dateGraph12(list[20].date);
      break;
    case 15:
      return dateGraph12(list[15].date);
      break;
    case 20:
      return dateGraph12(list[10].date);
      break;
    case 25:
      return dateGraph12(list[5].date);
      break;
    case 30:
      return dateGraph12(list[0].date);
      break;
    default:
      return '';
      break;
  }
}

bottomTitles3M(int value, List<Record> list) {
  switch (value.toInt()) {
    case 0:
      return dateGraph12(list[90].date);
      break;
    case 15:
      return dateGraph12(list[75].date);
      break;
    case 30:
      return dateGraph12(list[60].date);
      break;
    case 45:
      return dateGraph12(list[45].date);
      break;
    case 60:
      return dateGraph12(list[30].date);
      break;
    case 75:
      return dateGraph12(list[15].date);
      break;
    case 90:
      return dateGraph12(list[0].date);
      break;
    default:
      return '';
      break;
  }
}

bottomTitles6M(int value, List<Record> list) {
  switch (value.toInt()) {
    case 0:
      return dateGraph12(list[180].date);
      break;
    case 30:
      return dateGraph12(list[150].date);
      break;
    case 60:
      return dateGraph12(list[120].date);
      break;
    case 90:
      return dateGraph12(list[90].date);
      break;
    case 120:
      return dateGraph12(list[60].date);
      break;
    case 150:
      return dateGraph12(list[30].date);
      break;
    case 180:
      return dateGraph12(list[0].date);
      break;
    default:
      return '';
      break;
  }
}

bottomTitles1Y(int value, List<Record> list) {
  switch (value.toInt()) {
    case 0:
      return dateGraph12(list[364].date);
      break;
    case 60:
      return dateGraph12(list[303].date);
      break;
    case 120:
      return dateGraph12(list[242].date);
      break;
    case 180:
      return dateGraph12(list[181].date);
      break;
    case 240:
      return dateGraph12(list[120].date);
      break;
    case 300:
      return dateGraph12(list[59].date);
      break;
    case 360:
      return dateGraph12(list[0].date);
      break;
    default:
      return '';
      break;
  }
}

List<FlSpot> showingSections(List<Record> list, List<Record> sortedList) {
  double highestPrice = sortedList[sortedList.length - 1].price + 1;
  double lowestPrice = sortedList[0].price - 1;
  double difference = highestPrice - lowestPrice;
  return List.generate(list.length, (index) {
    return FlSpot(
        index.toDouble(),
        ((list[(sortedList.length - 1) - index].price - lowestPrice) /
                (difference)) *
            (9));
  });
}

List<FlSpot> showingSectionsNonFuel(
    List<Record> list, List<Record> sortedList) {
  double highestPrice = sortedList[sortedList.length - 1].price + 100;
  double lowestPrice = sortedList[0].price - 100;
  double difference = highestPrice - lowestPrice;
  return List.generate(list.length, (index) {
    return FlSpot(
        index.toDouble(),
        ((list[(sortedList.length - 1) - index].price - lowestPrice) /
                (difference)) *
            (9));
  });
}

revisionsCalculator(List<Record> list) {
  List<Record> revisions = new List<Record>();
  for (int i = 0; i < 365; i++) {
    if (revisions.length == 8) {
      break;
    }
    if ((list[i + 1].price - list[i].price) != 0) {
      revisions.add(Record(
        date: list[i].date,
        price: list[i].price,
      ));
    }
  }
  return revisions;
}

monthlyChangedPrice(List<Record> list) {
  List<Record> monthsRecord = new List<Record>();
  for (int i = 0; i < 11; i++) {
    if (i == 0) {
      monthsRecord.add(Record(
        date: list[0].date,
        price: list[0].price - list[list[0].date.day].price,
      ));
    } else if (i == 1) {
      monthsRecord.add(Record(
        date: list[0].date.subtract(Duration(days: list[0].date.day)),
        price: list[list[0].date.day].price - list[list[0].date.day + 31].price,
      ));
    } else if (i >= 2) {
      monthsRecord.add(Record(
        date: list[0]
            .date
            .subtract(Duration(days: list[0].date.day + (31 * (i - 1)))),
        price: list[list[0].date.day + (31 * (i - 1))].price -
            list[list[0].date.day + (31 * (i))].price,
      ));
    }
  }
  return monthsRecord;
}

revisionsBoxes(List<Record> list, bool fuel, BuildContext context) {
  return Container(
    height: 100,
    width: double.infinity,
    child: ListView.builder(
      itemCount: 7,
      scrollDirection: Axis.horizontal,
      itemBuilder: (BuildContext context, int index) {
        return Row(
          children: <Widget>[
            sizedWidth(15),
            Column(
              children: <Widget>[
                sizedHeight(10),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Theme.of(context).backgroundColor,
                    boxShadow: [
                      BoxShadow(
                        color: Theme.of(context).primaryColor,
                        blurRadius: 10,
                        offset: Offset(0, 4),
                        spreadRadius: 0,
                      )
                    ]
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(15.0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Row(
                          children: <Widget>[
                            txtNumber(
                                '₹ ' +
                                    (fuel
                                        ? list[index].price.toStringAsFixed(2)
                                        : numFormat.format(list[index].price)),
                                14,
                                Theme.of(context).highlightColor,
                                FontWeight.w600),
                            txtNumber(
                                '  (' +
                                    (fuel
                                        ? prefixSign(list[index].price -
                                            list[index + 1].price)
                                        : prefixSignNonFuel(list[index].price -
                                            list[index + 1].price)) +
                                    ')',
                                12,
                                priceColors(
                                    list[index].price - list[index + 1].price),
                                FontWeight.w400)
                          ],
                        ),
                        sizedHeight(10),
                        txtAlphabet(dateFormat(list[index].date), 12,
                            Theme.of(context).indicatorColor, FontWeight.w400)
                      ],
                    ),
                  ),
                ),
                sizedHeight(10)
              ],
            ),
          ],
        );
      },
    ),
  );
}
