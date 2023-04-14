import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minilauncher/Preferences/PreferencesClass.dart';

/// Pages import
import 'Pages/Home/Home.dart';
import 'Pages/Loading/Loading.dart';
import 'Pages/Settings/Settings.dart';
import 'Pages/Settings/SelectFavouriteApps.dart';

/// Preferences object
PreferencesClass preferences = PreferencesClass();

void main() async {

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
        '/select_favourite_apps': (context) => const SelectFavouriteApps(),
      },

    );
  }
}