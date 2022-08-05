import 'package:keemat_controller/places/places.dart';
import './placesModal.dart';

stateModal(String code, String state, bool isState) {
  return State(
    code: code,
    state: state,
    isState: isState,
  );
}

cityModal(String city, String code) {
  return City(
    code: code,
    city: city,
  );
}

statesSwitch(String code) {
  switch (code) {
    case 'AN':
      return anCities;
      break;
    case 'AP':
      return apCities;
      break;
    case 'AR':
      return arCities;
      break;
    case 'AS':
      return asCities;
      break;
    case 'BR':
      return brCities;
      break;
    case 'CG':
      return cgCities;
      break;
    case 'CH':
      return chCities;
      break;
    case 'DD':
      return ddCities;
      break;
    case 'DL':
      return dlCities;
      break;
    case 'GA':
      return gaCities;
      break;
    case 'GJ':
      return gjCities;
      break;
    case 'HP':
      return hpCities;
      break;
    case 'HR':
      return hrCities;
      break;
    case 'JH':
      return jhCities;
      break;
    case 'JK':
      return jkCities;
      break;
    case 'KA':
      return kaCities;
      break;
    case 'KL':
      return klCities;
      break;
    case 'LA':
      return laCities;
      break;
    case 'MH':
      return mhCities;
      break;
    case 'ML':
      return mlCities;
      break;
    case 'MN':
      return mnCities;
      break;
    case 'MP':
      return mpCities;
      break;
    case 'MZ':
      return mzCities;
      break;
    case 'NL':
      return nlCities;
      break;
    case 'OD':
      return odCities;
      break;
    case 'PB':
      return pbCities;
      break;
    case 'PY':
      return pyCities;
      break;
    case 'RJ':
      return rjCities;
      break;
    case 'SK':
      return skCities;
      break;
    case 'TN':
      return tnCities;
      break;
    case 'TR':
      return trCities;
      break;
    case 'TS':
      return tsCities;
      break;
    case 'UK':
      return ukCities;
      break;
    case 'UP':
      return upCities;
      break;
    case 'WB':
      return wbCities;
      break;
  }
}
