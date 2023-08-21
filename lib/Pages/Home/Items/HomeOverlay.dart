import 'dart:async';

import 'package:flutter_animate/flutter_animate.dart';
import 'package:minilauncher/Pages/Home/Drawer/HomeDrawer.dart';
import 'package:minilauncher/Pages/Settings/Settings.dart';
import 'package:page_transition/page_transition.dart';

import '../../../main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

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
              Text(
                "${currentDateTime.hour.toString().padLeft(2, "0")}"
                ":${currentDateTime.minute.toString().padLeft(2, "0")}"
                "${preferences.showSecondsOnClock ? ":${currentDateTime.second.toString().padLeft(2, "0")}" : ""}",
                style: GoogleFonts.montserrat(
                  letterSpacing: 3,
                  color: preferences.selectedTheme.textColor,
                  fontSize: MediaQuery.of(context).size.width / 10
                ),
              ),

              /// Date
              Text(
                "${currentDateTime.day.toString().padLeft(2, "0")}/"
                "${currentDateTime.month.toString().padLeft(2, "0")}/"
                "${currentDateTime.year}",
                style: GoogleFonts.montserrat(
                  letterSpacing: 2,
                  color: preferences.selectedTheme.textColor,
                  fontSize: MediaQuery.of(context).size.width / 22
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
