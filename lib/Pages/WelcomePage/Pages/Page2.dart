import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minilauncher/Internationalization/Locale.dart';
import 'package:minilauncher/main.dart';

class WelcomePage2 extends StatefulWidget {
  const WelcomePage2({super.key});

  @override
  State<WelcomePage2> createState() => _WelcomePage2State();
}

class _WelcomePage2State extends State<WelcomePage2> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: preferences.selectedTheme.primaryColor,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [

          Text(
            lng["welcomePage"]["page2"]["title"],
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              color: Colors.white,
              fontSize: MediaQuery.of(context).size.width / 20,
            ),
          ).animate().fade(
            duration: const Duration(milliseconds: 400),
          ),

          const SizedBox(height: 20),

          // Language selector
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              /// English
              GestureDetector(
                onTap: () {
                  Lng.changeLanguage("en");
                  setState(() {});
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 4,
                  height: MediaQuery.of(context).size.width / 4,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Lng.locale == "en" ? Border.fromBorderSide(BorderSide(
                        width: 3,
                        color: preferences.selectedTheme.textColor,
                      )
                    ): null,
                    image: const DecorationImage(
                      image: AssetImage("assets/flags/en.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ).animate().fade(
                delay: const Duration(milliseconds: 400),
                duration: const Duration(milliseconds: 400),
              ),

              const SizedBox(width: 20),

              /// Italian
              GestureDetector(
                onTap: () {
                  Lng.changeLanguage("it");
                  setState(() {});
                },
                child: Container(
                  width: MediaQuery.of(context).size.width / 4,
                  height: MediaQuery.of(context).size.width / 4,
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Lng.locale == "it" ? Border.fromBorderSide(BorderSide(
                        width: 3,
                        color: preferences.selectedTheme.textColor,
                      )
                    ) : null,
                    image: const DecorationImage(
                      image: AssetImage("assets/flags/it.png"),
                      fit: BoxFit.cover,
                    ),
                  ),
                ),
              ).animate().fade(
                delay: const Duration(milliseconds: 800),
                duration: const Duration(milliseconds: 400),
              ),

            ],
          )

        ],
      ),
    );
  }
}
