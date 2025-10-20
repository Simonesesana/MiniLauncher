import 'package:flutter/material.dart';
import 'package:minilauncher/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:flutter_phone_direct_caller/flutter_phone_direct_caller.dart';

void callNumber(String number) async {

  if(preferences.callContactsOnTap) {
    await FlutterPhoneDirectCaller.callNumber(number);
  } else {
    final Uri uri = Uri(scheme: "tel", path: number);
    if (await canLaunchUrl(uri)) {
      await launchUrl(uri);
    }
  }

}

Widget contactItem(String name, String phoneNumber, double screenWidth) {
  return SizedBox(
    width: screenWidth - 20,
    child: GestureDetector(
      onTap: () {
        callNumber(phoneNumber);
      },
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
        trailing: Icon(
          Icons.call,
          color: preferences.selectedTheme.textColor,
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
    ),
  );
}