import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minilauncher/main.dart';
import 'package:page_transition/page_transition.dart';
import 'package:minilauncher/Preferences/Preferences.dart';
import 'package:minilauncher/Pages/Settings/SettingsWidget.dart';
import 'package:minilauncher/Pages/Settings/SelectFavouriteApps/SelectFavouriteApps.dart';

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
            "Restricted apps",
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
            "The access for these app is restricted. You can open "
            "them for a maximum amount of times per day and you have to wait "
            "a fixed amount of time for them to boot up.",
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
                children: [

                  /// Select restricted apps
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      settingsTextLabel("Select restricted apps", screenWidth),

                      IconButton(
                        color: preferences.selectedTheme.textColor,
                        icon: Icon(
                          Icons.arrow_forward_ios,
                          color: preferences.selectedTheme.textColor,
                          size: 17,
                        ),
                        onPressed: (){
                          widget.setHomePageHasChanged();
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

                ],
              ),
            ),
          ),
        )

      ],
    );
  }
}
