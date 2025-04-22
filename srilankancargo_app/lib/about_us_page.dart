import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:srilankancargo_app/contact_us_page.dart';
import 'package:srilankancargo_app/main.dart';
import 'package:srilankancargo_app/terms_and_conditions.dart';
import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AboutUsPage extends StatefulWidget {
  const AboutUsPage({Key? key}) : super(key: key);

  @override
  _AboutUsPageState createState() => _AboutUsPageState();
}

class _AboutUsPageState extends State<AboutUsPage> {
  String aboutUsText = "Loading...\n\n\n\n\n\n";

  int _currentIndex = 2;

  @override
  void initState() {
    super.initState();
    getAboutUsFromPrefs();
  }

  // Retrieve About Us text from SharedPreferences
  Future<void> getAboutUsFromPrefs() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      aboutUsText = prefs.getString('aboutUs') ?? "No saved data.";
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Top Banner Gradient (bottom layer)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Container(
              height: screenHeight * 0.17,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF0060C8), Color(0xFF193E7F)],
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                ),
              ),
            ),
          ),

          Positioned(
            top: screenHeight * 0.16,
            left: 0,
            right: 0,
            child: LayoutBuilder(
              builder: (context, constraints) {
                double cardWidth = constraints.maxWidth * 0.9;

                double maxHeight = screenHeight * 0.9;

                return Container(
                  width: cardWidth,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  padding: EdgeInsets.symmetric(
                    horizontal: cardWidth * 0.05,
                    vertical: screenHeight * 0.01,
                  ),
                  child: ConstrainedBox(
                    constraints: BoxConstraints(
                      maxHeight: maxHeight,
                    ),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: Image.asset(
                              'assets/images/2022451025672_Big-removebg-preview (1).png',
                              height: screenHeight * 0.08,
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.001),
                          Text(
                            aboutUsText,
                            style: TextStyle(
                              fontSize: screenWidth * 0.042,
                              color: const Color(0xFF193E7F),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.05),
                          Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                'assets/images/about_us_picture.png',
                                height: screenHeight * 0.26,
                                width: cardWidth,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          Column(
                            children: [
                              SizedBox(height: screenHeight * 0.04),
                              Divider(),
                              SizedBox(height: screenHeight * 0.01),
                              Text(
                                'SriLankan IT Systems. All rights reserved',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.035,
                                  color:
                                      const Color.fromARGB(255, 154, 154, 156),
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.28),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            ),
          ),

          Positioned(
            top: screenHeight * 0.1,
            left: screenWidth * 0.05,
            child: Text(
              'About Us',
              style: TextStyle(
                fontSize: screenWidth * 0.055,
                fontWeight: FontWeight.bold,
                color: Colors.white,
              ),
              textAlign: TextAlign.left,
            ),
          ),
        ],
      ),
      bottomNavigationBar: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.1),
              offset: Offset(0, -2),
              blurRadius: 4,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(height: screenHeight * 0.006),
            Theme(
              data: Theme.of(context).copyWith(
                splashColor: Colors.transparent,
                highlightColor: Colors.transparent,
              ),
              child: BottomNavigationBar(
                type: BottomNavigationBarType.fixed,
                showSelectedLabels: true,
                showUnselectedLabels: true,
                backgroundColor: Colors.white,
                elevation: 0,
                items: [
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/images/home_icon.svg',
                      height: screenHeight * .03,
                      width: screenWidth * .03,
                    ),
                    activeIcon: SvgPicture.asset(
                      'assets/images/filled_home.svg',
                      height: screenHeight * .03,
                      width: screenWidth * .03,
                    ),
                    label: 'Home',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/images/contact_us_icon.svg',
                      height: screenHeight * .03,
                      width: screenWidth * .03,
                    ),
                    activeIcon: SvgPicture.asset(
                      'assets/images/filled_contact.svg',
                      height: screenHeight * .03,
                      width: screenWidth * .03,
                    ),
                    label: 'Contact Us',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/images/about_us_icon.svg',
                      height: screenHeight * .03,
                      width: screenWidth * .03,
                    ),
                    activeIcon: SvgPicture.asset(
                      'assets/images/filled_about.svg',
                      height: screenHeight * .03,
                      width: screenWidth * .03,
                    ),
                    label: 'About Us',
                  ),
                  BottomNavigationBarItem(
                    icon: SvgPicture.asset(
                      'assets/images/terms.svg',
                      height: screenHeight * .03,
                      width: screenWidth * .03,
                    ),
                    activeIcon: SvgPicture.asset(
                      'assets/images/filled_terms.svg',
                      height: screenHeight * .03,
                      width: screenWidth * .03,
                    ),
                    label: 'T&C',
                  ),
                ],
                selectedItemColor: Color.fromARGB(255, 28, 31, 106),
                unselectedItemColor: Color.fromARGB(255, 28, 31, 106),
                currentIndex:
                    _currentIndex, // Ensure _currentIndex is declared in your state
                onTap: (index) {
                  setState(() {
                    _currentIndex = index;
                  });
                  if (index == 0) {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            MyHomePage(title: 'Flutter Demo Home Page'),
                        transitionDuration: Duration(seconds: 0),
                      ),
                    );
                  } else if (index == 1) {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            ContactUsPage(),
                        transitionDuration: Duration(seconds: 0),
                      ),
                    );
                  } else if (index == 2) {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            AboutUsPage(),
                        transitionDuration: Duration(seconds: 0),
                      ),
                    );
                  } else if (index == 3) {
                    Navigator.push(
                      context,
                      PageRouteBuilder(
                        pageBuilder: (context, animation, secondaryAnimation) =>
                            TermsAndConditionsPage(), // Replace with your T&C page widget
                        transitionDuration: Duration(seconds: 0),
                      ),
                    );
                  }
                },
                selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
              ),
            ),
          ],
        ),
      ),
    );
  }
}