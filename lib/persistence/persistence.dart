import 'package:shared_preferences/shared_preferences.dart';

addIntToSP(String key, int value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setInt(key, value);
}

addDoubleToSP(String key, double value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setDouble(key, value);
}

addBoolToSP(String key, bool value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setBool(key, value);
}

addStringToSP(String key, String value) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);
}

getStringValuesSP(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return String
  String? stringValue = prefs.getString(key);
  return stringValue;
}
getBoolValuesSP(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return bool
  bool? boolValue = prefs.getBool(key);
  return boolValue;
}
getIntValuesSP(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return int
  int? intValue = prefs.getInt(key);
  return intValue;
}
getDoubleValuesSP(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  //Return double
  double? doubleValue = prefs.getDouble(key);
  return doubleValue;
}

removeValues(String key) async {
  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.remove(key);

}