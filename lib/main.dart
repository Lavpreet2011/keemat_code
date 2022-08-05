import 'package:firebase_analytics/firebase_analytics.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/root_widget.dart';
import 'package:keemat_controller/Provider/ChangedPrices.dart';
import 'package:keemat_controller/const/const.dart';
import 'package:keemat_controller/const/decoration.dart';
import 'package:keemat_controller/navigators/allNavigations.dart';
import 'package:keemat_controller/notifications/notification_service.dart';
import 'package:provider/provider.dart';
import 'package:wakelock/wakelock.dart';
import 'Provider/themeProvider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  await NotificationService().init();
  Wakelock.enable();
  Provider.debugCheckInvalidValueType = null;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) => MultiProvider(
        providers: [
          Provider<ThemeProvider>(create: (context) => ThemeProvider()),
          Provider<ChangedPrices>(create: (context) => ChangedPrices())
        ],
        builder: (context, _) {
          final themeProvider = Provider.of<ThemeProvider>(context);
          return GetMaterialApp(
            // translations: Messages(), // your translations
            locale: Locale(
                'en', 'US'), // translations will be displayed in that locale
            fallbackLocale: Locale('en', 'US'),
            title: 'Flutter Demo',
            themeMode: themeProvider.themeMode,
            debugShowCheckedModeBanner: false,
            darkTheme: MyThemes.darkTheme,
            theme: MyThemes.lightTheme,
            home: MyHomePage(),
          );
        },
      );
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  void initState() {
    _callAnalytics();
    super.initState();
  }

  _callAnalytics() async {
    FirebaseAnalytics analytics = FirebaseAnalytics();

    await analytics.logEvent(name: "App_Launched_now");
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: <Widget>[
            sizedHeight(45),
            _decoBoxLocal('State Pricer', context, () {
              toStatePriceSetter(context);
            }),
            _decoBoxLocal('India Pricer', context, () {
              toIndiaPriceSetter(context);
            }),
            _decoBoxLocal('Add Days', context, () {
              toAddMoreDays(context);
            }),
             _decoBoxLocal('Demo Screen', context, () {
              demoScreen(context);
            }),
             _decoBoxLocal('Update Logs', context, () {
              logScreen(context);
            })
          ],
        ),
      ),
    );
  }
}

_decoBoxLocal(String txt, BuildContext context, Function() func) {
  return Container(
    width: mediaWidth(1, context),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: <Widget>[
        GestureDetector(
          onTap: func,
          child: Container(
            width: mediaWidth(0.95, context),
            decoration: boxColored(context),
            child: Padding(
              padding: const EdgeInsets.all(13.0),
              child: Center(
                child: txtHeading('$txt', 15, Theme.of(context).highlightColor,
                    FontWeight.bold),
              ),
            ),
          ),
        ),
        sizedHeight(20),
      ],
    ),
  );
}
