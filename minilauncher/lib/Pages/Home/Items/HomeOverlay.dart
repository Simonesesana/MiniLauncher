import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minilauncher/Themes/Theme.dart';

class HomeOverlay extends StatefulWidget {
  const HomeOverlay({Key? key}) : super(key: key);

  @override
  _HomeOverlayState createState() => _HomeOverlayState();
}

class _HomeOverlayState extends State<HomeOverlay> {
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
                "${DateTime.now().hour}:${DateTime.now().minute}",
                style: GoogleFonts.montserrat(
                  letterSpacing: 5,
                  color: selectedTheme.textColor,
                  fontSize: MediaQuery.of(context).size.width / 10
                ),
              ),

              /// Date
              Text(
                "${DateTime.now().day.toString().padLeft(2, "0")}/"
                "${DateTime.now().month.toString().padLeft(2, "0")}/"
                "${DateTime.now().year}",
                style: GoogleFonts.montserrat(
                  letterSpacing: 2,
                  color: selectedTheme.textColor,
                  fontSize: MediaQuery.of(context).size.width / 22
                ),
              )
            ],
          ),

          /// Settings button
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [

              /// App Drawer
              GestureDetector(
                onTap: (){
                  print("drawer");
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(
                          width: 1,
                          color: selectedTheme.textColor
                      ),
                      borderRadius: BorderRadius.circular(100)
                  ),
                  child: Icon(
                    Icons.keyboard_arrow_up,
                    color: selectedTheme.textColor,
                  ),
                ),
              ),

              const SizedBox(width: 10),

              /// Settings
              GestureDetector(
                onTap: (){
                  Navigator.pushNamed(context, '/settings');
                },
                child: Container(
                  padding: const EdgeInsets.all(8),
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    border: Border.all(
                      width: 1,
                      color: selectedTheme.textColor
                    ),
                    borderRadius: BorderRadius.circular(100)
                  ),
                  child: Icon(
                    Icons.settings,
                    color: selectedTheme.textColor,
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
