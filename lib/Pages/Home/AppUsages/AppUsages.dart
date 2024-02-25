import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minilauncher/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minilauncher/Pages/Home/AppUsages/TotalAppUsage.dart';
import 'package:minilauncher/Pages/Home/AppUsages/AppUsagesList.dart';

class FormattedUsageInfo {

  late String appName;
  late int hours;
  late int minutes;
  late var appIcon;

  late int totalUsageInMinutes;

  // Constructor
  FormattedUsageInfo({required this.appName, required this.hours,
    required this.minutes, required this.appIcon, required this.totalUsageInMinutes});

}

class AppUsages extends StatefulWidget {
  const AppUsages({super.key});

  @override
  State<AppUsages> createState() => _AppUsagesState();
}

class _AppUsagesState extends State<AppUsages> {

  // Method channel
  static const platform = MethodChannel("com.simon.minilauncher/test");

  // App Usage Info
  int totalAppUsage = 0;
  List<FormattedUsageInfo> formattedAppUsageList =  [];

  bool isPermissionGranted = true;


  // Function to get app usages
  Future<void> getAppUsage() async {

    var infoList = await platform.invokeMethod('getAppUsageList');


    for(var app in infoList) {

      print(app);

      // Search for the app icon
      var appName;
      var appIcon;
      for(var a in preferences.apps) {
        if(a.packageName == app["packageName"]) {
          appIcon = a.icon;
          appName = a.appName;
        }
      }

      print(app["usageTimeInMinutes"]);

      if(appIcon != null) {
        totalAppUsage = totalAppUsage + int.parse(app["usageTimeInMinutes"].toString());
        int _appUsage = int.parse(app["usageTimeInMinutes"].toString());
        formattedAppUsageList.add(FormattedUsageInfo(
            appName: appName.toString(),
            hours: _appUsage ~/ 60,
            minutes: _appUsage - (_appUsage ~/ 60) * 60,
            appIcon: appIcon,
            totalUsageInMinutes: _appUsage
          )
        );
      }

    }

    // Ordering the results based on the time usage
    formattedAppUsageList.sort((b, a) => a.totalUsageInMinutes.compareTo(b.totalUsageInMinutes));

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

