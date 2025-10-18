import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minilauncher/Packages/Preferences/PreferencesClass.dart';
import 'package:minilauncher/Pages/WelcomePage/WelcomePage.dart';

// Pages
import 'Pages/Home/Home.dart';
import 'package:minilauncher/Pages/Loading/Loading.dart';

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

        routes: {
          '/home': (context) => const Home(),
          '/loading': (context) => const Loading(),
          '/welcome_page': (context) => const WelcomePage(),
        }

      );
  }
}