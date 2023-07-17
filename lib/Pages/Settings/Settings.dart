import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minilauncher/Pages/Home/Home.dart';
import 'package:minilauncher/Pages/Settings/SelectFavouriteApps/SelectFavouriteApps.dart';
import 'package:minilauncher/Preferences/Preferences.dart';
import 'package:minilauncher/Themes/Theme.dart';
import 'package:minilauncher/main.dart';
import 'package:page_transition/page_transition.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  /// Selected theme
  String? selectedTheme = "dark";

  /// Indicates if the home page must be recharged while exiting
  /// the settings
  bool homePageHasChanged = false;

  void initState() {
    super.initState();
    if(preferences.selectedTheme == lightTheme) {
      setState(() {
        selectedTheme = "light";
      });
    } else if(preferences.selectedTheme == darkTheme) {
      setState(() {
        selectedTheme = "dark";
      });
    }
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

          title: Text(
            "Settings",
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
            padding: EdgeInsets.symmetric(
              horizontal: screenWidth / 20,
              vertical: screenWidth / 14
            ),
            child: SingleChildScrollView(
              child: Column(

                crossAxisAlignment: CrossAxisAlignment.start,

                children: [

                  /// Theme
                  settingsTitleTextLabel("Theme", screenWidth),

                  SizedBox(
                    width: screenWidth,
                    child: Card(
                      elevation: 0,
                      color: preferences.selectedTheme.homeCardColor.withOpacity(0.15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [

                            /// Select theme
                            settingsTextLabel("Select theme", screenWidth),

                            /// Light
                            Row(
                              children: [
                                Radio<String> (
                                  value: "light",
                                  groupValue: selectedTheme,
                                  onChanged: (String? value){
                                    setState(() {
                                      selectedTheme = value;
                                      homePageHasChanged = true;
                                      setString("app_theme", "light");
                                      preferences.selectedTheme = lightTheme;
                                    });
                                  },
                                  activeColor: preferences.selectedTheme.textColor,
                                ),
                                settingsTextLabel("Light", screenWidth)
                              ],
                            ),

                            /// Dark
                            Row(
                              children: [
                                Radio<String> (
                                  value: "dark",
                                  groupValue: selectedTheme,
                                  onChanged: (String? value){
                                    setState(() {
                                      selectedTheme = value;
                                      homePageHasChanged = true;
                                      setString("app_theme", "dark");
                                      preferences.selectedTheme = darkTheme;
                                    });
                                  },
                                  activeColor: preferences.selectedTheme.textColor,
                                ),
                                settingsTextLabel("Dark", screenWidth)
                              ],
                            ),

                          ],
                        ),
                      ),
                    ),
                  ),

                  const SizedBox(
                    height: 20,
                  ),

                  /// Home screen
                  settingsTitleTextLabel("Home Screen", screenWidth),

                  SizedBox(
                    width: screenWidth,
                    child: Card(
                      elevation: 0,
                      color: preferences.selectedTheme.homeCardColor.withOpacity(0.15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(15, 5, 15, 5),
                        child: Column(
                          children: [

                            /// Select favourite apps
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                settingsTextLabel("Select favourite apps", screenWidth),

                                IconButton(
                                  color: preferences.selectedTheme.textColor,
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    color: preferences.selectedTheme.textColor,
                                    size: 17,
                                  ),
                                  onPressed: (){
                                    homePageHasChanged = true;
                                    Navigator.push(
                                        context,
                                        PageTransition(
                                            child: const SelectFavouriteApps(),
                                            type: PageTransitionType.fade
                                        )
                                    );
                                  },
                                ),

                              ],
                            ),

                            /// Divider
                            settingsDivider(screenWidth),

                            /// Show only favourite apps on home screen
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [

                                settingsTextLabel("Show only favourite apps on home screen", screenWidth),
                                Switch(
                                  value: preferences.showOnlyFavouriteAppsOnHomeScreen,
                                  activeColor: preferences.selectedTheme.textColor,
                                  onChanged: (value) {
                                    setState(() {
                                      homePageHasChanged = true;;
                                      setBool("showOnlyFavouriteAppsOnHomeScreen", value);
                                      preferences.showOnlyFavouriteAppsOnHomeScreen = value;
                                    });
                                  },
                                ),

                              ],
                            ),

                          ],
                        ),
                      ),
                    ),
                  )

                ],
              ),
            ),
          ),
        ),


      ),
    );
  }
}


/// Settings divider
Padding settingsDivider (double screenWidth) {
  return Padding(
    padding: EdgeInsets.only(
        right: screenWidth / 20
    ),
    child: Divider(
      color: preferences.selectedTheme.textColor,
    ),
  );
}


/// Settings text label
SizedBox settingsTextLabel (String text, double screenWidth) {
  return SizedBox(
    width: screenWidth / 1.8,
    child: Text(
      text,
      textAlign: TextAlign.justify,
      style: GoogleFonts.montserrat(
          letterSpacing: 1,
          color: preferences.selectedTheme.textColor,
          fontSize: screenWidth / 30
      ),
    ),
  );
}

/// Settings title text label
Padding settingsTitleTextLabel (String text, double screenWidth) {
  return Padding(
    padding: const EdgeInsets.only(
      bottom: 10,
      left: 3
    ),
    child: Text(
      text,
      style: GoogleFonts.montserrat(
          letterSpacing: 1,
          color: preferences.selectedTheme.textColor,
          fontSize: screenWidth / 17
      ),
    ),
  );
}