import 'dart:async';
import 'dart:convert';
import 'package:installed_apps/index.dart';
import 'package:minilauncher/Packages/Preferences/Preferences.dart';
import 'package:minilauncher/Packages/Preferences/PreferencesClass.dart';
import 'package:minilauncher/main.dart';

/// Function which initializes the launcher
Future<void> initializeAppList (
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

}



/// Fetches app list
Future<void> fetchAppList() async {

  /// Retrieves the app list
  preferences.apps = await InstalledApps.getInstalledApps(false, true);

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

  bool showOnlyFavouriteAppsOnHomeScreen = await getBool("showOnlyFavouriteAppsOnHomeScreen");
  preferences.showOnlyFavouriteAppsOnHomeScreen = showOnlyFavouriteAppsOnHomeScreen;

  bool showBackgroundOnHomeScreen = await getBool("showBackgroundOnHomeScreen");
  preferences.showBackgroundOnHomeScreen = showBackgroundOnHomeScreen;

  int restrictedAppTimer = await getInt("restrictedAppTimer");
  preferences.restrictedAppTimer = restrictedAppTimer.toDouble();

  int maxPhoneUsage = await getInt("maxPhoneUsage");
  if(maxPhoneUsage != 0) {
    preferences.maxPhoneUsage = maxPhoneUsage.toDouble();
  }

  int focusModeTimer = await getInt("focusModeTimer");
  if(focusModeTimer != 0) {
    preferences.focusModeTimer = focusModeTimer.toDouble();
  }

  String focusModeEnd = await getString("focusModeEnd");
  if(focusModeEnd != "") {
    preferences.focusModeEnd = DateTime.parse(focusModeEnd);
    print("Focus mode end: ${preferences.focusModeEnd}");
  }

  bool showFocusModeButtonOnHomeScreen = await getBool("showFocusModeButtonOnHomeScreen");
  preferences.showFocusModeButtonOnHomeScreen = showFocusModeButtonOnHomeScreen;

  bool showSecondsOnClock = await getBool("showSecondsOnClock");
  preferences.showSecondsOnClock = showSecondsOnClock;

  bool showRoundIcons = await getBool("showRoundIcons");
  preferences.showRoundIcons = showRoundIcons;

  bool showDialerButtonOnHomeScreen = await getBool("showDialerButtonOnHomeScreen");
  preferences.showDialerButtonOnHomeScreen = showDialerButtonOnHomeScreen;

  bool automaticallyOpenKeyboardOnAppDrawer = await getBool("automaticallyOpenKeyboardOnAppDrawer");
  preferences.automaticallyOpenKeyboardOnAppDrawer = automaticallyOpenKeyboardOnAppDrawer;

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