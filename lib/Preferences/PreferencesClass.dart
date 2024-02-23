import 'dart:convert';

import '../Themes/Theme.dart';
import 'package:minilauncher/main.dart';
import 'package:minilauncher/Preferences/Preferences.dart';

class FavouriteApplication {
  String appName;
  String packageName;
  var icon;
  FavouriteApplication(this.appName, this.packageName, this.icon);
}

class PreferencesClass {

  /// Selected theme
  Theme selectedTheme = darkTheme;

  /// List of all the applications
  List apps = [];
  /// List of favourite applications
  List<FavouriteApplication> favouriteApps = [];
  /// List of restricted applications
  List restrictedApps = [];
  List<String> restrictedPackages = [];


  /// Restricted app timer
  double restrictedAppTimer = 0.0;

  /// Max phone usage
  double maxPhoneUsage = 120;

  /// Focus mode timer in minutes
  double focusModeTimer = 30;

  /// Settings variables
  bool showRoundIcons = false;
  bool showSecondsOnClock = true;
  bool showBackgroundOnHomeScreen = false;
  bool showDialerButtonOnHomeScreen = false;
  bool showOnlyFavouriteAppsOnHomeScreen = true;
  bool automaticallyOpenKeyboardOnAppDrawer = false;

  /// Focus mode
  DateTime focusModeEnd = DateTime.now().subtract(const Duration(minutes: 1));

  /// Sets an app as favourite
  static addFavouriteApp(String appName, String packageName, var icon) {

    /// Adds the favourite app to the favourite apps list
    preferences.favouriteApps.add(FavouriteApplication(appName, packageName, icon));

    /// Saves everything in the shared preferences
    List<String> favouritePackages = [];
    List<String> favouriteNames = [];
    List<String> favouriteIcons = [];
    for (var element in preferences.favouriteApps) {
      favouritePackages.add(element.packageName);
      favouriteNames.add(element.appName);
      favouriteIcons.add(base64Encode(element.icon));
    }
    setStringList("favourite_apps_names", favouriteNames);
    setStringList("favourite_apps_packages", favouritePackages);
    setStringList("favourite_apps_icons", favouriteIcons);

  }

  /// Removes an app from the favourite list
  static removeFavouriteApp(String packageName) {

    /// Removes the favourite app to the favourite apps list
    for (var element in preferences.favouriteApps) {
      if(element.packageName == packageName) {
        preferences.favouriteApps.remove(element);
        break;
      }
    }

    /// Saves everything in the shared preferences
    List<String> favouritePackages = [];
    List<String> favouriteNames = [];
    List<String> favouriteIcons = [];
    for (var element in preferences.favouriteApps) {
      favouritePackages.add(element.packageName);
      favouriteNames.add(element.appName);
      favouriteIcons.add(element.icon.toString());
    }
    setStringList("favourite_apps_names", favouriteNames);
    setStringList("favourite_apps_packages", favouritePackages);
    setStringList("favourite_apps_icons", favouriteIcons);

  }

  /// Sets an app as restricted
  static Future<void> addRestrictedApp(String packageName)  async {

    /// Adds the restricted app to the restricted apps list based on the
    /// package name
    for (var element in preferences.apps) {
      if(element.packageName == packageName) {
        preferences.restrictedApps.add(element);
        preferences.restrictedPackages.add(element.packageName);
      }
    }

    /// Saves everything in the shared preferences
    setStringList("restricted_apps", preferences.restrictedPackages);

  }

  /// Removes an app from the restricted list
  static Future<void> removeRestrictedApp(String packageName)  async {

    /// Adds the favourite app to the favourite apps list based on the
    /// package name
    for (var element in preferences.apps) {
      if(element.packageName == packageName) {
        preferences.restrictedApps.remove(element);
        preferences.restrictedPackages.remove(element.packageName);
      }
    }

    /// Saves everything in the shared preferences
    setStringList("restricted_apps", preferences.restrictedPackages);

  }

}