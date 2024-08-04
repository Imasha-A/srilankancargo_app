import 'dart:async';
import 'package:flutter/material.dart';
import 'package:dots_indicator/dots_indicator.dart';
import 'package:srilankancargo_app/terms_and_conditions.dart';
import 'package:url_launcher/url_launcher.dart';
import 'schedule_page.dart';
import 'flightstatus_page.dart';
import 'loadibility_page.dart';
import 'storagecalculator_page.dart';
import 'volumecalculator_page.dart';
import 'dart:convert';
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
      buttonHeight = 65;
      buttonTextSize = 12;
    } else if (screenWidth >= 768) {
      // iPad or larger screens
      paddingBottom = 85.0;
      buttonWidth = (screenWidth - 80) / 3;
      buttonHeight = 70;
      buttonTextSize = 12;
    } else if (screenWidth == 375) {
      // iPhone SE
      paddingBottom = 15.0;
      buttonWidth = (screenWidth - 60) / 2;
      buttonHeight = 48;
      buttonTextSize = 10.5;
    } else if (screenWidth == 393) {
      // iPhone 15
      paddingBottom = 70.0;
      buttonWidth = (screenWidth - 60) / 2;
      buttonHeight = 63;
      buttonTextSize = 10;
    } else if (screenWidth == 430) {
      // iPhone 15 Plus
      paddingBottom = 92.0;
      buttonWidth = (screenWidth - 60) / 2;
      buttonHeight = 63;
      buttonTextSize = 12;
    } else if (screenWidth <= 768 && screenWidth > 600) {
      // Customization for larger Android screens
      paddingBottom = 90.0;
      buttonWidth = (screenWidth - 100) / 3;
      buttonHeight = 75;
      buttonTextSize = 14.0;
    } else if (screenWidth <= 600 && screenWidth > 400) {
      // Customization for medium-sized Android screens (Pixel 7 Pro API 29)
      paddingBottom = 60.0;
      buttonWidth = (screenWidth - 60) / 2;
      buttonHeight = 70;
      buttonTextSize = 11.0;
    } else {
      // Default values for other screen sizes
      paddingBottom = 85.0;
      buttonWidth = (screenWidth - 30) / 2;
      buttonHeight = 65;
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

  Future<List<dynamic>> fetchContacts() async {
    final response =
        await http.get(Uri.parse('http://10.60.11.134:5063/api/contacts'));

    if (response.statusCode == 200) {
      List<dynamic> contacts = jsonDecode(response.body);
      return contacts;
    } else {
      throw Exception('Failed to load contacts');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(kToolbarHeight),
        child: AppBar(
          title: null,
          centerTitle: true,
          flexibleSpace: Center(
            child: LayoutBuilder(
              builder: (context, constraints) {
                double offset = constraints.maxHeight * appBarOffsetPercentage;

                return Transform.translate(
                  offset: Offset(0.0, offset),
                  child: Transform.scale(
                    scale: 1.0,
                    child: Image.asset(
                      'assets/images/2022451025672_Big-removebg-preview (1).png',
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(bottom: paddingBottom),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Expanded(
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
                    fit: BoxFit.contain,
                  );
                },
                itemCount: 3,
              ),
            ),
            DotsIndicator(
              dotsCount: 3,
              position: _currentPage.toInt(),
              decorator: DotsDecorator(
                size: const Size.square(9.0),
                activeSize: const Size(18.0, 9.0),
                color: Colors.grey,
                activeColor: Color.fromARGB(255, 3, 75, 135),
                activeShape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            ),
            Padding(padding: const EdgeInsets.only(bottom: 15)),
            Wrap(
              spacing: 10.0,
              runSpacing: 10.0,
              alignment: WrapAlignment.center,
              children: [
                buildOutlinedButton('Schedule', Icons.flight),
                buildOutlinedButton('Flight Status', Icons.format_quote),
                buildOutlinedButton('Loadibility', Icons.local_shipping_sharp),
                buildOutlinedButton('Storage Calculator', Icons.storage),
                buildOutlinedButton('Volume Calculator', Icons.calculate),
                buildOutlinedButton('Tracking', Icons.location_on),
              ],
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            Container(
              height: 200,
              width: 220,
              color: Colors.white,
              padding: EdgeInsets.only(top: 42),
              child: UserAccountsDrawerHeader(
                decoration: BoxDecoration(
                  image: DecorationImage(
                    fit: BoxFit.cover,
                    image: AssetImage('assets/images/Image-DE_SLA.png'),
                  ),
                ),
                accountName: null,
                accountEmail: null,
              ),
            ),
            ListTile(
              leading: Icon(
                Icons.info,
                color: Color.fromARGB(255, 3, 75, 135),
              ),
              title: const Text('About Us',
                  style: TextStyle(color: Color.fromARGB(255, 3, 75, 135))),
              onTap: () async {
                try {
                  List<dynamic> contacts = await fetchContacts();
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('About Us'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: contacts.map<Widget>((contact) {
                              return Text(
                                  'Description: ${contact['description']}\n'
                                  'Addtional Description: ${contact['additionalDescription']}\n');
                            }).toList(),
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                } catch (e) {
                  print("Error fetching about us: $e");
                }
              },
            ),
            ListTile(
              leading: Icon(
                Icons.remove_red_eye,
                color: Color.fromARGB(255, 3, 75, 135),
              ),
              title: const Text('Terms & Conditions',
                  style: TextStyle(color: Color.fromARGB(255, 3, 75, 135))),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const WebViewContainer(),
                  ),
                );
                /*Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => WebViewPage(
                      url:
                          'https://www.srilankancargo.com/help-support/conditions',
                      title: 'Terms & Conditions',
                    ),
                  ),
                );
                */
              },
            ),
            ListTile(
              leading: Icon(
                Icons.web,
                color: Color.fromARGB(255, 3, 75, 135),
              ),
              title: const Text('View Full Website',
                  style: TextStyle(color: Color.fromARGB(255, 3, 75, 135))),
              onTap: () async {
                await launchUrl('https://www.srilankancargo.com/home');
                Navigator.pop(context);
              },
            ),
            ListTile(
              leading: Icon(
                Icons.contact_emergency,
                color: Color.fromARGB(255, 3, 75, 135),
              ),
              title: const Text('Contact Us',
                  style: TextStyle(color: Color.fromARGB(255, 3, 75, 135))),
              onTap: () async {
                try {
                  List<dynamic> contacts = await fetchContacts();
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        title: Text('Contact Information'),
                        content: SingleChildScrollView(
                          child: ListBody(
                            children: contacts.map<Widget>((contact) {
                              return Text('Name: ${contact['name']}\n'
                                  'Phone: ${contact['phoneNumber']}\n');
                            }).toList(),
                          ),
                        ),
                        actions: <Widget>[
                          TextButton(
                            child: Text('OK'),
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ],
                      );
                    },
                  );
                } catch (e) {
                  print("Error fetching contacts: $e");
                }
              },
            ),
          ],
        ),
      ),
    );
  }

  Widget buildOutlinedButton(String label, IconData icon) {
    return SizedBox(
      width: buttonWidth,
      height: buttonHeight,
      child: OutlinedButton(
        style: OutlinedButton.styleFrom(
          backgroundColor: Color.fromARGB(255, 3, 75, 135),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10.0),
          ),
        ),
        onPressed: () {
          if (label == 'Schedule') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => SchedulePage()),
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
              MaterialPageRoute(builder: (context) => StorageCalculatorPage()),
            );
          }
          if (label == 'Volume Calculator') {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => VolumeCalculatorPage()),
            );
          }
          if (label == 'Tracking') {
            const url =
                'http://www.srilankanskychain.aero/skychain/app?service=page/nwp:Trackshipmt';
            launchUrl(url);
          }
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, color: Colors.white),
            const SizedBox(height: 4),
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: buttonTextSize, color: Colors.white),
            ),
          ],
        ),
      ),
    );
  }

  String getImagePath(int index) {
    switch (index) {
      case 0:
        return 'assets/images/139.png';
      case 1:
        return 'assets/images/239378279_1992974014190829_3029728983071132528_n.jpg';
      case 2:
        return 'assets/images/EmQ9_FuVcAIrkfw.jpg';
      default:
        return 'assets/images/139.png';
    }
  }

  Future<void> launchUrl(String url) async {
    try {
      print("Launching URL: $url");
      if (await canLaunch(url)) {
        await launch(url);
        print("URL Launched successfully");
      } else {
        print("Could not launch $url");
        throw 'Could not launch $url';
      }
    } catch (e) {
      print("Error launching URL: $e");
      throw e;
    }
  }
}
