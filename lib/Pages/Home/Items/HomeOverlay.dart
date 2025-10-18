import 'dart:async';

import 'package:installed_apps/index.dart';
import 'package:minilauncher/Packages/Preferences/Preferences.dart';

import '../../../main.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:page_transition/page_transition.dart';
import 'package:minilauncher/Pages/Settings/Settings.dart';
import 'package:minilauncher/Pages/Home/Drawer/HomeDrawer.dart';

class HomeOverlay extends StatefulWidget {
  const HomeOverlay({Key? key}) : super(key: key);

  @override
  _HomeOverlayState createState() => _HomeOverlayState();
}

class _HomeOverlayState extends State<HomeOverlay> {

  // Timer
  late Timer dateTimer;

  // Current date
  DateTime currentDateTime = DateTime.now();

  // Function to enable focus mode
  void enableFocusMode() {

    // Add time to the focus mode
    preferences.focusModeEnd = DateTime.now().add(Duration(minutes: preferences.focusModeTimer.toInt()));

    // Save the preferences
    setString("focusModeEnd", DateTime.now().add(Duration(minutes: preferences.focusModeTimer.toInt())).toString());

    setState(() {});

  }

  // Function to disable focus mode before the time ends
  void disableFocusMode() {

    // Show dialog to confirm
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: preferences.selectedTheme.primaryColor,
            title: Text(
              "Disable Focus Mode",
              style: GoogleFonts.montserrat(
                  fontSize: MediaQuery.of(context).size.width / 20,
                  color: preferences.selectedTheme.textColor
              ),
            ),
            content: Text(
              "Are you sure you want to disable Focus Mode?",
              textAlign: TextAlign.justify,
              style: GoogleFonts.montserrat(
                  color: preferences.selectedTheme.textColor
              ),
            ),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: Text(
                  "Cancel",
                  style: GoogleFonts.montserrat(
                      color: preferences.selectedTheme.textColor
                  ),
                ),
              ),
              TextButton(
                onPressed: () {

                  // Remove the time from the focus mode
                  preferences.focusModeEnd = DateTime.now().subtract(const Duration(minutes: 1));

                  // Save the preferences
                  setString("focusModeEnd", DateTime.now().subtract(const Duration(minutes: 1)).toString());

                  setState(() {});

                  Navigator.pop(context);

                },
                child: Text(
                  "Ok",
                  style: GoogleFonts.montserrat(
                      color: Colors.red
                  ),
                ),
              )
            ],
          );
        }
    );

  }

  // Function to launch focus mode
  void activateFocusMode() {

    // If the focus mode is already enabled then return
    if(!preferences.focusModeEnd.difference(DateTime.now()).inSeconds.isNegative) {
      disableFocusMode();
      return;
    }

    // Show dialog to confirm
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: preferences.selectedTheme.primaryColor.withOpacity(0.5),
          title: Text(
            "Enable Focus Mode",
            style: GoogleFonts.montserrat(
              fontSize: MediaQuery.of(context).size.width / 20,
              color: preferences.selectedTheme.textColor
            ),
          ),
          content: Text(
            "Focus mode will improve your productivity for a fixed amount of time. During this time, you can only open the apps available on the home screen.",
            textAlign: TextAlign.justify,
            style: GoogleFonts.montserrat(
              color: preferences.selectedTheme.textColor
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text(
                "Cancel",
                style: GoogleFonts.montserrat(
                  color: Colors.red
                ),
              ),
            ),
            TextButton(
              onPressed: () {
                // Enable focus mode
                enableFocusMode();
                Navigator.pop(context);
              },
              child: Text(
                "Ok",
                style: GoogleFonts.montserrat(
                  color: preferences.selectedTheme.textColor
                ),
              ),
            )
          ],
        );
      }
    );

  }

  void updateDate() {
    dateTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        currentDateTime = DateTime.now();
      });
    });
  }

  @override
  void initState() {
    updateDate();
    super.initState();
  }

  @override
  void dispose() {
    dateTimer.cancel();
    super.dispose();
  }

  @override

  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: MediaQuery.of(context).size.height / 30,
        horizontal: MediaQuery.of(context).size.width / 20
      ),
      child: Column(

        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [

          /// Current Datetime
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [

              /// Time
              GestureDetector(
                onTap: () {
                  // Launch app
                  InstalledApps.startApp("com.android.deskclock");
                },
                child: Text(
                  "${currentDateTime.hour.toString().padLeft(2, "0")}"
                  ":${currentDateTime.minute.toString().padLeft(2, "0")}"
                  "${preferences.showSecondsOnClock ? ":${currentDateTime.second.toString().padLeft(2, "0")}" : ""}",
                  style: GoogleFonts.montserrat(
                    letterSpacing: 3,
                    color: preferences.selectedTheme.textColor,
                    fontSize: MediaQuery.of(context).size.width / 10
                  ),
                ),
              ),

              /// Date
              GestureDetector(
                onTap: () {
                  launchUrl(Uri.parse("content://com.android.calendar/time/"));
                },
                child: Text(
                  "${currentDateTime.day.toString().padLeft(2, "0")}/"
                  "${currentDateTime.month.toString().padLeft(2, "0")}/"
                  "${currentDateTime.year}",
                  style: GoogleFonts.montserrat(
                    letterSpacing: 2,
                    color: preferences.selectedTheme.textColor,
                    fontSize: MediaQuery.of(context).size.width / 22
                  ),
                ),
              )
            ],
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [

              /// Focus mode
              preferences.showFocusModeButtonOnHomeScreen ? GestureDetector(
                onTap: () {
                  activateFocusMode();
                },
                child: Card(
                  elevation: 0,
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    side: BorderSide(
                      color: preferences.selectedTheme.textColor
                    ),
                    borderRadius: BorderRadius.circular(20)
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                      vertical: 8,
                      horizontal: 15
                    ),
                    child: preferences.focusModeEnd.difference(DateTime.now()).inSeconds.isNegative ? Text(
                      "Focus Mode",
                      style: GoogleFonts.montserrat(
                        color: preferences.selectedTheme.textColor,
                      ),
                    ) : Text(
                      "${preferences.focusModeEnd.difference(DateTime.now()).inHours.toString().padLeft(2, "0")}"
                      ":${(preferences.focusModeEnd.difference(DateTime.now()).inMinutes - preferences.focusModeEnd.difference(DateTime.now()).inHours * 60).toString().padLeft(2, "0")}"
                      ":${(preferences.focusModeEnd.difference(DateTime.now()).inSeconds - preferences.focusModeEnd.difference(DateTime.now()).inMinutes * 60).toString().padLeft(2, "0")}",
                      style: GoogleFonts.montserrat(
                        color: preferences.selectedTheme.textColor,
                      ),
                    ),
                  ),
                ),
              ) : const SizedBox(),


              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [

                  /// App Drawer
                  preferences.focusModeEnd.difference(DateTime.now()).inSeconds.isNegative ? GestureDetector(
                    onTap: (){
                      Navigator.push(
                        context,
                        PageTransition(
                          child: const HomeDrawer(),
                          type: PageTransitionType.fade
                        )
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                              width: 1,
                              color: preferences.selectedTheme.textColor
                          ),
                          borderRadius: BorderRadius.circular(100)
                      ),
                      child: Icon(
                        Icons.keyboard_arrow_up,
                        color: preferences.selectedTheme.textColor,
                      ),
                    ),
                  ) : const SizedBox(),

                  const SizedBox(width: 10),

                  /// Dialer
                  GestureDetector(
                    onTap: () async {
                      await launchUrl(Uri.parse('tel:'));
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                          color: Colors.transparent,
                          border: Border.all(
                              width: 1,
                              color: preferences.selectedTheme.textColor
                          ),
                          borderRadius: BorderRadius.circular(100)
                      ),
                      child: Icon(
                        Icons.phone,
                        color: preferences.selectedTheme.textColor,
                      ),
                    ),
                  ),

                  const SizedBox(width: 10),

                  /// Settings
                  GestureDetector(
                    onTap: (){
                      Navigator.push(
                          context,
                          PageTransition(
                              child: const Settings(),
                              type: PageTransitionType.fade
                          )
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: Colors.transparent,
                        border: Border.all(
                          width: 1,
                          color: preferences.selectedTheme.textColor
                        ),
                        borderRadius: BorderRadius.circular(100)
                      ),
                      child: Icon(
                        Icons.settings,
                        color: preferences.selectedTheme.textColor,
                      ),
                    ),
                  ),

                ],
              ),
            ],
          )


        ],
      ),
    );
  }
}
