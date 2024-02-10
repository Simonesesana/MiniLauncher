import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minilauncher/Internationalization/Locale.dart';
import 'package:minilauncher/main.dart';

class WelcomePage5 extends StatefulWidget {
  const WelcomePage5({super.key});

  @override
  State<WelcomePage5> createState() => _WelcomePage5State();
}

class _WelcomePage5State extends State<WelcomePage5> {
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
              lng["welcomePage"]["page5"]["title"],
              style: GoogleFonts.montserrat(
                color: preferences.selectedTheme.textColor,
                fontSize: MediaQuery.of(context).size.width * 0.08,
              ),
            ).animate().fade(
              duration: const Duration(milliseconds: 500),
            ),

            Text(
              lng["welcomePage"]["page5"]["subtitle"],
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
