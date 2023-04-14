import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

/// Pages import
import 'Pages/Home/Home.dart';
import 'Pages/Settings/Settings.dart';

/// Application list
List apps = [];

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
      initialRoute: '/home',

      /// List of al the app pages
      routes: {
        '/home': (context) => const Home(),
        '/settings': (context) => const Settings()
      },

    );
  }
}