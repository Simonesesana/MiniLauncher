import 'package:flutter/material.dart';
import 'package:minilauncher/main.dart';
import 'package:google_fonts/google_fonts.dart';

TotalAppUsage(int totalAppUsage, BuildContext context) {
  return Padding(
    padding: const EdgeInsets.symmetric(
      vertical: 5
    ),
    child: SizedBox(
      width: MediaQuery.of(context).size.width,
      child: Card(
        color: preferences.selectedTheme.textColor.withOpacity(0.1),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10),
        ),
        child: Padding(
          padding: const EdgeInsets.symmetric(
              horizontal: 10
          ),
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical: 15
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [

                // Text
                Text(
                    "Total app usage: ${totalAppUsage ~/ 60} hrs ${(totalAppUsage - (totalAppUsage ~/ 60)*60).toString().padLeft(2, "0")} mins",
                    style: GoogleFonts.montserrat(
                        letterSpacing: 1,
                        color: preferences.selectedTheme.textColor,
                        fontSize: MediaQuery.of(context).size.width / 25
                    )
                ),

                const SizedBox(height: 10),

                // Slider
                LinearProgressIndicator(
                  minHeight: 10,
                  value: totalAppUsage / preferences.maxPhoneUsage,
                  borderRadius: BorderRadius.circular(10),
                  backgroundColor: preferences.selectedTheme.textColor.withOpacity(0.2),
                  valueColor: totalAppUsage <= preferences.maxPhoneUsage ?
                    (
                      totalAppUsage <= preferences.maxPhoneUsage * 0.6 ?
                        const AlwaysStoppedAnimation<Color>(Colors.green)
                        : const AlwaysStoppedAnimation<Color>(Colors.orange)
                    )
                    : const AlwaysStoppedAnimation<Color>(Colors.red),
                )


              ],
            ),
          ),
        ),
      ),
    ),
  );
}