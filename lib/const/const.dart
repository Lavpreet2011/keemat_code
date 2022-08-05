import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:get/get.dart';

//colors
Color greenColor = const Color(0xff1AC82B);
Color redColor = const Color(0xffFF4A4A);
Color yellowColor = Color(0xffFFBA33);

//gradients
List<Color> greenGradient = [
  Color(0xff02d39a),
  Color(0xff77ff85),
];
List<Color> redGradient = [
  Color(0xfff7b42c),
  Color(0xfffc575e),
];
List<Color> goldGradient = [
  Color(0xffB78628),
  Color(0xffDBA514),
];
List<Color> silverGradient = [
  Color(0xff8E8D8D),
  Color(0xffBEC0C2),
];

mediaHeight(double d, BuildContext context) {
  return MediaQuery.of(context).size.height * d;
}

mediaWidth(double d, BuildContext context) {
  return MediaQuery.of(context).size.width * d;
}

sizedWidth(double d) {
  return SizedBox(
    width: d,
  );
}

sizedHeight(double d) {
  return SizedBox(
    height: d,
  );
}

//txts
txtAlphabet(String txt, double fsize, Color color, FontWeight fw) {
  return Text(
    txt,
    style: GoogleFonts.montserrat(
      textStyle: TextStyle(
        fontSize: fsize,
        color: color,
        fontWeight: fw,
      ),
    ),
  );
}

txtAlphabetRAlign(String txt, double fsize, Color color, FontWeight fw) {
  return Text(
    txt,
    style: GoogleFonts.quicksand(
      textStyle: TextStyle(
        fontSize: fsize,
        color: color,
        fontWeight: fw,
      ),
    ),
    textAlign: TextAlign.right,
  );
}

txtHeading(String txt, double fsize, Color color, FontWeight fw) {
  return Text(
    txt,
    style: GoogleFonts.quicksand(
      textStyle: TextStyle(
        fontSize: fsize,
        color: color,
        fontWeight: fw,
      ),
    ),
  );
}

txtNumber(String txt, double fsize, Color color, FontWeight fw) {
  return Text(
    txt,
    style: GoogleFonts.cabin(
      textStyle: TextStyle(
        fontSize: fsize,
        color: color,
        fontWeight: fw,
      ),
    ),
  );
}

txtStyle(double fsize, Color color, FontWeight fw) {
  return GoogleFonts.quicksand(
    textStyle: TextStyle(
      fontSize: fsize,
      color: color,
      fontWeight: fw,
    ),
  );
}

txtStyleNumber(double fsize, Color color, FontWeight fw) {
  return GoogleFonts.karla(
    textStyle: TextStyle(
      fontSize: fsize,
      color: color,
      fontWeight: fw,
    ),
  );
}

//date formats
dateFormat(var datetime) {
  return datetime.day.toString() + ' ' + monthOptions(datetime.month);
}

dateShortFormat(var datetime) {
  return datetime.day.toString() +
      ' ' +
      monthOptions(datetime.month).toString().substring(0, 3) +
      ', ' +
      datetime.year.toString();
}

dateMonYear(var datetime) {
  return monthOptions(datetime.month).toString().substring(0, 3) +
      '/' +
      datetime.year.toString().substring(2, 4);
}

dateGraph12(var datetime) {
  return datetime.day.toString() + '/' + datetime.month.toString();
}

dateGraphXYZ(var datetime) {
  return datetime.day.toString() +
      '/' +
      monthOptions(datetime.month).toString().substring(0, 3);
}

dateFormatYear(var datetime) {
  return datetime.day.toString() +
      ' ' +
      monthOptions(datetime.month).toString().substring(0, 3) +
      ', ' +
      datetime.year.toString();
}

dateFormatFullYear(var datetime) {
  return datetime.day.toString() +
      ' ' +
      monthOptions(datetime.month).toString() +
      ', ' +
      datetime.year.toString();
}

timeFormat(var dateTime){
  return '' + _timeHour(dateTime.hour) +
      ' : ' +
      _timeSetter(dateTime.minute.toString()) + ' ' + _amPm(dateTime.hour);
}

_timeSetter(String number){
  if(number.length > 1){
    return '$number';
  }else{
    return '0$number';
  }
}

_timeHour(int number){
  if(number > 12){
    return _timeSetter((number - 12).toString());
  }else{
    return _timeSetter(number.toString());
  }
}

_amPm(int number){
  if(number >= 12){
    return 'Pm';
  }else{
    return 'Am';
  }
}

monthOptions(int m) {
  switch (m) {
    case 1:
      return 'January'.tr;
      break;
    case 2:
      return 'February'.tr;
      break;
    case 3:
      return 'March'.tr;
      break;
    case 4:
      return 'April'.tr;
      break;
    case 5:
      return 'May'.tr;
      break;
    case 6:
      return 'June'.tr;
      break;
    case 7:
      return 'July'.tr;
      break;
    case 8:
      return 'August'.tr;
      break;
    case 9:
      return 'September'.tr;
      break;
    case 10:
      return 'October'.tr;
      break;
    case 11:
      return 'November'.tr;
      break;
    case 12:
      return 'December'.tr;
      break;
  }
}

weekdayAllOptions(int index) {
  switch (index) {
    case 1:
      return 'Monday'.tr;
      break;
    case 2:
      return 'Tuesday'.tr;
      break;
    case 3:
      return 'Wednesday'.tr;
      break;
    case 4:
      return 'Thursday'.tr;
      break;
    case 5:
      return 'Friday'.tr;
      break;
    case 6:
      return 'Saturday'.tr;
      break;
    case 7:
      return 'Sunday'.tr;
      break;
  }
}
