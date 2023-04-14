import 'dart:async';
import 'package:minilauncher/Preferences/Preferences.dart';
import 'package:minilauncher/main.dart';
import 'package:device_apps/device_apps.dart';

/// Function which initializes the launcher
Future<void> initializeLauncher () async {

  /// Retrieves the app list
  preferences.apps = await DeviceApps.getInstalledApplications(
    includeAppIcons: true,
    includeSystemApps: true,
    onlyAppsWithLaunchIntent: true,
  );

  /// Retrieves the favourite apps
  List<String> favouriteApps = await getStringList("favourite_apps");

  for (var element in preferences.apps) {
    for (var favouriteElement in favouriteApps) {
      if(element.packageName == favouriteElement){
        preferences.favouriteApps.add(element);
      }
    }
  }

  preferences.showOnlyFavouriteAppsOnHomeScreen = true;

}