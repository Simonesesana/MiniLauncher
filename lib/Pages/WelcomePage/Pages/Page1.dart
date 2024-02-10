import 'package:flutter/material.dart';
import 'package:minilauncher/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:minilauncher/Internationalization/Locale.dart';

class WelcomePage1 extends StatefulWidget {
  const WelcomePage1({super.key});

  @override
  State<WelcomePage1> createState() => _WelcomePage1State();
}

class _WelcomePage1State extends State<WelcomePage1> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: preferences.selectedTheme.primaryColor,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.04,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              lng["welcomePage"]["page1"]["title"],
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width / 14,
              ),
            ).animate().fade(
              duration: const Duration(milliseconds: 500),
            ),
            const SizedBox(height: 20),
            Text(
              lng["welcomePage"]["page1"]["subtitle"],
              textAlign: TextAlign.center,
              style: GoogleFonts.montserrat(
                color: Colors.white,
                fontSize: MediaQuery.of(context).size.width / 23,
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
