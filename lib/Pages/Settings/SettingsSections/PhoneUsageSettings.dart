import 'package:flutter/material.dart';
import 'package:minilauncher/Preferences/Preferences.dart';
import 'package:minilauncher/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:minilauncher/Pages/Settings/SettingsWidget.dart';
import 'package:minilauncher/Pages/Settings/SettingsSections/AppSelection/SelectRestrictedApps.dart';

class PhoneUsageSettings extends StatefulWidget {

  Function setHomePageHasChanged;

  PhoneUsageSettings({super.key, required this.setHomePageHasChanged});

  @override
  State<PhoneUsageSettings> createState() => _PhoneUsageSettingsState();
}

class _PhoneUsageSettingsState extends State<PhoneUsageSettings> {

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// Phone usage
        Padding(
          padding: const EdgeInsets.only(
              bottom: 2,
              left: 3
          ),
          child: Text(
            "Phone usage",
            style: GoogleFonts.montserrat(
                letterSpacing: 1,
                color: preferences.selectedTheme.textColor,
                fontSize: screenWidth / 17
            ),
          ),
        ),

        Padding(
          padding: const EdgeInsets.only(
              left: 3,
              bottom: 10
          ),
          child: Text(
            "Set the preferred amount of time you want to spend on your phone daily.",
            textAlign: TextAlign.justify,
            style: GoogleFonts.montserrat(
              letterSpacing: 1,
              fontSize: screenWidth / 32,
              color: preferences.selectedTheme.textColor,
            ),
          ),
        ),

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
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  Padding(
                      padding: const EdgeInsets.only(
                          top: 10
                      ),
                      child: settingsTextLabel(
                          "Screen time: ${preferences.maxPhoneUsage.toInt() ~/ 60}"
                          " hrs ${(preferences.maxPhoneUsage.toInt() % 60).toString().padLeft(2, "0")} mins",
                          screenWidth
                      )
                  ),


                  Slider(
                    value: preferences.maxPhoneUsage,
                    min: 0,
                    max: 360,
                    divisions: 12,
                    activeColor: preferences.selectedTheme.textColor,
                    inactiveColor: preferences.selectedTheme.textColor.withOpacity(0.2),
                    onChanged: (value) {
                      if(value != 0) {
                        setState(() {
                          preferences.maxPhoneUsage = value;
                          setInt("maxPhoneUsage", value.toInt());
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        )

      ],
    );
  }
}
