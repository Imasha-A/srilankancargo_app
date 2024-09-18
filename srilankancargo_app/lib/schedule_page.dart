import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:srilankancargo_app/about_us_page.dart';
import 'package:srilankancargo_app/contact_us_page.dart';
import 'package:srilankancargo_app/main.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

import 'dart:io';
import 'package:http/io_client.dart';

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

  List<String> _flightDetails = [];

  @override
  void initState() {
    super.initState();
    fetchCountries();
    _searchController.addListener(() {
      filterCountries();
    });
  }

  Future<http.Client> createHttpClient() async {
    final ioc = new HttpClient();
    ioc.badCertificateCallback =
        (X509Certificate cert, String host, int port) => true;
    return IOClient(ioc);
  }

  Future<void> fetchCountries() async {
    final client = await createHttpClient(); // Use the custom client here

    final response = await client.get(Uri.parse(
        'https://ulmobservicestest.srilankan.com/ulrest/data/localdataC.js'));

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

  // Filter the list based on search input
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
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2000),
        lastDate: DateTime(2101),
        builder: (BuildContext context, Widget? child) {
          return Theme(
            data: ThemeData.light().copyWith(
              primaryColor: Color.fromARGB(
                  255, 28, 31, 106), // Selected date circle color
              hintColor:
                  Color.fromARGB(255, 28, 31, 106), // Accent color for buttons
              buttonTheme: ButtonThemeData(textTheme: ButtonTextTheme.primary),
              dialogBackgroundColor:
                  Colors.lightBlue[50], // Background color of the calendar
              colorScheme: ColorScheme.light(
                  primary: Color.fromARGB(
                      255, 28, 31, 106)), // Selected date circle color
              // Define any other customizations here
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

// Scrollable Alert dialog for displaying flight information
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
                    color: const Color.fromARGB(255, 28, 31, 106),
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                // Wrap the content in a scrollable widget
                Container(
                  height: screenHeight *
                      0.7, // Set a max height for the scrollable area
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
                              color: const Color.fromARGB(255, 28, 31, 106),
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
        "https://ulmobservicesstg.srilankan.com/ULMOBTEAMSERVICES/api/CARGOUL/FLTSHL?FromCity=$origin&ToCity=$destination&FlightDate=$formattedDate";

    try {
      final response = await http.get(Uri.parse(url));

      if (response.statusCode == 200) {
        List<dynamic> data = json.decode(response.body);

        if (data.isNotEmpty) {
          // Create a list of flight information strings
          List<String> flightDetails = data.map((flightInfo) {
            return '''
Flight Number: ${flightInfo['FlightNo']}
Flight Date: ${flightInfo['FlightDate']}
Aircraft Type: ${flightInfo['AircraftType']}
Arrival Time: ${flightInfo['Atime']}''';
          }).toList();

          setState(() {
            _flightDetails = flightDetails;
            print('Flight details updated: $_flightDetails'); // Debug print
          });
        } else {
          setState(() {
            _flightDetails = ['No flight schedule information available.'];
            print('No flight schedule information available.'); // Debug print
          });
        }
      } else {
        setState(() {
          _flightDetails = ['Failed to fetch flight schedule.'];
          print('Failed fetching flight schedule'); // Debug print
        });
      }
    } catch (e) {
      setState(() {
        _flightDetails = ['Error fetching flight schedule: $e'];
        print('Error fetching flight schedule: $e'); // Debug print
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
                    color: const Color.fromARGB(255, 28, 31, 106),
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),
                Text(
                  message,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: screenWidth * 0.04,
                    color: const Color.fromARGB(255, 28, 31, 106),
                  ),
                ),
                SizedBox(height: screenHeight * 0.025),
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
          // Origin country column with aligned text
          Flexible(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align country code and name
              children: [
                Text(
                  _originCountryController.text, // Origin country code
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 28, 31, 106),
                  ),
                ),
                SizedBox(height: screenWidth * 0.006),
                Text(
                  originCountryName
                      .split(' - ')[0], // Extract only the city part
                  style: TextStyle(
                    fontSize: screenWidth * 0.03,
                    color: Color.fromARGB(255, 28, 31, 106),
                  ),
                )
              ],
            ),
          ),
          SizedBox(width: screenWidth * 0.04),

          // Airplane SVG in the middle
          Padding(
            padding: EdgeInsets.only(
                bottom: screenHeight * 0.001), // Move it slightly up
            child: SvgPicture.asset(
              'assets/images/airplane_line.svg',
              height: screenHeight * 0.085,
              color: Color.fromARGB(
                  255, 27, 31, 127), // Keep the same size for the airplane icon
            ),
          ),
          SizedBox(width: screenWidth * 0.04),

          // Destination country column with aligned text
          Flexible(
            child: Column(
              crossAxisAlignment:
                  CrossAxisAlignment.start, // Align country code and name
              children: [
                Text(
                  _destinationCountryController
                      .text, // Destination country code
                  style: TextStyle(
                    fontSize: screenWidth * 0.06,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 28, 31, 106),
                  ),
                ),
                SizedBox(height: screenWidth * 0.006),
                Text(
                  destinationCountryName
                      .split(' - ')[0], // Extract only the city part
                  style: TextStyle(
                    fontSize: screenWidth * 0.03,
                    color: Color.fromARGB(255, 28, 31, 106),
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFlightDetails() {
    double screenWidth = MediaQuery.of(context).size.width;

    // Define a function that simulates a delay
    Future<List<String>> _fetchFlightDetailsWithDelay() async {
      // Simulate a delay of 2 seconds
      await Future.delayed(Duration(seconds: 2));

      // Return flight details after the delay
      return _flightDetails;
    }

    return FutureBuilder<List<String>>(
      future: _fetchFlightDetailsWithDelay(),
      builder: (BuildContext context, AsyncSnapshot<List<String>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          // While waiting for the delay, show a loading indicator
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          // Handle any errors
          return Center(child: Text('Error: ${snapshot.error}'));
        } else if (!snapshot.hasData || snapshot.data!.isEmpty) {
          // If no data or empty list, show a message
          return Center(
              child: Text('No flight schedule information available.'));
        } else {
          // Build the flight details if data is available
          final flightDetails = snapshot.data!;
          return SingleChildScrollView(
            child: Column(
              children: flightDetails.map((flightDetail) {
                final flightInfo = flightDetail
                    .split('\n'); // Adjust as per actual data format

                // Ensure flightInfo has enough elements
                if (flightInfo.length < 4) {
                  return Card(
                    color: Color.fromARGB(255, 251, 250, 255),
                    margin: EdgeInsets.symmetric(vertical: 3.5, horizontal: 0),
                    child: Padding(
                      padding: EdgeInsets.only(left: 125.0, top: 7, bottom: 7),
                      child: ListTile(
                        title: Text(
                          'No Flights',
                          style: TextStyle(
                            color: Color.fromARGB(255, 28, 31, 106),
                            fontSize: screenWidth * 0.05,
                          ),
                        ),
                      ),
                    ),
                  );
                }

                return Card(
                  color: Color.fromARGB(255, 251, 250, 255),
                  margin: EdgeInsets.symmetric(vertical: 3.5, horizontal: 0),
                  child: Padding(
                    padding: EdgeInsets.only(left: 100.0, top: 7, bottom: 7),
                    child: ListTile(
                      title: Text(
                          'Flight Number: ${flightInfo[0].split(': ')[1]}'),
                      titleTextStyle: TextStyle(
                          fontSize: screenWidth * 0.041,
                          color: Color.fromARGB(255, 10, 6, 33)),
                      subtitleTextStyle: TextStyle(
                          fontSize: screenWidth * 0.04,
                          color: Color.fromARGB(255, 4, 3, 21)),
                      subtitle: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                              'Aircraft Type: ${flightInfo[2].split(': ')[1]}'),
                          Text('Arrival Time: ${flightInfo[3].split(': ')[1]}'),
                        ],
                      ),
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

  Future<void> _handleBackButton(BuildContext context) async {
    double screenWidth = MediaQuery.of(context).size.width;

    if (_fetched) {
      bool? shouldExit = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirm Exit'),
            titleTextStyle: TextStyle(
                color: Color.fromARGB(255, 17, 4, 100),
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.06),
            content: Text(
                'Are you sure you want to leave? Flight info will be lost.'),
            contentTextStyle: TextStyle(
                color: Color.fromARGB(255, 25, 7, 138),
                fontSize: screenWidth * 0.04),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false); // Stay on the page
                },
                child: Text('Cancel'),
              ),
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true); // Exit the page
                },
                child: Text('Yes'),
              ),
            ],
          );
        },
      );

      if (shouldExit == true) {
        Navigator.of(context).pop(); // Perform the back navigation if confirmed
      }
    } else {
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
        // Calls your custom back button handler
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
                height: 185,
              ),
            ),
            Positioned(
              top: screenHeight * 0.025,
              left: screenWidth * 0.0012,
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
                        fontWeight: FontWeight.w900,
                        color: Color.fromARGB(255, 28, 31, 106),
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.01),
                    // Inner White Card with the Flight Form
                    AnimatedContainer(
                      duration:
                          Duration(milliseconds: 300), // Animation duration
                      height: _isCollapsed
                          ? buttonPadding * 0.7
                          : null, // Adjust height when collapsed
                      padding: EdgeInsets.all(
                          _isCollapsed ? 0 : 12), // Adjust padding
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
                                fontWeight: FontWeight.w900,
                                color: Color.fromARGB(255, 28, 31, 106),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.005),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.grey[100], // Fill color
                                border: Border.all(
                                  color: const Color.fromARGB(
                                      255, 206, 197, 197), // Border color
                                  width: 1.0,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: DropdownSearch<String>(
                                  items: _allCountries
                                      .map<String>((country) =>
                                          country['name'] as String)
                                      .toList(),
                                  popupProps: PopupProps.menu(
                                    showSearchBox: true,
                                    searchFieldProps: TextFieldProps(
                                      decoration: InputDecoration(
                                        labelText: "Search Origin Country",
                                        labelStyle: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 204, 203, 203),
                                          fontSize: screenWidth * 0.035,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        hintStyle: TextStyle(
                                          color: Colors.grey,
                                        ),
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
                                          color: const Color.fromARGB(
                                              255, 204, 203, 203),
                                          fontWeight: FontWeight.bold,
                                          fontSize: screenWidth * 0.035),
                                    ),
                                    itemBuilder: (context, item, isSelected) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: screenHeight * .01,
                                            horizontal: screenWidth * 0.03),
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? Color.fromARGB(255, 97, 95, 95)
                                              : Colors.white,
                                        ),
                                        child: Text(
                                          item,
                                          style: TextStyle(
                                            color: isSelected
                                                ? Color.fromARGB(
                                                    255, 163, 133, 133)
                                                : Color.fromARGB(
                                                    255, 208, 202, 202),
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
                                      var selectedCountry =
                                          _allCountries.firstWhere((country) =>
                                              country['name'] == newValue);
                                      _originCountryController.text =
                                          selectedCountry[
                                              'code']; // Save the code of the selected country
                                    });
                                  },
                                  selectedItem: _originCountryController
                                          .text.isEmpty
                                      ? null
                                      : _allCountries.firstWhere((country) =>
                                          country['code'] ==
                                          _originCountryController
                                              .text)['name'],
                                  dropdownBuilder: (context, selectedItem) {
                                    return Text(
                                      selectedItem ?? "Select Origin Country",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: selectedItem == null
                                            ? const Color.fromARGB(
                                                255, 204, 203, 203)
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
                                fontSize: 14,
                                fontWeight: FontWeight.w900,
                                color: Color.fromARGB(255, 28, 31, 106),
                              ),
                            ),
                            SizedBox(height: screenHeight * 0.005),
                            Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8.0),
                                color: Colors.grey[100], // Fill color
                                border: Border.all(
                                  color: const Color.fromARGB(
                                      255, 206, 197, 197), // Border color
                                  width: 1.0,
                                ),
                              ),
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: DropdownSearch<String>(
                                  items: _filteredCountries
                                      .map<String>((country) =>
                                          country['name'] as String)
                                      .toList(),
                                  popupProps: PopupProps.menu(
                                    showSearchBox: true,
                                    searchFieldProps: TextFieldProps(
                                      decoration: InputDecoration(
                                        labelText: "Search Destination Country",
                                        labelStyle: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 204, 203, 203),
                                          fontWeight: FontWeight.bold,
                                        ),
                                        hintStyle: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 204, 203, 203),
                                        ),
                                        border: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors.grey, // Border color
                                            width: 1.0,
                                          ),
                                        ),
                                        enabledBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors
                                                .grey, // Border color when enabled
                                            width: 1.0,
                                          ),
                                        ),
                                        focusedBorder: OutlineInputBorder(
                                          borderSide: BorderSide(
                                            color: Colors
                                                .grey, // Border color when focused
                                            width: 1.0,
                                          ),
                                        ),
                                      ),
                                      style: TextStyle(
                                        color: Colors.grey,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    itemBuilder: (context, item, isSelected) {
                                      return Container(
                                        padding: EdgeInsets.symmetric(
                                            vertical: 8, horizontal: 16),
                                        decoration: BoxDecoration(
                                          color: isSelected
                                              ? Colors.grey[300]
                                              : Colors.white,
                                        ),
                                        child: Text(
                                          item,
                                          style: TextStyle(
                                            color: isSelected
                                                ? const Color.fromARGB(
                                                    255, 135, 130, 130)
                                                : const Color.fromARGB(
                                                    255, 208, 202, 202),
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
                                              country['name'] == newValue);
                                      _destinationCountryController.text =
                                          selectedCountry[
                                              'code']; // Save the code of the selected country
                                    });
                                  },
                                  selectedItem:
                                      _destinationCountryController.text.isEmpty
                                          ? null
                                          : _filteredCountries.firstWhere(
                                              (country) =>
                                                  country['code'] ==
                                                  _destinationCountryController
                                                      .text)['name'],
                                  dropdownBuilder: (context, selectedItem) {
                                    return Text(
                                      selectedItem ??
                                          "Select Destination Country",
                                      style: TextStyle(
                                        fontWeight: FontWeight.bold,
                                        color: selectedItem == null
                                            ? const Color.fromARGB(
                                                255, 204, 203, 203)
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
                                  fontWeight: FontWeight.w900,
                                  color: Color.fromARGB(255, 28, 31, 106)),
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
                                          ? Color.fromARGB(255, 204, 203,
                                              203) // Default text color
                                          : const Color.fromARGB(255, 135, 130,
                                              130), // Text color when a date is selected
                                      fontWeight: FontWeight.bold,
                                      fontSize: screenWidth * 0.035,
                                    ),
                                    filled: true,
                                    fillColor:
                                        Color.fromARGB(255, 245, 245, 245),
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
                                          color: Color.fromARGB(
                                              255, 206, 197, 197),
                                          width: 0.1),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(10),
                                      borderSide: BorderSide(
                                        color: const Color.fromARGB(
                                            255,
                                            204,
                                            203,
                                            203), // Border color when unfocused
                                        width:
                                            1.0, // Border width when unfocused
                                      ),
                                    ),
                                    contentPadding: EdgeInsets.symmetric(
                                        vertical: 12.0, horizontal: 16.0),
                                  ),
                                ),
                              ),
                            ),
                          ],
                          SizedBox(height: screenHeight * 0.015),
                          Center(
                            child: Container(
                              height: screenHeight * 0.065,
                              width: screenWidth *
                                  0.86, // Fixed width for the button
                              child: ElevatedButton(
                                onPressed: () {
                                  if (_isCollapsed) {
                                    // Handle "More" button press
                                    clearFormFields(); // Clear the fields
                                    setState(() {
                                      _isCollapsed =
                                          !_isCollapsed; // Uncollapse the form
                                      _fetched = false; // Clear fetched data
                                      _flightDetails =
                                          []; // Clear flight details
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

                                    // Handle "Submit" button press
                                    fetchFlightSchedule(); // Fetch flight status
                                    _fetched = true;
                                    setState(() {
                                      _isCollapsed =
                                          !_isCollapsed; // Collapse the form
                                    });
                                  }
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: screenWidth * 0.2,
                                      vertical: screenHeight * 0.02),
                                  backgroundColor:
                                      Color.fromARGB(255, 28, 31, 106),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment
                                      .end, // Aligns text and icon to the right
                                  mainAxisSize: MainAxisSize
                                      .min, // Ensures Row size is only as big as its children
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
                                        size: screenWidth * 0.05,
                                      ),
                                    ] else ...[
                                      Text(
                                        'Submit',
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.035,
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
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight * 0.001),
                    Row(),
                    if (_fetched) ...[
                      _buildOriginDestinationRow(), // Display the origin-destination row
                    ],
                    if (_fetched) ...[
                      Container(
                        height: screenHeight *
                            0.425, // Adjust height for scrollable details
                        child: SingleChildScrollView(
                          child:
                              _buildFlightDetails(), // Display flight details here
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
        // Bottom Navigation Bar
        bottomNavigationBar: BottomNavigationBar(
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
      ),
    );
  }

  void clearFormFields() {
    _originCountryController.clear();
    _destinationCountryController.clear();
    _selectedDate = null;
  }
}
