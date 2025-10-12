import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

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
      initialRoute: '/home',

        routes: {
          //'/home': (context) => const Home(),
        }


        );
  }
}