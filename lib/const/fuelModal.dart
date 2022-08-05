import 'modals.dart';

class Petrol {
  bool listView;
  List<Record> list7D, list1M, list3M, list6M, list1Y, highLow;

  Petrol({
    this.list7D,
    this.listView,
    this.list1Y,
    this.highLow,
    this.list3M,
    this.list6M,
    this.list1M,
  });
}

class Diesel {
  bool listView;
  List<Record> list7D, list1M, list3M, list6M, list1Y, highLow;

  Diesel({
    this.list7D,
    this.listView,
    this.list1Y,
    this.list3M,
    this.list6M,
    this.list1M,
    this.highLow,
  });
}

class Gold {
  bool listView;
  List<Record> list7D, list1M, list3M, list6M, list1Y, highLow;

  Gold({
    this.list7D,
    this.listView,
    this.list1Y,
    this.list3M,
    this.list6M,
    this.list1M,
    this.highLow,
  });
}

class Silver {
  bool listView;
  List<Record> list7D, list1M, list3M, list6M, list1Y, highLow;

  Silver({
    this.list7D,
    this.listView,
    this.list1Y,
    this.list3M,
    this.list6M,
    this.list1M,
    this.highLow,
  });
}

class LPG {
  bool listView;
  List<Record> list7D, list1M, list3M, list6M, list1Y, highLow;

  LPG({
    this.list7D,
    this.listView,
    this.list1Y,
    this.list3M,
    this.list6M,
    this.list1M,
    this.highLow,
  });
}

//for min max
class MinMaxPetrol {
  List<MinMaxQuery> minMax;

  MinMaxPetrol({
    this.minMax,
  });
}

class MinMaxDiesel {
  List<MinMaxQuery> minMax;

  MinMaxDiesel({
    this.minMax,
  });
}

//for state prices
class StateFetchData{
  List<StateData> prices;

  StateFetchData({
    this.prices,
  });
}

class IndiaFetchData{
  List<IndiaData> prices;

  IndiaFetchData({
    this.prices,
  });
}