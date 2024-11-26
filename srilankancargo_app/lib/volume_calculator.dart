import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:srilankancargo_app/about_us_page.dart';
import 'package:srilankancargo_app/contact_us_page.dart';
import 'package:srilankancargo_app/main.dart';

class UserSelection {
  double length;
  double width;
  double height;
  double numberOfPieces;
  double total;
  double finalTotal;

  UserSelection({
    required this.length,
    required this.width,
    required this.height,
    required this.numberOfPieces,
    required this.total,
    required this.finalTotal,
  });

  Map<String, dynamic> toJson() {
    return {
      'length': length,
      'width': width,
      'height': height,
      'numberOfPieces': numberOfPieces,
      'total': total,
      'finalTotal': finalTotal,
    };
  }

  @override
  String toString() {
    return 'UserSelection(length: $length cm, width: $width cm, height: $height cm, numberOfPieces: $numberOfPieces, total: $total, Final total: $finalTotal)';
  }
}

class VolumeCalPage extends StatefulWidget {
  @override
  _VolumeCalPageState createState() => _VolumeCalPageState();
}

class _VolumeCalPageState extends State<VolumeCalPage> {
  List<UserSelection> userSelections = [];
  List<Map<String, dynamic>> cargoDetails = [];

  double finalTotal = 0;
  final TextEditingController _lengthController = TextEditingController();
  final TextEditingController _widthController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _piecesController = TextEditingController();
  final FocusNode _lengthFocusNode = FocusNode();
  final FocusNode _widthFocusNode = FocusNode();
  final FocusNode _heightFocusNode = FocusNode();
  final FocusNode _piecesFocusNode = FocusNode();
  bool _canNavigate = true;
  bool _fetched = false;

  @override
  void dispose() {
    _lengthController.dispose();
    _widthController.dispose();
    _heightController.dispose();
    _piecesController.dispose();
    _lengthFocusNode.dispose();
    _widthFocusNode.dispose();
    _heightFocusNode.dispose();
    _piecesFocusNode.dispose();
    super.dispose();
  }

  Map<String, dynamic> customizeFormCard(double screenWidth) {
    Map<String, dynamic> customizationValues = {};

    if (screenWidth == 1024) {
      // iPad Pro (12.9-inch)
      customizationValues['cardWidth'] = 800.0;
      customizationValues['cardHeight'] = 625.0;
      customizationValues['cardMargin'] = 60.0;
      customizationValues['cardOffset'] = 100.0;
      customizationValues['iconOffset'] = 734.5;
      customizationValues['buttonPadding'] = 38.0;
      customizationValues['fontSize'] = 15.0;
    }
    if (screenWidth == 834) {
      // iPad Pro (11-inch)
      customizationValues['cardWidth'] = 600.0;
      customizationValues['cardHeight'] = 635.0;
      customizationValues['cardMargin'] = 30.0;
      customizationValues['cardOffset'] = 40.0;
      customizationValues['iconOffset'] = 604.5;
      customizationValues['buttonPadding'] = 38.0;
      customizationValues['fontSize'] = 16.0;
    }
    if (screenWidth == 430) {
      // iPhone 15 Plus and Pro Max
      customizationValues['cardWidth'] = 335.0;
      customizationValues['cardHeight'] = 600.0;
      customizationValues['cardMargin'] = 30.0;
      customizationValues['cardOffset'] = -20.0;
      customizationValues['iconOffset'] = 145.5;
      customizationValues['buttonPadding'] = 26.0;
      customizationValues['fontSize'] = 11.0;
    } else if (screenWidth == 393) {
      // iPhone 15 and 15 Pro
      customizationValues['cardWidth'] = 800.0;
      customizationValues['cardHeight'] = 620.0;
      customizationValues['cardMargin'] = 30.0;
      customizationValues['cardOffset'] = -55.0;
      customizationValues['iconOffset'] = 734.5;
      customizationValues['buttonPadding'] = 38.0;
      customizationValues['fontSize'] = 13.0;
    } else if (screenWidth <= 600 && screenWidth > 400) {
      // Customization for medium-sized Android screens (Pixel 7 Pro API 29)
      customizationValues['cardMargin'] = 30.0;
      customizationValues['cardHeight'] = 620.0;
      customizationValues['cardOffset'] = -50.0;
      customizationValues['iconOffset'] = 192.5;
      customizationValues['buttonPadding'] = 30.0;
      customizationValues['appBarOffsetPercentage'] = 0.30;
      customizationValues['fontSize'] = 14.0;
    } else if (screenWidth == 375) {
      // iPhone SE
      customizationValues['cardWidth'] = 305.0;
      customizationValues['cardHeight'] = 570.0;
      customizationValues['cardMargin'] = 30.0;
      customizationValues['cardOffset'] = -92.0;
      customizationValues['iconOffset'] = 145.5;
      customizationValues['buttonPadding'] = 26.0;
      customizationValues['fontSize'] = 8.9;
    } else if (screenWidth >= 768) {
      // iPad or larger screens
      customizationValues['cardWidth'] = 620.0;
      customizationValues['cardHeight'] = 640.0;
      customizationValues['cardMargin'] = 56.0;
      customizationValues['cardOffset'] = 28.0;
      customizationValues['iconOffset'] = 538.5;
      customizationValues['buttonPadding'] = 54.0;
      customizationValues['fontSize'] = 16.0;
    } else if (screenWidth <= 768) {
      // iPad mini (6th Gen)
      customizationValues['cardWidth'] = 540.0;
      customizationValues['cardHeight'] = 630.0;
      customizationValues['cardMargin'] = 30.0;
      customizationValues['cardOffset'] = 60.0;
      customizationValues['iconOffset'] = 515.5;
      customizationValues['buttonPadding'] = 36.0;
      customizationValues['fontSize'] = 16.0;
    } else {
      customizationValues['cardWidth'] = 330.0;
      customizationValues['cardHeight'] = 620.0;
      customizationValues['cardMargin'] = 16.0;
      customizationValues['cardOffset'] = -60.0;
      customizationValues['iconOffset'] = 190.5;
      customizationValues['buttonPadding'] = 36.0;
      customizationValues['fontSize'] = 13.0;
    }

    return customizationValues;
  }

  Map<String, double> customizeAppBar(double screenWidth) {
    Map<String, double> customizationValues = {};

    if (screenWidth <= 600 && screenWidth >= 400) {
      // Customization for medium-sized Android screens (Pixel 7 Pro API 29)
      customizationValues['appBarOffsetPercentage'] = -0.60;
      customizationValues['titleXOffset'] = 84.0; // Adjust this value as needed
    }
    if (screenWidth == 430) {
      // Customization for iPhone 15 Plus
      customizationValues['appBarOffsetPercentage'] = -0.60;
      customizationValues['titleXOffset'] = 0.0; // Adjust this value as needed
    } else {
      // You can add specific customizations here
    }

    return customizationValues;
  }

  void calculateVolume() {
    double length = double.tryParse(_lengthController.text) ?? 0;
    double width = double.tryParse(_widthController.text) ?? 0;
    double height = double.tryParse(_heightController.text) ?? 0;
    double numberOfPieces = double.tryParse(_piecesController.text) ?? 0;
    double screenWidth = MediaQuery.of(context).size.width;

    if (length <= 0 || width <= 0 || height <= 0 || numberOfPieces <= 0) {
      // Show an alert if any of the values are invalid
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(12.0),
            ),
            title: Text(
              'Incomplete Form ',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Color.fromARGB(255, 28, 31, 106),
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.055,
              ),
            ),
            content: Text(
              "Please fill all the fields.",
              textAlign: TextAlign.center,
            ),
            actions: <Widget>[
              Center(
                child: SizedBox(
                  width: 250,
                  height: 50,
                  child: TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: Text(
                      'OK',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: screenWidth * 0.04,
                      ),
                    ),
                    style: TextButton.styleFrom(
                      backgroundColor: Color.fromARGB(255, 28, 31, 106),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8.0),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          );
        },
      );
      return;
    }

    double total = (length * width * height * numberOfPieces);
    finalTotal = (finalTotal / 1000000) + (total / 1000000);
    _fetched = true;

    setState(() {
      userSelections.add(UserSelection(
        length: length,
        width: width,
        height: height,
        numberOfPieces: numberOfPieces,
        total: total,
        finalTotal: finalTotal,
      ));
    });

    print('User Selections:');
    for (var selection in userSelections) {
      print(selection);
    }
    _lengthController.clear();
    _widthController.clear();
    _heightController.clear();
    _piecesController.clear();
    // Clear the input fields after calculation
  }

  double calculateTotalCBM(List<UserSelection> selections) {
    double totalCBM = 0;
    for (var selection in selections) {
      totalCBM += selection.finalTotal; // Accumulate the final CBM values
    }
    return totalCBM;
  }

  void clearSelections() {
    _fetched = false;
    setState(() {
      userSelections.clear();
      _lengthController.clear();
      _widthController.clear();
      _heightController.clear();
      _piecesController.clear();
    });
    print('Selections cleared');
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
                'Are you sure you want to leave? Your calculations will be lost.'),
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
    Map<String, dynamic> customizationValues = customizeFormCard(screenWidth);
    double totalCBM = calculateTotalCBM(userSelections);

    double buttonPadding = screenWidth * 0.128;

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
                  'assets/images/volume_calculator.png',
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
                    color: Color.fromARGB(255, 255, 255, 255),
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
                        'Volume Calculator',
                        style: TextStyle(
                          fontSize: screenWidth * 0.05,
                          fontWeight: FontWeight.w600,
                          color: Color.fromARGB(255, 28, 31, 106),
                        ),
                      ),

                      const SizedBox(height: 10),
                      // Inner White Card with the Flight Form
                      Container(
                        height: screenHeight * 0.635,
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
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        'Enter Details',
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.035,
                                          fontWeight: FontWeight.w600,
                                          color:
                                              Color.fromARGB(255, 28, 31, 106),
                                        ),
                                      ),
                                      SizedBox(height: screenHeight * 0.001),
                                      Row(
                                        children: [
                                          // Length Input
                                          Expanded(
                                            flex: 4,
                                            child: Container(
                                              height: screenHeight * 0.05,
                                              child: TextField(
                                                controller: _lengthController,
                                                focusNode: _lengthFocusNode,
                                                decoration: InputDecoration(
                                                  labelText: 'Length',
                                                  floatingLabelBehavior:
                                                      FloatingLabelBehavior
                                                          .never,
                                                  labelStyle: TextStyle(
                                                    fontSize:
                                                        screenWidth * 0.035,
                                                    color: Color(0xFFCEC5C5),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              206,
                                                              197,
                                                              197),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(8),
                                                      bottomLeft:
                                                          Radius.circular(8),
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              206,
                                                              197,
                                                              197),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(8),
                                                      bottomLeft:
                                                          Radius.circular(8),
                                                    ),
                                                  ),
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 10.0,
                                                          horizontal: 12.0),
                                                ),
                                                style: TextStyle(
                                                  fontSize: screenWidth * 0.035,
                                                  color: Color(0xFF878282),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                keyboardType: TextInputType
                                                    .numberWithOptions(
                                                        decimal: true),
                                                onEditingComplete: () {
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          _widthFocusNode);
                                                },
                                              ),
                                            ),
                                          ),
// Width Input
                                          Expanded(
                                            flex: 4,
                                            child: Container(
                                              height: screenHeight * 0.05,
                                              child: TextField(
                                                controller: _widthController,
                                                focusNode: _widthFocusNode,
                                                decoration: InputDecoration(
                                                  labelText: 'Width',
                                                  floatingLabelBehavior:
                                                      FloatingLabelBehavior
                                                          .never,
                                                  labelStyle: TextStyle(
                                                    fontSize:
                                                        screenWidth * 0.035,
                                                    color: Color(0xFFCEC5C5),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              206,
                                                              197,
                                                              197),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(0),
                                                      bottomLeft:
                                                          Radius.circular(0),
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              206,
                                                              197,
                                                              197),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(0),
                                                      bottomLeft:
                                                          Radius.circular(0),
                                                    ),
                                                  ),
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 10.0,
                                                          horizontal: 12.0),
                                                ),
                                                style: TextStyle(
                                                  fontSize: screenWidth * 0.035,
                                                  color: Color(0xFF878282),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                keyboardType: TextInputType
                                                    .numberWithOptions(
                                                        decimal: true),
                                                onEditingComplete: () {
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          _heightFocusNode);
                                                },
                                              ),
                                            ),
                                          ),

                                          // Height Input
                                          Expanded(
                                            flex: 4,
                                            child: Container(
                                              height: screenHeight * 0.05,
                                              child: TextField(
                                                controller: _heightController,
                                                focusNode: _heightFocusNode,
                                                decoration: InputDecoration(
                                                  labelText: 'Height',
                                                  floatingLabelBehavior:
                                                      FloatingLabelBehavior
                                                          .never,
                                                  labelStyle: TextStyle(
                                                    fontSize:
                                                        screenWidth * 0.035,
                                                    color: Color(0xFFCEC5C5),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              206,
                                                              197,
                                                              197),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(0),
                                                      bottomLeft:
                                                          Radius.circular(0),
                                                    ),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              206,
                                                              197,
                                                              197),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.only(
                                                      topLeft:
                                                          Radius.circular(0),
                                                      bottomLeft:
                                                          Radius.circular(0),
                                                    ),
                                                  ),
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                          vertical: 10.0,
                                                          horizontal: 12.0),
                                                ),
                                                style: TextStyle(
                                                  fontSize: screenWidth * 0.035,
                                                  color: Color(0xFF878282),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                keyboardType: TextInputType
                                                    .numberWithOptions(
                                                        decimal: true),
                                                onEditingComplete: () {
                                                  FocusScope.of(context)
                                                      .requestFocus(
                                                          _piecesFocusNode);
                                                },
                                              ),
                                            ),
                                          ),

// Unit (cm)
                                          Container(
                                            height: screenHeight * 0.05,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: 12.0),
                                            decoration: BoxDecoration(
                                              color: Color.fromARGB(
                                                  255, 206, 197, 197),
                                              borderRadius: BorderRadius.only(
                                                topRight: Radius.circular(8.0),
                                                bottomRight:
                                                    Radius.circular(8.0),
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
                                                  color: Color.fromARGB(
                                                      255, 4, 20, 111),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: screenHeight * 0.01),
// Number of Pieces and Calculate Button
                                      Row(
                                        children: [
                                          // Number of Pieces Input
                                          Expanded(
                                            flex: 5,
                                            child: Container(
                                              height: screenHeight * 0.05,
                                              child: TextField(
                                                controller: _piecesController,
                                                focusNode: _piecesFocusNode,
                                                decoration: InputDecoration(
                                                  labelText: 'Number of Pieces',
                                                  floatingLabelBehavior:
                                                      FloatingLabelBehavior
                                                          .never,
                                                  labelStyle: TextStyle(
                                                    fontSize:
                                                        screenWidth * 0.035,
                                                    color: Color(0xFFCEC5C5),
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                  enabledBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              206,
                                                              197,
                                                              197),
// Set your desired border color here
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  focusedBorder:
                                                      OutlineInputBorder(
                                                    borderSide: BorderSide(
                                                      color:
                                                          const Color.fromARGB(
                                                              255,
                                                              206,
                                                              197,
                                                              197),
                                                    ),
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            8.0),
                                                  ),
                                                  contentPadding:
                                                      EdgeInsets.symmetric(
                                                    vertical: 10.0,
                                                    horizontal: 12.0,
                                                  ),
                                                ),
                                                style: TextStyle(
                                                  fontSize: screenWidth * 0.035,
                                                  color: Color(0xFF878282),
                                                  fontWeight: FontWeight.bold,
                                                ),
                                                keyboardType:
                                                    TextInputType.number,
                                              ),
                                            ),
                                          ),

                                          SizedBox(width: screenWidth * 0.03),
                                          Expanded(
                                            flex: 5,
                                            child: ElevatedButton(
                                              onPressed: () {
                                                calculateVolume();
                                                FocusScope.of(context)
                                                    .unfocus();
                                              },
                                              style: ElevatedButton.styleFrom(
                                                padding: EdgeInsets.symmetric(
                                                    vertical: 10),
                                                backgroundColor: Color.fromARGB(
                                                    255, 28, 31, 106),
                                                shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(
                                                          10.0),
                                                ),
                                              ),
                                              child: Text(
                                                'Calculate',
                                                style: TextStyle(
                                                  fontSize: screenWidth * 0.04,
                                                  color: Colors.white,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                      SizedBox(height: screenHeight * 0.01),
                                    ],
                                  ),
                                ],
                              ),
                              Container(
                                height: screenHeight * 0.43,
                                padding: EdgeInsets.all(0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(10),
                                  color: Colors.white,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (userSelections != null &&
                                        userSelections.isNotEmpty) ...[
                                      Text(
                                        'Details per Cargo',
                                        style: TextStyle(
                                          fontSize: screenWidth * 0.035,
                                          fontWeight: FontWeight.bold,
                                          color:
                                              Color.fromARGB(255, 28, 31, 106),
                                        ),
                                      ),
                                    ],
                                    Expanded(
                                      child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        itemCount: userSelections.length,
                                        itemBuilder: (context, index) {
                                          final selection =
                                              userSelections[index];
                                          return Container(
                                            margin: EdgeInsets.symmetric(
                                              vertical: screenHeight * 0.005,
                                            ),
                                            decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(3),
                                              color: Colors.grey[200],
                                            ),
                                            child: ExpansionTile(
                                              tilePadding: EdgeInsets.symmetric(
                                                  horizontal:
                                                      screenWidth * 0.01),
                                              title: Text(
                                                'Cargo ${index + 1}',
                                                style: TextStyle(
                                                    fontSize:
                                                        screenWidth * 0.035,
                                                    fontWeight: FontWeight.w700,
                                                    color: Color.fromARGB(
                                                        255, 51, 51, 51)),
                                              ),
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.all(0.2),
                                                  child: Column(
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .spaceBetween,
                                                        children: [
                                                          Expanded(
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerLeft,
                                                              child: Text(
                                                                'Length: ${selection.length} cm',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        11),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Align(
                                                              alignment:
                                                                  Alignment
                                                                      .center,
                                                              child: Text(
                                                                'Width: ${selection.width} cm',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        screenWidth *
                                                                            0.025),
                                                              ),
                                                            ),
                                                          ),
                                                          Expanded(
                                                            child: Align(
                                                              alignment: Alignment
                                                                  .centerRight,
                                                              child: Text(
                                                                'Height: ${selection.height} cm',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        screenWidth *
                                                                            0.025),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                      SizedBox(
                                                          height: screenHeight *
                                                              0.005),
                                                      Row(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      right:
                                                                          20.0),
                                                              child: Text(
                                                                'Pieces: ${selection.numberOfPieces}',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        11),
                                                              ),
                                                            ),
                                                          ),
                                                          SizedBox(
                                                              width:
                                                                  screenWidth *
                                                                      0.02),
                                                          Align(
                                                            alignment: Alignment
                                                                .centerLeft,
                                                            child: Text(
                                                              'Cubic m: ${selection.finalTotal.toStringAsFixed(4)} m³',
                                                              style: TextStyle(
                                                                fontSize:
                                                                    screenWidth *
                                                                        0.025,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .bold,
                                                                color: Color
                                                                    .fromARGB(
                                                                        255,
                                                                        28,
                                                                        31,
                                                                        106),
                                                              ),
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                    Divider(),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        ElevatedButton(
                                          onPressed: clearSelections,
                                          style: ElevatedButton.styleFrom(
                                            foregroundColor: Color.fromARGB(
                                                255, 28, 31, 106),
                                            backgroundColor: Colors.white,
                                            padding: EdgeInsets.symmetric(
                                                horizontal: buttonPadding,
                                                vertical: 5),
                                            side: BorderSide(
                                                color: Color.fromARGB(
                                                    255, 28, 31, 106),
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
                                                color: Color.fromARGB(
                                                    255, 28, 31, 106)),
                                          ),
                                        ),
                                        Text(
                                          'Total: ${totalCBM.toStringAsFixed(4)} m³',
                                          style: TextStyle(
                                            fontSize: screenWidth * 0.045,
                                            fontWeight: FontWeight.bold,
                                            color: Color.fromARGB(
                                                255, 28, 31, 106),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: screenHeight * 0.15),
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
          MaterialPageRoute(
            builder: (context) => MyHomePage(title: 'Flutter Demo Home Page'),
          ),
        );
      } else if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ContactUsPage()),
        );
      } else if (index == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AboutUsPage()),
        );
      }
    }
  }
}
