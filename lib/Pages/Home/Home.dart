import '../../main.dart';
import 'package:flutter/material.dart';
import 'package:minilauncher/Themes/Theme.dart';
import 'package:minilauncher/Pages/Home/Items/HomeOverlay.dart';
import 'package:minilauncher/Pages/Home/Items/ApplicationItem.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(

          backgroundColor: preferences.selectedTheme.primaryColor,

          /// App list
          body: Stack(
            children: [

              /// Home overlay
              const HomeOverlay(),

              /// App Drawer
              Padding(
                padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height / 3,
                    horizontal: MediaQuery.of(context).size.width / 30
                ),
                child: Center(
                    child: Card(
                      elevation: 0,
                      color: preferences.selectedTheme.homeCardColor.withOpacity(0.15),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)
                      ),
                      child: Padding(
                        padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                        child: !preferences.showOnlyFavouriteAppsOnHomeScreen ? ListView.builder(
                          itemCount: preferences.apps.length,
                          itemBuilder: (context, index){
                            return ApplicationItem(
                                context,
                                preferences.apps[index].appName,
                                preferences.apps[index].packageName,
                                preferences.apps[index].icon
                            );
                          },
                        ) : ListView.builder(
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
                    )
                ),
              )

            ],
          )
      ),
    );
  }
}
