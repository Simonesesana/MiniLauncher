import 'package:flutter/material.dart';
import 'package:minilauncher/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:minilauncher/Internationalization/Locale.dart';
import 'package:permission_handler/permission_handler.dart';

class WelcomePage4 extends StatefulWidget {
  const WelcomePage4({super.key});

  @override
  State<WelcomePage4> createState() => _WelcomePage4State();
}

class _WelcomePage4State extends State<WelcomePage4> {

  bool granted = false;

  void askForLocationPermission() async {
    if (await Permission.location.isPermanentlyDenied) {
      openAppSettings();
    } else {
      granted = await Permission.location.request().isGranted;
      setState(() {});
    }
  }

  void getPermissionAccess() async {
    granted = await Permission.location.isGranted;
    setState(() {});
  }

  @override
  void initState() {
    getPermissionAccess();
    super.initState();
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
                lng["welcomePage"]["page4"]["title"],
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
            !granted ? GestureDetector(
              onTap: () {
                askForLocationPermission();
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    vertical: 5,
                    horizontal: 15
                  ),
                  child: Text(
                    lng["welcomePage"]["page4"]["buttonText"],
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
            ) : const SizedBox(),

          ],
        ),
      ),
    );
  }
}
