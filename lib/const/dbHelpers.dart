import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:keemat_controller/const/modals.dart';

getPetrolPrices(String field, DocumentSnapshot qrysnap) {
  return List<Record>.from(qrysnap.data()['$field'].map((item) {
    return new Record(
      date: item['Date'].toDate(),
      price: item['Petrol'].toDouble(),
    );
  }));
}

getDieselPrices(String field, DocumentSnapshot qrysnap) {
  return List<Record>.from(qrysnap.data()['$field'].map((item) {
    return new Record(
      date: item['Date'].toDate(),
      price: item['Diesel'].toDouble(),
    );
  }));
}

getGoldPrices(String field, DocumentSnapshot qrysnap) {
  return List<Record>.from(qrysnap.data()['$field'].map((item) {
    return new Record(
      date: item['Date'].toDate(),
      price: item['Gold'].toDouble(),
    );
  }));
}

getSilverPrices(String field, DocumentSnapshot qrysnap) {
  return List<Record>.from(qrysnap.data()['$field'].map((item) {
    return new Record(
      date: item['Date'].toDate(),
      price: item['Silver'].toDouble(),
    );
  }));
}

getLPGPrices(String field, DocumentSnapshot qrysnap) {
  return List<Record>.from(qrysnap.data()['$field'].map((item) {
    return new Record(
      date: item['Date'].toDate(),
      price: item['LPG'].toDouble(),
    );
  }));
}

//for state fetch
getStatePrices(String field, DocumentSnapshot qrysnap){
   return List<StateData>.from(qrysnap.data()['$field'].map((item) {
    return new StateData(
      city: item['City'],
      code: item['Code'],
      petrol: item['Petrol'].toDouble(),
      diesel: item['Diesel'].toDouble(),
    );
  }));
}

getIndiaPrices(String field, DocumentSnapshot qrysnap){
   return List<IndiaData>.from(qrysnap.data()['$field'].map((item) {
    return new IndiaData(
      code: item['Code'],
      state: item['State'],
      gold: item['Gold'],
      silver: item['Silver'],
      petrolMin: item['PetrolMin'],
      petrolMax: item['PetrolMax'],
      dieselMin: item['DieselMin'],
      dieselMax: item['DieselMax'],
    );
  }));
}

//for min max
getminMaxPetrol(String field, DocumentSnapshot qrysnap){
  return List<MinMaxQuery>.from(qrysnap.data()['$field'].map((item) {
    return new MinMaxQuery(
      price: item['Petrol'].toDouble(),
    );
  }));
}

getminMaxDiesel(String field, DocumentSnapshot qrysnap){
  return List<MinMaxQuery>.from(qrysnap.data()['$field'].map((item) {
    return new MinMaxQuery(
      price: item['Diesel'].toDouble(),
    );
  }));
}