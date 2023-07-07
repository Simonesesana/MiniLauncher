import 'dart:async';
import 'package:minilauncher/Preferences/Preferences.dart';
import 'package:minilauncher/Themes/Theme.dart';
import 'package:minilauncher/main.dart';
import 'package:device_apps/device_apps.dart';

/// Function which initializes the launcher
Future<void> initializeLauncher () async {


  // Fetches app list
  await fetchAppList();

  // Retrieves the app theme
  await fetchAppTheme();

  preferences.showOnlyFavouriteAppsOnHomeScreen = true;

}



/// Fetches app list
Future<void> fetchAppList() async {
  /// Retrieves the app list
  preferences.apps = await DeviceApps.getInstalledApplications(
    includeAppIcons: true,
    includeSystemApps: true,
    onlyAppsWithLaunchIntent: true,
  );

  /// Ordinates the list in alphabetic order
  for (int i = 0; i < preferences.apps.length - 1; i++) {
    for (int j = 0; j < preferences.apps.length - i - 1; j++) {
      if (preferences.apps[j].appName.compareTo(preferences.apps[j + 1].appName) > 0) {
        var temp = preferences.apps[j];
        preferences.apps[j] = preferences.apps[j + 1];
        preferences.apps[j + 1] = temp;
      }
    }
  }

  /// Retrieves the favourite apps
  List<String> favouriteApps = await getStringList("favourite_apps");

  for (var element in preferences.apps) {
    for (var favouriteElement in favouriteApps) {
      if(element.packageName == favouriteElement){
        preferences.favouriteApps.add(element);
      }
    }
  }
}


/// Fetches app theme
Future<void> fetchAppTheme() async {

  String appTheme = await getString("app_theme");
  switch (appTheme) {
    case "light":
      preferences.selectedTheme = lightTheme;
      break;
    case "dark":
      preferences.selectedTheme = darkTheme;
      break;
    default:
      preferences.selectedTheme = darkTheme;
      break;
  }

}