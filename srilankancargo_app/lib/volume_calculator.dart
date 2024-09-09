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

    if (length <= 0 || width <= 0 || height <= 0 || numberOfPieces <= 0) {
      // Show an alert if any of the values are invalid
      showDialog(
        context: context,
        builder: (context) => AlertDialog(
          title: Text('Invalid Input'),
          content: Text('Please enter valid values for all fields.'),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        ),
      );
      return;
    }

    double total = (length * width * height * numberOfPieces);
    finalTotal = (finalTotal / 1000000) + (total / 1000000);

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

    // Print the array with details of each selection
    print('User Selections:');
    for (var selection in userSelections) {
      print(selection);
    }

    // Clear the input fields after calculation
  }

  void clearSelections() {
    setState(() {
      userSelections.clear();
      _lengthController.clear();
      _widthController.clear();
      _heightController.clear();
      _piecesController.clear();
    });
    print('Selections cleared');
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    Map<String, dynamic> customizationValues = customizeFormCard(screenWidth);

    return Scaffold(
      body: Stack(
        children: [
          // Top Banner Image (bottom layer)
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            child: Image.asset(
              'assets/images/volume_calculator.png',
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
                    'Volume Calculator',
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
                                      color: const Color.fromARGB(
                                          255, 135, 130, 130),
                                      fontWeight: FontWeight.bold,
                                    ),
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
                        SizedBox(
                          height: 14,
                        ),
                        Container(
                          constraints: BoxConstraints(
                            maxHeight: 45, // Controls the height
                          ),
                          decoration: BoxDecoration(
                            border: Border.all(
                              color: Color(
                                  0xFFCEC5C5), // Border color matching the image
                              width: 1.0,
                            ),
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                          child: Row(
                            children: [
                              Expanded(
                                flex:
                                    2, // Occupies 3 parts of the available space
                                child: Padding(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 0),
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color.fromARGB(255, 206, 197,
                                          197), // Light gray background color
                                      borderRadius: BorderRadius.circular(
                                          8.0), // Optional: rounded corners
                                    ),
                                    padding: EdgeInsets.symmetric(
                                        vertical: 10.0,
                                        horizontal:
                                            12.0), // Add padding inside the box
                                    child: Text(
                                      'Number of Pieces',
                                      style: TextStyle(
                                        fontSize: 14.0,
                                        color: Color(
                                            0xFF333333), // Dark text color
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                              Expanded(
                                flex:
                                    2, // Occupies 2 parts of the available space
                                child: Container(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 12.0, vertical: 0.0),
                                  child: TextField(
                                    controller: _piecesController,
                                    decoration: InputDecoration(
                                      border: OutlineInputBorder(
                                        borderSide: BorderSide
                                            .none, // Removes default border
                                        borderRadius:
                                            BorderRadius.circular(8.0),
                                      ),
                                      contentPadding:
                                          EdgeInsets.symmetric(vertical: 12.0),
                                      hintText:
                                          '', // You can add a placeholder if needed
                                    ),
                                    style: TextStyle(
                                      fontSize: 14.0,
                                      color: Color.fromARGB(
                                          255, 135, 130, 130), // Text color
                                      fontWeight: FontWeight.bold,
                                    ),
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
                                      horizontal: 52,
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
                                onPressed: () {
                                  calculateVolume();
                                },
                                style: ElevatedButton.styleFrom(
                                  padding: EdgeInsets.symmetric(
                                      horizontal: 52, vertical: 10),
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
                        const SizedBox(height: 50),
                        const Text(
                          'Details Per Cargo',
                          style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w900,
                            color: Color.fromARGB(255, 28, 31, 106),
                          ),
                        ),
                        ListView.builder(
                          shrinkWrap:
                              true, // Ensures it takes up only as much space as needed
                          physics:
                              NeverScrollableScrollPhysics(), // Prevents internal scrolling
                          itemCount:
                              cargoDetails.length, // Number of cargo entries
                          itemBuilder: (context, index) {
                            var cargo =
                                cargoDetails[index]; // Get each cargo's details

                            // Returning a card for each cargo entry
                            return Card(
                              margin: EdgeInsets.symmetric(vertical: 8.0),
                              child: ExpansionTile(
                                title: Text('Cargo ${cargo['pieces']} pcs'),
                                trailing: Icon(
                                  Icons.expand_more, // Arrow icon for expansion
                                  color: Colors.black,
                                ),
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.all(16.0),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text('Length: ${cargo['length']} cm'),
                                        Text('Width: ${cargo['width']} cm'),
                                        Text('Height: ${cargo['height']} cm'),
                                        Text('Pieces: ${cargo['pieces']}'),
                                        Text(
                                            'Volume (CBM): ${cargo['cbm'].toStringAsFixed(2)} m³'),
                                        Text(
                                            'Total CBM: ${cargo['finalCbm'].toStringAsFixed(2)} m³'),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            );
                          },
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
