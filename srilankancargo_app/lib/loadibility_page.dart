import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:srilankancargo_app/about_us_page.dart';
import 'package:srilankancargo_app/contact_us_page.dart';
import 'package:srilankancargo_app/main.dart';

class LoadibilityPage extends StatefulWidget {
  @override
  _LoadibilityPageState createState() => _LoadibilityPageState();
}

class _LoadibilityPageState extends State<LoadibilityPage> {
  bool _isTiltedPermitted = false;
  String? _selectedAircraftType;
  String? _selectedCargoHold;
  final TextEditingController _lengthController = TextEditingController();
  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _flightNumberController = TextEditingController();

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
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold,
                    color: const Color.fromARGB(
                        255, 28, 31, 106), // You can tweak this color to match
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
                SizedBox(height: 20.0),
                SizedBox(
                  width: double.infinity, // Make button take full width
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color.fromARGB(
                          255, 28, 31, 106), // Button color
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(10.0), // Rounded corners
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

  void _lodabilityCheck() {
    final length = double.tryParse(_lengthController.text);
    final width = double.tryParse(_widthController.text);
    final height = double.tryParse(_heightController.text);

    if (length == null) {
      _showAlert('Loadability', 'Please enter the length');
      return;
    }
    if (width == null) {
      _showAlert('Loadability', 'Please enter the width');
      return;
    }
    if (height == null) {
      _showAlert('Loadability', 'Please enter the height');
      return;
    }
    if (_selectedAircraftType == null) {
      _showAlert('Loadability', 'Please select the Aircraft Type');
      return;
    }
    if (_selectedCargoHold == null) {
      _showAlert('Loadability', 'Please select the cargo hold');
      return;
    }

    final isTilted = _isTiltedPermitted;

    if (isTilted && _selectedCargoHold == 'Forward Cargo Hold') {
      if (height <= 25.0 && width <= 25.0 && length <= 500.0) {
        _showAlert(_selectedAircraftType!,
            'You will be able to load your Item into Forward Cargo hold');
      } else if (height <= 50.0 && width <= 50.0 && length <= 493.0) {
        _showAlert(_selectedAircraftType!,
            'You will be able to load your Item into Forward Cargo hold');
      } else if (height <= 75.0 && width <= 75.0 && length <= 489.5) {
        _showAlert(_selectedAircraftType!,
            'You will be able to load your Item into Forward Cargo hold');
      } else {
        _showAlert(_selectedAircraftType!,
            'You will not be able to load your Item into Forward Cargo hold');
      }
    } else if (isTilted && _selectedCargoHold == 'After Cargo Hold') {
      if (height <= 25.0 && width <= 25.0 && length <= 530.9) {
        _showAlert(_selectedAircraftType!,
            'You will be able to load your Item into After Cargo hold');
      } else if (height <= 50.0 && width <= 50.0 && length <= 514.4) {
        _showAlert(_selectedAircraftType!,
            'You will be able to load your Item into After Cargo hold');
      } else if (height <= 75.0 && width <= 75.0 && length <= 491.5) {
        _showAlert(_selectedAircraftType!,
            'You will be able to load your Item into After Cargo hold');
      } else {
        _showAlert(_selectedAircraftType!,
            'You will not be able to load your Item into After Cargo hold');
      }
    } else if (isTilted && _selectedCargoHold == 'Rear (bulk) Cargo Hold') {
      if (height <= 25.0 && width <= 25.0 && length <= 324.0) {
        _showAlert(_selectedAircraftType!,
            'You will be able to load your Item into Rear (bulk) Cargo hold');
      } else if (height <= 50.0 && width <= 50.0 && length <= 324.0) {
        _showAlert(_selectedAircraftType!,
            'You will be able to load your Item into Rear (bulk) Cargo hold');
      } else if (height <= 75.0 && width <= 75.0 && length <= 324.0) {
        _showAlert(_selectedAircraftType!,
            'You will be able to load your Item into Rear (bulk) Cargo hold');
      } else {
        _showAlert(_selectedAircraftType!,
            'You will not be able to load your Item into Rear (bulk) Cargo hold');
      }
    } else if (!isTilted) {
      if (_selectedCargoHold == 'Forward Cargo Hold' &&
          height <= 119.4 &&
          width <= 149.9 &&
          length <= 164.3) {
        _showAlert(_selectedAircraftType!,
            'You will be able to load your Item into Forward Cargo hold');
      } else if (_selectedCargoHold == 'After Cargo Hold' &&
          height <= 119.4 &&
          width <= 149.9 &&
          length <= 171.5) {
        _showAlert(_selectedAircraftType!,
            'You will be able to load your Item into After Cargo hold');
      } else if (_selectedCargoHold == 'Rear (bulk) Cargo Hold' &&
          height <= 149.9 &&
          width <= 149.9 &&
          length <= 174.8) {
        _showAlert(_selectedAircraftType!,
            'You will be able to load your Item into Rear (bulk) Cargo hold');
      } else {
        _showAlert(_selectedAircraftType!,
            'You will not be able to load your Item into Cargo holds');
      }
    }
  }

  void clearSelections() {
    setState(() {
      _isTiltedPermitted = false;
      _selectedAircraftType = null;
      _selectedCargoHold = null;
      _lengthController.clear();
      _widthController.clear();
      _heightController.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double buttonPadding = screenWidth * 0.128;
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
              'assets/images/loadability.png',
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
                    'Loadability',
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
                          'Enter Details',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            color: Color.fromARGB(255, 28, 31, 106),
                          ),
                        ),
                        Container(
                          constraints: BoxConstraints(
                            maxHeight:
                                45, // Adjust this value to control the height
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color.fromARGB(
                                  255, 206, 197, 197), // Border color
                              width: 1.0, // Border width
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 14.0),
                                  child: TextField(
                                    controller: _lengthController,
                                    decoration: InputDecoration(
                                      labelText: 'Length',
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      labelStyle: TextStyle(
                                        fontSize:
                                            customizationValues['fontSize'] ??
                                                14.0,
                                        color: const Color.fromARGB(
                                            255, 206, 197, 197),
                                        fontWeight: FontWeight.bold,
                                      ),
                                      border: InputBorder.none,
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 15.0),
                                    ),
                                    style: TextStyle(
                                      fontSize:
                                          customizationValues['fontSize'] ??
                                              14.0,
                                      color: Color.fromARGB(255, 135, 130, 130),
                                      fontWeight: FontWeight.bold,
                                    ),
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            decimal: true),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 10),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 206, 197, 197),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(7.0),
                                    bottomRight: Radius.circular(7.0),
                                  ),
                                ),
                                child: Text(
                                  'cm',
                                  style: TextStyle(
                                    fontSize:
                                        customizationValues['fontSize'] ?? 16.0,
                                    color: const Color.fromARGB(255, 51, 51,
                                        51), // Ensure contrast for the "cm" label
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          constraints: BoxConstraints(
                            maxHeight:
                                45, // Adjust this value to control the height
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color.fromARGB(
                                  255, 206, 197, 197), // Border color
                              width: 1.0, // Border width
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: TextField(
                                    controller: _widthController,
                                    decoration: InputDecoration(
                                      labelText: 'Width',
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      labelStyle: TextStyle(
                                        fontSize:
                                            customizationValues['fontSize'] ??
                                                14.0,
                                        color: const Color.fromARGB(
                                            255, 206, 197, 197),
                                        fontWeight: FontWeight.bold,
                                      ),
                                      border: InputBorder.none,
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 15.0),
                                    ),
                                    style: TextStyle(
                                      fontSize:
                                          customizationValues['fontSize'] ??
                                              14.0,
                                      color: const Color.fromARGB(
                                          255, 135, 130, 130),
                                      fontWeight: FontWeight.bold,
                                    ),
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            decimal: true),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 10),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 206, 197, 197),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(7.0),
                                    bottomRight: Radius.circular(7.0),
                                  ),
                                ),
                                child: Text(
                                  'cm',
                                  style: TextStyle(
                                    fontSize:
                                        customizationValues['fontSize'] ?? 16.0,
                                    color: const Color.fromARGB(255, 51, 51,
                                        51), // Ensure contrast for the "cm" label
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15),
                        Container(
                          constraints: BoxConstraints(
                            maxHeight:
                                45, // Adjust this value to control the height
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color.fromARGB(
                                  255, 206, 197, 197), // Border color
                              width: 1.0, // Border width
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: TextField(
                                    controller: _heightController,
                                    decoration: InputDecoration(
                                      labelText: 'Height',
                                      floatingLabelBehavior:
                                          FloatingLabelBehavior.never,
                                      labelStyle: TextStyle(
                                        fontSize:
                                            customizationValues['fontSize'] ??
                                                14.0,
                                        color: const Color.fromARGB(
                                            255, 206, 197, 197),
                                        fontWeight: FontWeight.bold,
                                      ),
                                      border: InputBorder.none,
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 15.0),
                                    ),
                                    style: TextStyle(
                                      fontSize:
                                          customizationValues['fontSize'] ??
                                              14.0,
                                      color: const Color.fromARGB(
                                          255, 135, 130, 130),
                                      fontWeight: FontWeight.bold,
                                    ),
                                    keyboardType:
                                        TextInputType.numberWithOptions(
                                            decimal: true),
                                  ),
                                ),
                              ),
                              Container(
                                padding: EdgeInsets.symmetric(
                                    horizontal: 12.0, vertical: 10),
                                decoration: BoxDecoration(
                                  color:
                                      const Color.fromARGB(255, 206, 197, 197),
                                  borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(7.0),
                                    bottomRight: Radius.circular(7.0),
                                  ),
                                ),
                                child: Text(
                                  'cm',
                                  style: TextStyle(
                                    fontSize:
                                        customizationValues['fontSize'] ?? 16.0,
                                    color: const Color.fromARGB(255, 51, 51,
                                        51), // Ensure contrast for the "cm" label
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 0),
                          child: Row(
                            children: [
                              Checkbox(
                                value: _isTiltedPermitted,
                                onChanged: (bool? newValue) {
                                  setState(() {
                                    _isTiltedPermitted = newValue ?? false;
                                  });
                                },
                                activeColor: const Color.fromARGB(255, 28, 31,
                                    106), // Checkbox border and check color
                                checkColor: Color.fromARGB(255, 255, 255,
                                    255), // Color of the check mark
                              ),
                              Text(
                                'Tilted Permitted',
                                style: TextStyle(
                                  color: const Color.fromARGB(255, 28, 31, 106),
                                  fontWeight: FontWeight.bold, // Text color
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 5),
                        // Aircraft Type Dropdown
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Aircraft Type',
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
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 206, 197, 197),
                                      width: 1.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: DropdownButton<String>(
                                    value: _selectedAircraftType,
                                    icon: Container(
                                      width:
                                          20.0, // Adjust the width of the icon container
                                      height:
                                          35.0, // Adjust the height of the icon container
                                      child: Icon(
                                        Icons.arrow_drop_down,
                                        size: 32.0, // Size of the icon
                                        color: Color.fromARGB(255, 145, 145,
                                            145), // Color of the icon
                                      ),
                                    ),
                                    iconSize: 30.0,
                                    underline:
                                        SizedBox(), // Removes the default underline
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: const Color.fromARGB(
                                          255, 135, 130, 130),
                                    ),
                                    hint: Text(
                                      'Select Aircraft Type',
                                      style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 206, 197, 197),
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            customizationValues['fontSize'] ??
                                                14.0,
                                      ),
                                    ),
                                    isExpanded: true,
                                    items: ['A320', 'A321', 'A320neo']
                                        .map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedAircraftType = newValue;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 15.0),

                        // Cargo Hold Dropdown
                        Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 3.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Cargo Hold',
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
                                  color:
                                      const Color.fromARGB(255, 255, 255, 255),
                                  border: Border.all(
                                      color: const Color.fromARGB(
                                          255, 206, 197, 197),
                                      width: 1.0),
                                ),
                                child: Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 16.0),
                                  child: DropdownButton<String>(
                                    value: _selectedCargoHold,
                                    icon: Container(
                                      width:
                                          20.0, // Adjust the width of the icon container
                                      height:
                                          35.0, // Adjust the height of the icon container
                                      child: Icon(
                                        Icons.arrow_drop_down,
                                        size: 32.0, // Size of the icon
                                        color: Color.fromARGB(255, 145, 145,
                                            145), // Color of the icon
                                      ),
                                    ),
                                    iconSize: 30.0,
                                    underline:
                                        SizedBox(), // Removes the default underline
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      fontWeight: FontWeight.bold,
                                      color: const Color.fromARGB(
                                          255, 135, 130, 130),
                                    ),
                                    hint: Text(
                                      'Select Cargo Hold',
                                      style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 206, 197, 197),
                                        fontWeight: FontWeight.bold,
                                        fontSize:
                                            customizationValues['fontSize'] ??
                                                14.0,
                                      ),
                                    ),
                                    isExpanded: true,
                                    items: [
                                      'Forward Cargo Hold',
                                      'After Cargo Hold',
                                      'Rear (bulk) Cargo Hold',
                                    ].map((String value) {
                                      return DropdownMenuItem<String>(
                                        value: value,
                                        child: Text(value),
                                      );
                                    }).toList(),
                                    onChanged: (String? newValue) {
                                      setState(() {
                                        _selectedCargoHold = newValue;
                                      });
                                    },
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                        SizedBox(
                          height: 14,
                        ),
                        Center(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              ElevatedButton(
                                onPressed: clearSelections,
                                style: ElevatedButton.styleFrom(
                                  foregroundColor:
                                      Color.fromARGB(255, 28, 31, 106),
                                  backgroundColor: Colors.white,
                                  padding: EdgeInsets.symmetric(
                                      horizontal: buttonPadding,
                                      vertical: 10), // White fill
                                  side: BorderSide(
                                      color: Color.fromARGB(255, 28, 31, 106),
                                      width: 1), // Blue border
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ), // Text color
                                ),
                                child: Text(
                                  'Clear',
                                  style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold,
                                      color: Color.fromARGB(255, 28, 31, 106)),
                                ),
                              ),
                              const SizedBox(width: 8), // Space between buttons
                              // Existing Submit Button
                              ElevatedButton(
                                onPressed: _lodabilityCheck,
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: buttonPadding, vertical: 10),
                                  backgroundColor: Color.fromARGB(
                                      255, 28, 31, 106), // Blue fill
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                                child: Text(
                                  'Calculate',
                                  style: TextStyle(
                                    fontSize: 16,
                                    color: Color.fromARGB(
                                        255, 255, 255, 255), // White text color
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          padding: EdgeInsets.all(5.0),
                          child: Transform.translate(
                            offset: Offset(-1.0, 0.0),
                            child: Text(
                              'Maximum Weight per Package : 150Kg',
                              style: TextStyle(
                                  fontSize:
                                      customizationValues['fontSize'] ?? 12.0,
                                  color: Color.fromARGB(255, 28, 31, 106),
                                  fontWeight: FontWeight.bold),
                            ),
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
