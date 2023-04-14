import 'dart:async';
import 'package:minilauncher/main.dart';
import 'package:device_apps/device_apps.dart';

/// Function which initializes the launcher
Future<void> initializeLauncher () async {

  /// Retrieves the app list
  preferences.apps = await DeviceApps.getInstalledApplications
    (
    includeAppIcons: true,
    includeSystemApps: true,
    onlyAppsWithLaunchIntent: true,
  );

  /// Retrieves tha favourite apps

  preferences.displayAllAppsOnHomeScreen = true;


}