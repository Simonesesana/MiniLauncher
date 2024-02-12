import 'package:app_usage/app_usage.dart';
import 'package:flutter/material.dart';
import 'package:minilauncher/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minilauncher/Pages/Home/AppUsages/TotalAppUsage.dart';
import 'package:minilauncher/Pages/Home/AppUsages/AppUsagesList.dart';

class FormattedUsageInfo {

  late String appName;
  late int hours;
  late int minutes;
  late var appIcon;

  // Constructor
  FormattedUsageInfo({required this.appName, required this.hours,
    required this.minutes, required this.appIcon});

}

class AppUsages extends StatefulWidget {
  const AppUsages({super.key});

  @override
  State<AppUsages> createState() => _AppUsagesState();
}

class _AppUsagesState extends State<AppUsages> {

  // App Usage Info
  int totalAppUsage = 0;
  List<FormattedUsageInfo> formattedAppUsageList =  [];

  bool isPermissionGranted = true;


  // Function to get app usages
  Future<void> getAppUsage() async {

    // grant usage permission - opens Usage Settings


    // check if usage permission is granted


    // get all app usage info from today
    DateTime endDate = DateTime.now();
    DateTime startDate = DateTime(
      DateTime.now().year,
      DateTime.now().month,
      DateTime.now().day,
      0, 0, 0
    );

    List<AppUsageInfo> infoList =
    await AppUsage().getAppUsage(startDate, endDate);

    for(AppUsageInfo app in infoList) {


      // Search for the app icon
      var appIcon;
      for(var a in preferences.apps) {
        if(a.packageName == app.packageName) {
          appIcon = a.icon;
        }
      }

      if(appIcon != null) {
        totalAppUsage = totalAppUsage + app.usage.inMinutes;
        formattedAppUsageList.add(FormattedUsageInfo(
            appName: app.appName,
            hours: app.usage.inHours.toInt(),
            minutes: app.usage.inMinutes - app.usage.inHours.toInt() * 60,
            appIcon: appIcon
          )
        );
      }
    }

    setState(() {});

  }

  @override
  void initState() {
    getAppUsage();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return isPermissionGranted ? SafeArea(
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: MediaQuery.of(context).size.width * 0.02
        ),
        child: Column(
          children: [

            // Title
            Padding(
              padding: EdgeInsets.only(
                top: MediaQuery.of(context).size.height / 100,
              ),
              child: Text(
                "Phone Usage",
                style: GoogleFonts.montserrat(
                    letterSpacing: 3,
                    color: preferences.selectedTheme.textColor,
                    fontSize: MediaQuery.of(context).size.width / 15
                ),
              ),
            ),

            // Total usage
            TotalAppUsage(totalAppUsage, context),

            // Usage list
            AppUsagesList(formattedAppUsageList),

          ],
        ),
      ),
    ) : Stack(
      children: [
        Center(
          child: Padding(
            padding: EdgeInsets.symmetric(
              horizontal: MediaQuery.of(context).size.width / 20
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Permission Not Granted",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                      letterSpacing: 3,
                      color: preferences.selectedTheme.textColor,
                      fontSize: MediaQuery.of(context).size.width / 23
                  ),
                ),
                Text(
                  "Please grant \"usage access\" permission to use this feature",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.montserrat(
                      letterSpacing: 2,
                      color: preferences.selectedTheme.textColor,
                      fontSize: MediaQuery.of(context).size.width / 27
                  ),
                ),
              ],
            ),
          ),
        ),
        Align(
          alignment: Alignment.bottomCenter,
          child: Padding(
            padding: EdgeInsets.only(
              bottom: MediaQuery.of(context).size.height / 30,
            ),
            child: TextButton(
              onPressed: () {
                getAppUsage();
              },
              style: TextButton.styleFrom(
                backgroundColor: preferences.selectedTheme.textColor.withOpacity(0.2),
                  shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)
                )
              ),
              child: Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 3
                ),
                child: Text(
                  "Grant Permission",
                  style: GoogleFonts.montserrat(
                      letterSpacing: 1,
                      color: preferences.selectedTheme.textColor,
                      fontSize: MediaQuery.of(context).size.width / 32
                  ),
                ),
              ),
            ),
          ),
        )
      ],
    );
  }
}

