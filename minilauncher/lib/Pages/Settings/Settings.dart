import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minilauncher/Themes/Theme.dart';

class Settings extends StatefulWidget {
  const Settings({Key? key}) : super(key: key);

  @override
  _SettingsState createState() => _SettingsState();
}

class _SettingsState extends State<Settings> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: selectedTheme.primaryColor,

      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 20,
            vertical: MediaQuery.of(context).size.width / 14
          ),
          child: SingleChildScrollView(
            child: Column(
              children: [

                /// Favourite apps
                Text(
                  "Displayed Apps",
                  style: GoogleFonts.montserrat(
                      letterSpacing: 1,
                      color: selectedTheme.textColor,
                      fontSize: MediaQuery.of(context).size.width / 20
                  ),
                ),

                Card(
                  elevation: 0,
                  color: selectedTheme.homeCardColor.withOpacity(0.15),
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)
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
