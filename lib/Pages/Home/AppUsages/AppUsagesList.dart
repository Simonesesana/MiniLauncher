import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minilauncher/main.dart';

AppUsagesList(List formattedAppUsageList) {
  return Flexible(
    child: Card(
      color: preferences.selectedTheme.textColor.withOpacity(0.1),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(10),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: 10
        ),
        child: ListView.builder(
          itemCount: formattedAppUsageList.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: const EdgeInsets.only(bottom: 5,top: 5),
              child: Row(
                children: [
                  formattedAppUsageList[index].appIcon != null ? Image.memory(
                    formattedAppUsageList[index].appIcon,
                    height: MediaQuery.of(context).size.width / 10,
                    width: MediaQuery.of(context).size.width / 10,
                  ) : const SizedBox(),
                  const SizedBox(width: 10),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                          formattedAppUsageList[index].appName!,
                          style: GoogleFonts.montserrat(
                              letterSpacing: 1,
                              color: preferences.selectedTheme.textColor,
                              fontSize: MediaQuery.of(context).size.width / 25
                          )
                      ),
                      Text(
                        "${formattedAppUsageList[index].hours.toString()}:${formattedAppUsageList[index].minutes.toString().padLeft(2, "0")} hrs",
                        style: GoogleFonts.montserrat(
                            letterSpacing: 1,
                          fontSize: MediaQuery.of(context).size.width / 30,
                          color: preferences.selectedTheme.textColor.withOpacity(0.6),
                        )
                      ),
                    ],
                  )
                ],
              ),
            );
          },
        ),
      ),
    ),
  );
}