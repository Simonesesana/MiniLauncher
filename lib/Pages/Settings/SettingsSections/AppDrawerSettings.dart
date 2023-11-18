import 'package:flutter/material.dart';
import 'package:minilauncher/main.dart';
import 'package:page_transition/page_transition.dart';
import 'package:minilauncher/Preferences/Preferences.dart';
import 'package:minilauncher/Pages/Settings/SettingsWidget.dart';
import 'package:minilauncher/Pages/Settings/SettingsSections/AppSelection/SelectFavouriteApps.dart';

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
        settingsTitleTextLabel("App Drawer", screenWidth),

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

                      settingsTextLabel("Automatically open drawer keyboard", screenWidth),
                      Switch(
                        value: preferences.automaticallyOpenKeyboardOnAppDrawer,
                        activeColor: preferences.selectedTheme.textColor,
                        onChanged: (value) {
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
