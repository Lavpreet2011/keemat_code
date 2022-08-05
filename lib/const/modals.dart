class Record{
  double price;
  var date;

  Record({
    this.date,
    this.price,
  });
}

class LPGCylinders{
  final String type;
  final double price;

  const LPGCylinders({
    this.price,
    this.type,
  });
}

class Prices{
  var petrol, diesel, gold, silver, lpg;

  Prices({
    this.diesel,
    this.gold,
    this.petrol,
    this.silver,
    this.lpg,
  });

  factory Prices.fromMap(Map<String, dynamic> json){
    return Prices(
      diesel: json['Diesel'],
      gold: json['Gold'],
      petrol: json['Petrol'],
      silver: json['Silver'],
      lpg: json['LPG'],
    );

  }
}

class StateData{
  var city, code, petrol, diesel;

  StateData({
    this.diesel,
    this.petrol,
    this.city,
    this.code,
  });

  factory StateData.fromMap(Map<String, dynamic> json){
    return StateData(
      city: json['City'],
      code: json['Code'],
      diesel: json['Diesel'],
      petrol: json['Petrol'],
    );
  }
}

class IndiaData{
  var code, state, petrolMin, petrolMax, dieselMin, dieselMax, gold, silver;

  IndiaData({
    this.code,
    this.gold,
    this.silver,
    this.dieselMax,
    this.dieselMin,
    this.petrolMax,
    this.petrolMin,
    this.state
  });

  factory IndiaData.fromMap(Map<String, dynamic> json){
    return IndiaData(
      code: json['Code'],
      state: json['State'],
      petrolMin: json['PetrolMin'],
      petrolMax: json['PetrolMax'],
      dieselMin: json['DieselMin'],
      dieselMax: json['DieselMax'],
      gold: json['Gold'],
      silver: json['Silver'],
    );
  }
}

class IndiaSetter{
  final double minPetrol, maxPetrol, minDiesel, maxDiesel, gold, silver;
  final String state, stateCode;

  const IndiaSetter({
    this.state,
    this.gold,
    this.maxDiesel,
    this.maxPetrol,
    this.minDiesel,
    this.minPetrol,
    this.silver,
    this.stateCode,
  });
}

//for min max
class MinMaxQuery{
  double price;

  MinMaxQuery({
    this.price,
  });
}

class FuelModel{
  double petrol, diesel;

  FuelModel({this.diesel,this.petrol});

  

  factory FuelModel.fromMap(Map<String, dynamic> json){
    return FuelModel(
      diesel: json['cDiesel'].toDouble(),
      petrol: json['cPetrol'].toDouble(),
    );

  }
}