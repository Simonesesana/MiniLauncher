import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:minilauncher/Packages/Preferences/Preferences.dart';
import 'package:minilauncher/main.dart';

// Pages import
import 'Pages/Page1.dart';
import 'Pages/Page2.dart';
import 'Pages/Page3.dart';
import 'Pages/Page4.dart';
import 'Pages/Page5.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({super.key});

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {

  int currentPage = 0;

  // Pageview controller
  final PageController _pageController = PageController(
    initialPage: 0
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Stack(
        children: [

          PageView(
            controller: _pageController,
            onPageChanged: (int page) {
              setState(() {
                currentPage = page;
              });
            },
            children: const [

              // Welcome page
              WelcomePage1(),

              // Favourite apps page
              WelcomePage2(),

              // Location permission page
              WelcomePage3(),

              // Set as default launcher page
              WelcomePage4(),

              // Finish page
              WelcomePage5()

            ],

          ),

          // Dots
          Align(
            alignment: Alignment.bottomCenter,
            child: currentPage != 4 ? Container(
              height: 40,
              color: Colors.transparent,
              child: Center(
                child: ListView.builder(
                  itemCount: 6,
                  shrinkWrap: true,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (BuildContext context, int index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                        vertical: 8,
                        horizontal: 4
                      ),
                      child: Container(
                        width: currentPage == index ? 7 : 5,
                        height: currentPage == index ? 7 : 5,
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            color: currentPage == index ?
                                preferences.selectedTheme.textColor :
                                preferences.selectedTheme.textColor.withOpacity(0.2)
                        ),
                      ),
                    );
                  },
                ),
              ),
            ) : GestureDetector(
              onTap: () {
                setBool("first_access", false);
                Navigator.pushReplacementNamed(context, '/home');
              },
              child: Card(
                child: Padding(
                  padding: const EdgeInsets.symmetric(
                      vertical: 5,
                      horizontal: 15
                  ),
                  child: Text(
                    "Finish",
                    style: GoogleFonts.montserrat(
                        color: preferences.selectedTheme.primaryColor,
                        fontSize: MediaQuery.of(context).size.width / 27
                    ),
                  ),
                ),
              ),
            ).animate().fade(
              delay: const Duration(milliseconds: 500),
              duration: const Duration(milliseconds: 1500),
            )
          )

        ],
      ),

    );
  }
}
