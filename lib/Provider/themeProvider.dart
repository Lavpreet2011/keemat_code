import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

class ThemeProvider extends ChangeNotifier {
  ThemeMode themeMode = ThemeMode.system;
  double petrol = 0;
  double diesel = 0;
  double gold = 0;
  double silver = 0;
  String city = '';
  String cityCode = '';
  String state = '';
  String stateCode = '';
  int langCode = 0;

  bool get isDarkMode {
    if (themeMode == ThemeMode.system) {
      final brightness = SchedulerBinding.instance.window.platformBrightness;
      return brightness == Brightness.dark;
    } else {
      return themeMode == ThemeMode.dark;
    }
  }

  void toggleTheme(bool isOn) {
    themeMode = isOn ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }

  void setPrices(double p, double d, double g, double s){
    petrol = p;
    diesel = d;
    gold = g;
    silver = s;
    notifyListeners();
  }

  void setLocation(String gcity, String gcityCode, String gstate, String gstateCode){
    city = gcity;
    cityCode = gcityCode;
    state = gstate;
    stateCode = gstateCode;
    notifyListeners();
  }

  void setLangCode(int code){
    langCode = code;
    notifyListeners();
  }

  double get getPetrol{
    return petrol;
  }

  double get getDiesel{
    return diesel;
  }

  double get getGold{
    return gold;
  }

  double get getSilver{
    return silver;
  }

  String get getCity{
    return city;
  }

  String get getCityCode{
    return cityCode;
  }

  String get getState{
    return state;
  }

  String get getStateCode{
    return stateCode;
  }

  int get getLangCode{
    return langCode;
  }

}

class MyThemes {
  static final darkTheme = ThemeData(
    scaffoldBackgroundColor: Color(0xff1A1A1A),
    colorScheme: ColorScheme.dark(),
    highlightColor: Colors.white,
    backgroundColor: Color(0xff2F2F2F),
    accentColor: Color(0xffFFBA33),
    indicatorColor: Colors.grey[600],
    primaryColor: Color(0xff1A1A1A),
  );

  static final lightTheme = ThemeData(
    scaffoldBackgroundColor: Color(0xffFFFBF3),
    colorScheme: ColorScheme.light(),
    backgroundColor: Color(0xffffffff),
    accentColor: Color(0xffFFBA33),
    highlightColor: Color(0xff262626),
    indicatorColor: Colors.grey[600],
    primaryColor: Color(0xffE3E3E3),
  );
}

