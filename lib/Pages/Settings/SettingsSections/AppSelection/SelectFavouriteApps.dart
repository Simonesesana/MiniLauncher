import 'package:minilauncher/Packages/GlobalElements/ApplicationItem.dart';
import 'package:minilauncher/Packages/GlobalProperties/TextFieldDecoration.dart';
import 'package:minilauncher/Packages/Preferences/PreferencesClass.dart';
import '../../../../main.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class SelectFavouriteApps extends StatefulWidget {
  const SelectFavouriteApps({Key? key}) : super(key: key);

  @override
  _SelectFavouriteAppsState createState() => _SelectFavouriteAppsState();
}

class _SelectFavouriteAppsState extends State<SelectFavouriteApps> {

  /// Search bar text
  String searchText = "";

  /// This function determines if the app is set as favourite
  bool isFavourite(String packageName) {
    for (var element in preferences.favouriteApps) {
      if(element.packageName == packageName) {
        return true;
      }
    }
    return false;
  }

  /// This function determines if the app is being searched in the search bar
  bool isSearched(String appName) {

    if(searchText==""){
      return true;
    }

    if(appName.toLowerCase().contains(searchText.toLowerCase())){
      return true;
    }
    return false;
  }

  @override
  Widget build(BuildContext context) {

    /// Screen width
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(

      backgroundColor: preferences.selectedTheme.primaryColor,

      /// AppBar
      appBar: AppBar(

        elevation: 0,
        centerTitle: true,
        backgroundColor: preferences.selectedTheme.textColor.withOpacity(0.1),

        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(15),
                bottomRight: Radius.circular(15)
            )
        ),

        title: Text(
          "Favourite apps",
          style: GoogleFonts.montserrat(
              letterSpacing: 2,
              fontWeight: FontWeight.w400,
              color: preferences.selectedTheme.textColor,
              fontSize: screenWidth / 20
          ),
        ),

        /// Back button
        leading: IconButton(
          color: preferences.selectedTheme.textColor,
          icon: Icon(
            Icons.arrow_back_ios,
            size: 17,
            color: preferences.selectedTheme.textColor,
          ),
          onPressed: (){
            Navigator.pop(context);
          },
        ),
      ),

      /// App list
      body: Padding(
        padding: const EdgeInsets.fromLTRB(8, 0, 8, 0),
        child: Column(
          
          children: [

            /// Text field
            Padding(
              padding: const EdgeInsets.only(
                top: 10,
                bottom: 5
              ),
              child: GestureDetector(
                onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                child: TextField(
                  onChanged: (String value) {
                    setState(() {
                      searchText = value;
                    });
                  },

                  style: GoogleFonts.montserrat(
                    color: preferences.selectedTheme.textColor,
                    fontSize: MediaQuery.of(context).size.width / 25
                  ),

                  decoration: searchBarTextFieldDecoration(screenWidth),
                ),
              ),
            ),

            /// App list
            Flexible(
              child: ListView.builder(
                itemCount: preferences.apps.length,
                itemBuilder: (context, index){
                  return isSearched(preferences.apps[index].name)
                      ? Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [

                      /// App Item
                      ApplicationItem(
                          context,
                          preferences.apps[index].name,
                          preferences.apps[index].packageName,
                          preferences.apps[index].icon
                      ),

                      /// Favourite button
                      IconButton(
                        onPressed: (){

                          /// Adds or removes app from favourite
                          if(isFavourite(preferences.apps[index].packageName)) {
                            PreferencesClass.removeFavouriteApp(
                                preferences.apps[index].packageName
                            );
                          } else {
                            PreferencesClass.addFavouriteApp(
                                preferences.apps[index].name,
                                preferences.apps[index].packageName,
                                preferences.apps[index].icon
                            );
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
                  )
                      : const SizedBox();
                },
              ),
            ),
          ],
        ),
      ),

    );
  }
}
