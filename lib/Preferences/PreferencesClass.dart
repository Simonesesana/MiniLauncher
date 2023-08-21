import '../Themes/Theme.dart';
import 'package:minilauncher/main.dart';
import 'package:minilauncher/Preferences/Preferences.dart';

class PreferencesClass {

  /// Selected theme
  Theme selectedTheme = darkTheme;

  /// List of all the applications
  List apps = [];
  /// List of favourite applications
  List favouriteApps = [];
  /// List of restricted applications
  List restrictedApps = [];
  List<String> restrictedPackages = [];

  /// Restricted app timer
  double restrictedAppTimer = 0.0;

  /// Settings variables
  late bool showRoundIcons;
  late bool showSecondsOnClock;
  late bool showBackgroundOnHomeScreen;
  late bool showOnlyFavouriteAppsOnHomeScreen;

  /// Sets an app as favourite
  static Future<void> addFavouriteApp(String packageName)  async {

    /// Adds the favourite app to the favourite apps list based on the
    /// package name
    preferences.apps.forEach((element) {
      if(element.packageName == packageName) {
        preferences.favouriteApps.add(element);
      }
    });

    /// Saves everything in the shared preferences
    List<String> favouritePackages = [];
    preferences.favouriteApps.forEach((element) {
      favouritePackages.add(element.packageName);
    });
    setStringList("favourite_apps", favouritePackages);

  }

  /// Removes an app from the favourite list
  static Future<void> removeFavouriteApp(String packageName)  async {

    /// Adds the favourite app to the favourite apps list based on the
    /// package name
    for (var element in preferences.apps) {
      if(element.packageName == packageName) {
        preferences.favouriteApps.remove(element);
      }
    }

    /// Saves everything in the shared preferences
    List<String> favouritePackages = [];
    preferences.favouriteApps.forEach((element) {
      favouritePackages.add(element.packageName);
    });
    setStringList("favourite_apps", favouritePackages);

  }

  /// Sets an app as restricted
  static Future<void> addRestrictedApp(String packageName)  async {

    /// Adds the restricted app to the restricted apps list based on the
    /// package name
    preferences.apps.forEach((element) {
      if(element.packageName == packageName) {
        preferences.restrictedApps.add(element);
        preferences.restrictedPackages.add(element.packageName);
      }
    });

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