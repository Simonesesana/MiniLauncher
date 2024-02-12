import 'dart:async';
import 'package:minilauncher/Pages/Home/Weather/Weather.dart';

import '../../main.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:minilauncher/Pages/Home/Items/HomeOverlay.dart';
import 'package:minilauncher/Pages/Home/Items/ApplicationItem.dart';

import 'AppUsages/AppUsages.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  bool isLoading = true;


  /// Function to detect if the page is loading
  void detectLoading(Timer timer) {

    if(preferences.apps.isNotEmpty){
      setState(() {isLoading = false;});
      timer.cancel();
    }

  }

  @override
  void initState() {
    if(preferences.showOnlyFavouriteAppsOnHomeScreen) {
        setState(() {isLoading = false;});
    } else {
      Timer t = Timer.periodic(const Duration(seconds: 1), detectLoading);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: SafeArea(
        child: Scaffold(

            backgroundColor: preferences.selectedTheme.primaryColor,

            /// App list
            body: PageView(
              controller: PageController(initialPage: 1),
              onPageChanged: (index) {},
              children: [

                AppUsages(),

                // Home page
                Stack(
                  children: [

                    /// Home overlay
                    const HomeOverlay(),

                    /// App Drawer
                    Padding(
                      padding: EdgeInsets.symmetric(
                          vertical: MediaQuery.of(context).size.height / 4,
                          horizontal: MediaQuery.of(context).size.width / 30
                      ),
                      child: !isLoading ? Center(
                          child: Card(
                            elevation: 0,
                            color: preferences.showBackgroundOnHomeScreen
                             ? preferences.selectedTheme.homeCardColor.withOpacity(0.15)
                             : Colors.transparent,
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(20)
                            ),
                            child: Padding(
                              padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                              child: !preferences.showOnlyFavouriteAppsOnHomeScreen ? ListView.builder(
                                physics: const ClampingScrollPhysics(),
                                itemCount: preferences.apps.length,
                                shrinkWrap: true,
                                itemBuilder: (context, index){
                                  return ApplicationItem(
                                      context,
                                      preferences.apps[index].appName,
                                      preferences.apps[index].packageName,
                                      preferences.apps[index].icon
                                  );
                                },
                              ) : Center(
                                child: ListView.builder(
                                  shrinkWrap: true,
                                  physics: const ClampingScrollPhysics(),
                                  itemCount: preferences.favouriteApps.length,
                                  itemBuilder: (context, index){
                                    return ApplicationItem(
                                        context,
                                        preferences.favouriteApps[index].appName,
                                        preferences.favouriteApps[index].packageName,
                                        preferences.favouriteApps[index].icon
                                    );
                                  },
                                ),
                              ),
                            ),
                          )
                      ) : const Center(
                        child: SpinKitRing(
                          color: Colors.white,
                          lineWidth: 1,
                        ),
                      ),
                    )

                  ],
                ),

                // Weather
                const Weather(),

              ],
            )

        ),
      ),
    );
  }
}
