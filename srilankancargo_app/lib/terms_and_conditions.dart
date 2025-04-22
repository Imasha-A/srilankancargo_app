import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:http/http.dart' as http;
import 'package:srilankancargo_app/about_us_page.dart';
import 'package:srilankancargo_app/contact_us_page.dart';
import 'dart:convert';

import 'package:srilankancargo_app/main.dart';

Future<Map<String, dynamic>> fetchData() async {
  final response = await http.get(Uri.parse(
      'https://ulmobservices.srilankan.com/ULMOBTEAMSERVICES/api/CargoMobileAppCorp/GetTermsAndConditions'));

  if (response.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(response.body);
    List<dynamic> termsList = data['terms'] ?? [];
    List<Map<String, String>> sections = [];

    for (var term in termsList) {
      String section = term['section']?.trim() ?? 'Unknown Section';
      String content = term['content']?.trim() ?? 'No Content';

      content = content
          .replaceAll(RegExp(r'\s*\n\s*'), '\n\n')
          .replaceAll(RegExp(r'\n{2,}'), '\n\n')
          .trim();

      sections.add({
        'section': section,
        'content': content,
      });
    }

    String lastUpdated = data['lastUpdated']?.trim() ?? 'Not available';

    return {
      'sections': sections,
      'lastUpdated': lastUpdated,
    };
  } else {
    throw Exception('Failed to load terms and conditions');
  }
}

class TermsAndConditionsPage extends StatefulWidget {
  @override
  _TermsAndConditionsPageState createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {
  late Future<Map<String, dynamic>> _data;
  int _currentIndex = 3;
  @override
  void initState() {
    super.initState();
    _data = fetchData();
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
                    child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // Fixed Image at the Top
                          Center(
                            child: Image.asset(
                              'assets/images/2022451025672_Big-removebg-preview (1).png',
                              height: screenHeight * 0.08,
                              fit: BoxFit.contain,
                            ),
                          ),
                          SizedBox(
                            width: double.infinity,
                            child: Divider(
                              thickness: screenHeight * 0.007,
                              color: Color(0xFFD9D9D9),
                            ),
                          ),

                          // Scrollable Content
                          ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: maxHeight,
                            ),
                            child: SingleChildScrollView(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(
                                        top: screenHeight * 0.01),
                                    child: FutureBuilder<Map<String, dynamic>>(
                                      future: _data,
                                      builder: (context, snapshot) {
                                        if (snapshot.connectionState ==
                                            ConnectionState.waiting) {
                                          return Container(
                                            color: Colors.white,
                                            width: double.infinity,
                                            padding: EdgeInsets.all(
                                                screenWidth * 0.01),
                                            child: SizedBox(
                                              height: screenHeight *
                                                  0.8, // Adjust this height as needed
                                              child: Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              ),
                                            ),
                                          );
                                        } else if (snapshot.hasError) {
                                          return Center(
                                              child: Text(
                                                  'Error: ${snapshot.error}'));
                                        } else if (!snapshot.hasData ||
                                            snapshot.data == null) {
                                          return Center(
                                              child: Text('No data available'));
                                        } else {
                                          final data = snapshot.data!;
                                          final sections = data['sections']
                                              as List<Map<String, String>>;
                                          return SingleChildScrollView(
                                            child: Padding(
                                              padding: EdgeInsets.all(
                                                  screenWidth * 0.01),
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  for (var section in sections)
                                                    Column(
                                                      crossAxisAlignment:
                                                          CrossAxisAlignment
                                                              .start,
                                                      children: [
                                                        Text(
                                                          section['section']!,
                                                          style: TextStyle(
                                                            fontSize:
                                                                screenWidth *
                                                                    0.0445,
                                                            fontWeight:
                                                                FontWeight.w600,
                                                            color: const Color(
                                                                0xFF1C1F6A),
                                                          ),
                                                          textAlign:
                                                              TextAlign.left,
                                                        ),
                                                        SizedBox(
                                                            height:
                                                                screenHeight *
                                                                    0.01),
                                                        Text(
                                                          section['content']!,
                                                          style: TextStyle(
                                                            fontSize:
                                                                screenWidth *
                                                                    0.04,
                                                            color: const Color(
                                                                0xFF1C1F6A),
                                                          ),
                                                          textAlign:
                                                              TextAlign.left,
                                                        ),
                                                        SizedBox(
                                                            height:
                                                                screenHeight *
                                                                    0.01),
                                                      ],
                                                    ),
                                                  Text(
                                                    'IA',
                                                    style: TextStyle(
                                                      fontSize:
                                                          screenWidth * 0.008,
                                                      fontWeight:
                                                          FontWeight.w500,
                                                      color: const Color(
                                                          0xFF1C1F6A),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                          );
                                        }
                                      },
                                    ),
                                  ),
                                  SizedBox(height: screenHeight * 0.28),
                                ],
                              ),
                            ),
                          ),
                        ]));
              },
            ),
          ),

          Positioned(
            top: screenHeight * 0.1,
            left: screenWidth * 0.05,
            child: Text(
              'Terms and Conditions',
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