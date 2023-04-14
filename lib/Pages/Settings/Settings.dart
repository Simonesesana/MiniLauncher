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


  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(

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
            Navigator.pop(context);
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

                          /// Show only favourite apps on home screen
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              settingsTextLabel("Show only favourite apps on home screen", screenWidth),
                              Switch(
                                value: preferences.displayAllAppsOnHomeScreen,
                                activeColor: selectedTheme.textColor,
                                onChanged: (value) {
                                  setState(() {
                                    preferences.displayAllAppsOnHomeScreen = value;
                                  });
                                },
                              ),

                            ],
                          ),

                          Padding(
                            padding: EdgeInsets.only(
                              right: screenWidth / 20
                            ),
                            child: Divider(
                              color: selectedTheme.textColor,
                            ),
                          ),

                          /// Another one
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [

                              settingsTextLabel("Another", screenWidth),
                              Switch(
                                value: preferences.displayAllAppsOnHomeScreen,
                                activeColor: selectedTheme.textColor,
                                onChanged: (value) {
                                  setState(() {
                                    preferences.displayAllAppsOnHomeScreen = value;
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


    );
  }
}


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