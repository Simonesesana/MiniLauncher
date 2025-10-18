import 'package:flutter/material.dart';
import 'package:minilauncher/Packages/GlobalElements/ApplicationItem.dart';
import 'package:minilauncher/main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minilauncher/Packages/Preferences/PreferencesClass.dart';
import 'package:minilauncher/Packages/GlobalProperties/TextFieldDecoration.dart';

class SelectRestrictedApps extends StatefulWidget {
  const SelectRestrictedApps({Key? key}) : super(key: key);

  @override
  _SelectRestrictedAppsState createState() => _SelectRestrictedAppsState();
}

class _SelectRestrictedAppsState extends State<SelectRestrictedApps> {

  /// Search bar text
  String searchText = "";

  /// This function determines if the app is set as favourite
  bool isRestricted(String packageName) {
    for (var element in preferences.restrictedApps) {
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
          "Restricted Apps",
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

                      /// Restricted button
                      IconButton(
                        onPressed: (){

                          /// Adds or removes app from favourite
                          if(isRestricted(preferences.apps[index].packageName)) {
                            PreferencesClass.removeRestrictedApp(preferences.apps[index].packageName);
                          } else {
                            PreferencesClass.addRestrictedApp(preferences.apps[index].packageName);
                          }

                          /// Updates interface
                          setState(() {});

                        },
                        icon: !isRestricted(preferences.apps[index].packageName) ? Icon(
                            Icons.remove_circle_outline,
                            color: preferences.selectedTheme.textColor
                        ) : Icon(
                            Icons.remove_circle,
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
