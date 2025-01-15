import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:srilankancargo_app/about_us_page.dart';
import 'package:srilankancargo_app/contact_us_page.dart';
import 'package:srilankancargo_app/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class FlightStatusPage extends StatefulWidget {
  @override
  _FlightStatusPageState createState() => _FlightStatusPageState();
}

class _FlightStatusPageState extends State<FlightStatusPage> {
  final TextEditingController _flightNumberController = TextEditingController();
  DateTime? _selectedDate;
  String? _flightStatus; // To hold flight status information
  bool _isLoading = false; // Loading indicator
  bool _canNavigate = true;
  Map<String, dynamic>? _flightInfo;

  Map<String, double> customizeFormCard(double screenWidth) {
    Map<String, double> customizationValues = {};

    if (screenWidth == 1024) {
      customizationValues['cardMargin'] = 70.0;
      customizationValues['cardOffset'] = 400.0;
      customizationValues['iconOffset'] = 660.5;
      customizationValues['buttonPadding'] = 40.0;
      customizationValues['cardHeight'] = 333;
    } else if (screenWidth == 834) {
      customizationValues['cardMargin'] = 50.0;
      customizationValues['cardOffset'] = 280.0;
      customizationValues['iconOffset'] = 515.5;
      customizationValues['buttonPadding'] = 38.0;
    } else if (screenWidth >= 768) {
      customizationValues['cardMargin'] = 86.0;
      customizationValues['cardOffset'] = 278.0;
      customizationValues['iconOffset'] = 425.5;
      customizationValues['buttonPadding'] = 54.0;
    } else {
      customizationValues['cardMargin'] = 16.0;
      customizationValues['cardOffset'] = -110.0;
      customizationValues['iconOffset'] = 190.5;
      customizationValues['buttonPadding'] = 36.0;
    }

    return customizationValues;
  }

  Map<String, double> customizeAppBar(double screenWidth) {
    Map<String, double> customizationValues = {};

    if (screenWidth <= 600 && screenWidth >= 400) {
      customizationValues['appBarOffsetPercentage'] = -0.60;
      customizationValues['titleXOffset'] = 60.0;
    }
    if (screenWidth == 430) {
      customizationValues['appBarOffsetPercentage'] = -0.60;
      customizationValues['titleXOffset'] = 0.0;
    }

    return customizationValues;
  }

  Future<void> _selectDate(BuildContext context) async {
    DateTime now = DateTime.now();
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: now.subtract(Duration(days: 366)),
        lastDate: now.add(Duration(days: 365 * 100)),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Color.fromARGB(255, 28, 31, 106),
              hintColor: Color.fromARGB(255, 28, 31, 106),
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
              dialogBackgroundColor: Colors.lightBlue[50],
              colorScheme:
                  ColorScheme.light(primary: Color.fromARGB(255, 28, 31, 106)),
            ),
            child: child!,
          );
        });
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  Future<void> fetchFlightStatus() async {
    FocusScope.of(context).unfocus();
    final RegExp flightNumberReg = RegExp(r'^[a-zA-Z]{2}\d{1,4}$');
    final RegExp cargoFlightNumberReg = RegExp(r'^[a-zA-Z0-9]{2}\d{1,4}$');

    if (_flightNumberController.text.isEmpty && _selectedDate == null) {
      _clearFlightInfo();
      _showAlert('Incomplete Form',
          'Please enter valid flight number and select date');

      return;
    } else if (_flightNumberController.text.isEmpty) {
      _clearFlightInfo();
      _showAlert('Incomplete Form', 'Please enter valid flight number.');
      return;
    } else if (!flightNumberReg.hasMatch(_flightNumberController.text) &&
        (!cargoFlightNumberReg.hasMatch(_flightNumberController.text))) {
      _clearFlightInfo();
      _showAlert('Invalid Flight Number', 'Please enter valid flight number.');
      return;
    } else if (_selectedDate == null) {
      _clearFlightInfo();
      _showAlert('Incomplete Form', 'Please select date');
      return;
    }

    setState(() {
      _isLoading = true;
    });

    String flightNo = _flightNumberController.text.toUpperCase();
    String flightDate =
        "${_selectedDate!.month}/${_selectedDate!.day}/${_selectedDate!.year}";

    String url =
        "https://ulmobservicesstg.srilankan.com/ULMOBTEAMSERVICES/api/CARGOUL/FLTSTA?FlightNo=$flightNo&FlightDate=$flightDate";

    _flightNumberController.clear();
    _selectedDate = null;
    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        if (data.isNotEmpty) {
          setState(() {
            _flightInfo = data[0];
          });
        } else {
          _clearFlightInfo();
          _showAlert(
              'No Flight Data', 'No flight status information available.');
        }
      } else {
        _clearFlightInfo();
        _showAlert('Failed to Fetch Data',
            'Server returned status code ${response.statusCode}.');
      }
    } catch (e) {
      _clearFlightInfo();
      _showAlert('Error', 'Error fetching flight status: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showAlert(String title, String message) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(23.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontSize: screenWidth * 0.055,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 28, 31, 106),
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenWidth * 0.045,
                    color: const Color.fromARGB(255, 28, 31, 106),
                  ),
                ),
                SizedBox(height: screenHeight * 0.012),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 28, 31, 106),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: screenHeight * 0.015),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Close',
                      style: TextStyle(
                        fontSize: screenWidth * 0.04,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  Future<void> _handleBackButton(BuildContext context) async {
    double screenWidth = MediaQuery.of(context).size.width;

    if (_flightInfo != null) {
      bool? shouldExit = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirm Exit'),
            titleTextStyle: TextStyle(
                color: Color.fromARGB(255, 21, 5, 126),
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.06),
            content: Text(
                'Are you sure you want to leave? Flight information will be lost.'),
            contentTextStyle: TextStyle(
                color: Color.fromARGB(255, 21, 7, 110),
                fontSize: screenWidth * 0.045),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  _canNavigate = false;
                  Navigator.of(context).pop(false);
                },
                child: Text('Cancel',
                    style: TextStyle(
                        color: Color.fromARGB(255, 25, 7, 138),
                        fontSize: screenWidth * 0.043)),
              ),
              TextButton(
                onPressed: () {
                  _canNavigate = true;
                  Navigator.of(context).pop(true);
                },
                child: Text('Yes',
                    style: TextStyle(
                        color: Color.fromARGB(255, 25, 7, 138),
                        fontSize: screenWidth * 0.043)),
              ),
            ],
          );
        },
      );

      if (shouldExit == true) {
        _canNavigate = true;
        Navigator.of(context).pop();
      }
    } else {
      _canNavigate = true;
      Navigator.of(context).pop();
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double buttonPadding = screenWidth * 0.34;
    Map<String, double> customizationValues = customizeFormCard(screenWidth);

    return WillPopScope(
      onWillPop: () async {
        await _handleBackButton(context);
        return false; // Prevents default back navigation
      },
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus();
          },
          child: Stack(
            children: [
              // Top Banner Image (bottom layer)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Image.asset(
                  'assets/images/flight_status.png',
                  fit: BoxFit.cover,
                  height: screenHeight * 0.23,
                ),
              ),
              Positioned(
                top: screenHeight * 0.04,
                left: screenWidth * 0.001,
                child: SizedBox(
                  width: screenWidth * .12,
                  height: screenHeight * 0.04,
                  child: IconButton(
                    icon: Icon(Icons.arrow_back),
                    color: Color.fromARGB(255, 255, 255, 255),
                    onPressed: () => _handleBackButton(context),
                  ),
                ),
              ),
              // Outer White Card (middle layer) wrapping the form
              Positioned(
                top: screenHeight * 0.18,
                left: 0,
                right: 0,
                child: Container(
                  padding: EdgeInsets.all(18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(15),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.grey.withOpacity(0.5),
                        spreadRadius: 2,
                        blurRadius: 5,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        'Flight Status',
                        style: TextStyle(
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 28, 31, 106),
                        ),
                      ),

                      const SizedBox(height: 10),
                      // Inner White Card with the Flight Form
                      Container(
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(10),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.grey.withOpacity(0.5),
                              spreadRadius: 1,
                              blurRadius: 3,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        padding: EdgeInsets.all(16),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Flight Number',
                              style: TextStyle(
                                  fontSize: screenWidth * 0.035,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 28, 31, 106)),
                            ),
                            SizedBox(
                              height: screenHeight * 0.06,
                              child: TextField(
                                controller: _flightNumberController,
                                style: TextStyle(
                                    color: Color.fromARGB(255, 135, 130, 130),
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenWidth * 0.035),
                                decoration: InputDecoration(
                                  hintText: 'Enter Flight Number (Ex: UL225)',
                                  hintStyle: TextStyle(
                                    color: Color.fromARGB(255, 204, 203, 203),
                                    fontSize: screenWidth * 0.035,
                                  ),
                                  filled: true,
                                  fillColor: Color.fromARGB(255, 245, 245, 245),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: Color.fromARGB(255, 204, 203, 203),
                                      width: 1.0,
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: const Color.fromARGB(
                                          255, 204, 203, 203),
                                      width: 1.0,
                                    ),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: BorderSide(
                                      color: const Color.fromARGB(
                                          255, 204, 203, 203),
                                      width: 1.0,
                                    ),
                                  ),
                                  contentPadding: EdgeInsets.symmetric(
                                      vertical: screenHeight * 0.01,
                                      horizontal: screenWidth * 0.02),
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Text(
                              'Select Flight Date',
                              style: TextStyle(
                                  fontSize: screenWidth * 0.035,
                                  fontWeight: FontWeight.w600,
                                  color: Color.fromARGB(255, 28, 31, 106)),
                            ),
                            SizedBox(height: screenHeight * 0.001),
                            GestureDetector(
                              onTap: () => _selectDate(context),
                              child: AbsorbPointer(
                                child: TextField(
                                  style: TextStyle(
                                    color: Color.fromARGB(255, 96, 92, 92),
                                    fontWeight: FontWeight.bold,
                                    fontSize: screenWidth * 0.025,
                                  ),
                                  decoration: InputDecoration(
                                    hintText: _selectedDate == null
                                        ? 'Select Flight Date'
                                        : "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}",
                                    hintStyle: TextStyle(
                                      color: _selectedDate == null
                                          ? Color.fromARGB(255, 204, 203, 203)
                                          : const Color.fromARGB(
                                              255, 135, 130, 130),
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenWidth * 0.035,
                                    ),
                                    filled: true,
                                    fillColor:
                                        Color.fromARGB(255, 245, 245, 245),
                                    suffixIcon: SizedBox(
                                        child: Icon(
                                      Icons.calendar_today,
                                      color: Color.fromARGB(255, 128, 126, 126),
                                      size: 19.0,
                                    )),
                                    border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                          color: Color.fromARGB(
                                              255, 206, 197, 197),
                                          width: 0.1),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: const Color.fromARGB(
                                            255, 204, 203, 203),
                                        width: 1.0,
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: screenHeight * 0.01,
                                        horizontal: screenWidth * 0.02),
                                  ),
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.02),

                            ElevatedButton(
                              onPressed: fetchFlightStatus,
                              style: ElevatedButton.styleFrom(
                                padding: EdgeInsets.symmetric(
                                    horizontal: buttonPadding,
                                    vertical: screenHeight * 0.013),
                                backgroundColor:
                                    Color.fromARGB(255, 28, 31, 106),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                              child: _isLoading
                                  ? CircularProgressIndicator(
                                      valueColor: AlwaysStoppedAnimation<Color>(
                                          Colors.white),
                                    )
                                  : Text(
                                      'Submit',
                                      style: TextStyle(
                                        fontSize: screenWidth * 0.04,
                                        color: Colors.white,
                                      ),
                                    ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            // Display flight status
                            if (_flightStatus != null)
                              Text(
                                _flightStatus!,
                                style: TextStyle(
                                  fontSize: screenWidth * 0.04,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black,
                                ),
                              ),
                          ],
                        ),
                      ),

                      if (_flightInfo != null) ...[
                        SizedBox(height: screenHeight * 0.03),
                        Text(
                          'ON-SCHEDULE',
                          style: TextStyle(
                            fontSize: screenWidth * 0.06,
                            fontWeight: FontWeight.w600,
                            color: Color.fromARGB(255, 15, 20, 158),
                          ),
                        ),

                        Text.rich(
                          TextSpan(
                            text: 'Scheduled Time: ',
                            style: TextStyle(
                              fontSize: screenWidth * 0.035,
                              color: const Color.fromARGB(255, 15, 20, 158),
                            ),
                            children: <TextSpan>[
                              TextSpan(
                                text: '${_flightInfo!['Schedultime']}',
                                style: TextStyle(
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                            ],
                          ),
                        ),

                        // Flight route with airplane line
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              _flightInfo!['Sector'].split('-')[0],
                              style: TextStyle(
                                fontSize: screenWidth * 0.05,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 15, 20, 158),
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.05),
                            // Airplane SVG in the middle
                            Padding(
                              padding:
                                  EdgeInsets.only(bottom: screenHeight * 0.015),
                              child: SvgPicture.asset(
                                'assets/images/airplane_line.svg',
                                height: screenHeight * 0.085,
                                color: Color.fromARGB(255, 27, 31, 127),
                              ),
                            ),
                            SizedBox(width: screenWidth * 0.05),
                            Text(
                              _flightInfo!['Sector'].split('-')[1],
                              style: TextStyle(
                                fontSize: screenWidth * 0.05,
                                fontWeight: FontWeight.bold,
                                color: const Color.fromARGB(255, 15, 20, 158),
                              ),
                            ),
                          ],
                        ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text.rich(
                              TextSpan(
                                text: 'Flight number: ',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.035,
                                  color: const Color.fromARGB(255, 15, 20, 158),
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '${_flightInfo!['Flight_No']}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Text.rich(
                              TextSpan(
                                text: 'Flight Date: ',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.035,
                                  color: const Color.fromARGB(255, 15, 20, 158),
                                ),
                                children: <TextSpan>[
                                  TextSpan(
                                    text: '${_flightInfo!['FlightDate']}',
                                    style: TextStyle(
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ],
                              ),
                            )
                          ],
                        ),
                        SizedBox(height: screenHeight * 0.01),
                        Padding(
                          padding: EdgeInsets.only(left: screenWidth * 0.6),
                          child: ElevatedButton(
                            onPressed: () {
                              _clearFlightInfo();
                            },
                            style: ElevatedButton.styleFrom(
                              foregroundColor: Color.fromARGB(255, 28, 31, 106),
                              backgroundColor: Colors.white,
                              padding: EdgeInsets.symmetric(
                                  horizontal: screenWidth * 0.1,
                                  vertical: screenHeight * 0.01),
                              side: BorderSide(
                                  color: Color.fromARGB(255, 28, 31, 106),
                                  width: 1),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'Clear',
                              style: TextStyle(
                                  fontSize: screenWidth * 0.04,
                                  fontWeight: FontWeight.bold,
                                  color: Color.fromARGB(255, 28, 31, 106)),
                            ),
                          ),
                        ),
                      ],

                      SizedBox(height: screenHeight),
                    ],
                  ),
                ),
              ),
            ],
          ),
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
                onTap: (index) {
                  _handleNavigation(index, context);
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleNavigation(int index, BuildContext context) async {
    _canNavigate = true;

    await _handleBackButton(context);

    if (_canNavigate) {
      if (index == 0) {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                MyHomePage(title: 'Flutter Demo Home Page'),
            transitionDuration: Duration(seconds: 0), // No animation
          ),
        );
      } else if (index == 1) {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                ContactUsPage(),
            transitionDuration: Duration(seconds: 0), // No animation
          ),
        );
      } else if (index == 2) {
        Navigator.push(
          context,
          PageRouteBuilder(
            pageBuilder: (context, animation, secondaryAnimation) =>
                AboutUsPage(),
            transitionDuration: Duration(seconds: 0), // No animation
          ),
        );
      }
    }
  }

  void _clearFlightInfo() {
    setState(() {
      _flightInfo = null;
      _flightStatus = null;
    });
  }
}
