import 'package:flutter/material.dart';
import 'package:minilauncher/main.dart';
import 'package:google_fonts/google_fonts.dart';

/// Settings divider
Padding settingsDivider (double screenWidth) {
  return Padding(
    padding: EdgeInsets.only(
        right: screenWidth / 20
    ),
    child: Divider(
      color: preferences.selectedTheme.textColor,
    ),
  );
}


/// Settings text label
SizedBox settingsTextLabel (String text, double screenWidth) {
  return SizedBox(
    width: screenWidth / 1.8,
    child: Text(
      text,
      textAlign: TextAlign.justify,
      style: GoogleFonts.montserrat(
          letterSpacing: 1,
          color: preferences.selectedTheme.textColor,
          fontSize: screenWidth / 30
      ),
    ),
  );
}

/// Settings title text label
Padding settingsTitleTextLabel (String text, double screenWidth) {
  return Padding(
    padding: const EdgeInsets.only(
        bottom: 10,
        left: 3
    ),
    child: Text(
      text,
      style: GoogleFonts.montserrat(
          letterSpacing: 1,
          color: preferences.selectedTheme.textColor,
          fontSize: screenWidth / 17
      ),
    ),
  );
}