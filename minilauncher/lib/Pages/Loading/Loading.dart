import 'package:device_apps/device_apps.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minilauncher/Themes/Theme.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import '../../main.dart';


class Loading extends StatefulWidget {
  const Loading({Key? key}) : super(key: key);

  @override
  _LoadingState createState() => _LoadingState();
}

class _LoadingState extends State<Loading> {

  void getApps() async {

    /// Retrieves the app list
    apps = await DeviceApps.getInstalledApplications
      (
      includeAppIcons: true,
      includeSystemApps: true,
      onlyAppsWithLaunchIntent: true,
    );

    Navigator.pushReplacementNamed(context, '/home');

  }

  @override
  void initState() {
    getApps();
    super.initState();
  }


  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [

        /// Loading spinkit
        SpinKitRing(
          lineWidth: 1,
          color: selectedTheme.textColor,
          size: MediaQuery.of(context).size.width / 10,
        ),

        /// Text
        Padding(
            padding: const EdgeInsets.only(
              top: 20,
            ),
            child: Text(
                "Loading, please wait...",
                textAlign: TextAlign.center,
                style: GoogleFonts.nunito(
                    height: 1.2,
                    color: selectedTheme.textColor,
                    fontWeight: FontWeight.w300,
                    decoration: TextDecoration.none,
                    fontSize: MediaQuery.of(context).size.width / 20
                )
            )
        )

      ],
    );
  }
}

