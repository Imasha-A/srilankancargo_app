import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:srilankancargo_app/contact_us_page.dart';
import 'package:srilankancargo_app/main.dart';
import 'package:srilankancargo_app/terms_and_conditions.dart';

class AboutUsPage extends StatelessWidget {
  const AboutUsPage({Key? key}) : super(key: key);

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

          // White Card with Content (middle layer)
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
                        offset: Offset(0, 3),
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
                            'SriLankan Cargo is the Cargo Arm of SriLankan Airlines - The National Carrier of Sri Lanka.',
                            style: TextStyle(
                              fontSize: screenWidth * 0.0425,
                              color: Color.fromARGB(255, 28, 31, 106),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.02),
                          Text(
                            'SriLankan Cargo provides connectivity to its global network of 37 destinations in 21 countries across Europe, the Middle East, South Asia, Southeast Asia, the Far East and Australia.',
                            style: TextStyle(
                              fontSize: screenWidth * 0.0425,
                              color: Color.fromARGB(255, 28, 31, 106),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.03),
                          Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8.0),
                              child: Image.asset(
                                'assets/images/about_us_picture.jpg',
                                height: screenHeight * 0.2,
                                width: cardWidth,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.015),
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
                                    fontSize: screenWidth * 0.043,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 28, 31, 106),
                                  ),
                                ),
                                SizedBox(width: screenWidth * 0.02),
                                SvgPicture.asset(
                                  'assets/images/terms_icon.svg',
                                  height: 20,
                                  width: 20,
                                ),
                              ],
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.03),
                          Text(
                            'SriLankan IT Systems. All rights reserved',
                            style: TextStyle(
                              fontSize: screenWidth * 0.038,
                              color: Color.fromARGB(255, 51, 51, 51),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.003),
                          Text(
                            'Last Updated on 11/11/2024',
                            style: TextStyle(
                              fontSize: screenWidth * 0.038,
                              color: Color.fromARGB(255, 51, 51, 51),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.003),
                          Text(
                            'Created on 10/10/2024',
                            style: TextStyle(
                              fontSize: screenWidth * 0.038,
                              color: Color.fromARGB(255, 51, 51, 51),
                            ),
                          ),
                          SizedBox(height: screenHeight * 0.1),
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

      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ContactUsPage()));
          } else if (index == 0) {
            // Navigate to Home page
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      MyHomePage(title: 'Flutter Demo Home Page')),
            );
          } else if (index == 2) {
            // Navigate to About Us page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AboutUsPage()),
            );
          }
        },
        selectedLabelStyle: TextStyle(fontWeight: FontWeight.w600),
      ),
    );
  }
}
