import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:srilankancargo_app/about_us_page.dart';
import 'package:srilankancargo_app/contact_us_page.dart';
import 'package:srilankancargo_app/main.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:cached_network_image/cached_network_image.dart';

import 'dart:io';
import 'package:http/io_client.dart';
import 'package:srilankancargo_app/terms_and_conditions.dart';

class FlightSchedulePage extends StatefulWidget {
  @override
  _FlightSchedulePageState createState() => _FlightSchedulePageState();
}

class _FlightSchedulePageState extends State<FlightSchedulePage> {
  final TextEditingController _originCountryController =
      TextEditingController();
  final TextEditingController _destinationCountryController =
      TextEditingController();
  DateTime? _selectedDate;
  List<dynamic> _allCountries = [];
  List<dynamic> _filteredCountries = [];
  TextEditingController _searchController = TextEditingController();
  bool _isLoading = false;
  bool _isCollapsed = false;
  bool _fetched = false;
  bool _showFlightDetails = false;
  bool _canNavigate = true;
  bool _animate = false;

  List<String> _flightDetails = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      setState(() {
        _animate = true;
        print("Animation triggered: $_animate");
      });
    });
    fetchCountries();
    filterCountries();
    sortCountries();
  }

  Future<http.Client> createHttpClient() async {
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return IOClient(ioc);
  }

  Future<void> fetchCountries() async {
    final response = await http.get(Uri.parse(
        'https://ulmobservices.srilankan.com/ULMOBTEAMSERVICES/api/CargoMobileAppCorp/GetOriginsAndDestinations'));

    if (response.statusCode == 200) {
      setState(() {
        _allCountries = json.decode(response.body);
        _filteredCountries = _allCountries;
        sortCountries();
      });
    } else {
      throw Exception('Failed to load countries');
    }
  }

  void filterCountries() {
    String query = _searchController.text.toLowerCase();
    setState(() {
      _filteredCountries = _allCountries
          .where((country) => country['name'].toLowerCase().contains(query))
          .toList();
    });
  }

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
              primaryColor: const Color(0xFF193E7F),
              hintColor: const Color(0xFF193E7F),
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
              dialogBackgroundColor: Colors.lightBlue[50],
              colorScheme: ColorScheme.light(
                primary: const Color(0xFF193E7F),
              ),
            ),
            child: child!,
          );
        });
    if (picked != null && picked != _selectedDate)
      setState(() {
        _selectedDate = picked;
      });
  }

  void _toggleCollapse() {
    setState(() {
      _isCollapsed = !_isCollapsed;
    });
  }

  void _showScrollableAlert(String title, List<String> flightDetails) {
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
                    fontSize: screenWidth * 0.01,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF193E7F),
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Container(
                  height: screenHeight * 0.7,
                  child: SingleChildScrollView(
                    child: Column(
                      children: flightDetails.map((flight) {
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 10.0),
                          child: Text(
                            flight,
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              fontSize: screenWidth * 0.006,
                              color: const Color(0xFF193E7F),
                            ),
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF193E7F),
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
                        fontSize: screenWidth * 0.08,
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

  void sortCountries() {
    _filteredCountries.sort((a, b) => a['name'].compareTo(b['name']));
  }

  Future<void> fetchFlightSchedule() async {
    setState(() {
      _isLoading = true;
    });

    String formattedDate =
        "${_selectedDate!.month}/${_selectedDate!.day}/${_selectedDate!.year}";
    String origin = _originCountryController.text;
    String destination = _destinationCountryController.text;
    print(origin);
    print(destination);

    // API URL to fetch flight schedule
    String url =
        "https://ulmobservices.srilankan.com/ULMOBTEAMSERVICES/api/CARGOUL/FLTSHL?FromCity=$origin&ToCity=$destination&FlightDate=$formattedDate";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);

        if (data.isNotEmpty) {
          List<String> flightDetails = data.map((flightInfo) {
            return '''
Flight Number: ${flightInfo['FlightNo']}
Flight Date: ${flightInfo['FlightDate']}
Aircraft Type: ${flightInfo['AircraftType']}
Arrival Time: ${flightInfo['Atime']}''';
          }).toList();

          setState(() {
            _flightDetails = flightDetails;
            print('Flight details updated: $_flightDetails');
          });
        } else {
          setState(() {
            _flightDetails = ['No flight schedule information available.'];
            print('No flight schedule information available.');
          });
        }
      } else {
        setState(() {
          _flightDetails = ['Failed to fetch flight schedule.'];
          print('Failed fetching flight schedule');
        });
      }
    } catch (e) {
      setState(() {
        _flightDetails = ['Error fetching flight schedule: $e'];
        print('Error fetching flight schedule: $e');
      });
    } finally {
      setState(() {
        _isLoading = false;
      });
    }
  }

  // Alert dialog for displaying information
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
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF193E7F),
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    color: const Color(0xFF193E7F),
                  ),
                ),
                SizedBox(height: screenHeight * 0.025),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF193E7F),
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

  Widget _buildOriginDestinationRow() {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    String originCountryName = _allCountries.firstWhere(
        (country) => country['code'] == _originCountryController.text)['name'];
    String destinationCountryName = _allCountries.firstWhere((country) =>
        country['code'] == _destinationCountryController.text)['name'];

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 5),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _originCountryController.text,
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF193E7F),
                  ),
                ),
                SizedBox(height: screenWidth * 0.006),
                Text(
                  originCountryName.split(' - ')[0],
                  style: TextStyle(
                    fontSize: screenWidth * 0.03,
                    color: const Color(0xFF193E7F),
                  ),
                )
              ],
            ),
          ),
          SizedBox(width: screenWidth * 0.04),

          // Airplane SVG in the middle
          Column(
            children: [
              SizedBox(
                height: screenHeight * 0.08,
                width: screenWidth * 0.5,
                child: Stack(
                  alignment: Alignment.center,
                  children: [
                    SizedBox(
                      height: screenHeight * 0.012,
                      width: screenWidth * 0.8,
                      child: Image.asset(
                        'assets/images/airplane_line.png',
                        fit: BoxFit.fill,
                        color: const Color(0xFF193E7F),
                      ),
                    ),
                    AnimatedAlign(
                      alignment:
                          _animate ? Alignment.center : Alignment.centerLeft,
                      duration: const Duration(seconds: 3),
                      curve: Curves.easeInOut,
                      child: SizedBox(
                        height: screenHeight * 0.07,
                        width: screenWidth * 0.14,
                        child: Image.asset(
                          'assets/images/airplane.png',
                          fit: BoxFit.contain,
                          color: const Color(0xFF193E7F),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              // Date below the airplane
              Text(
                _selectedDate == null
                    ? 'Select Flight Date'
                    : DateFormat('MM/dd/yyyy').format(_selectedDate!),
                style: TextStyle(
                  fontSize: screenWidth * 0.037,
                  fontWeight: FontWeight.bold,
                  color: _selectedDate == null
                      ? Color.fromARGB(255, 204, 203, 203)
                      : const Color(0xFF193E7F),
                ),
              ),
            ],
          ),
          SizedBox(width: screenWidth * 0.04),

          // Destination country
          Flexible(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  _destinationCountryController.text,
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF193E7F),
                  ),
                ),
                SizedBox(height: screenWidth * 0.006),
                Text(
                  destinationCountryName.split(' - ')[0],
                  style: TextStyle(
                    fontSize: screenWidth * 0.03,
                    color: const Color(0xFF193E7F),
                  ),
                ),
                SizedBox(height: screenWidth * 0.006),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFlightDetails() {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;

    // Simulating flight details fetching with delay
    Future<List<String>> _fetchFlightDetailsWithDelay() async {
      await Future.delayed(Duration(seconds: 2)); // Simulate network delay
      return _flightDetails; // Replace with actual API data fetching
    }

    return FutureBuilder<List<String>>(
      future: _fetchFlightDetailsWithDelay(),
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting ||
            snapshot.connectionState == ConnectionState.active) {
          // Display loading indicator while data is still being fetched
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          return Center(
              child: Text('No flight schedule information available.'));
        } else {
          final flightDetails = snapshot.data!;

          // Sorting the flight details by ascending order of Arrival Time
          flightDetails.sort((a, b) {
            final timeA = _extractTime(a);
            final timeB = _extractTime(b);
            return timeA.compareTo(timeB);
          });

          return SingleChildScrollView(
            child: Column(
              children: flightDetails.map((flightDetail) {
                final flightInfo =
                    flightDetail.split('\n'); // Adjust per data format

                if (flightInfo.length < 4) {
                  return Container(
                    child: Center(
                      child: Text(
                        'No Flights Available',
                        style: TextStyle(
                          color: const Color(0xFF193E7F),
                          fontSize: screenWidth * 0.045,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  );
                }

                final flightNom =
                    flightInfo[0].split(': ')[1]; // Extract flight number
                print(flightNom);
                final airlineCode = flightNom.substring(0, 2);
                print(airlineCode);
                final logoUrl =
                    'https://www.srilankan.com/images/airlinescodes/$airlineCode.png';

                return Card(
                  color: Color.fromARGB(255, 255, 255, 255),
                  margin: EdgeInsets.symmetric(vertical: screenHeight * 0.006),
                  child: Padding(
                    padding: EdgeInsets.symmetric(
                        vertical: screenHeight * 0.01,
                        horizontal: screenWidth * 0.03),
                    child: Row(
                      children: [
                        // Display the logo using the constructed URL
                        Container(
                          width: screenWidth * 0.12,
                          height: screenHeight * 0.06,
                          child: Image.network(
                            logoUrl,
                            errorBuilder: (context, error, stackTrace) {
                              return Center(
                                child: Icon(
                                  Icons.flight,
                                  color: const Color(0xFF193E7F),
                                  size: screenHeight * 0.06,
                                ),
                              );
                            },
                          ),
                        ),
                        SizedBox(width: screenWidth * 0.02),
                        // Flight Info
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '${flightInfo[0].split(': ')[1]} (${flightInfo[2].split(': ')[1]})',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.045,
                                  fontWeight: FontWeight.bold,
                                  color: const Color(0xFF193E7F),
                                ),
                              ),
                              Text(
                                'Flight No & Type',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.035,
                                  color: const Color(0xFF193E7F),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              flightInfo[3].split(': ')[1],
                              style: TextStyle(
                                fontSize: screenWidth * 0.045,
                                fontWeight: FontWeight.bold,
                                color: const Color(0xFF193E7F),
                              ),
                            ),
                            Text(
                              'Arrival Time',
                              style: TextStyle(
                                fontSize: screenWidth * 0.035,
                                color: const Color(0xFF193E7F),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
          );
        }
      },
    );
  }

  DateTime _extractTime(String flightDetail) {
    final flightInfo = flightDetail.split('\n');
    final arrivalTimeString = flightInfo[3].split(': ')[1];

    final timeParts = arrivalTimeString.split(':');
    final hour = int.parse(timeParts[0]);
    final minute = int.parse(timeParts[1]);

    return DateTime(0, 1, 1, hour, minute);
  }

  Future<void> _handleBackButton(BuildContext context) async {
    double screenWidth = MediaQuery.of(context).size.width;

    if (_fetched) {
      bool? shouldExit = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirm Exit'),
            titleTextStyle: TextStyle(
                color: const Color(0xFF193E7F),
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.06),
            content: Text(
                'Are you sure you want to leave? Flight information will be lost.'),
            contentTextStyle: TextStyle(
                color: const Color(0xFF193E7F), fontSize: screenWidth * 0.045),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  _canNavigate = false;
                  Navigator.of(context).pop(false); // Stay on the page
                },
                child: Text('Cancel',
                    style: TextStyle(
                        color: const Color(0xFF193E7F),
                        fontSize: screenWidth * 0.043)),
              ),
              TextButton(
                onPressed: () {
                  _canNavigate = true;
                  Navigator.of(context).pop(true); // Exit the page
                },
                child: Text('Yes',
                    style: TextStyle(
                        color: const Color(0xFF193E7F),
                        fontSize: screenWidth * 0.043)),
              ),
            ],
          );
        },
      );

      if (shouldExit == true) {
        _canNavigate = true;
        Navigator.of(context).pop(); // Perform the back navigation if confirmed
      }
    } else {
      _canNavigate = true;
      Navigator.of(context)
          .pop(); // Allow back navigation if no flight info is loaded
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double buttonPadding = screenWidth * 0.34;

    return WillPopScope(
      onWillPop: () async {
        await _handleBackButton(context);
        return false; // Prevents default back navigation
      },
      child: Scaffold(
        body: Stack(
          children: [
            // Top Banner Image (bottom layer)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/images/flight_schedule.png',
                fit: BoxFit.cover,
                height: screenHeight * .23,
              ),
            ),

            Positioned(
              top: screenHeight * 0.04,
              left: screenWidth * 0.001,
              child: SizedBox(
                width: screenWidth * .12,
                height: screenHeight * 0.04,
                child: BackButton(
                  color: Color.fromARGB(255, 255, 255, 255), // Icon color
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
                      color:
                          Color.fromARGB(255, 226, 223, 223).withOpacity(0.5),
                      spreadRadius: 1,
                      blurRadius: 1,
                      offset: Offset(0, 1),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Text(
                      'Flight Schedule',
                      style: TextStyle(
                        fontSize: screenWidth * 0.05,
                        fontWeight: FontWeight.w600,
                        color: const Color(0xFF193E7F),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    // Inner White Card with the Flight Form
                    AnimatedContainer(
                      duration: Duration(milliseconds: 300),
                      height: _isCollapsed ? buttonPadding * 0.7 : null,
                      padding: EdgeInsets.all(_isCollapsed ? 0 : 12),
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
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (!_isCollapsed) ...[
                            SizedBox(height: screenHeight * 0.01),
                            Text(
                              'Origin Country',
                              style: TextStyle(
                                fontSize: screenWidth * 0.035,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF193E7F),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.005),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.grey[100],
                                border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 206, 197, 197),
                                  width: 1.0,
                                ),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 12.0, top: 4),
                                child: DropdownSearch<String>(
                                  items: _filteredCountries
                                      .where((country) =>
                                          country['code'] !=
                                          _destinationCountryController.text)
                                      .map<String>((country) =>
                                          '${country['name']} (${country['code']})')
                                      .toList(),
                                  popupProps: PopupProps.menu(
                                    showSearchBox: true,
                                    searchFieldProps: TextFieldProps(
                                      decoration: InputDecoration(
                                        labelText: "Search Origin Country",
                                        labelStyle: TextStyle(
                                          color: Color.fromARGB(
                                              255, 160, 156, 156),
                                          fontSize: screenWidth * 0.035,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        hintStyle: TextStyle(
                                          color: Color.fromARGB(
                                              255, 178, 172, 172),
                                        ),
                                        filled:
                                            true, // Ensures background is filled
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: const Color.fromARGB(
                                                255, 204, 203, 203),
                                            width: 1.0,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: const Color.fromARGB(
                                                255, 204, 203, 203),
                                            width: 1.0,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: const Color.fromARGB(
                                                255, 204, 203, 203),
                                            width: 1.0,
                                          ),
                                        ),
                                      ),
                                      style: TextStyle(
                                        color:
                                            Color.fromARGB(255, 204, 203, 203),
                                        fontWeight: FontWeight.bold,
                                        fontSize: screenWidth * 0.035,
                                      ),
                                    ),
                                    menuProps: MenuProps(
                                      backgroundColor: Colors.white,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Colors.transparent),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                    itemBuilder: (context, item, isSelected) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: screenHeight * .01,
                                            horizontal: screenWidth * 0.03),
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? Color.fromARGB(
                                                  255, 135, 130, 130)
                                              : Colors.white,
                                        ),
                                        child: Text(
                                          item,
                                          style: TextStyle(
                                            color: isSelected
                                                ? Colors
                                                    .white // Highlight color change for selection
                                                : Color.fromARGB(
                                                    255, 135, 130, 130),
                                            fontWeight: isSelected
                                                ? FontWeight.bold
                                                : FontWeight.w500,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  dropdownDecoratorProps:
                                      DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                  dropdownButtonProps: DropdownButtonProps(
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      size: 32.0,
                                      color: const Color.fromARGB(
                                          255, 145, 145, 145),
                                    ),
                                  ),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      var selectedCountry = _filteredCountries
                                          .firstWhere((country) =>
                                              '${country['name']} (${country['code']})' ==
                                              newValue);
                                      _originCountryController.text =
                                          selectedCountry['code'];
                                    });
                                  },
                                  selectedItem: _originCountryController
                                          .text.isEmpty
                                      ? null
                                      : '${_filteredCountries.firstWhere((country) => country['code'] == _originCountryController.text)['name']} (${_originCountryController.text})',
                                  dropdownBuilder: (context, selectedItem) {
                                    return Text(
                                      selectedItem ?? "Select Origin Country",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: selectedItem == null
                                            ? Color.fromARGB(255, 204, 203, 203)
                                            : const Color.fromARGB(
                                                255, 135, 130, 130),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.01),
                            Text(
                              'Destination Country',
                              style: TextStyle(
                                fontSize: screenWidth * 0.035,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF193E7F),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.005),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.grey[100],
                                border: Border.all(
                                  color:
                                      const Color.fromARGB(255, 206, 197, 197),
                                  width: 1.0,
                                ),
                              ),
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 12.0, top: 4),
                                child: DropdownSearch<String>(
                                  items: _filteredCountries
                                      .where((country) =>
                                          country['code'] !=
                                          _originCountryController.text)
                                      .map<String>((country) =>
                                          '${country['name']} (${country['code']})')
                                      .toList(),
                                  popupProps: PopupProps.menu(
                                    showSearchBox: true,
                                    searchFieldProps: TextFieldProps(
                                      decoration: InputDecoration(
                                        labelText: "Search Destination Country",
                                        labelStyle: TextStyle(
                                          color: Color.fromARGB(
                                              255, 169, 165, 165),
                                          fontWeight: FontWeight.bold,
                                          fontSize: screenWidth * 0.035,
                                        ),
                                        hintStyle: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 204, 203, 203),
                                        ),
                                        filled:
                                            true, // Ensures the search box background is filled
                                        fillColor: Colors.white,
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey,
                                            width: 1.0,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey,
                                            width: 1.0,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey,
                                            width: 1.0,
                                          ),
                                        ),
                                      ),
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    menuProps: MenuProps(
                                      backgroundColor: Colors.white,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                        side: BorderSide(
                                            color: Colors.transparent),
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                    ),
                                    itemBuilder: (context, item, isSelected) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 16),
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? Color.fromARGB(
                                                  255, 123, 115, 115)
                                              : Colors.white,
                                        ),
                                        child: Text(
                                          item,
                                          style: TextStyle(
                                            color: isSelected
                                                ? Colors
                                                    .white // Highlight color change for selection
                                                : const Color.fromARGB(
                                                    255, 135, 130, 130),
                                            fontWeight: isSelected
                                                ? FontWeight.bold
                                                : FontWeight.w500,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                  dropdownDecoratorProps:
                                      DropDownDecoratorProps(
                                    dropdownSearchDecoration: InputDecoration(
                                      border: InputBorder.none,
                                    ),
                                  ),
                                  dropdownButtonProps: DropdownButtonProps(
                                    icon: Icon(
                                      Icons.arrow_drop_down,
                                      size: 32.0,
                                      color: const Color.fromARGB(
                                          255, 145, 145, 145),
                                    ),
                                  ),
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      var selectedCountry = _filteredCountries
                                          .firstWhere((country) =>
                                              '${country['name']} (${country['code']})' ==
                                              newValue);
                                      _destinationCountryController.text =
                                          selectedCountry['code'];
                                    });
                                  },
                                  selectedItem: _destinationCountryController
                                          .text.isEmpty
                                      ? null
                                      : '${_filteredCountries.firstWhere((country) => country['code'] == _destinationCountryController.text)['name']} (${_destinationCountryController.text})',
                                  dropdownBuilder: (context, selectedItem) {
                                    return Text(
                                      selectedItem ??
                                          "Select Destination Country",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: selectedItem == null
                                            ? Color.fromARGB(255, 204, 203, 203)
                                            : const Color.fromARGB(
                                                255, 135, 130, 130),
                                      ),
                                    );
                                  },
                                ),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.013),
                            Text(
                              'Flight Date',
                              style: TextStyle(
                                fontSize: screenWidth * 0.035,
                                fontWeight: FontWeight.w600,
                                color: const Color(0xFF193E7F),
                              ),
                            ),
                            GestureDetector(
                              onTap: () => _selectDate(context),
                              child: AbsorbPointer(
                                child: TextField(
                                  decoration: InputDecoration(
                                    hintText: _selectedDate == null
                                        ? 'MM/DD/YYYY'
                                        : DateFormat('MM/dd/yyyy')
                                            .format(_selectedDate!),
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
                                        vertical: 12.0, horizontal: 16.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                          SizedBox(height: screenHeight * 0.018),
                          Center(
                            child: SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Container(
                                height: screenHeight * 0.062,
                                width: screenWidth * 0.86,
                                child: ElevatedButton(
                                  onPressed: () {
                                    if (_isCollapsed) {
                                      setState(() {
                                        _isCollapsed = !_isCollapsed;
                                        _fetched = false;
                                        _flightDetails = [];
                                        _animate =
                                            false; // Reset to left position
                                      });
                                    } else {
                                      if (_originCountryController.text.isEmpty &&
                                          _destinationCountryController
                                              .text.isEmpty &&
                                          _selectedDate == null) {
                                        _showAlert('Incomplete Form',
                                            'Please enter origin country, destination country, and select date.');
                                        return;
                                      } else if (_originCountryController
                                          .text.isEmpty) {
                                        _showAlert('Incomplete Form',
                                            'Please enter origin country.');
                                        return;
                                      } else if (_destinationCountryController
                                          .text.isEmpty) {
                                        _showAlert('Incomplete Form',
                                            'Please enter destination country.');
                                        return;
                                      } else if (_selectedDate == null) {
                                        _showAlert('Incomplete Form',
                                            'Please select a date.');
                                        return;
                                      }
                              
                                      fetchFlightSchedule();
                                      _fetched = true;
                                      setState(() {
                                        _isCollapsed = !_isCollapsed;
                                        _animate = false; // Reset position
                                      });
                              
                                      // Trigger animation after a short delay
                                      Future.delayed(Duration(milliseconds: 100),
                                          () {
                                        setState(() {
                                          _animate = true; // Move to the center
                                        });
                                      });
                                    }
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: screenWidth * 0.2,
                                        vertical: screenHeight * 0.02),
                                    backgroundColor: const Color(0xFF193E7F),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      if (_isCollapsed) ...[
                                        Text(
                                          'Search More',
                                          style: TextStyle(
                                            fontSize: screenWidth * 0.035,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                          ),
                                        ),
                                        Icon(
                                          Icons.arrow_drop_down,
                                          color:
                                              Color.fromARGB(255, 255, 255, 255),
                                          size: screenWidth * 0.042,
                                        ),
                                      ] else ...[
                                        Text(
                                          'Submit',
                                          style: TextStyle(
                                            fontSize: screenWidth * 0.038,
                                            color: Color.fromARGB(
                                                255, 255, 255, 255),
                                          ),
                                        ),
                                      ],
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.0008),
                    Row(),
                    if (_fetched) ...[
                      _buildOriginDestinationRow(),
                    ],
                    if (_fetched) ...[
                      SizedBox(height: screenHeight * 0.018),
                      Container(
                        height: screenHeight * 0.44,
                        child: SingleChildScrollView(
                          physics: BouncingScrollPhysics(),
                          child: _buildFlightDetails(),
                        ),
                      ),
                    ],
                    SizedBox(height: screenHeight * 0.9),
                  ],
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
                        color: const Color(0xFF193E7F),
                      ),
                      label: 'Home',
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        'assets/images/contact_us_icon.svg',
                        height: screenHeight * .03,
                        width: screenWidth * .03,
                        color: const Color(0xFF193E7F),
                      ),
                      label: 'Contact Us',
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        'assets/images/about_us_icon.svg',
                        height: screenHeight * .03,
                        width: screenWidth * .03,
                        color: const Color(0xFF193E7F),
                      ),
                      label: 'About Us',
                    ),
                    BottomNavigationBarItem(
                      icon: SvgPicture.asset(
                        'assets/images/terms.svg',
                        height: screenHeight * .03,
                        width: screenWidth * .03,
                        color: const Color(0xFF193E7F),
                      ),
                      label: 'T&C',
                    ),
                  ],
                  selectedItemColor: const Color(0xFF193E7F),
                  unselectedItemColor: const Color(0xFF193E7F),
                  onTap: (index) {
                    _handleNavigation(index, context);
                  },
                ),
              )
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
                TermsAndConditionsPage(),
            transitionDuration: Duration(seconds: 0),
          ),
        );
      }
    }
  }
}