import 'package:flutter/material.dart';
import 'package:minilauncher/main.dart';
import 'package:page_transition/page_transition.dart';
import 'package:minilauncher/Preferences/Preferences.dart';
import 'package:minilauncher/Internationalization/Locale.dart';
import 'package:minilauncher/Pages/Settings/SettingsWidgets.dart';
import 'package:minilauncher/Pages/Settings/SettingsSections/AppSelection/SelectFavouriteApps.dart';

class HomeScreenSettings extends StatefulWidget {

  Function setHomePageHasChanged;

  HomeScreenSettings({super.key, required this.setHomePageHasChanged});

  @override
  State<HomeScreenSettings> createState() => _HomeScreenSettingsState();
}

class _HomeScreenSettingsState extends State<HomeScreenSettings> {


  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// Home screen
        settingsTitleTextLabel(lng["settings"]["homeScreen"]["title"], screenWidth),

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

                      settingsTextLabel(lng["settings"]["homeScreen"]["selectFavouriteApps"], screenWidth),

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

                  /// Divider
                  settingsDivider(screenWidth),

                  /// Show only favourite apps on home screen
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      settingsTextLabel(lng["settings"]["homeScreen"]["showOnlyFavouriteApps"], screenWidth),
                      Switch(
                        value: preferences.showOnlyFavouriteAppsOnHomeScreen,
                        inactiveTrackColor: Colors.transparent,
                        activeColor: preferences.selectedTheme.textColor,
                        onChanged: (value) {
                          setState(() {
                            widget.setHomePageHasChanged();
                            setBool("showOnlyFavouriteAppsOnHomeScreen", value);
                            preferences.showOnlyFavouriteAppsOnHomeScreen = value;
                          });
                        },
                      ),

                    ],
                  ),


                  /// Show round icons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      settingsTextLabel(lng["settings"]["homeScreen"]["showRoundIcons"], screenWidth),
                      Switch(
                        value: preferences.showRoundIcons,
                        inactiveTrackColor: Colors.transparent,
                        activeColor: preferences.selectedTheme.textColor,
                        onChanged: (value) {
                          setState(() {
                            widget.setHomePageHasChanged();
                            setBool("showRoundIcons", value);
                            preferences.showRoundIcons = value;
                          });
                        },
                      ),

                    ],
                  ),

                  /// Show background on home screen
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      settingsTextLabel(lng["settings"]["homeScreen"]["showBackground"], screenWidth),
                      Switch(
                        value: preferences.showBackgroundOnHomeScreen,
                        inactiveTrackColor: Colors.transparent,
                        activeColor: preferences.selectedTheme.textColor,
                        onChanged: (value) {
                          setState(() {
                            widget.setHomePageHasChanged();
                            setBool("showBackgroundOnHomeScreen", value);
                            preferences.showBackgroundOnHomeScreen = value;
                          });
                        },
                      ),

                    ],
                  ),

                  /// Show seconds on clock
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      settingsTextLabel(lng["settings"]["homeScreen"]["showSecondsOnClock"], screenWidth),
                      Switch(
                        value: preferences.showSecondsOnClock,
                        inactiveTrackColor: Colors.transparent,
                        activeColor: preferences.selectedTheme.textColor,
                        onChanged: (value) {
                          setState(() {
                            widget.setHomePageHasChanged();
                            setBool("showSecondsOnClock", value);
                            preferences.showSecondsOnClock = value;
                          });
                        },
                      ),

                    ],
                  ),

                  /// Show dialer button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      settingsTextLabel(lng["settings"]["homeScreen"]["showDialerButton"], screenWidth),
                      Switch(
                        value: preferences.showDialerButtonOnHomeScreen,
                        inactiveTrackColor: Colors.transparent,
                        activeColor: preferences.selectedTheme.textColor,
                        onChanged: (value) {
                          setState(() {
                            widget.setHomePageHasChanged();
                            setBool("showDialerButtonOnHomeScreen", value);
                            preferences.showDialerButtonOnHomeScreen = value;
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
