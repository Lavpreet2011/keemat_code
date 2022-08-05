import 'package:flutter/material.dart';
import 'package:keemat_controller/addPrices/loopUpdater.dart';
import 'package:keemat_controller/const/const.dart';
import 'package:keemat_controller/const/decoration.dart';
import 'package:keemat_controller/navigators/allNavigations.dart';
import 'package:keemat_controller/places/places.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';

class UpdatePrices extends StatefulWidget {
  final int stateIndex;
  final String goldText, silverText, petrolText, dieselText, lpgText;
  final bool petrolChanged,
      dieselChanged,
      goldChanged,
      silverChanged,
      lpgChanged;
  UpdatePrices({
    this.stateIndex,
    this.goldText,
    this.silverText,
    this.dieselChanged,
    this.goldChanged,
    this.lpgChanged,
    this.petrolChanged,
    this.silverChanged,
    this.dieselText,
    this.lpgText,
    this.petrolText,
  });
  @override
  _UpdatePricesState createState() => _UpdatePricesState();
}


class _UpdatePricesState extends State<UpdatePrices> {
  bool _pcPetrol, _pcDiesel, _pcGold, _pcSilver, _pcLPG;
  TextEditingController _txtPetrol = TextEditingController();
  TextEditingController _txtDiesel = TextEditingController();
  TextEditingController _txtGold = TextEditingController();
  TextEditingController _txtSilver = TextEditingController();
  TextEditingController _txtLPG = TextEditingController();
  String _state = '';
  String _stateCode = '';
  int _stateIndex = 0;

  @override
  void initState() {
    _callOnInit();
    super.initState();
  }

  _callOnInit() async{
    await _initalSetup();
    if(_stateIndex > 0){
      _navigateToLoopScreen();
    }
  }

  Future<void> _initalSetup() async{
    setState(() {
      _state = stateOptions[widget.stateIndex].state;
      _stateCode = stateOptions[widget.stateIndex].code;
      _pcLPG = widget.lpgChanged;
      _pcPetrol = widget.petrolChanged;
      _pcSilver = widget.silverChanged;
      _pcGold = widget.goldChanged;
      _pcDiesel = widget.dieselChanged;
      _stateIndex = widget.stateIndex;
      _txtGold.text = widget.goldText;
      _txtSilver.text = widget.silverText;
      _txtDiesel.text = widget.dieselText;
      _txtPetrol.text = widget.petrolText;
      _txtLPG.text = widget.lpgText;
      print(_state + _stateCode);
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
                        
                      _navigateToLoopScreen();
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
                                txtHeading(
                                    'Preview', 16, Colors.white, FontWeight.w700)
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

  _navigateToLoopScreen(){
     Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (_) => LoopUpdater(
                                        diesel: _pcDiesel ? double.parse(_txtDiesel.text) : 0,
                                        gold: _pcGold ? double.parse(_txtGold.text) : 0,
                                        lpg:  _pcLPG ? double.parse(_txtLPG.text) : 0,
                                        petrol: _pcPetrol ? double.parse(_txtPetrol.text) : 0,
                                        silver: _pcSilver ? double.parse(_txtSilver.text) : 0,
                                        state: _state,
                                        stateCode: _stateCode,
                                        stateIndex: _stateIndex,
                                        dieselChanged: _pcDiesel,
                                        goldChanged: _pcGold,
                                        lpgChanged: _pcLPG,
                                        petrolChanged: _pcPetrol,
                                        silverChanged: _pcSilver,
                                      )));
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
