import 'dart:convert';
import 'package:flutter/services.dart';
import 'package:minilauncher/Preferences/Preferences.dart';

var lng;

class Lng {

  static String locale = 'en';

  static Future<void> initializeLanguage() async {

    // Gets preferred language from shared preferences
    String ln = await getString("preferredLanguage");

    // Changes language
    if(ln == "") {
      await changeLanguage("en", forceFetch: true);
    } else if (ln == "it") {
      await changeLanguage("it", forceFetch: true);
    } else if (ln == "en") {
      await changeLanguage("en", forceFetch: true);
    }

  }

  static Future<void> changeLanguage(
      String _locale,
      {bool forceFetch = false}
    ) async {

    if(_locale == locale && !forceFetch) return;

    if(!forceFetch) {
      await setString("preferredLanguage", _locale);
    }

    switch(_locale) {
      case 'it':
        String jsonString = await rootBundle.loadString('lib/Internationalization/it.json');
        lng = jsonDecode(jsonString);
        locale = 'it';
        break;
      case 'en':
        String jsonString = await rootBundle.loadString('lib/Internationalization/en.json');
        lng = jsonDecode(jsonString);
        locale = 'en';
        break;
    }


  }

}