import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:keemat_controller/Provider/ChangedPrices.dart';
import 'package:keemat_controller/addPrices/DemoResultScreen.dart';
import 'package:keemat_controller/addPrices/loopUpdater.dart';
import 'package:keemat_controller/const/const.dart';
import 'package:keemat_controller/const/decoration.dart';
import 'package:keemat_controller/const/modals.dart';
import 'package:keemat_controller/navigators/allNavigations.dart';
import 'package:keemat_controller/places/places.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:provider/provider.dart';

class DemoCheckScreen extends StatefulWidget {
  @override
  _DemoCheckScreenState createState() => _DemoCheckScreenState();
}

class _DemoCheckScreenState extends State<DemoCheckScreen> {
  bool _pcPetrol = false;
  bool _pcDiesel = false;
  bool _pcGold = false;
  bool _pcSilver = false;
  bool _pcLPG = false;
  TextEditingController _txtPetrol = TextEditingController();
  TextEditingController _txtDiesel = TextEditingController();
  TextEditingController _txtGold = TextEditingController();
  TextEditingController _txtSilver = TextEditingController();
  TextEditingController _txtLPG = TextEditingController();
  String _state = '';
  String _stateCode = '';
  int _stateIndex = 0;
  List<Prices> _fuelPricesList = new List();
  List<FuelModel> _changedFuelPrices = new List();

  @override
  void initState() {
    _callOnInit();
    super.initState();
  }

  _callOnInit() async {
    await _initalSetup();
  }

  Future<void> _initalSetup() async {
    setState(() {
      _state = stateOptions[0].state;
      _stateCode = stateOptions[0].code;
      _stateIndex = 0;
      _txtGold.text = '0';
      _txtSilver.text = '0';
      _txtDiesel.text = '0';
      _txtPetrol.text = '0';
      _txtLPG.text = '0';
    });
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: AppBar(
        title: txtHeading('Update Prices', 20, Theme.of(context).highlightColor,
            FontWeight.bold),
        leading: BackButton(
          color: Theme.of(context).highlightColor,
          onPressed: () {
            toHome(context);
          },
        ),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 25),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                txtHeading('State', 12, Theme.of(context).indicatorColor,
                    FontWeight.w500),
                sizedHeight(7),
                GestureDetector(
                  onLongPress: () {
                    _stateOptionsDialog();
                  },
                  child: Container(
                    width: double.infinity,
                    decoration: boxColored(context),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 15, vertical: 15),
                      child: Row(
                        children: <Widget>[
                          Container(
                            width: mediaWidth(0.7, context),
                            child: txtHeading(
                                _state,
                                15,
                                Theme.of(context)
                                    .highlightColor
                                    .withOpacity(0.7),
                                FontWeight.w800),
                          ),
                          Spacer(),
                          Icon(
                            Icons.keyboard_arrow_down,
                            color: Theme.of(context)
                                .highlightColor
                                .withOpacity(0.7),
                            size: 19,
                          )
                        ],
                      ),
                    ),
                  ),
                ),
                sizedHeight(25),
                Container(
                  height: 30,
                  width: double.infinity,
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      _changedFuels('GOLD', _pcGold, () {
                        setState(() {
                          _pcGold = !_pcGold;
                        });
                      }),
                      _changedFuels('SILVER', _pcSilver, () {
                        setState(() {
                          _pcSilver = !_pcSilver;
                        });
                      }),
                      _changedFuels('PETROL', _pcPetrol, () {
                        setState(() {
                          _pcPetrol = !_pcPetrol;
                        });
                      }),
                      _changedFuels('DIESEL', _pcDiesel, () {
                        setState(() {
                          _pcDiesel = !_pcDiesel;
                        });
                      }),
                      _changedFuels('LPG', _pcLPG, () {
                        setState(() {
                          _pcLPG = !_pcLPG;
                        });
                      }),
                    ],
                  ),
                ),
                sizedHeight(25),
                _txtFieldsHandler(_pcPetrol, 'Petrol', _txtPetrol),
                _txtFieldsHandler(_pcDiesel, 'Diesel', _txtDiesel),
                _txtFieldsHandler(_pcGold, 'Gold', _txtGold),
                _txtFieldsHandler(_pcSilver, 'Silver', _txtSilver),
                _txtFieldsHandler(_pcLPG, 'LPG', _txtLPG),
                sizedHeight(80),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: <Widget>[
                    GestureDetector(
                      onTap: () {
                        getApiResults();
                        //setChanges();
                      },
                      child: Container(
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              color: Colors.green),
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: Row(
                              children: <Widget>[
                                Icon(
                                  Icons.subscriptions,
                                  color: Colors.white,
                                  size: 20,
                                ),
                                sizedWidth(15),
                                txtHeading('Preview', 16, Colors.white,
                                    FontWeight.w700)
                              ],
                            ),
                          )),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  void newDemoSettings(){

  }

  void getApiResults() async{
    var url = 'https://script.googleusercontent.com/macros/echo?user_content_key=tNHsUQOx6uaUCfHgM5lu9JTTbuCR-pCp59gBOHBTK1-np1a8yUg6mu_-qPqeEG34LiQX7aNv5oVPT9AtVkC4UiYHpbb_n91am5_BxDlH2jW0nuo2oDemN9CCS2h10ox_1xSncGQajx_ryfhECjZEnOgK-JfMfgxwaNqGsPH5yLesXrYJ65T4VywgVLfjh--5zLh-_yuMxjRrMhxR1rrYtN1XkgrEEtGKEt3_Sra11sGAziqwru-sKw&lib=MBZL_VFgBt_vofEaaS1Ha8LTAXNRazKmj';
      http.get(url).then((res) {
        if(res.statusCode == 200){
          final parsed = json.decode(res.body).cast<Map<String, dynamic>>();
        _changedFuelPrices =
            parsed.map<FuelModel>((json) => FuelModel.fromMap(json)).toList();
        }
      }).then((value) {
        setChanges();
      }).then((value) {
        _navigateToResultScreen();
      });
  }

  void setChanges() {
    final provider = Provider.of<ChangedPrices>(context, listen: false);
      provider.setFuelChanges(_changedFuelPrices);
      provider.setGoldPrice(double.parse(_txtGold.text));
      provider.setSilverPrice(double.parse(_txtSilver.text));
      provider.setlpgPrice(double.parse(_txtLPG.text));
    
   // uponValueAdding();
  }

  void uponValueAdding() {
    if (_stateIndex == stateOptions.length - 1) {
      // final provider = Provider.of<ChangedPrices>(context, listen: false);
      // provider.setFuelChanges(_fuelPricesList);
      _navigateToResultScreen();
    } else {
      setState(() {
        _stateIndex++;
        _state = stateOptions[_stateIndex].state;
        _stateCode = stateOptions[_stateIndex].code;
        _pcGold = false;
        _pcSilver = false;
        _pcLPG = false;
      });
      log('value updated in states');
    }
  }

  _navigateToResultScreen() {
    Navigator.push(
        context, MaterialPageRoute(builder: (_) => DemoResultScreen()));
  }

  _txtFieldsHandler(
      bool visi, String txt, TextEditingController txtController) {
    return Visibility(
      visible: visi,
      child: Column(
        children: <Widget>[
          seperationLine(),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 15),
            child: Row(
              children: <Widget>[
                txtHeading('$txt', 16, Theme.of(context).indicatorColor,
                    FontWeight.w700),
                Spacer(),
                Container(
                  width: mediaWidth(0.2, context),
                  child: TextField(
                    controller: txtController,
                    keyboardType: TextInputType.number,
                    autocorrect: false,
                    enableSuggestions: false,
                    cursorColor: Theme.of(context).highlightColor,
                    decoration: InputDecoration(
                        border: InputBorder.none,
                        prefixText: '₹ ',
                        hintText: '0.0',
                        hintStyle: txtStyleNumber(14,
                            Theme.of(context).indicatorColor, FontWeight.w600),
                        prefixStyle: txtStyleNumber(14,
                            Theme.of(context).highlightColor, FontWeight.bold)),
                    textAlign: TextAlign.center,
                    style: txtStyleNumber(
                        14, Theme.of(context).highlightColor, FontWeight.bold),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  _changedFuels(String txt, bool changed, Function() func) {
    return Row(
      children: <Widget>[
        GestureDetector(
          onTap: func,
          child: Container(
            decoration: BoxDecoration(
                color: changed
                    ? Theme.of(context).accentColor.withOpacity(0.2)
                    : Colors.transparent,
                borderRadius: BorderRadius.circular(10),
                border: Border.all(
                    color: Theme.of(context).accentColor.withOpacity(0.2),
                    width: changed ? 0 : 1)),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
              child: Center(
                child: txtHeading(
                    '$txt',
                    10,
                    changed
                        ? Theme.of(context).accentColor
                        : Theme.of(context).accentColor.withOpacity(0.7),
                    FontWeight.w700),
              ),
            ),
          ),
        ),
        sizedWidth(12),
      ],
    );
  }

  _stateOptionsDialog() {
    return showMaterialModalBottomSheet(
      context: context,
      backgroundColor: Theme.of(context).backgroundColor.withOpacity(0.3),
      builder: (context) => Container(
        height: mediaHeight(0.8, context),
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
            sizedHeight(15),
            Row(
              children: <Widget>[
                sizedWidth(15),
                txtHeading('Select a State/UT', 18,
                    Theme.of(context).highlightColor, FontWeight.bold),
                Spacer(),
              ],
            ),
            sizedHeight(15),
            seperationLine(),
            Flexible(
              child: Container(
                width: double.infinity,
                child: ListView.builder(
                    itemCount: stateOptions.length,
                    scrollDirection: Axis.vertical,
                    padding: EdgeInsets.zero,
                    itemBuilder: (BuildContext context, int index) {
                      return InkWell(
                        onTap: () {
                          setState(() {
                            _state = stateOptions[index].state;
                            _stateCode = stateOptions[index].code;
                            _stateIndex = index;
                          });
                          print(_stateIndex);
                          Navigator.pop(context);
                        },
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 15, vertical: 20),
                          child: Row(
                            children: <Widget>[
                              Container(
                                width: mediaWidth(0.8, context),
                                child: txtHeading(
                                    stateOptions[index].state,
                                    15,
                                    Theme.of(context).indicatorColor,
                                    FontWeight.bold),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              ),
            )
          ],
        ),
      ),
    );
  }
}
