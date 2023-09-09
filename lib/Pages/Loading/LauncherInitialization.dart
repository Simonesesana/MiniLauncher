import 'dart:async';
import 'package:minilauncher/main.dart';
import 'package:device_apps/device_apps.dart';
import 'package:minilauncher/Preferences/Preferences.dart';

/// Function which initializes the launcher
Future<void> initializeLauncher (
      {bool? fetchOnlyAppList}
    ) async {

  if(fetchOnlyAppList != null && fetchOnlyAppList) {
    await fetchAppList();
    orderApps();
    return;
  }

  // Fetches settings preferences
  await fetchSettingsPreferences();

  // Fetches app list
  await fetchAppList();

  // Orders apps in alphabetic order
  orderApps();

}



/// Fetches settings preferences
Future<void> fetchSettingsPreferences () async {

  bool _showOnlyFavouriteAppsOnHomeScreen = await getBool("showOnlyFavouriteAppsOnHomeScreen");
  preferences.showOnlyFavouriteAppsOnHomeScreen = _showOnlyFavouriteAppsOnHomeScreen;

  bool _showBackgroundOnHomeScreen = await getBool("showBackgroundOnHomeScreen");
  preferences.showBackgroundOnHomeScreen = _showBackgroundOnHomeScreen;

  int _restrictedAppTimer = await getInt("restrictedAppTimer");
  preferences.restrictedAppTimer = _restrictedAppTimer.toDouble();

  bool _showSecondsOnClock = await getBool("showSecondsOnClock");
  preferences.showSecondsOnClock = _showSecondsOnClock;

  bool _showRoundIcons = await getBool("showRoundIcons");
  preferences.showRoundIcons = _showRoundIcons;


}


/// Fetches app list
Future<void> fetchAppList() async {

  /// Retrieves the app list
  preferences.apps = await DeviceApps.getInstalledApplications(
    includeAppIcons: true,
    includeSystemApps: true,
    onlyAppsWithLaunchIntent: true,
  );

  /// Retrieves the favourite and restricted apps
  List<String> favouriteApps = await getStringList("favourite_apps");
  List<String> restrictedApps = await getStringList("restricted_apps");

  for (var element in preferences.apps) {

    if(favouriteApps.contains(element.packageName)) {
      preferences.favouriteApps.add(element);
    }

    if(restrictedApps.contains(element.packageName)) {
      preferences.restrictedApps.add(element);
      preferences.restrictedPackages.add(element.packageName);
    }

  }

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