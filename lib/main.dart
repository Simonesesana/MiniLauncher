import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Pages import
import 'Pages/Home/Home.dart';
import 'Pages/Loading/Loading.dart';
import 'Pages/Settings/Settings.dart';
import 'package:minilauncher/Pages/Home/Drawer/HomeDrawer.dart';
import 'package:minilauncher/Preferences/PreferencesClass.dart';
import 'package:minilauncher/Pages/WelcomePage/WelcomePage.dart';
import 'Pages/Settings/SettingsSections/AppSelection/SelectFavouriteApps.dart';
import 'package:minilauncher/Pages/Settings/SettingsSections/AppSelection/SelectRestrictedApps.dart';

/// Preferences object
PreferencesClass preferences = PreferencesClass();

void main() async {

  WidgetsFlutterBinding.ensureInitialized();

  /// Locks device orientation
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown
  ]);

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {

  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(

      showSemanticsDebugger: false,
      debugShowCheckedModeBanner: false,

      /// App Title
      title: 'MiniLauncher',

      /// Initial route
      initialRoute: '/loading',

      /// List of al the app pages
      routes: {
        '/home': (context) => const Home(),
        '/loading': (context) => const Loading(),
        '/settings': (context) => const Settings(),
        '/home_drawer': (context) => const HomeDrawer(),
        '/welcome_page': (context) => const WelcomePage(),
        '/select_favourite_apps': (context) => const SelectFavouriteApps(),
        '/select_restricted_apps': (context) => const SelectRestrictedApps(),
      },

    );
  }
}