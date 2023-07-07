import 'package:shared_preferences/shared_preferences.dart';

/// STRING LIST
/// ////////////////////////////////////////////////////////////////////////////
/// Get string list
Future<List<String>> getStringList(String key) async {

  SharedPreferences prefs = await SharedPreferences.getInstance();

  List<String>? value = [];
  value = prefs.getStringList(key);

  if(value != null ) {
    return value;
  } else {
    return [];
  }

}

/// Set string list
Future<void> setStringList(String key, List<String> value) async {

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setStringList(key, value);

}
/// ////////////////////////////////////////////////////////////////////////////


/// STRING LIS
/// ////////////////////////////////////////////////////////////////////////////
/// Get string
Future<String> getString(String key) async {

  SharedPreferences prefs = await SharedPreferences.getInstance();

  String? value = "";
  value = prefs.getString(key);

  if(value != null ) {
    return value;
  } else {
    return "";
  }

}

/// Set string list
Future<void> setString(String key, String value) async {

  SharedPreferences prefs = await SharedPreferences.getInstance();
  prefs.setString(key, value);

}
/// ////////////////////////////////////////////////////////////////////////////