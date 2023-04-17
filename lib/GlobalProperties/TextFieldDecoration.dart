import '../main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

InputDecoration textFieldDecoration (double screenWidth) {
  return InputDecoration(

    prefixIcon: Icon(
      Icons.search,
      size: 20,
      color: preferences.selectedTheme.textColor,
    ),

    contentPadding: EdgeInsets.zero,

    // Hint text
    hintText: "Search an app",
    hintStyle: GoogleFonts.montserrat(
        letterSpacing: 0.5,
        color: Colors.grey[400],
        fontWeight: FontWeight.w300,
        fontSize: screenWidth / 25
    ),

    // Border decoration
    focusedBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        width: 1.5,
        color: preferences.selectedTheme.textColor,
      ),
    ),
    enabledBorder: OutlineInputBorder(
      borderRadius: BorderRadius.circular(12),
      borderSide: BorderSide(
        width: 1,
        color: preferences.selectedTheme.textColor,
      ),
    ),

  );
}