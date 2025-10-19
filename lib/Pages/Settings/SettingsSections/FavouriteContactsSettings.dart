import 'package:flutter/material.dart';
import 'package:minilauncher/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:minilauncher/Pages/Settings/SettingsWidgets.dart';
import 'package:minilauncher/Pages/Settings/SettingsSections/AppSelection/SelectFavouriteContacts.dart';

class FavouriteContactsSettings extends StatefulWidget {

  FavouriteContactsSettings({super.key});

  @override
  State<FavouriteContactsSettings> createState() => _FavouriteContactsSettingsState();
}

class _FavouriteContactsSettingsState extends State<FavouriteContactsSettings> {

  @override
  Widget build(BuildContext context) {

    double screenWidth = MediaQuery.of(context).size.width;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [

        /// Favourite Contacts Title
        Padding(
          padding: const EdgeInsets.only(
              bottom: 2,
              left: 3
          ),
          child: Text(
            "Favourite Contacts",
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
            "Select favourite contacts to show them quickly in the contacts screen.",
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
                          "Select favourite contacts",
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
                          Navigator.push(
                              context,
                              PageTransition(
                                type: PageTransitionType.fade,
                                child: const SelectFavouriteContacts(),
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
