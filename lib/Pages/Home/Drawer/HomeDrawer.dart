import 'package:device_apps/device_apps.dart';
import 'package:minilauncher/Pages/Loading/LauncherInitialization.dart';

import '../../../main.dart';
import '../Items/ApplicationItem.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../GlobalProperties/TextFieldDecoration.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {

  /// Search bar text
  String searchText = "";

  /// Search bar controller
  TextEditingController searchBarController = TextEditingController();

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


  /// Checks if new apps have been installed
  void checkNewApps() async {
    List<Application> apps = await DeviceApps.getInstalledApplications(
      includeAppIcons: true,
      includeSystemApps: true,
      onlyAppsWithLaunchIntent: true,
    );
    if(apps.length != preferences.apps.length) {
      await initializeLauncher(fetchOnlyAppList: true);
      setState(() {});
    }
  }

  @override
  void initState() {
    checkNewApps();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {

    /// Screen width
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(

      backgroundColor: preferences.selectedTheme.primaryColor,

      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
          child: Column(
            children: [

              /// Search bar
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 10, 5, 5),
                child: GestureDetector(
                  onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                  child: TextField(

                    controller: searchBarController,
                    onChanged: (String value) {
                      setState(() {
                        searchText = value;
                      });
                    },

                    style: GoogleFonts.montserrat(
                        color: preferences.selectedTheme.textColor,
                        fontSize: MediaQuery.of(context).size.width / 25
                    ),

                    decoration: textFieldDecoration(screenWidth).copyWith(
                      suffixIcon: GestureDetector(
                        onTap: () {
                          setState(() {
                            searchText = "";
                            searchBarController.clear();
                          });
                        },
                        child: Icon(
                          Icons.close,
                          color: preferences.selectedTheme.textColor,
                          size: MediaQuery.of(context).size.width / 25,
                        ),
                      )
                    ),
                  ),
                ),
              ).animate().fade(
                duration: const Duration(seconds: 1)
              ),

              /// App List
              Flexible(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                    horizontal: 10
                  ),
                  child: AnimationLimiter(
                    child: ListView.builder(
                      itemCount: preferences.apps.length,
                      itemBuilder: (context, index){
                        try{
                          if(preferences.apps[index].appName[0].toString().toUpperCase() != preferences.apps[index-1].appName[0].toString().toUpperCase()) {
                            return ApplicationItemWithLetter(index);
                          }
                        } catch(e) {
                          return  ApplicationItemWithLetter(index);
                        }
                        return AnimationConfiguration.staggeredList(
                          position: index,
                          child: FadeInAnimation(
                              child: isSearched(preferences.apps[index].appName) ? ApplicationItem(
                                  context,
                                  preferences.apps[index].appName,
                                  preferences.apps[index].packageName,
                                  preferences.apps[index].icon
                              ) : const SizedBox()
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),

    );
  }

  ApplicationItemWithLetter (
      int index
      ) {
    return searchText == "" ? Padding(
      padding: const EdgeInsets.only(
        top: 10,
        bottom: 5
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AnimationConfiguration.staggeredList(
            position: index,
            child: FadeInAnimation(
              child: Text(
                  preferences.apps[index].appName[0].toString().toUpperCase(),
                  style: GoogleFonts.montserrat(
                      fontSize: 20,
                      fontWeight: FontWeight.w500,
                      color: preferences.selectedTheme.textColor
                  )
              ),
            ),
          ),
          const SizedBox(
            height: 5,
          ),
          AnimationConfiguration.staggeredList(
            position: index,
            child: FadeInAnimation(
                child: isSearched(preferences.apps[index].appName) ? ApplicationItem(
                    context,
                    preferences.apps[index].appName,
                    preferences.apps[index].packageName,
                    preferences.apps[index].icon
                ) : const SizedBox()
            ),
          )
        ],
      ),
    ) : AnimationConfiguration.staggeredList(
      position: index,
      child: FadeInAnimation(
          child: isSearched(preferences.apps[index].appName) ? ApplicationItem(
              context,
              preferences.apps[index].appName,
              preferences.apps[index].packageName,
              preferences.apps[index].icon
          ) : const SizedBox()
      ),
    );
  }
  
}
