import '../../../main.dart';
import 'package:flutter/material.dart';
import '../Items/ApplicationItem.dart';
import 'package:device_apps/device_apps.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:flutter_animate/flutter_animate.dart';
import '../../../GlobalProperties/TextFieldDecoration.dart';
import 'package:minilauncher/Pages/Loading/LauncherInitialization.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';

class HomeDrawer extends StatefulWidget {
  const HomeDrawer({Key? key}) : super(key: key);

  @override
  _HomeDrawerState createState() => _HomeDrawerState();
}

class _HomeDrawerState extends State<HomeDrawer> {

  /// Search bar text
  String searchText = "";

  /// Keyboard focus node
  final FocusNode _focusNode = FocusNode();

  /// Search bar controller
  TextEditingController searchBarController = TextEditingController();

  /// This function determines if the app is being searched in the search bar
  bool isSearched(String appName) {

    if(searchText=="" || appName.toLowerCase().contains(searchText.toLowerCase())){
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
      await initializeAppList(fetchOnlyAppList: true);
      setState(() {});
    }
  }

  /// Checks if the app is the only one of the list, if so it opens it. Only if
  /// the app is not restricted
  void checkIfOpenApp() {
    String text = searchText;
    if(preferences.apps.where(
            (app) => app.appName.toString().toLowerCase().contains(searchText)
    ).length == 1){
      var app = preferences.apps.where(
              (app) => app.appName.toString().toLowerCase().contains(searchText)
      ).toList()[0];
      if(!preferences.restrictedPackages.contains(app.packageName)) {
        setState(() {
          searchText = "";
          searchBarController.clear();
        });
        DeviceApps.openApp(
            preferences.apps.where((app) => app.appName.toString().toLowerCase().contains(text)).toList()[0].packageName);
       }
    }
  }

  /// Opens the keyboard
  openKeyboard() {
    Future.delayed(const Duration(milliseconds: 0), () {
      // Focuses on the search bar
      FocusScope.of(context).requestFocus(_focusNode);
    });
  }

  @override
  void initState() {
    checkNewApps();
    super.initState();
    if (preferences.automaticallyOpenKeyboardOnAppDrawer) openKeyboard();
  }

  @override
  Widget build(BuildContext context) {

    /// Screen width
    double screenWidth = MediaQuery.of(context).size.width;

    return Scaffold(

      backgroundColor: preferences.selectedTheme.primaryColor,

      body: SafeArea(
        child: preferences.apps.isNotEmpty ? Padding(
          padding: const EdgeInsets.fromLTRB(8, 10, 8, 0),
          child: Column(
            children: [

              /// Search bar
              Padding(
                padding: const EdgeInsets.fromLTRB(5, 10, 5, 5),
                child: GestureDetector(
                  onTap: () => FocusManager.instance.primaryFocus?.unfocus(),
                  child: TextField(

                    focusNode: _focusNode,
                    controller: searchBarController,
                    onChanged: (String value) {
                      setState(() {
                        searchText = value;
                      });
                      checkIfOpenApp();
                    },

                    cursorColor: preferences.selectedTheme.textColor.withOpacity(0.5),

                    style: GoogleFonts.montserrat(
                        color: preferences.selectedTheme.textColor,
                        fontSize: MediaQuery.of(context).size.width / 25
                    ),

                    decoration: searchBarTextFieldDecoration(screenWidth).copyWith(
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
                    child: ScrollConfiguration(
                      behavior: const ScrollBehavior().copyWith(
                          overscroll: false
                      ),
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
              )
            ],
          ),
        ) : Center(
          child: SpinKitRing(
            color: preferences.selectedTheme.textColor,
            lineWidth: 1,
          ),
        ),
      ),

    );
  }

  ApplicationItemWithLetter (
      int index
      ) {
    try {
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
    } catch (e) {
      return isSearched(preferences.apps[index].appName) ? ApplicationItem(
          context,
          preferences.apps[index].appName,
          preferences.apps[index].packageName,
          preferences.apps[index].icon
      ) : const SizedBox();
    }
  }
  
}
