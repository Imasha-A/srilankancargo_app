import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
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

  @override
  void initState() {
    super.initState();
    fetchAboutUs();
  }

  Future<void> fetchAboutUs() async {
    final url = Uri.parse(
        'https://ulmobservices.srilankan.com/ULMOBTEAMSERVICES/api/CargoMobileAppCorp/GetCargoAboutUs');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        setState(() {
          aboutUsText = data['aboutUs'] ?? "No information available.";
        });
      } else {
        setState(() {
          aboutUsText = "Failed to load data.";
        });
      }
    } catch (e) {
      setState(() {
        aboutUsText = "Error: $e";
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    return Scaffold(
      body: Stack(
        children: [
          // Top Banner Image (bottom layer)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/homescreen_banner.jpg',
              fit: BoxFit.cover,
              height: screenHeight * 0.28,
            ),
          ),

          Positioned(
            top: screenHeight * 0.205,
            left: 0,
            right: 0,
            child: LayoutBuilder(
              builder: (context, constraints) {
                double cardWidth = constraints.maxWidth * 0.9;

                double maxHeight = screenHeight * 0.71;

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
                              color: Color.fromARGB(255, 28, 31, 106),
                            ),
                            textAlign: TextAlign.justify,
                          ),
                          SizedBox(height: screenHeight * 0.03),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      TermsAndConditionsPage(),
                                ),
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text(
                                  'Terms and Conditions',
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.045,
                                    fontWeight: FontWeight.w500,
                                    color:
                                        const Color.fromARGB(255, 28, 31, 106),
                                  ),
                                ),
                                SizedBox(width: screenWidth * 0.03),
                                SvgPicture.asset(
                                  'assets/images/terms_icon.svg',
                                  height: screenHeight * 0.025,
                                  width: screenWidth * 0.025,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.015),
                          Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                'assets/images/about_us_picture.jpg',
                                height: screenHeight * 0.22,
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
                              SizedBox(height: screenHeight * 0.06),
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
            top: screenHeight * 0.145,
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
              color: Colors.black.withOpacity(0.1), // Shadow color
              offset: Offset(0, -2), // Shadow position
              blurRadius: 4, // Shadow blur radius
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
                height: screenHeight *
                    0.006), // Change this height to increase space
            BottomNavigationBar(
              backgroundColor: Colors.white,
              elevation: 0,
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/images/home_icon.svg',
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
                  label: 'Contact Us',
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    'assets/images/about_us_icon.svg',
                    height: screenHeight * .03,
                    width: screenWidth * .03,
                  ),
                  label: 'About Us',
                ),
              ],
              selectedItemColor: Color.fromARGB(255, 28, 31, 106),
              unselectedItemColor: Color.fromARGB(255, 28, 31, 106),
              currentIndex: 2,
              onTap: (index) {
                if (index == 1) {
                  // Navigate to Contact Us page
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          ContactUsPage(),
                      transitionDuration: Duration(seconds: 0), // No animation
                    ),
                  );
                } else if (index == 0) {
                  // Navigate to Home page
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          MyHomePage(title: 'Flutter Demo Home Page'),
                      transitionDuration: Duration(seconds: 0), // No animation
                    ),
                  );
                } else if (index == 2) {
                  // Navigate to About Us page
                  Navigator.push(
                    context,
                    PageRouteBuilder(
                      pageBuilder: (context, animation, secondaryAnimation) =>
                          AboutUsPage(),
                      transitionDuration: Duration(seconds: 0), // No animation
                    ),
                  );
                }
              },
              selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
            ),
          ],
        ),
      ),
    );
  }
}
