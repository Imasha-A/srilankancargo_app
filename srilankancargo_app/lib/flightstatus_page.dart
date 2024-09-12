import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:srilankancargo_app/about_us_page.dart';
import 'package:srilankancargo_app/contact_us_page.dart';
import 'package:srilankancargo_app/main.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:xml/xml.dart' as xml;

class FlightStatusPage extends StatefulWidget {
  @override
  _FlightStatusPageState createState() => _FlightStatusPageState();
}

class _FlightStatusPageState extends State<FlightStatusPage> {
  final TextEditingController _flightNumberController = TextEditingController();
  DateTime? _selectedDate;
  String? _flightStatus; // To hold flight status information
  bool _isLoading = false; // Loading indicator

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
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  Future<void> fetchFlightStatus() async {
    final RegExp flightNumberReg = RegExp(r'^[a-zA-Z]{2}\d{1,4}$');

    if (_flightNumberController.text.isEmpty && _selectedDate == null) {
      _showAlert('Incomplete Form',
          'Please enter valid flight number and select date');
      return;
    } else if (_flightNumberController.text.isEmpty) {
      _showAlert('Incomplete Form', 'Please enter valid flight number.');
      return;
    } else if (!flightNumberReg.hasMatch(_flightNumberController.text)) {
      _showAlert('Invalid Flight Number', 'Please enter valid flight number.');
      return;
    } else if (_selectedDate == null) {
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

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        var data = json.decode(response.body);

        if (data.isNotEmpty) {
          var flightInfo = data[0];

          String message = '''Flight Number: ${flightInfo['Flight_No']}
Flight Date: ${flightInfo['FlightDate']}
Sector: ${flightInfo['Sector']}
Scheduled Time: ${flightInfo['Schedultime']}''';
          String heading = ''' ${flightInfo['Stauts']}''';

          _showAlert(heading, message);
        } else {
          _showAlert(
              'No Flight Data', 'No flight status information available.');
        }
      } else {
        _showAlert('Failed to Fetch Data',
            'Server returned status code ${response.statusCode}.');
      }
    } catch (e) {
      _showAlert('Error', 'Error fetching flight status: $e');
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  void _showAlert(String title, String message) {
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
                    fontSize: 22.0,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(255, 28, 31, 106),
                  ),
                ),
                SizedBox(height: 10.0),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18.0,
                    color: const Color.fromARGB(255, 28, 31, 106),
                  ),
                ),
                SizedBox(height: 15.0),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(255, 28, 31, 106),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding: EdgeInsets.symmetric(vertical: 15.0),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Close',
                      style: TextStyle(
                        fontSize: 16.0,
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

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double buttonPadding = screenWidth * 0.34;
    Map<String, double> customizationValues = customizeFormCard(screenWidth);

    return Scaffold(
      body: Stack(
        children: [
          // Top Banner Image (bottom layer)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/flight_status.png',
              fit: BoxFit.cover,
              height: 185,
            ),
          ),
          Positioned(
            top: 25, // Adjust according to your design
            left: 3, // Adjust according to your design
            child: SizedBox(
              width: 58, // Set width of the button
              height: 48, // Set height of the button
              child: BackButton(
                color: Color.fromARGB(255, 255, 255, 255), // Icon color
              ),
            ),
          ),

          // Outer White Card (middle layer) wrapping the form
          Positioned(
            top: 155,
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
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
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
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                              color: Color.fromARGB(255, 28, 31, 106)),
                        ),
                        SizedBox(
                          height:
                              50, // Adjust the height of the TextField wrapper if needed
                          child: TextField(
                            controller: _flightNumberController,
                            style: TextStyle(
                                color: Color.fromARGB(255, 135, 130, 130),
                                fontWeight: FontWeight.bold,
                                fontSize: 14),
                            decoration: InputDecoration(
                              hintText: 'Enter Flight Number (Ex: UL225)',
                              hintStyle: TextStyle(
                                color: Color.fromARGB(255, 204, 203,
                                    203), // Change hint text color to red
                                fontSize:
                                    14.0, // Optional: Adjust font size as needed
                              ),
                              filled: true,
                              fillColor: Color.fromARGB(
                                  255, 245, 245, 245), // Background color
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: Color.fromARGB(
                                      255, 204, 203, 203), // Border color
                                  width: 1.0, // Border width
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: const Color.fromARGB(255, 204, 203,
                                      203), // Border color when focused
                                  width: 1.0, // Border width when focused
                                ),
                              ),
                              enabledBorder: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide(
                                  color: const Color.fromARGB(255, 204, 203,
                                      203), // Border color when unfocused
                                  width: 1.0, // Border width when unfocused
                                ),
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                  vertical: 12.0,
                                  horizontal: 16.0), // Adjust padding
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          'Select Flight Date',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                              color: Color.fromARGB(255, 28, 31, 106)),
                        ),
                        SizedBox(height: 3),
                        GestureDetector(
                          onTap: () => _selectDate(context),
                          child: AbsorbPointer(
                            child: TextField(
                              style: TextStyle(
                                color: Color.fromARGB(255, 96, 92, 92),
                                fontWeight: FontWeight.bold,
                                fontSize:
                                    12, // Set the input text color to grey
                              ),
                              decoration: InputDecoration(
                                hintText: _selectedDate == null
                                    ? 'Select Flight Date'
                                    : "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}",
                                hintStyle: TextStyle(
                                  color: _selectedDate == null
                                      ? Color.fromARGB(255, 204, 203,
                                          203) // Default text color
                                      : const Color.fromARGB(255, 135, 130,
                                          130), // Text color when a date is selected
                                  fontWeight: FontWeight.bold,
                                  fontSize: 14,
                                  // Optional: Adjust font size as needed
                                ),
                                filled: true,
                                fillColor: Color.fromARGB(255, 245, 245, 245),
                                suffixIcon: SizedBox(
                                    // Optionally set width to maintain aspect ratio
                                    child: Icon(
                                  Icons.calendar_today,
                                  color: Color.fromARGB(
                                      255, 51, 51, 51), // Suffix icon color
                                  size: 19.0, // Set the icon size
                                )),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                      color: Color.fromARGB(255, 206, 197, 197),
                                      width: 0.1),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: BorderSide(
                                    color: const Color.fromARGB(255, 204, 203,
                                        203), // Border color when unfocused
                                    width: 1.0, // Border width when unfocused
                                  ),
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                    vertical: 12.0, horizontal: 16.0),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),

                        ElevatedButton(
                          onPressed:
                              fetchFlightStatus, // Call fetchFlightStatus on submit
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(
                                horizontal: buttonPadding, vertical: 10),
                            backgroundColor: Color.fromARGB(255, 28, 31, 106),
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
                                    fontSize: 16,
                                    color: Colors.white,
                                  ),
                                ),
                        ),
                        SizedBox(height: 20),
                        // Display flight status
                        if (_flightStatus != null)
                          Text(
                            _flightStatus!,
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                      ],
                    ),
                  ),
                  const SizedBox(height: 500),
                ],
              ),
            ),
          ),
        ],
      ),
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
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => ContactUsPage()));
          } else if (index == 0) {
            Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) =>
                      MyHomePage(title: 'Flutter Demo Home Page')),
            );
          } else if (index == 2) {
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
