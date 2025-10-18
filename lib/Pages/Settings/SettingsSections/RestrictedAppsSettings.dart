import 'package:flutter/material.dart';
import 'package:minilauncher/Packages/Preferences/Preferences.dart';
import 'package:minilauncher/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:minilauncher/Pages/Settings/SettingsWidgets.dart';
import 'package:minilauncher/Pages/Settings/SettingsSections/AppSelection/SelectRestrictedApps.dart';

class RestrictedAppsSettings extends StatefulWidget {

  Function setHomePageHasChanged;

  RestrictedAppsSettings({super.key, required this.setHomePageHasChanged});

  @override
  State<RestrictedAppsSettings> createState() => _RestrictedAppsSettingsState();
}

class _RestrictedAppsSettingsState extends State<RestrictedAppsSettings> {

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// Restricted apps
        Padding(
          padding: const EdgeInsets.only(
              bottom: 2,
              left: 3
          ),
          child: Text(
            "Restricted Apps",
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
            "Restrict access to selected apps for a specified duration.",
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

                  /// Select restricted apps
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      settingsTextLabel(
                        "Select restricted apps",
                        screenWidth
                      ),

                      IconButton(
                        color: preferences.selectedTheme.textColor,
                        icon: Icon(
                          size: 17,
                          Icons.arrow_forward_ios,
                          color: preferences.selectedTheme.textColor,
                        ),
                        onPressed: (){
                          widget.setHomePageHasChanged();
                          Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: const SelectRestrictedApps(),
                              )
                          );
                        },
                      ),

                    ],
                  ),


                  /// Divider
                  settingsDivider(screenWidth),
                  
                  Padding(
                    padding: const EdgeInsets.only(
                        top: 10
                    ),
                    child: settingsTextLabel(
                        "Timer duration: "
                        " ${preferences.restrictedAppTimer.toInt().toString()}s",
                        screenWidth
                    )
                  ),


                  Slider(
                    value: preferences.restrictedAppTimer,
                    min: 0,
                    max: 60,
                    divisions: 12,
                    activeColor: preferences.selectedTheme.textColor,
                    inactiveColor: preferences.selectedTheme.textColor.withOpacity(0.2),
                    onChanged: (value) {
                      setState(() {
                        preferences.restrictedAppTimer = value;
                        setInt("restrictedAppTimer", value.toInt());
                      });
                    },
                  ),

                  const SizedBox(
                    height: 10,
                  )

                ],
              ),
            ),
          ),
        )

      ],
    );
  }
}
