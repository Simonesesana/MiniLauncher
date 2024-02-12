import 'package:flutter/material.dart';
import 'package:minilauncher/Pages/Settings/SettingsSections/PhoneUsageSettings.dart';
import 'package:minilauncher/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minilauncher/Pages/Home/Home.dart';
import 'package:page_transition/page_transition.dart';
import 'package:minilauncher/Internationalization/Locale.dart';
import 'package:minilauncher/Pages/Settings/SettingsSections/ThemeSettings.dart';
import 'package:minilauncher/Pages/Settings/SettingsSections/LanguageSettings.dart';
import 'package:minilauncher/Pages/Settings/SettingsSections/HomeScreenSettings.dart';
import 'package:minilauncher/Pages/Settings/SettingsSections/RestrictedAppsSettings.dart';

import 'SettingsSections/AppDrawerSettings.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  /// Indicates if the home page must be recharged while exiting
  /// the settings
  bool homePageHasChanged = false;

  /// Callback function to set the "homePageHasChanged" variable
  void setHomePageHasChanged () {
    setState(() {
      homePageHasChanged = true;
    });
  }

  @override
  Widget build(BuildContext context) {

    /// Screen width
    double screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(

      /// Prevents the settings screen from closing without loosing the changes
      onWillPop: () async {
        if(homePageHasChanged){
          Navigator.pushReplacement(
              context,
              PageTransition(
                  child: const Home(),
                  type: PageTransitionType.fade
              )
          );
        } else {
          Navigator.pop(context);
        }
        return false;
      },

      child: Scaffold(

        backgroundColor: preferences.selectedTheme.primaryColor,

        /// Appbar
        appBar: AppBar(

          elevation: 0,
          centerTitle: true,
          backgroundColor: preferences.selectedTheme.textColor.withOpacity(0.1),

          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(15),
              bottomRight: Radius.circular(15)
            )
          ),
          
          title: Text(
            lng["settings"]["title"],
            style: GoogleFonts.montserrat(
                letterSpacing: 2,
                fontWeight: FontWeight.w400,
                color: preferences.selectedTheme.textColor,
                fontSize: MediaQuery.of(context).size.width / 20
            ),
          ),

          /// Back button
          leading: IconButton(
            color: preferences.selectedTheme.textColor,
            icon: Icon(
              Icons.arrow_back_ios,
              color: preferences.selectedTheme.textColor,
              size: 17,
            ),
            onPressed: (){
              if(homePageHasChanged){
                Navigator.pushReplacement(
                    context,
                    PageTransition(
                        child: const Home(),
                        type: PageTransitionType.fade
                    )
                );
              } else {
                Navigator.pop(context);
              }
            },
          ),
        ),

        body: SafeArea(
          child: Padding(
            padding: EdgeInsets.only(
              top: screenWidth / 30,
              left: screenWidth / 20,
              right: screenWidth / 20
            ),
            child: SingleChildScrollView(
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  ThemeSettings(
                      setHomePageHasChanged: setHomePageHasChanged
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  LanguageSettings(
                      setHomePageHasChanged: setHomePageHasChanged
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  HomeScreenSettings(
                    setHomePageHasChanged: setHomePageHasChanged,
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  AppDrawerSettings(
                    setHomePageHasChanged: setHomePageHasChanged,
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  PhoneUsageSettings(
                      setHomePageHasChanged: setHomePageHasChanged
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  RestrictedAppsSettings(
                      setHomePageHasChanged: setHomePageHasChanged
                  ),

                  const SizedBox(height: 20),

                ],
              ),
            ),
          ),
        ),


      ),
    );

  }
}


