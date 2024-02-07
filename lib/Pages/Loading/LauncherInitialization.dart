import 'dart:async';
import 'dart:convert';
import 'package:minilauncher/main.dart';
import 'package:device_apps/device_apps.dart';
import 'package:minilauncher/Preferences/Preferences.dart';
import 'package:minilauncher/Preferences/WeatherForecast.dart';
import 'package:minilauncher/Preferences/PreferencesClass.dart';

/// Function which initializes the launcher
Future<void> initializeLauncher (
      {bool? fetchOnlyAppList}
    ) async {

  if(fetchOnlyAppList != null && fetchOnlyAppList) {
    await fetchAppList();
    orderApps();
    return;
  }

  // Fetches app list
  await fetchAppList();

  // Orders apps in alphabetic order
  orderApps();

  // Gets weather forecast
  weatherForecast.getWeatherForecast();

}



/// Fetches app list
Future<void> fetchAppList() async {

  /// Retrieves the app list
  preferences.apps = await DeviceApps.getInstalledApplications(
    includeAppIcons: true,
    includeSystemApps: true,
    onlyAppsWithLaunchIntent: true,
  );

  /// Retrieves the restricted apps
  List<String> restrictedApps = await getStringList("restricted_apps");

  for (var element in preferences.apps) {

    if(restrictedApps.contains(element.packageName)) {
      preferences.restrictedApps.add(element);
      preferences.restrictedPackages.add(element.packageName);
    }

  }

}


/// Fetches settings preferences
Future<void> fetchSettingsPreferences () async {

  bool _showOnlyFavouriteAppsOnHomeScreen = await getBool("showOnlyFavouriteAppsOnHomeScreen");
  preferences.showOnlyFavouriteAppsOnHomeScreen = _showOnlyFavouriteAppsOnHomeScreen;

  bool _showBackgroundOnHomeScreen = await getBool("showBackgroundOnHomeScreen");
  preferences.showBackgroundOnHomeScreen = _showBackgroundOnHomeScreen;

  int _restrictedAppTimer = await getInt("restrictedAppTimer");
  preferences.restrictedAppTimer = _restrictedAppTimer.toDouble();

  int _maxPhoneUsage = await getInt("maxPhoneUsage");
  if(_maxPhoneUsage != 0) {
    preferences.maxPhoneUsage = _maxPhoneUsage.toDouble();
  }

  bool _showSecondsOnClock = await getBool("showSecondsOnClock");
  preferences.showSecondsOnClock = _showSecondsOnClock;

  bool _showRoundIcons = await getBool("showRoundIcons");
  preferences.showRoundIcons = _showRoundIcons;

  bool _showDialerButtonOnHomeScreen = await getBool("showDialerButtonOnHomeScreen");
  preferences.showDialerButtonOnHomeScreen = _showDialerButtonOnHomeScreen;

  bool _automaticallyOpenKeyboardOnAppDrawer = await getBool("automaticallyOpenKeyboardOnAppDrawer");
  preferences.automaticallyOpenKeyboardOnAppDrawer = _automaticallyOpenKeyboardOnAppDrawer;

}


/// Orders app into alphabetic order
void orderApps() {
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
}


/// Fetches favourite apps
Future<void> fetchFavouriteApps() async {

  List<String> favouritePackages = await getStringList("favourite_apps_names");
  List<String> favouriteNames = await getStringList("favourite_apps_packages");
  List<String> favouriteIcons = await getStringList("favourite_apps_icons");

  for (int i = 0; i < favouritePackages.length; i++) {
    preferences.favouriteApps.add(FavouriteApplication(
        favouritePackages[i],
        favouriteNames[i],
        base64Decode(favouriteIcons[i])
    ));
  }

}