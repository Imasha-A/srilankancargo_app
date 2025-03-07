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
                            'SriLankan Cargo is the Cargo Arm of SriLankan Airlines - The National Carrier of Sri Lanka. SriLankan Cargo provides connectivity to its global network of 37 destinations in 21 countries across Europe, the Middle East, South Asia, Southeast Asia, the Far East and Australia.',
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
                                    fontSize: screenWidth * 0.038,
                                    fontWeight: FontWeight.w500,
                                    color: Color.fromARGB(255, 28, 31, 106),
                                  ),
                                ),
                                SizedBox(width: screenWidth * 0.02),
                                SvgPicture.asset(
                                  'assets/images/terms_icon.svg',
                                  height: screenHeight * 0.02,
                                  width: screenHeight * 0.02,
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
                                width: cardWidth * 1.2,
                                fit: BoxFit.fill,
                              ),
                            ),
                          ),

                          SizedBox(height: screenHeight * 0.03),

                          Row(
                            mainAxisAlignment: MainAxisAlignment
                                .spaceBetween, // Space between the two columns
                            children: [
                              // First column: Left aligned
                              Column(
                                crossAxisAlignment: CrossAxisAlignment
                                    .start, // Align text in the first column to the left
                                children: [
                                  Text(
                                    'Last Updated on',
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.03,
                                      color: Color.fromARGB(255, 51, 51, 51),
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.003),
                                  Text(
                                    '05/03/2025',
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.036,
                                      color: Color.fromARGB(255, 51, 51, 51),
                                    ),
                                  ),
                                ],
                              ),
                              // Second column: Right aligned
                              Column(
                                crossAxisAlignment: CrossAxisAlignment
                                    .end, // Align text in the second column to the right
                                children: [
                                  Text(
                                    'Created on',
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.03,
                                      color: Color.fromARGB(255, 51, 51, 51),
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.003),
                                  Text(
                                    '10/10/2024',
                                    style: TextStyle(
                                      fontSize: screenWidth * 0.036,
                                      color: Color.fromARGB(255, 51, 51, 51),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          Divider(),
                          Center(
                            child: Text(
                              'SriLankan IT Systems. All rights reserved',
                              style: TextStyle(
                                fontSize: screenWidth * 0.036,
                                color: Color.fromARGB(255, 51, 51, 51),
                              ),
                            ),
                          ),

                          SizedBox(height: screenHeight * 0.02),
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
