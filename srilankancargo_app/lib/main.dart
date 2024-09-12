import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:srilankancargo_app/about_us_page.dart';
import 'package:srilankancargo_app/contact_us_page.dart';
import 'package:srilankancargo_app/storagecalculator_page.dart';
import 'package:srilankancargo_app/terms_and_conditions.dart';
import 'package:srilankancargo_app/volume_calculator.dart';
import 'package:url_launcher/url_launcher.dart';
import 'schedule_page.dart';
import 'flightstatus_page.dart';
import 'loadibility_page.dart';

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
      home: const MyHomePage(title: 'Flutter Demo Home Page'),
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
  late double paddingBottom; // Adjusted dynamically based on screen width
  late double buttonWidth;
  late double buttonHeight;
  late double buttonTextSize;
  double appBarOffsetPercentage = 0.27;

  @override
  void initState() {
    super.initState();
    _startTimer();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    _updateButtonDimensions();
    _updateAppBarOffset();
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
      buttonWidth = (screenWidth - 100) / 3;
      buttonHeight = 45;
      buttonTextSize = 12;
    } else if (screenWidth >= 768) {
      // iPad or larger screens
      paddingBottom = 85.0;
      buttonWidth = (screenWidth - 80) / 3;
      buttonHeight = 50;
      buttonTextSize = 12;
    } else if (screenWidth == 375) {
      // iPhone SE
      paddingBottom = 15.0;
      buttonWidth = (screenWidth - 60) / 2;
      buttonHeight = 28;
      buttonTextSize = 10.5;
    } else if (screenWidth == 393) {
      // iPhone 15
      paddingBottom = 70.0;
      buttonWidth = (screenWidth - 60) / 2;
      buttonHeight = 43;
      buttonTextSize = 10;
    } else if (screenWidth == 430) {
      // iPhone 15 Plus
      paddingBottom = 92.0;
      buttonWidth = (screenWidth - 60) / 2;
      buttonHeight = 43;
      buttonTextSize = 12;
    } else if (screenWidth <= 768 && screenWidth > 600) {
      // Customization for larger Android screens
      paddingBottom = 90.0;
      buttonWidth = (screenWidth - 100) / 3;
      buttonHeight = 55;
      buttonTextSize = 14.0;
    } else if (screenWidth <= 600 && screenWidth > 400) {
      // Customization for medium-sized Android screens (Pixel 7 Pro API 29)
      paddingBottom = 60.0;
      buttonWidth = (screenWidth - 60) / 2;
      buttonHeight = 50;
      buttonTextSize = 11.0;
    } else {
      // Default values for other screen sizes
      paddingBottom = 85.0;
      buttonWidth = (screenWidth - 30) / 2;
      buttonHeight = 45;
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
    return Scaffold(
      key: _scaffoldKey,
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
              height: 235, // Adjust as necessary
            ),
          ),

          // White Card with Content (middle layer)
          Positioned(
            top: 225, // Adjust to start below the banner
            left: 0,
            right: 0,
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10), // Rounded corners
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey.withOpacity(0.5),
                    spreadRadius: 2,
                    blurRadius: 5,
                    offset: Offset(0, 3), // Shadow position
                  ),
                ],
              ),
              padding: EdgeInsets.all(3),
              child: SingleChildScrollView(
                child: Padding(
                  padding: EdgeInsets.only(bottom: paddingBottom),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: <Widget>[
                      const SizedBox(height: 147),
                      DotsIndicator(
                        dotsCount: 3,
                        position: _currentPage.toInt(),
                        decorator: DotsDecorator(
                          size: const Size.square(9.0),
                          activeSize: const Size(18.0, 9.0),
                          color: const Color.fromARGB(255, 85, 88, 181),
                          activeColor: Color.fromARGB(255, 28, 31, 106),
                          activeShape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5.0),
                          ),
                        ),
                      ),

                      Padding(
                        padding: const EdgeInsets.only(
                            right: 250), // Adjust the value as needed
                        child: Text(
                          'Categories',
                          style: TextStyle(
                            fontSize: 20,
                            color: Color.fromARGB(255, 28, 31, 106),
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(height: 10),

                      // Category Icons
                      Padding(
                        padding: const EdgeInsets.all(10),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: buildOutlinedButton('Schedule',
                                        'assets/images/flight_schedule_icon.svg')),
                                SizedBox(width: 0), // Space between buttons
                                Expanded(
                                    child: buildOutlinedButton('Flight Status',
                                        'assets/images/flight_status_icon.svg')),
                                SizedBox(width: 0), // Space between buttons
                                Expanded(
                                    child: buildOutlinedButton('Loadibility',
                                        'assets/images/loadability_icon.svg')),
                              ],
                            ),
                            SizedBox(height: 30), // Space between rows
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: buildOutlinedButton(
                                        'Storage Calculator',
                                        'assets/images/storage_calculator_icon.svg')),
                                SizedBox(width: 5), // Space between buttons
                                Expanded(
                                    child: buildOutlinedButton(
                                        'Volume Calculator',
                                        'assets/images/volume_calculator_icon.svg')),
                                SizedBox(width: 5), // Space between buttons
                                Expanded(
                                    child: buildOutlinedButton('Tracking',
                                        'assets/images/tracking_icon.svg')),
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 3),

                      // Website Banner
                      Positioned(
                        top: 10,
                        left: 5,
                        right: 5,
                        child: Stack(
                          children: [
                            SizedBox(
                              width: 355,
                              height: 160,
                              child: GestureDetector(
                                onTap: () {
                                  //const url = 'https://www.srilankancargo.com';
                                  launchUrl(Uri.parse(
                                      'https://www.srilankancargo.com'));
                                },
                                child: Image.asset(
                                  'assets/images/visit_website_banner.png',
                                  fit: BoxFit.cover,
                                ),
                              ),
                            ),
                            Positioned(
                              bottom: 5, // Position from the bottom
                              left: 30, // Position from the left
                              child: ElevatedButton(
                                onPressed: () {
                                  launchUrl((Uri.parse(
                                      'https://www.srilankancargo.com')));
                                },
                                child: const Text("Click here"),
                                style: ElevatedButton.styleFrom(
                                  foregroundColor: Colors.white,
                                  backgroundColor: const Color.fromARGB(
                                      255, 0, 0, 0), // Text color
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 28, vertical: 0),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            top: 95, // Adjust this value to position the text above the slider
            left: 20,
            child: Text(
              'Welcome to',
              style: TextStyle(
                fontSize: 22,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              textAlign: TextAlign.left,
            ),
          ),

          Positioned(
            top: 125, // Adjust this value to position the text above the slider
            left: 20,

            child: Text(
              'SriLankan Airlines Cargo',
              style: TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold,
                color: Color.fromARGB(255, 255, 255, 255),
              ),
              textAlign: TextAlign.left,
            ),
          ),
          // Image Slider (PageView) (top layer)
          Positioned(
            top: 165, // Adjust to overlap the white card and banner
            left: 20,
            right: 20,
            child: Container(
              height: 200, // Adjust height as necessary
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.2),
                    blurRadius: 8,
                    spreadRadius: 2,
                    offset: Offset(0, 4), // Shadow position
                  ),
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
      // Bottom Navigation Bar
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/home_icon.svg', // Relative path to your SVG asset
              height: 24, // Adjust the size as needed
              width: 24,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/contact_us_icon.svg', // Relative path to your SVG asset
              height: 24, // Adjust the size as needed
              width: 24,
            ),
            label: 'Contact Us',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/about_us_icon.svg', // Relative path to your SVG asset
              height: 24, // Adjust the size as needed
              width: 24,
            ),
            label: 'About Us',
          ),
        ],
        selectedItemColor: Color.fromARGB(255, 28, 31, 106),
        unselectedItemColor: Color.fromARGB(255, 28, 31, 106),
        currentIndex: 0, // This can be updated as per the current screen
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
      ),
    );
  }

  Widget buildOutlinedButton(String label, String svgPath) {
    return SizedBox(
      width: buttonWidth,
      height: buttonHeight * 1.5,
      child: TextButton(
        style: TextButton.styleFrom(
          backgroundColor:
              Color.fromARGB(255, 255, 255, 255), // Button background color
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0), // Square corners
          ),
          padding: EdgeInsets.zero, // Remove padding
          side: BorderSide.none, // No border
          elevation: 0, // Ensure no elevation
        ),
        onPressed: () {
          if (label == 'Schedule') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FlightSchedulePage()),
            );
          }
          if (label == 'Flight Status') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => FlightStatusPage()),
            );
          }
          if (label == 'Loadibility') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => LoadibilityPage()),
            );
          }
          if (label == 'Storage Calculator') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => StorageCalPage()),
            );
          }
          if (label == 'Volume Calculator') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => VolumeCalPage()),
            );
          }
          if (label == 'Tracking') {
            launchUrlTracking((Uri.parse(
                'http://www.srilankanskychain.aero/skychain/app?service=page/nwp:Trackshipmt')));
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SvgPicture.asset(
              svgPath,
              height: 24,
              width: 24,
            ),
            const SizedBox(height: 20),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                  fontSize: buttonTextSize,
                  color: Color.fromARGB(255, 28, 31, 106)),
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
        'http://www.srilankanskychain.aero/skychain/app?service=page/nwp:Trackshipmt'); // Updated to use Uri.parse
    forceWebView:
    true;
    if (!await launchUrl(url)) {
      throw 'Could not launch $url';
    }
  }
}
