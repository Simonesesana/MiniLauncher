import 'package:flutter/material.dart';
import 'package:device_apps/device_apps.dart';
import 'package:minilauncher/Pages/Home/Items/HomeOverlay.dart';
import 'package:minilauncher/Themes/Theme.dart';
import 'package:minilauncher/Pages/GlobalPages/Loading.dart';
import 'package:minilauncher/Pages/Home/Items/ApplicationItem.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {

  List apps = [];

  void getApps() async {

    /// Retrieves the app list
    apps = await DeviceApps.getInstalledApplications
      (
      includeAppIcons: true,
      includeSystemApps: true,
      onlyAppsWithLaunchIntent: true,
    );

    /// Updates the interface
    setState(() {
      apps = apps;
    });

  }

  @override
  void initState() {
    getApps();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return apps.isNotEmpty ? SafeArea(
      child: Scaffold(

          backgroundColor: selectedTheme.primaryColor,

          /// App list
          body: Stack(
            children: [

              /// Home overlay
              const HomeOverlay(),

              /// App Drawer
              Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(
                    vertical: MediaQuery.of(context).size.height / 3,
                    horizontal: MediaQuery.of(context).size.width / 30
                  ),
                  child: Card(
                    elevation: 0,
                    color: selectedTheme.homeCardColor.withOpacity(0.15),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20)
                    ),
                    child: Padding(
                      padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                      child: ListView.builder(
                        itemCount: apps.length,
                        itemBuilder: (context, index){
                          return ApplicationItem(
                              context,
                              apps[index].appName,
                              apps[index].packageName,
                              apps[index].icon
                          );
                        },
                      ),
                    ),
                  ),
                ),
              )

            ],
          )
      ),
    ) : const Loading();
  }
}
