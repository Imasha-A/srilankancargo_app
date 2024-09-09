import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:srilankancargo_app/about_us_page.dart';
import 'package:srilankancargo_app/contact_us_page.dart';
import 'package:srilankancargo_app/main.dart';

class FlightSchedulePage extends StatefulWidget {
  @override
  _FlightSchedulePageState createState() => _FlightSchedulePageState();
}

class _FlightSchedulePageState extends State<FlightSchedulePage> {
  final TextEditingController _flightNumberController = TextEditingController();
  DateTime? _selectedDate;

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

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
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
              'assets/images/flight_schedule.png',
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
                    color: Color.fromARGB(255, 226, 223, 223).withOpacity(0.5),
                    spreadRadius: 1,
                    blurRadius: 1,
                    offset: Offset(0, 1),
                  ),
                ],
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Text(
                    'Flight Schedule',
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w900,
                      color: Color.fromARGB(255, 28, 31, 106),
                    ),
                  ),

                  const SizedBox(height: 20),
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
                        SizedBox(height: 10),
                        Text(
                          'Origin Country',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                              color: Color.fromARGB(255, 28, 31, 106)),
                        ),
                        SizedBox(height: 3),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.grey[100],
                            border: Border.all(
                                color: const Color.fromARGB(255, 206, 197, 197),
                                width: 1.0),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: DropdownButton<String>(
                              icon: Container(
                                width:
                                    20.0, // Adjust the width of the icon container
                                height:
                                    35.0, // Adjust the height of the icon container
                                child: Icon(
                                  Icons.arrow_drop_down,
                                  size: 32.0, // Size of the icon
                                  color: const Color.fromARGB(
                                      255, 145, 145, 145), // Color of the icon
                                ),
                              ),
                              iconSize: 30.0,
                              underline: SizedBox(),
                              style: TextStyle(
                                fontSize: 14.0,
                                color: Color.fromARGB(255, 28, 31, 106),
                              ),
                              hint: Text(
                                'Select Origin Country',
                                style: TextStyle(
                                    color: Color.fromARGB(255, 204, 203, 203),
                                    fontWeight: FontWeight.w900,
                                    fontSize: customizationValues['fontSize'] ??
                                        14.0),
                              ),
                              isExpanded: true,
                              items: <String>[
                                'Country 1',
                                'Country 2',
                                'Country 3',
                                'Country 4'
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                // Handle origin country selection
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          'Destination Country',
                          style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w900,
                              color: Color.fromARGB(255, 28, 31, 106)),
                        ),
                        SizedBox(height: 3),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.grey[100],
                            border: Border.all(
                                color: const Color.fromARGB(255, 206, 197, 197),
                                width: 1.0),
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: DropdownButton<String>(
                              icon: Container(
                                width:
                                    20.0, // Adjust the width of the icon container
                                height:
                                    35.0, // Adjust the height of the icon container
                                child: Icon(
                                  Icons.arrow_drop_down,
                                  size: 32.0, // Size of the icon
                                  color: Color.fromARGB(
                                      255, 145, 145, 145), // Color of the icon
                                ),
                              ),
                              iconSize: 30.0,
                              underline: SizedBox(),
                              style: TextStyle(
                                  fontSize: 16.0,
                                  color:
                                      const Color.fromARGB(255, 119, 116, 116),
                                  fontWeight: FontWeight.bold),
                              hint: Text(
                                'Select Destination Country',
                                style: TextStyle(
                                    color: const Color.fromARGB(
                                        255, 204, 203, 203),
                                    fontWeight: FontWeight.bold,
                                    fontSize: customizationValues['fontSize'] ??
                                        14.0),
                              ),
                              isExpanded: true,
                              items: <String>[
                                'Country A',
                                'Country B',
                                'Country C',
                                'Country D'
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                // Handle destination country selection
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 15),
                        Text(
                          'Flight Date',
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
                                  fontSize:
                                      14, // Optional: Adjust font size as needed
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
                        Center(
                          child: ElevatedButton(
                            onPressed: () {
                              // Implement submit action here
                            },
                            style: ElevatedButton.styleFrom(
                              padding: EdgeInsets.symmetric(
                                  horizontal: 135, vertical: 10),
                              backgroundColor: Color.fromARGB(255, 28, 31, 106),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'Submit',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: Color.fromARGB(255, 255, 255, 255)),
                            ),
                          ),
                        ),
                        SizedBox(height: 20),
                      ],
                    ),
                  ),
                  const SizedBox(height: 350),
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
