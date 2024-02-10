import 'package:flutter/material.dart';
import 'package:minilauncher/main.dart';
import 'package:minilauncher/Preferences/Preferences.dart';
import 'package:minilauncher/Internationalization/Locale.dart';
import 'package:minilauncher/Pages/Settings/SettingsWidgets.dart';


class AppDrawerSettings extends StatefulWidget {

  Function setHomePageHasChanged;

  AppDrawerSettings({super.key, required this.setHomePageHasChanged});

  @override
  State<AppDrawerSettings> createState() => _AppDrawerSettingsState();
}

class _AppDrawerSettingsState extends State<AppDrawerSettings> {


  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// Home screen
        settingsTitleTextLabel(lng["settings"]["appDrawer"]["title"], screenWidth),

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


                  /// Show only favourite apps on home screen
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      settingsTextLabel(lng["settings"]["appDrawer"]["automaticallyOpenKeyboard"], screenWidth),
                      Switch(
                        value: preferences.automaticallyOpenKeyboardOnAppDrawer,
                        inactiveTrackColor: Colors.transparent,
                        activeColor: preferences.selectedTheme.textColor,                        onChanged: (value) {
                          setState(() {
                            widget.setHomePageHasChanged();
                            setBool("automaticallyOpenKeyboardOnAppDrawer", value);
                            preferences.automaticallyOpenKeyboardOnAppDrawer = value;
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
    );
  }
}
