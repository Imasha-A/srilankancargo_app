import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:srilankancargo_app/about_us_page.dart';
import 'package:srilankancargo_app/contact_us_page.dart';
import 'package:srilankancargo_app/storagecalculator_page.dart';
import 'package:srilankancargo_app/terms_and_conditions.dart';
import 'package:srilankancargo_app/volume_calculator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'schedule_page.dart';
import 'flightstatus_page.dart';
import 'loadibility_page.dart';
import 'package:http/http.dart' as http;

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.white),
        useMaterial3: true,
      ),
      home: const SplashScreen(),
    );
  }
}

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() {
    Timer(const Duration(seconds: 3), () {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
            builder: (context) =>
                const MyHomePage(title: 'Flutter Demo Home Page')),
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Background Image
          Container(
            width: double.infinity,
            height: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('assets/images/android12splash.jpg'),
                fit: BoxFit.cover,
              ),
            ),
          ),

          Positioned(
            bottom: 10,
            left: 0,
            right: 0,
            child: Center(
              child: Image.asset(
                'assets/images/logo_white.png',
                height: 130,
                width: 250,
                fit: BoxFit.contain,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  PageController _pageController = PageController();
  int _currentPage = 0;
  final GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey<ScaffoldState>();
  late Timer _timer;
  late double paddingBottom;

  late double buttonTextSize;
  double appBarOffsetPercentage = 0.27;
  String aboutUsText = '';

  int _currentIndex = 0;

  @override
  void initState() {
    super.initState();
    _startTimer();
    fetchAboutUs();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateButtonDimensions();
    _updateAppBarOffset();
  }

  // Fetch data and save to SharedPreferences
  Future<void> fetchAboutUs() async {
    final url = Uri.parse(
        'https://ulmobservices.srilankan.com/ULMOBTEAMSERVICES/api/CargoMobileAppCorp/GetCargoAboutUs');

    try {
      final response = await http.get(url);

      if (response.statusCode == 200) {
        final data = jsonDecode(response.body);
        String fetchedText = data['aboutUs'] ?? "No information available.";

        // Save to SharedPreferences
        await saveAboutUsToPrefs(fetchedText);

        setState(() {
          aboutUsText = fetchedText;
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

  // Save About Us text to SharedPreferences
  Future<void> saveAboutUsToPrefs(String text) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('aboutUs', text);
  }

  void _startTimer() {
    _timer = Timer.periodic(Duration(seconds: 10), (Timer timer) {
      if (_currentPage < 2) {
        _currentPage++;
      } else {
        _currentPage = 0;
      }
      _pageController.animateToPage(
        _currentPage,
        duration: Duration(milliseconds: 300),
        curve: Curves.easeInOut,
      );
    });
  }

  void _updateButtonDimensions() {
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth == 1024) {
      // iPad Pro (12.9-inch)
      paddingBottom = 65.0;

      buttonTextSize = 12;
    } else if (screenWidth >= 768) {
      // iPad or larger screens
      paddingBottom = 85.0;

      buttonTextSize = 12;
    } else if (screenWidth == 375) {
      // iPhone SE
      paddingBottom = 15.0;

      buttonTextSize = 10.5;
    } else if (screenWidth == 393) {
      // iPhone 15
      paddingBottom = 70.0;

      buttonTextSize = 10;
    } else if (screenWidth == 430) {
      // iPhone 15 Plus
      paddingBottom = 92.0;

      buttonTextSize = 12;
    } else if (screenWidth <= 768 && screenWidth > 600) {
      // Customization for larger Android screens
      paddingBottom = 90.0;

      buttonTextSize = 14.0;
    } else if (screenWidth <= 600 && screenWidth > 400) {
      // Customization for medium-sized Android screens (Pixel 7 Pro API 29)
      paddingBottom = 60.0;

      buttonTextSize = 11.0;
    } else {
      // Default values for other screen sizes
      paddingBottom = 85.0;

      buttonTextSize = 12.0;
    }
  }

  void _updateAppBarOffset() {
    double screenWidth = MediaQuery.of(context).size.width;

    if (screenWidth >= 768) {
      // iPad or larger screens
      appBarOffsetPercentage = 0.20;
    } else if (screenWidth == 375) {
      // iPhone SE
      appBarOffsetPercentage = 0.17;
    } else if (screenWidth == 393) {
      // iPhone 15
      appBarOffsetPercentage = 0.28;
    } else if (screenWidth == 430) {
      // iPhone 15 Plus
      appBarOffsetPercentage = 0.29;
    } else if (screenWidth <= 768) {
      // iPad mini (6th Gen)
      appBarOffsetPercentage = 0.20;
    } else {
      // iPhone or smaller screens
      appBarOffsetPercentage = 0.285;
    }
  }

  @override
  void dispose() {
    _timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
        key: _scaffoldKey,
        body: Stack(
          children: [
            // Top Banner Image (bottom layer)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: screenHeight * 0.28,
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
              top: screenHeight * 0.26,
              left: 0,
              right: 0,
              child: LayoutBuilder(
                builder: (context, constraints) {
                  double cardWidth = constraints.maxWidth * 0.9;
                  double maxScrollableHeight = screenHeight * 0.45;

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
                      horizontal: cardWidth * 0.01,
                      vertical: screenHeight * 0.012,
                    ),
                    child: Column(
                      children: [
                        SizedBox(height: screenHeight * 0.175),
                        DotsIndicator(
                          dotsCount: 3,
                          position: _currentPage.toInt(),
                          decorator: DotsDecorator(
                            size: Size.square(screenWidth * 0.025),
                            activeSize:
                                Size(screenWidth * 0.04, screenHeight * 0.0095),
                            color: const Color(0xFF0060C8),
                            activeColor: const Color(0xFF193E7F),
                            activeShape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(5.0),
                            ),
                          ),
                        ),
                        Center(
                          child: ConstrainedBox(
                            constraints: BoxConstraints(
                              maxHeight: maxScrollableHeight,
                            ),
                            child: SingleChildScrollView(
                              child: Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: cardWidth * 0.01),
                                child: Column(
                                  children: <Widget>[
                                    Padding(
                                      padding: EdgeInsets.only(
                                        right: cardWidth * 0.7,
                                      ),
                                      child: Text(
                                        'Categories',
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.05,
                                          color: const Color(0xFF193E7F),
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                    // Category Icons
                                    Padding(
                                      padding: EdgeInsets.symmetric(
                                          horizontal: cardWidth * 0.001,
                                          vertical: screenHeight * 0.015),
                                      child: Column(
                                        children: [
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                  child: buildOutlinedButton(
                                                      'Schedule',
                                                      'assets/images/flight_schedule_icon.svg')),
                                              Expanded(
                                                  child: buildOutlinedButton(
                                                      'Flight Status',
                                                      'assets/images/flight_status_icon.svg')),
                                              Expanded(
                                                  child: buildOutlinedButton(
                                                      'Loadability',
                                                      'assets/images/loadability_icon.svg')),
                                            ],
                                          ),
                                          SizedBox(
                                              height: screenHeight * 0.016),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Expanded(
                                                  child: buildOutlinedButton(
                                                      'Storage Calculator',
                                                      'assets/images/storage_calculator_icon.svg')),
                                              SizedBox(
                                                  width: screenWidth * 0.01),
                                              Expanded(
                                                  child: buildOutlinedButton(
                                                      'Volume Calculator',
                                                      'assets/images/volume_calculator_icon.svg')),
                                              SizedBox(
                                                  width: screenWidth * 0.01),
                                              Expanded(
                                                  child: buildOutlinedButton(
                                                      'Tracking',
                                                      'assets/images/tracking_icon.svg')),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(height: screenHeight * 0.01),
                                    Padding(
                                      padding: EdgeInsets.only(
                                          left: screenWidth * 0.035),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            "Product Categories",
                                            style: TextStyle(
                                                fontSize: screenWidth * .045,
                                                fontWeight: FontWeight.bold,
                                                color: const Color(0xFF193E7F)),
                                          ),
                                          SizedBox(height: screenHeight * 0.01),
                                          Divider(
                                            endIndent: screenWidth * 0.018,
                                          ),
                                          SizedBox(height: screenHeight * 0.02),
                                          SingleChildScrollView(
                                            scrollDirection: Axis.horizontal,
                                            child: Row(
                                              children: [
                                                Container(
                                                  height: screenHeight * 0.12,
                                                  width: screenWidth * 0.4,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8.0),
                                                    child: ElevatedButton(
                                                      onPressed: () {},
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            Colors.green,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                        elevation: 5,
                                                      ),
                                                      child: Text(
                                                          "Freshness Class",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white)),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: screenHeight * 0.12,
                                                  width: screenWidth * 0.4,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8.0),
                                                    child: ElevatedButton(
                                                      onPressed: () {},
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            Colors.red,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                        elevation: 5,
                                                      ),
                                                      child: Text(
                                                          "Wellness Class",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white)),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: screenHeight * 0.12,
                                                  width: screenWidth * 0.4,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8.0),
                                                    child: ElevatedButton(
                                                      onPressed: () {},
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            Colors.orange,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                        elevation: 5,
                                                      ),
                                                      child: Text(
                                                          "Guardian Class",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white)),
                                                    ),
                                                  ),
                                                ),
                                                Container(
                                                  height: screenHeight * 0.12,
                                                  width: screenWidth * 0.4,
                                                  child: Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8.0),
                                                    child: ElevatedButton(
                                                      onPressed: () {},
                                                      style: ElevatedButton
                                                          .styleFrom(
                                                        backgroundColor:
                                                            Colors.blue,
                                                        shape: RoundedRectangleBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        20)),
                                                        elevation: 5,
                                                      ),
                                                      child: Text(
                                                          "Precious Class",
                                                          style: TextStyle(
                                                              color: Colors
                                                                  .white)),
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ),

                                    SizedBox(height: screenHeight * 0.05),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),

            Positioned(
              top: screenHeight * 0.11,
              left: screenWidth * 0.065,
              child: Text(
                'Welcome to',
                style: TextStyle(
                  fontWeight: FontWeight.w100,
                  fontSize: screenWidth * 0.048,
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
                textAlign: TextAlign.left,
              ),
            ),

            Positioned(
              top: screenHeight * 0.125,
              left: screenWidth * 0.1,
              child: Image.asset(
                'assets/images/logo_white.png',
                height: screenHeight * 0.1,
                width: screenWidth * 0.55,
                fit: BoxFit.contain,
              ),
            ),
            // Image Slider
            Positioned(
              top: screenHeight * 0.21,
              left: screenWidth * 0.05,
              right: screenWidth * 0.05,
              child: Container(
                height: screenHeight * 0.23,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.2),
                      blurRadius: 8,
                      spreadRadius: 2,
                      offset: Offset(0, 0),
                    )
                  ],
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(15),
                  child: PageView.builder(
                    controller: _pageController,
                    onPageChanged: (int page) {
                      setState(() {
                        _currentPage = page;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Image.asset(
                        getImagePath(index),
                        fit: BoxFit.cover,
                      );
                    },
                    itemCount: 3,
                  ),
                ),
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
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  MyHomePage(title: 'Flutter Demo Home Page'),
                          transitionDuration: Duration(seconds: 0),
                        ),
                      );
                    } else if (index == 1) {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  ContactUsPage(),
                          transitionDuration: Duration(seconds: 0),
                        ),
                      );
                    } else if (index == 2) {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder:
                              (context, animation, secondaryAnimation) =>
                                  AboutUsPage(),
                          transitionDuration: Duration(seconds: 0),
                        ),
                      );
                    } else if (index == 3) {
                      Navigator.push(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation,
                                  secondaryAnimation) =>
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
        ));
  }

  Widget buildOutlinedButton(String label, String svgPath) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return SizedBox(
      width: screenWidth * 0.05,
      height: screenHeight * 0.07,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 255, 255, 255),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0),
          ),
          padding: EdgeInsets.zero,
          side: BorderSide.none,
          elevation: 0,
        ),
        onPressed: () {
          if (label == 'Schedule') {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    FlightSchedulePage(),
                transitionDuration: Duration(seconds: 0), // No animation
              ),
            );
          }
          if (label == 'Flight Status') {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    FlightStatusPage(),
                transitionDuration: Duration(seconds: 0), // No animation
              ),
            );
          }
          if (label == 'Loadability') {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    LoadibilityPage(),
                transitionDuration: Duration(seconds: 0), // No animation
              ),
            );
          }
          if (label == 'Storage Calculator') {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    StorageCalPage(),
                transitionDuration: Duration(seconds: 0), // No animation
              ),
            );
          }
          if (label == 'Volume Calculator') {
            Navigator.push(
              context,
              PageRouteBuilder(
                pageBuilder: (context, animation, secondaryAnimation) =>
                    VolumeCalPage(),
                transitionDuration: Duration(seconds: 0), // No animation
              ),
            );
          }
          if (label == 'Tracking') {
            launchUrlTracking((Uri.parse(
                'https://srilankancargo.ibsplc.aero/icargoneoportal/app/main/#/app')));
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              svgPath,
              color: const Color(0xFF193E7F),
              height: screenHeight * 0.032,
              width: screenWidth * 0.032,
            ),
            SizedBox(height: screenHeight * 0.005),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: screenWidth * 0.0315,
                  fontWeight: FontWeight.w600,
                  color: const Color(0xFF193E7F)),
            ),
          ],
        ),
      ),
    );
  }

  String getImagePath(int index) {
    switch (index) {
      case 0:
        return 'assets/images/homescreen_image_1.jpg';
      case 1:
        return 'assets/images/homescreen_image_2.jpg';
      case 2:
        return 'assets/images/homescreen_image_3.jpg';
      default:
        return 'assets/images/homescreen_image_1.jpg';
    }
  }

  Future<void> launchUrlTracking(Uri parse) async {
    final Uri url = Uri.parse(
        'https://srilankancargo.ibsplc.aero/icargoneoportal/app/main/#/app');

    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }
}
