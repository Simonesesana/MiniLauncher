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
        horizontal: MediaQuery.of(context).size.width / 30
      ),
      child: Column(

        mainAxisAlignment: MainAxisAlignment.spaceBetween,

        children: [

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
          )


        ],
      ),
    );
  }
}
