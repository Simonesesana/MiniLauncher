import '../../../main.dart';
import 'package:flutter/material.dart';
import '../../Home/Items/ApplicationItem.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minilauncher/Preferences/PreferencesClass.dart';

class SelectFavouriteApps extends StatefulWidget {
  const SelectFavouriteApps({Key? key}) : super(key: key);

  @override
  _SelectFavouriteAppsState createState() => _SelectFavouriteAppsState();
}

class _SelectFavouriteAppsState extends State<SelectFavouriteApps> {

  bool isFavourite(String packageName) {
    for (var element in preferences.favouriteApps) {
      if(element.packageName == packageName) {
        return true;
      }
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      backgroundColor: preferences.selectedTheme.primaryColor,

      /// AppBar
      appBar: AppBar(

        elevation: 0,
        centerTitle: true,
        backgroundColor: preferences.selectedTheme.textColor.withOpacity(0.1),

        title: Text(
          "Favourite Apps",
          style: GoogleFonts.montserrat(
              letterSpacing: 2,
              fontWeight: FontWeight.w400,
              color: preferences.selectedTheme.textColor,
              fontSize: MediaQuery.of(context).size.width / 20
          ),
        ),

        /// Back button
        leading: IconButton(
          color: preferences.selectedTheme.textColor,
          icon: Icon(
            Icons.arrow_back_ios,
            color: preferences.selectedTheme.textColor,
            size: 17,
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),

      /// App list
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: ListView.builder(
          itemCount: preferences.apps.length,
          itemBuilder: (context, index){
            return Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [

                /// App Item
                ApplicationItem(
                    context,
                    preferences.apps[index].appName,
                    preferences.apps[index].packageName,
                    preferences.apps[index].icon
                ),

                /// Favourite button
                IconButton(
                  onPressed: (){

                    /// Adds or removes app from favourite
                    if(isFavourite(preferences.apps[index].packageName)) {
                      PreferencesClass.removeFavouriteApp(preferences.apps[index].packageName);
                    } else {
                      PreferencesClass.addFavouriteApp(preferences.apps[index].packageName);
                    }

                    /// Updates interface
                    setState(() {});

                  },
                  icon: !isFavourite(preferences.apps[index].packageName) ? Icon(
                    Icons.favorite_border_outlined,
                    color: preferences.selectedTheme.textColor
                  ) : Icon(
                      Icons.favorite,
                      color: preferences.selectedTheme.textColor
                  ),
                )

              ],
            );
          },
        ),
      ),

    );
  }
}
