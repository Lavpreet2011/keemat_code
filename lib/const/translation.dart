import 'dart:ui';

List languageOptions = ['English', 'Hindi', 'Punjabi'];
List languageTransOptions = ['English', 'हिन्दी' , 'ਪੰਜਾਬੀ'];

getLangLocale(int index){
  switch (index){
    case 0:
      return Locale('en', 'US');
      break;
    case 1:
      return Locale('hi', 'IN');
      break;
    case 2:
      return Locale('pb', 'IN');
      break;
  }
}