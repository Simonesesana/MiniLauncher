import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minilauncher/main.dart';
import 'package:url_launcher/url_launcher.dart';

void callNumber(String number) async {
  final Uri uri = Uri(scheme: "tel", path: number);
  if (await canLaunchUrl(uri)) {
    await launchUrl(uri);
  }
}

Widget contactItem(String name, String phoneNumber, double screenWidth) {
  return SizedBox(
    width: screenWidth - 20,
    child: ListTile(

      leading: CircleAvatar(
          backgroundColor: preferences.selectedTheme.textColor.withOpacity(0.5),
          child: Text(
            name.isNotEmpty
                ? name[0].toUpperCase()
                : "",
            style: GoogleFonts.montserrat(
                color: preferences.selectedTheme.primaryColor,
                fontSize: 20,
                fontWeight: FontWeight.w600
            ),
          )
      ),

      // Call icon
      trailing: GestureDetector(
        onTap: () {
          callNumber(phoneNumber);
        },
        child: Icon(
          Icons.call,
          color: preferences.selectedTheme.textColor,
        ),
      ),

      title: Text(
        name,
        style: GoogleFonts.montserrat(
            color: preferences.selectedTheme.textColor,
            fontSize: 17
        ),
      ),
      subtitle: Text(
        phoneNumber,
        style: GoogleFonts.montserrat(
            color: preferences.selectedTheme.textColor.withOpacity(0.7),
            fontSize: 11
        ),
      ),
    ),
  );
}