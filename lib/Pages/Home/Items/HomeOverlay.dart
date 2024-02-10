import 'dart:async';

import '../../../main.dart';
import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';
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
                  DeviceApps.openApp("com.android.deskclock");
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
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

              /// App Drawer
              GestureDetector(
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
              ),

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
          )


        ],
      ),
    );
  }
}
