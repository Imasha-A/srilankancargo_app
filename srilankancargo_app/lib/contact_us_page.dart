import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:srilankancargo_app/about_us_page.dart';
import 'package:srilankancargo_app/main.dart';

class ContactUsPage extends StatelessWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
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
            top: 175,
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              padding: EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 10),
                  // Contact Information Cards with colors applied
                  ContactInfoCard(
                    svgPath: 'assets/images/call_us_icon.svg',
                    title: 'Call us',
                    subtitle: '0197 333 259',
                    subtitleColor: Color.fromARGB(255, 51, 51, 51),
                  ),
                  ContactInfoCard(
                    svgPath: 'assets/images/email_us_icon.svg',
                    title: 'Email us',
                    subtitle: 'cargo@srilankan.com',
                    subtitleColor: Color.fromARGB(255, 51, 51, 51),
                  ),
                  ContactInfoCard(
                    svgPath: 'assets/images/address_icon.svg',
                    title: 'Address',
                    subtitle:
                        'SriLankan Airlines Cargo,\nKatunayake, Sri Lanka',
                    subtitleColor: Color.fromARGB(255, 51, 51, 51),
                  ),

                  // Social Media Buttons
                  Padding(
                    padding: const EdgeInsets.fromLTRB(150, 32, 100, 0),
                    child: Text(
                      'Follow on',
                      style: TextStyle(
                        fontSize: 16,
                        color: const Color.fromARGB(
                            255, 28, 31, 106), // Set your desired color here
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      SocialMediaButton(
                        svgPath: 'assets/images/youtube_icon.svg',
                      ),
                      SocialMediaButton(
                        svgPath: 'assets/images/instagram_icon.svg',
                      ),
                      SocialMediaButton(
                        svgPath: 'assets/images/facebook_icon.svg',
                      ),
                      SocialMediaButton(
                        svgPath: 'assets/images/x_icon.svg',
                      ),
                      SocialMediaButton(
                        svgPath: 'assets/images/linkedin_icon.svg',
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),

          Positioned(
            top: 123,
            left: 25,
            child: Text(
              'Contact Us',
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
        currentIndex: 1,
        onTap: (index) {
          if (index == 1) {
            // Current page, no need to navigate
            Navigator.popUntil(context, (route) => route.isFirst);
          } else if (index == 0) {
            // Navigate to Home page
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) =>
                    MyHomePage(title: 'Flutter Demo Home Page'),
              ),
            );
          } else if (index == 2) {
            // Navigate to About Us page
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => AboutUsPage()),
            );
          }
        },
      ),
    );
  }
}

class ContactInfoCard extends StatelessWidget {
  final String svgPath;
  final String title;
  final String subtitle;
  final Color titleColor;
  final Color subtitleColor;

  ContactInfoCard({
    required this.svgPath,
    required this.title,
    required this.subtitle,
    this.titleColor = const Color.fromARGB(255, 28, 31, 106),
    this.subtitleColor = const Color.fromARGB(255, 51, 51, 51),
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 12.0, horizontal: 0),
      padding: const EdgeInsets.fromLTRB(30, 35, 50, 35),
      decoration: BoxDecoration(
        color: Colors.white, // Background color of the inner box
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: const Color.fromARGB(255, 85, 18, 181),
          width: 1.3,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.2), // Shadow color
            spreadRadius: 0, // Spread of the shadow
            blurRadius: 3, // Blur radius of the shadow
            offset: Offset(0, 4), // Offset of the shadow (bottom shadow)
          ),
        ],
      ),
      child: Row(
        children: [
          SvgPicture.asset(
            svgPath,
            height: 30,
            width: 40,
          ),
          SizedBox(width: 20),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                style: TextStyle(fontSize: 18, color: titleColor),
              ),
              Text(
                subtitle,
                style: TextStyle(fontSize: 14, color: subtitleColor),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class SocialMediaButton extends StatelessWidget {
  final String svgPath;

  SocialMediaButton({required this.svgPath});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(5.5),
      child: IconButton(
        icon: SvgPicture.asset(
          svgPath,
          height: 42,
          width: 40,
        ),
        onPressed: () {
          // Implement your onPressed logic
        },
      ),
    );
  }
}
