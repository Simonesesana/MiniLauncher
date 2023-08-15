import 'package:flutter/material.dart';
import 'package:minilauncher/main.dart';
import 'package:device_apps/device_apps.dart';
import 'package:google_fonts/google_fonts.dart';

ApplicationItem(
  BuildContext context,
  String appName,
  String packageName,
  var icon
) {
  return GestureDetector(

    onTap: (){
      /// Opens the application
      DeviceApps.openApp(packageName);
    },

    child: Container(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 5,
          left: 7,
          bottom: 5,
        ),

        child: Row(
          children: [

            /// App icon
            Image(
              width: 40,
              image: MemoryImage(
                icon
              ),
            ),

            const SizedBox(width: 10),

            /// App text
            Text(
              appName,
              style: GoogleFonts.montserrat(
                letterSpacing: 1.5,
                fontWeight: FontWeight.w500,
                color: preferences.selectedTheme.textColor,
                fontSize: MediaQuery.of(context).size.width / 27,
              ),
            ),
          ],

        ),
      ),
    ),

  );
}