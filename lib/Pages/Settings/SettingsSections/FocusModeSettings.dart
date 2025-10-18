import 'package:flutter/material.dart';
import 'package:minilauncher/Packages/Preferences/Preferences.dart';
import 'package:minilauncher/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minilauncher/Pages/Settings/SettingsWidgets.dart';

class FocusModeSettings extends StatefulWidget {

  Function setHomePageHasChanged;

  FocusModeSettings({super.key, required this.setHomePageHasChanged});

  @override
  State<FocusModeSettings> createState() => _FocusModeSettingsState();
}

class _FocusModeSettingsState extends State<FocusModeSettings> {

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// Focus mode
        Padding(
          padding: const EdgeInsets.only(
              bottom: 2,
              left: 3
          ),
          child: Text(
            "Focus Mode",
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
            "Minimize distractions by enabling Focus Mode. This feature allows you to temporarily hide certain apps and notifications, helping you stay concentrated on your tasks.",
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

                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      settingsTextLabel("Show focus mode button", screenWidth),
                      Switch(
                        value: preferences.showFocusModeButtonOnHomeScreen,
                        inactiveTrackColor: Colors.transparent,
                        activeColor: preferences.selectedTheme.textColor,
                        onChanged: (value) {
                          setState(() {
                            widget.setHomePageHasChanged();
                            setBool("showFocusModeButtonOnHomeScreen", value);
                            preferences.showFocusModeButtonOnHomeScreen = value;
                          });
                        },
                      ),

                    ],
                  ),

                  Padding(
                      padding: const EdgeInsets.only(
                          top: 10
                      ),
                      child: settingsTextLabel(
                          "${"Focus mode durations"} ${preferences.focusModeTimer.toInt() ~/ 60}"
                              " ${"hrs"} ${(preferences.focusModeTimer.toInt() % 60).toString().padLeft(2, "0")} ${"mins"}",
                          screenWidth
                      )
                  ),


                  Slider(
                    value: preferences.focusModeTimer,
                    min: 0,
                    max: 360,
                    divisions: 12,
                    activeColor: preferences.selectedTheme.textColor,
                    inactiveColor: preferences.selectedTheme.textColor.withOpacity(0.2),
                    onChanged: (value) {
                      if(value != 0) {
                        setState(() {
                          preferences.focusModeTimer = value;
                          setInt("focusModeTimer", value.toInt());
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
