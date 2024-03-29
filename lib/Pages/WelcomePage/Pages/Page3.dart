import 'package:flutter/material.dart';
import 'package:minilauncher/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:page_transition/page_transition.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:minilauncher/Internationalization/Locale.dart';
import 'package:minilauncher/Pages/Settings/SettingsSections/AppSelection/SelectFavouriteApps.dart';

class WelcomePage3 extends StatefulWidget {
  const WelcomePage3({super.key});

  @override
  State<WelcomePage3> createState() => _WelcomePage3State();
}

class _WelcomePage3State extends State<WelcomePage3> {

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
                  lng["welcomePage"]["page3"]["title"],
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
                Navigator.push(
                    context,
                    PageTransition(
                        child: const SelectFavouriteApps(),
                        type: PageTransitionType.fade
                    )
                );
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 15
                  ),
                  child: Text(
                    lng["welcomePage"]["page3"]["buttonText"],
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
            )

          ],
        ),
      ),
    );
  }
}
