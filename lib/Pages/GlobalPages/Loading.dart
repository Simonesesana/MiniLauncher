import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:minilauncher/Themes/Theme.dart';

class Loading extends StatelessWidget {
  const Loading({Key? key}) : super(key: key);

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
