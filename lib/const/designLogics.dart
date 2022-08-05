import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:get/get.dart';
import 'package:keemat_controller/Provider/themeProvider.dart';
import 'package:keemat_controller/const/const.dart';
import 'package:keemat_controller/const/decoration.dart';
import 'package:keemat_controller/const/translation.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';
import 'package:share/share.dart';
import 'package:shared_preferences/shared_preferences.dart';

final numFormat = new NumberFormat("#,##0", "en_US");

priceChangeBG(double pc) {
  if (pc > 0) {
    return redColor;
  } else if (pc < 0) {
    return greenColor;
  } else {
    return yellowColor;
  }
}

priceChangeImage(double pc) {
  if (pc > 0) {
    return 'increase_sign';
  } else if (pc < 0) {
    return 'decrease_sign';
  } else {
    return 'noChanged';
  }
}

dropOneMonth(var date) {
  var newDate;
  if (date.month == 1) {
    newDate = DateTime(date.year - 1, date.month - 1);
    return newDate.month;
  } else {
    newDate = DateTime(date.year, date.month - 1);
    return newDate.month;
  }
}

dropOneYear(var date) {
  var newDate;
  if (date.month == 1) {
    newDate = DateTime(date.year - 1);
    return newDate.year;
  } else {
    newDate = DateTime(date.year);
    return newDate.year;
  }
}

pricePer(double oldPrice, double newPrice) {
  if (oldPrice > newPrice) {
    return (((oldPrice - newPrice) / newPrice) * 100).toStringAsFixed(2);
  } else {
    return (((newPrice - oldPrice) / oldPrice) * 100).toStringAsFixed(2);
  }
}

prefixSign(double price) {
  if (price > 0) {
    return '+' + price.toStringAsFixed(2);
  } else if (price < 0) {
    return price.toStringAsFixed(2);
  } else {
    return price.toStringAsFixed(1);
  }
}

prefixSignNonFuel(double price) {
  if (price > 0) {
    return '+' + numFormat.format(price);
  } else if (price < 0) {
    return numFormat.format(price);
  } else {
    return numFormat.format(price);
  }
}

priceDouble(double price, double fsize) {
  if (price > 0) {
    return txtNumber(
        '+' + price.toStringAsFixed(2), fsize, redColor, FontWeight.w600);
  } else if (price < 0) {
    return txtNumber(
        price.toStringAsFixed(2), fsize, greenColor, FontWeight.w600);
  } else {
    return txtNumber(
        price.toStringAsFixed(2), fsize, yellowColor, FontWeight.w600);
  }
}

priceNonFuel(double price, double fsize) {
  if (price > 0) {
    return txtNumber(
        '+' + numFormat.format(price), fsize, redColor, FontWeight.w600);
  } else if (price < 0) {
    return txtNumber(
        numFormat.format(price), fsize, greenColor, FontWeight.w600);
  } else {
    return txtNumber(
        numFormat.format(price), fsize, yellowColor, FontWeight.w600);
  }
}

priceColors(double price) {
  if (price > 0) {
    return redColor;
  } else if (price < 0) {
    return greenColor;
  } else {
    return yellowColor;
  }
}

priceColMonths(double price) {
  if (price > 0) {
    return redColor;
  } else if (price < 0) {
    return greenColor;
  } else {
    return yellowColor;
  }
}

yesterDayPrice(double price, double pc) {
  if (price > 0) {
    return price - pc;
  } else if (price < 0) {
    return price + pc;
  } else {
    return price;
  }
}

resetCityCode(String code) {
  if (code.contains('XX')) {
    return '';
  } else {
    return code;
  }
}

cheapExpensive(int index, double price, double minPrice, double maxPrice,
    BuildContext context) {
  if (price == minPrice) {
    return txtHeading(
        'Cheapest'.tr.toUpperCase(), 11, Theme.of(context).indicatorColor, FontWeight.w600);
  } else if (price == maxPrice) {
    return txtHeading('Most Expensive'.tr.toUpperCase(), 11, Theme.of(context).indicatorColor,
        FontWeight.w600);
  } else {
    return sizedHeight(0);
  }
}

cheapState(double price, double minPrice, BuildContext context) {
  if (price == minPrice) {
    return txtHeading(
        'Cheapest'.tr.toUpperCase(), 11, Theme.of(context).indicatorColor, FontWeight.w600);
  } else {
    return sizedHeight(0);
  }
}

expensiveState(double price, double maxPrice, BuildContext context) {
  if (price == maxPrice) {
    return txtHeading('Most Expensive'.tr.toUpperCase(), 11, Theme.of(context).indicatorColor,
        FontWeight.w600);
  } else {
    return sizedHeight(0);
  }
}

setLineWidth(double price, double myCityPrice, double minPrice, double maxPrice,
    BuildContext context) {
  if (price > myCityPrice) {
    return (mediaWidth(0.95, context) *
        ((price - myCityPrice) / (maxPrice - myCityPrice)));
  } else if (price < myCityPrice) {
    return (mediaWidth(0.95, context) *
        ((myCityPrice - price) / (myCityPrice - minPrice)));
  } else {
    return 1.0;
  }
}

setLineWidthMin(double price, double myCityPrice, double minPrice,
    double maxPrice, BuildContext context) {
  if (price > myCityPrice) {
    return (mediaWidth(0.43, context) *
        ((price - myCityPrice) / (maxPrice - myCityPrice)));
  } else if (price < myCityPrice) {
    return (mediaWidth(0.43, context) *
        ((myCityPrice - price) / (myCityPrice - minPrice)));
  } else {
    return 1.0;
  }
}

viewInfoDiff(int index, String city, String price, BuildContext context) {
  if (index == 0) {
    return Column(
      children: <Widget>[
        Container(
          width: mediaWidth(0.9, context),
          child: txtHeading(
              "Current view represents the price difference of States & UT's with $city (₹ $price)",
              12,
              Theme.of(context).indicatorColor,
              FontWeight.w500),
        ),
        sizedHeight(15),
      ],
    );
  } else {
    return sizedHeight(0);
  }
}

viewInfoDetail(int index, String txt, BuildContext context) {
  if (index == 0) {
    return Column(
      children: <Widget>[
        Container(
          width: mediaWidth(1, context) - 22,
          child: txtHeading(
              "$txt",
              12,
              Theme.of(context).indicatorColor,
              FontWeight.w500),
        ),
        sizedHeight(15),
      ],
    );
  } else {
    return sizedHeight(0);
  }
}

switchViewBox(int index, bool detailedView, bool viewingPetrol,
    BuildContext context, Function() funcView, Function() funcFuel) {
  if (index == 0) {
    return Column(
      children: <Widget>[
        Row(
          children: <Widget>[
            GestureDetector(
              onTap: funcView,
              child: Container(
                width: mediaWidth(0.65, context),
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: <Widget>[
                      txtHeading(
                          detailedView
                              ? 'Switch to Graphical View'.tr
                              : 'Switch to Detailed view'.tr,
                          12,
                         Colors.blue,
                          FontWeight.w600),
                      Spacer(),
                      Icon(
                        Icons.filter_list,
                        color: Colors.blue,
                        size: 16,
                      )
                    ],
                  ),
                ),
              ),
            ),
            Spacer(),
            GestureDetector(
              onTap: funcFuel,
              child: Container(
                width: mediaWidth(0.25, context),
                decoration: BoxDecoration(
                  color: Theme.of(context).accentColor.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: <Widget>[
                      txtHeading(viewingPetrol ? 'Diesel'.tr.toUpperCase() : 'Petrol'.tr.toUpperCase(), 12,
                          Theme.of(context).accentColor, FontWeight.w600),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        sizedHeight(15),
      ],
    );
  } else {
    return sizedHeight(0);
  }
}

switchViewBoxIndia(
    int index, bool detailedView, BuildContext context, Function() funcView) {
  if (index == 0) {
    return Column(
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: funcView,
              child: Container(
                width: mediaWidth(1, context) - 23,
                decoration: BoxDecoration(
                  color: Colors.blue.withOpacity(0.25),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: Row(
                    children: <Widget>[
                      txtHeading(
                          detailedView
                              ? 'Switch to Graphical View'.tr
                              : 'Switch to Detailed view'.tr,
                          12,
                          Colors.blue,
                          FontWeight.w600),
                      Spacer(),
                      Icon(
                        Icons.filter_list,
                        color: Colors.blue,
                        size: 16,
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
        sizedHeight(10),
      ],
    );
  } else {
    return sizedHeight(0);
  }
}

contentCases(int i) {
  switch (i) {
    case 0:
      return 'Petrol';
      break;
    case 1:
      return 'Diesel';
      break;
    case 2:
      return 'Gold';
      break;
    case 3:
      return 'Silver';
      break;
  }
}

popupMenuCases(int i, BuildContext context){
  switch(i){
    case 1:
     return _changeLocaleDialog(context);
      break;
    case 2:
      return _shareApp();
      break;
    case 3:
      return '';
      break;
  }
}

_shareApp(){
  Share.share('KEEMAT !!!\n\nCheck Petrol | Diesel | Gold | Silver | LPG prices in one app and with daily price updations.');
}

_changeLocaleDialog(BuildContext context) {
    return showMaterialModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).backgroundColor.withOpacity(0.3),
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
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: <Widget>[
            sizedHeight(20),
            Row(
              children: <Widget>[
                sizedWidth(15),
                txtHeading('Change Language'.tr, 18,
                    Theme.of(context).highlightColor, FontWeight.bold),
                Spacer(),
              ],
            ),
            sizedHeight(20),
            seperationLine(),
            ListView.builder(
                itemCount: languageTransOptions.length,
                scrollDirection: Axis.vertical,
                padding: EdgeInsets.zero,
                physics: NeverScrollableScrollPhysics(),
                shrinkWrap: true,
                itemBuilder: (BuildContext context, int index) {
                  return Column(
                    children: <Widget>[
                      InkWell(
                        onTap: () {
                          _updateLocale(index, context);
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 17),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              txtHeading(
                                  languageTransOptions[index],
                                  15,
                                  Theme.of(context)
                                      .highlightColor
                                      .withOpacity(0.7),
                                  FontWeight.w600),
                            ],
                          ),
                        ),
                      ),
                      seperationLine(),
                    ],
                  );
                })
          ],
        ),
      ),
    );
  }

  _updateLocale(int index, BuildContext context) async{
    Get.updateLocale(getLangLocale(index));
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt("Lang", index);
    Provider.of<ThemeProvider>(context, listen: false).setLangCode(index);
  }

