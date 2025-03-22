import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:srilankancargo_app/about_us_page.dart';
import 'package:srilankancargo_app/contact_us_page.dart';
import 'package:srilankancargo_app/main.dart';
import 'package:srilankancargo_app/terms_and_conditions.dart';

class LoadibilityPage extends StatefulWidget {
  @override
  _LoadibilityPageState createState() => _LoadibilityPageState();
}

class _LoadibilityPageState extends State<LoadibilityPage> {
  bool _isTiltedPermitted = false;
  String? _selectedAircraftType;
  String? _selectedCargoHold;
  bool _canNavigate = true;
  final TextEditingController _lengthController = TextEditingController();
  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final FocusNode _lengthFocusNode = FocusNode();
  final FocusNode _widthFocusNode = FocusNode();
  final FocusNode _heightFocusNode = FocusNode();

  bool _fetched = false;

  @override
  void dispose() {
    _lengthController.dispose();
    _widthController.dispose();
    _heightController.dispose();

    _lengthFocusNode.dispose();
    _widthFocusNode.dispose();
    _heightFocusNode.dispose();
    super.dispose();
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

  void _showAlertForIncomplete(String title, String message) {
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
                Icon(
                  Icons.error,
                  size: 65.0,
                  color: const Color(0xFF193E7F),
                ),
                SizedBox(height: screenHeight * 0.01),
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
                SizedBox(height: screenHeight * 0.02),
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

  void _showAlert(String flightType, String cargoHold,
      {bool isLoadable = true}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        double screenWidth = MediaQuery.of(context).size.width;
        double screenHeight = MediaQuery.of(context).size.height;

        return Dialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          child: Padding(
            padding: const EdgeInsets.all(23.0),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Icon(
                  isLoadable ? Icons.check_circle : Icons.cancel,
                  color: isLoadable
                      ? const Color.fromARGB(255, 101, 195, 104)
                      : const Color.fromARGB(255, 220, 83, 73),
                  size: 65.0,
                ),
                SizedBox(height: screenHeight * 0.01),

                Text(
                  isLoadable ? 'Loadable' : 'Not Loadable',
                  style: TextStyle(
                    fontSize: screenWidth * 0.055,
                    fontWeight: FontWeight.bold,
                    color: Color.fromARGB(255, 13, 3, 103),
                  ),
                ),
                SizedBox(height: screenHeight * 0.01),

                Text(
                  'Aircraft Type: $flightType\nCargo Hold: $cargoHold',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                      fontSize: screenWidth * 0.042,
                      color: Color.fromARGB(255, 11, 5, 108),
                      fontWeight: FontWeight.w500),
                ),
                SizedBox(height: screenHeight * 0.025),

                // Close button
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Color.fromARGB(
                          255, 5, 8, 110), // Matching button color
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      padding:
                          EdgeInsets.symmetric(vertical: screenHeight * 0.01),
                    ),
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'Close',
                      style: TextStyle(
                        fontSize: screenWidth * 0.045,
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
    _fetched = true;
    final length = double.tryParse(_lengthController.text);
    final width = double.tryParse(_widthController.text);
    final height = double.tryParse(_heightController.text);

    if (length == null) {
      _showAlertForIncomplete('Loadability', 'Please enter the length');
      return;
    }
    if (width == null) {
      _showAlertForIncomplete('Loadability', 'Please enter the width');
      return;
    }
    if (height == null) {
      _showAlertForIncomplete('Loadability', 'Please enter the height');
      return;
    }
    if (_selectedAircraftType == null) {
      _showAlertForIncomplete('Loadability', 'Please select the Aircraft Type');
      return;
    }
    if (_selectedCargoHold == null) {
      _showAlertForIncomplete('Loadability', 'Please select the cargo hold');
      return;
    }

    final isTilted = _isTiltedPermitted;

    if (!isTilted && _selectedAircraftType == "A330") {
      if (_selectedCargoHold == 'Forward Cargo Hold') {
        if ((height <= 165.0 && width <= 307.0 && length <= 237.0)) {
          _showAlert(_selectedAircraftType!, 'Forward Cargo hold',
              isLoadable: true);
        } else {
          _showAlert(_selectedAircraftType!, 'Forward Cargo hold',
              isLoadable: false);
        }
      } else if (_selectedCargoHold == 'After Cargo Hold') {
        if ((height <= 162.0 && width <= 307.0 && length <= 237.0)) {
          _showAlert(_selectedAircraftType!, 'After Cargo hold',
              isLoadable: true);
        } else {
          _showAlert(_selectedAircraftType!, 'After Cargo hold',
              isLoadable: false);
        }
      }
    } else if (isTilted && _selectedAircraftType == "A330") {
      if (_selectedCargoHold == 'Forward Cargo Hold') {
        if (height <= 25.0 && width <= 25.0 && length <= 1400.0) {
          _showAlert(_selectedAircraftType!, 'Forward Cargo hold',
              isLoadable: true);
        } else if (height <= 50.0 && width <= 50.0 && length <= 950.0) {
          _showAlert(_selectedAircraftType!, 'Forward Cargo hold',
              isLoadable: true);
        } else if (height <= 76.0 && width <= 76.0 && length <= 750.0) {
          _showAlert(_selectedAircraftType!, 'Forward Cargo hold',
              isLoadable: true);
        } else {
          _showAlert(_selectedAircraftType!, 'Forward Cargo hold',
              isLoadable: false);
        }
      } else if (_selectedCargoHold == 'After Cargo Hold') {
        if (height <= 25.0 && width <= 25.0 && length <= 1100.0) {
          _showAlert(_selectedAircraftType!, 'After Cargo hold',
              isLoadable: true);
        } else if (height <= 50.0 && width <= 50.0 && length <= 950.0) {
          _showAlert(_selectedAircraftType!, 'After Cargo hold',
              isLoadable: true);
        } else if (height <= 76.0 && width <= 76.0 && length <= 750.0) {
          _showAlert(_selectedAircraftType!, 'After Cargo hold',
              isLoadable: true);
        } else {
          _showAlert(_selectedAircraftType!, 'After Cargo hold',
              isLoadable: false);
        }
      }
    } else {
      if (isTilted && _selectedCargoHold == 'Forward Cargo Hold') {
        if (height <= 25.0 && width <= 25.0 && length <= 500.0) {
          _showAlert(_selectedAircraftType!, 'Forward Cargo hold',
              isLoadable: true);
        } else if (height <= 50.0 && width <= 50.0 && length <= 493.0) {
          _showAlert(_selectedAircraftType!, 'Forward Cargo hold',
              isLoadable: true);
        } else if (height <= 75.0 && width <= 75.0 && length <= 489.0) {
          _showAlert(_selectedAircraftType!, 'Forward Cargo hold',
              isLoadable: true);
        } else {
          _showAlert(_selectedAircraftType!, 'Forward Cargo hold',
              isLoadable: false);
        }
      } else if (isTilted && _selectedCargoHold == 'After Cargo Hold') {
        if (height <= 25.0 && width <= 25.0 && length <= 530.9) {
          _showAlert(_selectedAircraftType!, 'After Cargo hold',
              isLoadable: true);
        } else if (height <= 50.0 && width <= 50.0 && length <= 514.4) {
          _showAlert(_selectedAircraftType!, 'After Cargo hold',
              isLoadable: true);
        } else if (height <= 75.0 && width <= 75.0 && length <= 491.5) {
          _showAlert(_selectedAircraftType!, 'After Cargo hold',
              isLoadable: true);
        } else {
          _showAlert(_selectedAircraftType!, 'After Cargo hold',
              isLoadable: false);
        }
      } else if (isTilted && _selectedCargoHold == 'Rear (bulk) Cargo Hold') {
        if (height <= 25.0 && width <= 25.0 && length <= 323.0) {
          _showAlert(_selectedAircraftType!, 'Rear (bulk) Cargo hold',
              isLoadable: true);
        } else if (height <= 50.0 && width <= 50.0 && length <= 323.0) {
          _showAlert(_selectedAircraftType!, 'Rear (bulk) Cargo hold',
              isLoadable: true);
        } else if (height <= 75.0 && width <= 75.0 && length <= 323.0) {
          _showAlert(_selectedAircraftType!, 'Rear (bulk) Cargo hold',
              isLoadable: true);
        } else {
          _showAlert(_selectedAircraftType!, 'Rear (bulk) Cargo hold',
              isLoadable: false);
        }
      } else if (!isTilted) {
        if (_selectedCargoHold == 'Forward Cargo Hold' &&
            height <= 119.4 &&
            width <= 149.9 &&
            length <= 164.3) {
          _showAlert(_selectedAircraftType!, 'Forward Cargo hold',
              isLoadable: true);
        } else if (_selectedCargoHold == 'After Cargo Hold' &&
            height <= 119.4 &&
            width <= 149.9 &&
            length <= 171.5) {
          _showAlert(_selectedAircraftType!, 'After Cargo hold',
              isLoadable: true);
        } else if (_selectedCargoHold == 'Rear (bulk) Cargo Hold' &&
            height <= 122.8 &&
            width <= 149.9 &&
            length <= 174.8) {
          _showAlert(_selectedAircraftType!, 'Rear (bulk) Cargo hold',
              isLoadable: true);
        } else if (_selectedCargoHold == 'Forward Cargo Hold') {
          _showAlert(_selectedAircraftType!, 'Forward Cargo hold',
              isLoadable: false);
        } else if (_selectedCargoHold == 'After Cargo Hold') {
          _showAlert(_selectedAircraftType!, 'After Cargo Hold',
              isLoadable: false);
        } else if (_selectedCargoHold == 'Rear (bulk) Cargo Hold') {
          _showAlert(_selectedAircraftType!, 'Rear (bulk) Cargo hold',
              isLoadable: false);
        }
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

  Future<void> _handleBackButton(BuildContext context) async {
    double screenWidth = MediaQuery.of(context).size.width;

    if (_fetched) {
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
                'Are you sure you want to leave? Loadability information will be lost.'),
            contentTextStyle: TextStyle(
                color: Color.fromARGB(255, 21, 7, 110),
                fontSize: screenWidth * 0.045),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  _canNavigate = false;
                  Navigator.of(context).pop(false); // Stay on the page
                },
                child: Text('Cancel',
                    style: TextStyle(
                        color: Color.fromARGB(255, 25, 7, 138),
                        fontSize: screenWidth * 0.043)),
              ),
              TextButton(
                onPressed: () {
                  _canNavigate = true;
                  Navigator.of(context).pop(true); // Exit the page
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
    double buttonPadding = screenWidth * 0.128;
    Map<String, double> customizationValues = customizeFormCard(screenWidth);

    return WillPopScope(
      onWillPop: () async {
        await _handleBackButton(context);
        return false; // Prevents default back navigation
      },
      child: Scaffold(
        body: GestureDetector(
          onTap: () {
            FocusScope.of(context).unfocus(); // Dismiss the keyboard
          },
          child: Stack(
            children: [
              // Top Banner Image (bottom layer)
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Image.asset(
                  'assets/images/loadability.png',
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
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.w600,
                          color: const Color(0xFF193E7F),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.01),
                      // Inner White Card with the Flight Form
                      Container(
                        height: screenHeight * 0.65,
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
                        child: SingleChildScrollView(
                          padding: EdgeInsets.all(16),
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'Enter Details',
                                style: TextStyle(
                                  fontSize: screenWidth * 0.035,
                                  fontWeight: FontWeight.w600,
                                  color: const Color(0xFF193E7F),
                                ),
                              ),
                              Container(
                                constraints: BoxConstraints(
                                  maxHeight: screenHeight * 0.065,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color.fromARGB(255, 206, 197, 197),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: screenHeight * 0.019),
                                        child: TextField(
                                          controller: _lengthController,
                                          focusNode: _lengthFocusNode,
                                          decoration: InputDecoration(
                                            labelText: 'Length',
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.never,
                                            labelStyle: TextStyle(
                                              fontSize: screenWidth * 0.035,
                                              color: const Color.fromARGB(
                                                  255, 206, 197, 197),
                                              fontWeight: FontWeight.bold,
                                            ),
                                            border: InputBorder.none,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical:
                                                        screenHeight * 0.025),
                                          ),
                                          style: TextStyle(
                                            fontSize: screenWidth * 0.035,
                                            color: Color.fromARGB(
                                                255, 135, 130, 130),
                                            fontWeight: FontWeight.bold,
                                          ),
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  decimal: true),
                                          onEditingComplete: () {
                                            FocusScope.of(context)
                                                .requestFocus(_widthFocusNode);
                                          },
                                        ),
                                      ),
                                    ),
                                    // Unit (cm)
                                    Container(
                                      height: screenHeight * 0.08,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.0),
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 206, 197, 197),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(8.0),
                                          bottomRight: Radius.circular(8.0),
                                        ),
                                        border: Border.all(
                                          color: const Color.fromARGB(
                                              255, 206, 197, 197),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'cm',
                                          style: TextStyle(
                                            fontSize: screenWidth * 0.045,
                                            color:
                                                Color.fromARGB(255, 4, 20, 111),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              Container(
                                constraints: BoxConstraints(
                                  maxHeight: screenHeight * 0.065,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color.fromARGB(255, 206, 197, 197),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: screenWidth * 0.038),
                                        child: TextField(
                                          controller: _widthController,
                                          focusNode: _widthFocusNode,
                                          decoration: InputDecoration(
                                            labelText: 'Width',
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.never,
                                            labelStyle: TextStyle(
                                              fontSize: customizationValues[
                                                      'fontSize'] ??
                                                  14.0,
                                              color: const Color.fromARGB(
                                                  255, 206, 197, 197),
                                              fontWeight: FontWeight.bold,
                                            ),
                                            border: InputBorder.none,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical:
                                                        screenHeight * 0.025),
                                          ),
                                          style: TextStyle(
                                            fontSize: screenWidth * 0.035,
                                            color: const Color.fromARGB(
                                                255, 135, 130, 130),
                                            fontWeight: FontWeight.bold,
                                          ),
                                          keyboardType:
                                              TextInputType.numberWithOptions(
                                                  decimal: true),
                                          onEditingComplete: () {
                                            FocusScope.of(context)
                                                .requestFocus(_heightFocusNode);
                                          },
                                        ),
                                      ),
                                    ),
                                    // Unit (cm)
                                    Container(
                                      height: screenHeight * 0.08,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.0),
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 206, 197, 197),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(8.0),
                                          bottomRight: Radius.circular(8.0),
                                        ),
                                        border: Border.all(
                                          color: const Color.fromARGB(
                                              255, 206, 197, 197),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'cm',
                                          style: TextStyle(
                                            fontSize: screenWidth * 0.045,
                                            color:
                                                Color.fromARGB(255, 4, 20, 111),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.01),
                              Container(
                                constraints: BoxConstraints(
                                  maxHeight: screenHeight * 0.065,
                                ),
                                decoration: BoxDecoration(
                                  border: Border.all(
                                    color: Color.fromARGB(255, 206, 197, 197),
                                    width: 1.0,
                                  ),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: screenWidth * 0.038),
                                        child: TextField(
                                          controller: _heightController,
                                          focusNode: _heightFocusNode,
                                          decoration: InputDecoration(
                                            labelText: 'Height',
                                            floatingLabelBehavior:
                                                FloatingLabelBehavior.never,
                                            labelStyle: TextStyle(
                                              fontSize: screenWidth * 0.035,
                                              color: const Color.fromARGB(
                                                  255, 206, 197, 197),
                                              fontWeight: FontWeight.bold,
                                            ),
                                            border: InputBorder.none,
                                            contentPadding:
                                                EdgeInsets.symmetric(
                                                    vertical:
                                                        screenHeight * .025),
                                          ),
                                          style: TextStyle(
                                            fontSize: screenWidth * 0.035,
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
                                    // Unit (cm)
                                    Container(
                                      height: screenHeight * 0.08,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: 12.0),
                                      decoration: BoxDecoration(
                                        color:
                                            Color.fromARGB(255, 206, 197, 197),
                                        borderRadius: BorderRadius.only(
                                          topRight: Radius.circular(8.0),
                                          bottomRight: Radius.circular(8.0),
                                        ),
                                        border: Border.all(
                                          color: const Color.fromARGB(
                                              255, 206, 197, 197),
                                        ),
                                      ),
                                      child: Center(
                                        child: Text(
                                          'cm',
                                          style: TextStyle(
                                            fontSize: screenWidth * 0.045,
                                            color:
                                                Color.fromARGB(255, 4, 20, 111),
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 0),
                                child: Row(
                                  children: [
                                    Checkbox(
                                      value: _isTiltedPermitted,
                                      onChanged: (bool? newValue) {
                                        setState(() {
                                          _isTiltedPermitted =
                                              newValue ?? false;
                                        });
                                      },
                                      activeColor: const Color(0xFF193E7F),
                                      checkColor:
                                          Color.fromARGB(255, 255, 255, 255),
                                    ),
                                    Text(
                                      'Tilted Permitted',
                                      style: TextStyle(
                                        color: const Color(0xFF193E7F),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),

                              // Aircraft Type Dropdown
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenWidth * 0.003),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Aircraft Type',
                                      style: TextStyle(
                                          fontSize: screenWidth * 0.035,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF193E7F)),
                                    ),
                                    SizedBox(height: screenHeight * 0.003),
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255),
                                        border: Border.all(
                                            color: const Color.fromARGB(
                                                255, 206, 197, 197),
                                            width: 1.0),
                                      ),
                                      child: Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: screenWidth * 0.03),
                                        child: DropdownButton<String>(
                                          value: _selectedAircraftType,
                                          icon: Container(
                                            width: 20.0,
                                            height: 35.0,
                                            child: Icon(
                                              Icons.arrow_drop_down,
                                              size: 32.0,
                                              color: Color.fromARGB(
                                                  255, 145, 145, 145),
                                            ),
                                          ),
                                          iconSize: 30.0,
                                          underline: SizedBox(),
                                          style: TextStyle(
                                            fontSize: screenWidth * 0.035,
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
                                              fontSize: screenWidth * 0.035,
                                            ),
                                          ),
                                          isExpanded: true,
                                          items: [
                                            'A320',
                                            'A321',
                                            'A320neo',
                                            'A330'
                                          ].map((String value) {
                                            return DropdownMenuItem<String>(
                                              value: value,
                                              child: Text(value),
                                            );
                                          }).toList(),
                                          onChanged: (String? newValue) {
                                            setState(() {
                                              _selectedAircraftType = newValue;
                                              _selectedCargoHold = null;
                                            });
                                          },
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              SizedBox(height: screenHeight * 0.01),

                              // Cargo Hold Dropdown
                              Padding(
                                padding: EdgeInsets.symmetric(
                                    horizontal: screenHeight * 0.003),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Cargo Hold',
                                      style: TextStyle(
                                          fontSize: screenWidth * 0.035,
                                          fontWeight: FontWeight.w600,
                                          color: const Color(0xFF193E7F)),
                                    ),
                                    SizedBox(height: screenHeight * 0.002),
                                    Container(
                                      width: double.infinity,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                        color: const Color.fromARGB(
                                            255, 255, 255, 255),
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
                                            width: 20.0,
                                            height: 35.0,
                                            child: Icon(
                                              Icons.arrow_drop_down,
                                              size: 32.0,
                                              color: Color.fromARGB(
                                                  255, 145, 145, 145),
                                            ),
                                          ),
                                          iconSize: 30.0,
                                          underline: SizedBox(),
                                          style: TextStyle(
                                            fontSize: screenWidth * 0.035,
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
                                              fontSize: screenWidth * 0.035,
                                            ),
                                          ),
                                          isExpanded: true,
                                          items:
                                              (_selectedAircraftType == 'A330'
                                                      ? [
                                                          'Forward Cargo Hold',
                                                          'After Cargo Hold'
                                                        ]
                                                      : [
                                                          'Forward Cargo Hold',
                                                          'After Cargo Hold',
                                                          'Rear (bulk) Cargo Hold',
                                                        ])
                                                  .map((String value) {
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
                                height: screenHeight * .01,
                              ),
                              Center(
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    ElevatedButton(
                                      onPressed: clearSelections,
                                      style: ElevatedButton.styleFrom(
                                        foregroundColor:
                                            const Color(0xFF193E7F),
                                        backgroundColor: Colors.white,
                                        padding: EdgeInsets.symmetric(
                                            horizontal: buttonPadding,
                                            vertical: screenHeight * .01),
                                        side: BorderSide(
                                            color: const Color(0xFF193E7F),
                                            width: 1),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Text(
                                        'Clear',
                                        style: TextStyle(
                                            fontSize: screenWidth * 0.04,
                                            fontWeight: FontWeight.bold,
                                            color: const Color(0xFF193E7F)),
                                      ),
                                    ),
                                    SizedBox(width: screenWidth * 0.03),
                                    // Existing Submit Button
                                    ElevatedButton(
                                      onPressed: _lodabilityCheck,
                                      style: ElevatedButton.styleFrom(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: buttonPadding,
                                            vertical: screenHeight * 0.01),
                                        backgroundColor:
                                            const Color(0xFF193E7F),
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(10),
                                        ),
                                      ),
                                      child: Text(
                                        'Calculate',
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.04,
                                          color: Color.fromARGB(
                                              255, 255, 255, 255),
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
                                        fontSize: screenWidth * 0.035,
                                        color: const Color(0xFF193E7F),
                                        fontWeight: FontWeight.bold),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),

                      SizedBox(height: screenHeight * 0.3),
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
