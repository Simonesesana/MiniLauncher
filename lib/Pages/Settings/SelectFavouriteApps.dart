import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Themes/Theme.dart';
import '../../main.dart';
import '../Home/Items/ApplicationItem.dart';

class SelectFavouriteApps extends StatefulWidget {
  const SelectFavouriteApps({Key? key}) : super(key: key);

  @override
  _SelectFavouriteAppsState createState() => _SelectFavouriteAppsState();
}

class _SelectFavouriteAppsState extends State<SelectFavouriteApps> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: selectedTheme.primaryColor,

      /// AppBar
      appBar: AppBar(

        centerTitle: true,
        backgroundColor: selectedTheme.textColor.withOpacity(0.1),

        title: Text(
          "Favourite Apps",
          style: GoogleFonts.montserrat(
              letterSpacing: 2,
              fontWeight: FontWeight.w400,
              color: selectedTheme.textColor,
              fontSize: MediaQuery.of(context).size.width / 20
          ),
        ),

        /// Back button
        leading: IconButton(
          color: selectedTheme.textColor,
          icon: Icon(
            Icons.arrow_back_ios,
            color: selectedTheme.textColor,
            size: 17,
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),

      /// App list
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Scrollbar(
          thickness: 10,
          radius: Radius.circular(20),
          scrollbarOrientation: ScrollbarOrientation.right,
          child: ListView.builder(
            itemCount: preferences.apps.length,
            itemBuilder: (context, index){
              return ApplicationItem(
                  context,
                  preferences.apps[index].appName,
                  preferences.apps[index].packageName,
                  preferences.apps[index].icon
              );
            },
          ),
        ),
      ),

    );
  }
}
