import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minilauncher/Internationalization/Locale.dart';
import 'package:minilauncher/main.dart';
import 'package:system_settings/system_settings.dart';

class WelcomePage5 extends StatefulWidget {
  const WelcomePage5({super.key});

  @override
  State<WelcomePage5> createState() => _WelcomePage5State();
}

class _WelcomePage5State extends State<WelcomePage5> {

  void openAppSettings() async {
    SystemSettings.defaultApps();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: preferences.selectedTheme.primaryColor,
      child: Padding(
        padding: EdgeInsets.symmetric(
            horizontal: MediaQuery.of(context).size.width / 25
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            // Title
            Center(
              child: Text(
                  lng["welcomePage"]["page5"]["title"],
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                      fontWeight: FontWeight.w500,
                      color: preferences.selectedTheme.textColor,
                      fontSize: MediaQuery.of(context).size.width / 23
                  )
              ),
            ).animate().fade(
              duration: const Duration(milliseconds: 500),
            ),

            const SizedBox(height: 20),

            // Enable location button
            GestureDetector(
              onTap: () {
                openAppSettings();
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 15
                  ),
                  child: Text(
                    lng["welcomePage"]["page5"]["buttonText"],
                    style: GoogleFonts.montserrat(
                        color: preferences.selectedTheme.primaryColor,
                        fontSize: MediaQuery.of(context).size.width / 27
                    ),
                  ),
                ),
              ),
            ).animate().fade(
              delay: const Duration(milliseconds: 500),
              duration: const Duration(milliseconds: 500),
            ),

          ],
        ),
      ),
    );
  }
}
