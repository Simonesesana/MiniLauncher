import 'package:flutter/material.dart';
import 'package:minilauncher/Internationalization/Locale.dart';
import 'package:minilauncher/main.dart';
import 'package:minilauncher/Themes/Theme.dart';
import 'package:minilauncher/Preferences/Preferences.dart';
import 'package:minilauncher/Pages/Settings/SettingsWidgets.dart';

class LanguageSettings extends StatefulWidget {

  Function setHomePageHasChanged;

  LanguageSettings({super.key, required this.setHomePageHasChanged});

  @override
  State<LanguageSettings> createState() => _LanguageSettingsState();
}

class _LanguageSettingsState extends State<LanguageSettings> {

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// Theme
        settingsTitleTextLabel(lng["settings"]["language"]["title"], screenWidth),

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

                  /// Select language
                  settingsTextLabel(lng["settings"]["language"]["selectLanguage"], screenWidth),

                  /// English
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 5, 0, 0),
                    child: Row(
                      children: [
                        Radio<String> (
                          value: "en",
                          groupValue: Lng.locale,
                          visualDensity: const VisualDensity(
                              horizontal: VisualDensity.minimumDensity,
                              vertical: VisualDensity.minimumDensity),
                          onChanged: (String? value){
                            setState(() {
                              Lng.changeLanguage("en");
                              widget.setHomePageHasChanged();
                            });
                          },
                          activeColor: preferences.selectedTheme.textColor,
                        ),
                        settingsTextLabel(
                          lng["settings"]["language"]["english"]
                          , screenWidth
                        )
                      ],
                    ),
                  ),
                  
                  
                  /// Italian
                  Padding(
                    padding: const EdgeInsets.fromLTRB(5, 5, 0, 5),
                    child: Row(
                      children: [
                        Radio<String> (
                          value: "it",
                          groupValue: Lng.locale,
                          visualDensity: const VisualDensity(
                              horizontal: VisualDensity.minimumDensity,
                              vertical: VisualDensity.minimumDensity),
                          onChanged: (String? value){
                            setState(() {
                              Lng.changeLanguage("it");
                              widget.setHomePageHasChanged();
                            });
                          },
                          activeColor: preferences.selectedTheme.textColor,
                        ),
                        settingsTextLabel(
                            lng["settings"]["language"]["italian"],
                            screenWidth
                        )
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
