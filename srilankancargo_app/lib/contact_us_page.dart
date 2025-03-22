import 'dart:ui';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:srilankancargo_app/about_us_page.dart';
import 'package:srilankancargo_app/main.dart';
import 'package:srilankancargo_app/terms_and_conditions.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUsPage extends StatefulWidget {
  const ContactUsPage({Key? key}) : super(key: key);

  @override
  _ContactUsPageState createState() => _ContactUsPageState();
}

class _ContactUsPageState extends State<ContactUsPage> {
  int _currentIndex = 1;

  Future<void> _launchURLYoutube(Uri parse) async {
    final Uri url =
        Uri.parse('https://www.youtube.com/channel/UCU_e10UGVQS8JikgDpwvdag');
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

  Future<void> _launchPhone(String phoneNumber) async {
    final Uri phoneUri = Uri(scheme: 'tel', path: phoneNumber);
    if (!await launchUrl(phoneUri)) {
      throw 'Could not launch $phoneUri';
    }
  }

  Future<void> _launchEmail(String emailAddress) async {
    final Uri emailUri = Uri(scheme: 'mailto', path: emailAddress);
    if (!await launchUrl(emailUri)) {
      throw 'Could not launch $emailUri';
    }
  }

  Future<void> _launchURLAddress(Uri parse) async {
    final Uri url = Uri.parse(
        'https://www.google.com/maps/place/SriLankan+Cargo/@7.1702799,79.5546651,10z/data=!4m10!1m2!2m1!1ssrilankan+cargo!3m6!1s0x3ae2efc8eeea9517:0x5b390f6a09d7fe3f!8m2!3d7.1704115!4d79.8836481!15sCg9zcmlsYW5rYW4gY2FyZ2-SAQl3YXJlaG91c2XgAQA!16s%2Fg%2F11c518c5b5?entry=ttu&g_ep=EgoyMDI0MDkwOS4wIKXMDSoASAFQAw%3D%3D');
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }

  void _copyToClipboard(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text('Copied to clipboard')),
    );
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

          // White Card with Content (middle layer)
          Positioned(
            top: screenHeight * 0.16,
            left: 0,
            right: 0,
            child: LayoutBuilder(
              builder: (context, constraints) {
                double cardWidth = constraints.maxWidth * 0.8;
                double maxHeight = screenHeight * 0.9;
                return Container(
                  width: cardWidth * 1.2,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  padding: EdgeInsets.symmetric(
                      horizontal: cardWidth * 0.02,
                      vertical: screenHeight * 0.01),
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

                          ContactInfoCard(
                            svgPath: 'assets/images/call_us_icon.svg',
                            title: 'Call us',
                            subtitle: '0197 333 344',
                            subtitleColor: Color.fromARGB(255, 51, 51, 51),
                            onTap: () => _launchPhone('0197333344'),
                          ),
                          ContactInfoCard(
                            svgPath: 'assets/images/email_us_icon.svg',
                            title: 'Email us',
                            subtitle: 'customersupportunit@srilankan.com',
                            subtitleColor: Color.fromARGB(255, 51, 51, 51),
                            onTap: () => _launchEmail(
                                'customersupportunit@srilankan.com'),
                            onLongPress: () => _copyToClipboard(
                                context, 'customersupportunit@srilankan.com'),
                          ),
                          ContactInfoCard(
                              svgPath: 'assets/images/address_icon.svg',
                              title: 'Address',
                              subtitle:
                                  'SriLankan Airlines Cargo, Katunayake, \nSri Lanka',
                              subtitleColor: Color.fromARGB(255, 51, 51, 51),
                              onTap: () => _launchURLAddress(Uri.parse(
                                  'https://www.google.com/maps/place/SriLankan+Cargo/@7.1702799,79.5546651,10z/data=!4m10!1m2!2m1!1ssrilankan+cargo!3m6!1s0x3ae2efc8eeea9517:0x5b390f6a09d7fe3f!8m2!3d7.1704115!4d79.8836481!15sCg9zcmlsYW5rYW4gY2FyZ2-SAQl3YXJlaG91c2XgAQA!16s%2Fg%2F11c518c5b5?entry=ttu&g_ep=EgoyMDI0MDkwOS4wIKXMDSoASAFQAw%3D%3D'))),

                          // Social Media Buttons
                          Padding(
                            padding: EdgeInsets.symmetric(
                                horizontal: screenWidth * 0.32,
                                vertical: screenHeight * 0.015),
                            child: Text(
                              'Follow on',
                              style: TextStyle(
                                fontSize: screenWidth * 0.05,
                                color: const Color(0xFF193E7F),
                              ),
                            ),
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: SvgPicture.asset(
                                  'assets/images/youtube_icon.svg',
                                  height: screenHeight * .055,
                                  width: screenWidth * .055,
                                ),
                                onPressed: () {
                                  _launchURLYoutube(Uri.parse(
                                      'https://www.youtube.com/channel/UCU_e10UGVQS8JikgDpwvdag'));
                                },
                              ),
                              SizedBox(width: screenWidth * 0.02),
                              IconButton(
                                icon: SvgPicture.asset(
                                  'assets/images/instagram_icon.svg',
                                  height: screenHeight * .055,
                                  width: screenWidth * .055,
                                ),
                                onPressed: () {
                                  launchUrl(Uri.parse(
                                      'https://www.instagram.com/srilankanairlinesofficial/'));
                                },
                              ),
                              IconButton(
                                icon: SvgPicture.asset(
                                  'assets/images/facebook_icon.svg',
                                  height: screenHeight * .055,
                                  width: screenWidth * .055,
                                ),
                                onPressed: () {
                                  launchUrl(Uri.parse(
                                      'https://web.facebook.com/flysrilankan?_rdc=1&_rdr'));
                                },
                              ),
                              IconButton(
                                icon: SvgPicture.asset(
                                  'assets/images/x_icon.svg',
                                  height: screenHeight * .055,
                                  width: screenWidth * .055,
                                ),
                                onPressed: () {
                                  launchUrl(
                                      Uri.parse('https://x.com/flysrilankan'));
                                },
                              ),
                              IconButton(
                                icon: SvgPicture.asset(
                                  'assets/images/linkedin_icon.svg',
                                  height: screenHeight * .055,
                                  width: screenWidth * .055,
                                ),
                                onPressed: () {
                                  launchUrl(Uri.parse(
                                      'https://www.linkedin.com/company/srilankan-cargo/'));
                                },
                              ),
                            ],
                          ),
                          SizedBox(height: screenHeight * 0.2),
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
              'Contact Us',
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
        child: Column(mainAxisSize: MainAxisSize.min, children: [
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
        ]),
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
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  ContactInfoCard(
      {required this.svgPath,
      required this.title,
      required this.subtitle,
      this.titleColor = const Color(0xFF193E7F),
      this.subtitleColor = const Color.fromARGB(255, 51, 51, 51),
      this.onTap,
      this.onLongPress});

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return GestureDetector(
      onTap: onTap,
      onLongPress: onLongPress,
      child: Container(
        margin: EdgeInsets.symmetric(
            vertical: screenHeight * 0.014, horizontal: screenWidth * 0.01),
        padding: EdgeInsets.fromLTRB(screenWidth * 0.06, screenHeight * 0.035,
            screenWidth * 0.06, screenHeight * 0.035),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(10),
          border: Border.all(
            color: const Color(0xFF193E7F),
            width: 1.5,
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.2),
              spreadRadius: 0,
              blurRadius: 3,
              offset: Offset(0, 4),
            ),
          ],
        ),
        child: Row(
          children: [
            SvgPicture.asset(
              svgPath,
              color: Color(0xFF193E7F),
              height: screenHeight * 0.035,
              width: screenWidth * 0.025,
            ),
            SizedBox(width: screenWidth * 0.05),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: TextStyle(
                      fontSize: screenWidth * 0.055,
                      color: titleColor,
                      fontWeight: FontWeight.w500),
                ),
                Text(
                  subtitle,
                  style: TextStyle(
                    fontSize: screenWidth * 0.036,
                    color: subtitleColor,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
