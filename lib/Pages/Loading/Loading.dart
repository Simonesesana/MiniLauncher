import 'package:flutter/material.dart';
import 'package:minilauncher/Packages/Preferences/Preferences.dart';
import 'package:minilauncher/Packages/Theme.dart';
import 'package:minilauncher/Packages/WeatherForecast.dart';
import 'package:minilauncher/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:minilauncher/Pages/Loading/LauncherInitialization.dart';

import '../../Packages/Contacts.dart';



class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  /// Fetches app theme
  Future<void> fetchAppTheme() async {

    String appTheme = await getString("app_theme");
    switch (appTheme) {
      case "light":
        setState(() {
          preferences.selectedTheme = lightTheme;
        });
        break;
      case "dark":
        setState(() {
          preferences.selectedTheme = darkTheme;
        });
        break;
      default:
        setState(() {
          preferences.selectedTheme = darkTheme;
        });
        break;
    }

  }


  void initialize() async {

    /// Fetches first access
    bool firstAccess = await getBool("first_access");

    if(!firstAccess) {

      /// Fetches app theme
      await fetchAppTheme();

      /// Fetches favourite apps
      await fetchFavouriteApps();

      /// Fetches settings preferences
      await fetchSettingsPreferences();

    }

    /// App list recovery
    initializeAppList();

    if(!firstAccess) {

      /// Fetches weather forecast
      weatherForecast.getWeatherForecast();

      /// Fetches favourite contacts
      Contacts.fetchContacts();

    }

    if(context.mounted && !firstAccess) {
      Navigator.pushReplacementNamed(context, '/home');
    } else {
      await setBool("first_access", true);
      Navigator.pushReplacementNamed(context, '/welcome_page');
    }

  }

  @override
  void initState() {
    initialize();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: preferences.selectedTheme.primaryColor,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          /// Loading spinkit
          SpinKitRing(
            lineWidth: 1,
            color: preferences.selectedTheme.textColor,
            size: MediaQuery.of(context).size.width / 10,
          ),

          /// Text
          Padding(
              padding: const EdgeInsets.only(
                top: 20,
              ),
              child: Text(
                  "Loading, please wait...",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.nunito(
                      height: 1.2,
                      color: preferences.selectedTheme.textColor,
                      fontWeight: FontWeight.w300,
                      decoration: TextDecoration.none,
                      fontSize: MediaQuery.of(context).size.width / 20
                  )
              )
          )

        ],
      ),
    );
  }
}

