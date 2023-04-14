import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minilauncher/Themes/Theme.dart';
import 'package:minilauncher/main.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {

  /// Indicates if the home page must be recharged while exiting
  /// the settings
  bool homePageHasChanged = false;

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    return WillPopScope(

      /// Prevents the settings screen from closing without loosing the changes
      onWillPop: () async {
        if(homePageHasChanged){
          Navigator.pushReplacementNamed(context, '/home');
        } else {
          Navigator.pop(context);
        }
        return false;
      },

      child: Scaffold(

        backgroundColor: selectedTheme.primaryColor,

        /// Appbar
        appBar: AppBar(

          centerTitle: true,
          backgroundColor: selectedTheme.textColor.withOpacity(0.1),

          title: Text(
            "Settings",
            style: GoogleFonts.montserrat(
                letterSpacing: 2,
                fontWeight: FontWeight.w400,
                color: selectedTheme.textColor,
                fontSize: MediaQuery.of(context).size.width / 20
            ),
          ),

          /// Back button
          leading: IconButton(
            color: selectedTheme.textColor,
            icon: Icon(
              Icons.arrow_back_ios,
              color: selectedTheme.textColor,
              size: 17,
            ),
            onPressed: (){
              if(homePageHasChanged){
                Navigator.pushReplacementNamed(context, '/home');
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

                  /// Home screen
                  Padding(
                    padding: const EdgeInsets.only(
                      bottom: 10
                    ),
                    child: Text(
                      "Home Screen",
                      style: GoogleFonts.montserrat(
                          letterSpacing: 1,
                          color: selectedTheme.textColor,
                          fontSize: screenWidth / 17
                      ),
                    ),
                  ),

                  SizedBox(
                    width: screenWidth,
                    child: Card(
                      elevation: 0,
                      color: selectedTheme.homeCardColor.withOpacity(0.15),
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
                                  color: selectedTheme.textColor,
                                  icon: Icon(
                                    Icons.arrow_forward_ios,
                                    color: selectedTheme.textColor,
                                    size: 17,
                                  ),
                                  onPressed: (){
                                    homePageHasChanged = true;
                                    Navigator.pushNamed(context, '/select_favourite_apps');
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
                                  activeColor: selectedTheme.textColor,
                                  onChanged: (value) {
                                    setState(() {
                                      homePageHasChanged = true;
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
      color: selectedTheme.textColor,
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
          color: selectedTheme.textColor,
          fontSize: screenWidth / 30
      ),
    ),
  );
}