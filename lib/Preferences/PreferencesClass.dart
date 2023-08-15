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


  /// Settings variables
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

}