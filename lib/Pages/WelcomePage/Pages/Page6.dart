import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minilauncher/main.dart';

class WelcomePage6 extends StatefulWidget {
  const WelcomePage6({super.key});

  @override
  State<WelcomePage6> createState() => _WelcomePage6State();
}

class _WelcomePage6State extends State<WelcomePage6> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: preferences.selectedTheme.primaryColor,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.03,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [

            Text(
              "You're all set!",
              style: GoogleFonts.montserrat(
                color: preferences.selectedTheme.textColor,
                fontSize: MediaQuery.of(context).size.width * 0.08,
              ),
            ).animate().fade(
              duration: const Duration(milliseconds: 500),
            ),

            Text(
              "Now you can start to use your new launcher!",
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                color: preferences.selectedTheme.textColor,
                fontSize: MediaQuery.of(context).size.width * 0.05,
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
