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

    double paddingBottom;
    double buttonWidth;
    double buttonHeight;
    double buttonTextSize;

    // Use the same dimension logic as HomePage
    if (screenWidth == 1024) {
      paddingBottom = 65.0;
      buttonWidth = (screenWidth - 100) / 3;
      buttonHeight = 45;
      buttonTextSize = 12;
    } else if (screenWidth >= 768) {
      paddingBottom = 85.0;
      buttonWidth = (screenWidth - 80) / 3;
      buttonHeight = 50;
      buttonTextSize = 12;
    } else if (screenWidth == 375) {
      paddingBottom = 15.0;
      buttonWidth = (screenWidth - 60) / 2;
      buttonHeight = 28;
      buttonTextSize = 10.5;
    } else if (screenWidth == 393) {
      paddingBottom = 70.0;
      buttonWidth = (screenWidth - 60) / 2;
      buttonHeight = 43;
      buttonTextSize = 10;
    } else if (screenWidth == 430) {
      paddingBottom = 92.0;
      buttonWidth = (screenWidth - 60) / 2;
      buttonHeight = 43;
      buttonTextSize = 12;
    } else if (screenWidth <= 768 && screenWidth > 600) {
      paddingBottom = 90.0;
      buttonWidth = (screenWidth - 100) / 3;
      buttonHeight = 55;
      buttonTextSize = 14.0;
    } else if (screenWidth <= 600 && screenWidth > 400) {
      paddingBottom = 60.0;
      buttonWidth = (screenWidth - 60) / 2;
      buttonHeight = 50;
      buttonTextSize = 11.0;
    } else {
      paddingBottom = 85.0;
      buttonWidth = (screenWidth - 30) / 2;
      buttonHeight = 45;
      buttonTextSize = 12.0;
    }

    return Scaffold(
      body: Stack(
        children: [
          // Top Banner Image (bottom layer)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/homescreen_banner.jpg', // Your blue banner image
              fit: BoxFit.cover,
              height: 235,
            ),
          ),

          // White Card with Content (middle layer)
          Positioned(
            top: screenHeight * 0.205,
            left: 0,
            right: 0,
            child: Container(
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
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/images/2022451025672_Big-removebg-preview (1).png', // Replace with your image path
                      height: 65,
                      // Adjust height as needed
                      fit: BoxFit.contain,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'SriLankan Cargo is the Cargo Arm of SriLankan Airlines - The National Carrier of Sri Lanka.',
                    style: TextStyle(
                      fontSize: 16.3,
                      color: Color.fromARGB(255, 28, 31, 106),
                    ),
                  ),
                  const SizedBox(height: 30),
                  Text(
                    'SriLankan Cargo provides connectivity to its global network of 37 destinations in 21 countries across Europe, the Middle East, South Asia, Southeast Asia, the Far East and Australia.',
                    style: TextStyle(
                      fontSize: 16.3,
                      color: Color.fromARGB(255, 28, 31, 106),
                    ),
                  ),
                  const SizedBox(height: 35),
                  Center(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(
                          8.0), // Adjust the radius as needed
                      child: Image.asset(
                        'assets/images/about_us_picture.jpg',
                        height: 165,
                        width: 410, // Adjust height as needed
                        fit: BoxFit.fill, // Adjust fit as needed
                      ),
                    ),
                  ),
                  const SizedBox(height: 15),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => TermsAndConditionsPage()),
                      );
                    },
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          'Terms and Conditions',
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Color.fromARGB(255, 28, 31, 106),
                          ),
                        ),
                        const SizedBox(width: 8),
                        SvgPicture.asset(
                          'assets/images/terms_icon.svg', // Add the path to your icon asset
                          height: 20,
                          width: 20,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 45),
                  Text(
                    'SriLankan IT Systems. All rights reserved',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 51, 51, 51),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Last Updated on 11/11/2024',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 51, 51, 51),
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Created on 10/10/2024',
                    style: TextStyle(
                      fontSize: 14,
                      color: Color.fromARGB(255, 51, 51, 51),
                    ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),

          Positioned(
            top: 123,
            left: 25,
            child: Text(
              'About Us',
              style: TextStyle(
                fontSize: 22,
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
              height: 24,
              width: 24,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/contact_us_icon.svg',
              height: 24,
              width: 24,
            ),
            label: 'Contact Us',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/about_us_icon.svg',
              height: 24,
              width: 24,
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
