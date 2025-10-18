import 'dart:async';
import 'package:flutter/material.dart';
import 'package:installed_apps/index.dart';
import 'package:minilauncher/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:android_intent_plus/android_intent.dart';

void showRestrictedAppDialog(BuildContext context, String packageName) async {

  /// Indicates if the dialog has been closed
  bool dialogIsClosed = false;

  /// Remaining seconds for the app opening
  int seconds = preferences.restrictedAppTimer.toInt();

  /// Timer to detract seconds
  Timer t1 = Timer.periodic(const Duration(seconds: 1), (timer) {
    seconds = seconds -1;
  });

  /// Timer to update the state of the dialog
  late Timer t2;

  /// Timer to close the dialog
  Future.delayed(Duration(seconds: preferences.restrictedAppTimer.toInt()), () {
    if(!dialogIsClosed) Navigator.of(context).pop();
    if(!dialogIsClosed) InstalledApps.startApp(packageName);
  });

  await showDialog(
    context: context,
    builder: (BuildContext context) {
      return StatefulBuilder(
          builder: (context, setState) {
            t2 = Timer.periodic(const Duration(seconds: 1), (timer) {
              try {setState(() {});} catch (e) {}
            });
            return Dialog(
              elevation: 5,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(20)
              ),
              backgroundColor: Colors.red[400],
              child: SizedBox(
                height: MediaQuery.of(context).size.height * 0.27,
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      horizontal: 20
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Restricted App",
                        style: GoogleFonts.montserrat(
                          letterSpacing: 1.5,
                          fontWeight: FontWeight.w500,
                          color: preferences.selectedTheme.textColor,
                          fontSize: MediaQuery.of(context).size.width / 23,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 5,
                            bottom: 30
                        ),
                        child: Text(
                          "The access for these app is restricted. You have to wait a fixed amount of time for these apps to boot up.",
                          textAlign: TextAlign.justify,
                          style: GoogleFonts.montserrat(
                            letterSpacing: 1.5,
                            color: preferences.selectedTheme.textColor,
                            fontSize: MediaQuery.of(context).size.width / 28,
                          ),
                        ),
                      ),
                      Center(
                        child: Text(
                          "${seconds}s",
                          style: GoogleFonts.montserrat(
                            letterSpacing: 1.5,
                            fontWeight: FontWeight.w500,
                            color: preferences.selectedTheme.textColor,
                            fontSize: MediaQuery.of(context).size.width / 25,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            );
          }
      );
    },
  ).then((value) {
    dialogIsClosed = true;
    try {
      t1.cancel();
      t2.cancel();
    } catch (e) {}
  });
}

ApplicationItem(
    BuildContext context,
    String? appName,
    String packageName,
    var icon
    ) {
  return GestureDetector(

    onLongPress: () {
      AndroidIntent intent = AndroidIntent(
        action: "android.settings.APPLICATION_DETAILS_SETTINGS",
        data: "package:$packageName",
        package: packageName,
      );
      intent.launch();
    },

    onTap: (){

      /// Opens the application if not restricted
      if(!preferences.restrictedPackages.contains(packageName)) {
        InstalledApps.startApp(packageName);
      } else {
        showRestrictedAppDialog(context, packageName);
      }

    },

    child: Container(
      color: Colors.transparent,
      child: Padding(
        padding: const EdgeInsets.only(
          top: 5,
          left: 7,
          bottom: 5,
        ),

        child: Row(
          children: [

            /// App icon
            preferences.showRoundIcons ? Container(
              width: 43,
              height: 46,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  fit: BoxFit.fitHeight,
                  image: MemoryImage(
                      icon
                  ),
                ),
              ),
            ) : Image(
              width: 43,
              image: MemoryImage(
                  icon
              ),
            ),

            const SizedBox(width: 10),

            /// App text
            SizedBox(
              width: MediaQuery.of(context).size.width * 0.65,
              child: Text(
                appName ?? "",
                overflow: TextOverflow.ellipsis,
                style: GoogleFonts.montserrat(
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.w500,
                  color: preferences.selectedTheme.textColor,
                  fontSize: MediaQuery.of(context).size.width / 23,
                ),
              ),
            ),
          ],

        ),
      ),
    ),

  );
}