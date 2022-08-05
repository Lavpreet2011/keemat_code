import 'package:flutter/cupertino.dart';
import 'package:keemat_controller/const/modals.dart';

class ChangedPrices extends ChangeNotifier{
  List<FuelModel> fuelChanges;
  double goldPrice;
  double silverPrice;
  double lpgPrice;

  void setFuelChanges(List<FuelModel> list){
    fuelChanges = list;
    notifyListeners();
  }

 
  void setGoldPrice(double price){
    goldPrice = price;
    notifyListeners();
  }
   void setSilverPrice(double price){
    silverPrice = price;
    notifyListeners();
  }
   void setlpgPrice(double price){
    lpgPrice = price;
    notifyListeners();
  }

   List<FuelModel> get getFuelChanges{
    return fuelChanges;
  }

  double get getGoldPrice{
    return goldPrice;
  }

  double get getSilverPrice{
    return silverPrice;
  }

  double get getLpgPrice{
    return lpgPrice;
  }
}