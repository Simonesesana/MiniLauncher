import 'package:flutter/material.dart';
import 'package:minilauncher/Packages/Preferences/Preferences.dart';
import 'package:minilauncher/Packages/Theme.dart';
import 'package:minilauncher/main.dart';
import 'package:minilauncher/Pages/Settings/SettingsWidgets.dart';

class ThemeSettings extends StatefulWidget {

  Function setHomePageHasChanged;

  ThemeSettings({super.key, required this.setHomePageHasChanged});

  @override
  State<ThemeSettings> createState() => _ThemeSettingsState();
}

class _ThemeSettingsState extends State<ThemeSettings> {

  /// Selected theme
  String? selectedTheme = "dark";

  @override
  void initState() {
    super.initState();
    if(preferences.selectedTheme == lightTheme) {
      setState(() {
        selectedTheme = "light";
      });
    } else if(preferences.selectedTheme == darkTheme) {
      setState(() {
        selectedTheme = "dark";
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// Theme
        settingsTitleTextLabel(
          "Theme",
          screenWidth
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
              padding: const EdgeInsets.fromLTRB(15, 10, 15, 5),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                  /// Select theme
                  settingsTextLabel("Select theme", screenWidth),

                  /// Light
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                    child: Row(
                      children: [
                        Radio<String> (
                          value: "light",
                          groupValue: selectedTheme,
                          visualDensity: const VisualDensity(
                              horizontal: VisualDensity.minimumDensity,
                              vertical: VisualDensity.minimumDensity),
                          onChanged: (String? value){
                            setState(() {
                              selectedTheme = value;
                              widget.setHomePageHasChanged();
                              setString("app_theme", "light");
                              preferences.selectedTheme = lightTheme;
                            });
                          },
                          activeColor: preferences.selectedTheme.textColor,
                        ),
                        settingsTextLabel("Light theme", screenWidth)
                      ],
                    ),
                  ),

                  /// Dark
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 5, 0, 5),
                    child: Row(
                      children: [
                        Radio<String> (
                          value: "dark",
                          groupValue: selectedTheme,
                          visualDensity: const VisualDensity(
                              horizontal: VisualDensity.minimumDensity,
                              vertical: VisualDensity.minimumDensity),
                          onChanged: (String? value){
                            setState(() {
                              selectedTheme = value;
                              widget.setHomePageHasChanged();
                              setString("app_theme", "dark");
                              preferences.selectedTheme = darkTheme;
                            });
                          },
                          activeColor: preferences.selectedTheme.textColor,
                        ),
                        settingsTextLabel("Dark theme", screenWidth)
                      ],
                    ),
                  ),

                ],
              ),
            ),
          ),
        ),

      ],
    );
  }
}
