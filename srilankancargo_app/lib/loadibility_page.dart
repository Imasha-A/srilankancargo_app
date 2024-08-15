import 'package:flutter/material.dart';

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

  Map<String, dynamic> customizeLoadibilityCard(double screenWidth) {
    Map<String, dynamic> customizationValues = {};

    if (screenWidth == 1024) {
      // iPad Pro (12.9-inch)
      customizationValues['cardWidth'] = 800.0;
      customizationValues['cardHeight'] = 645.0;
      customizationValues['cardMargin'] = 60.0;
      customizationValues['cardOffset'] = 100.0;
      customizationValues['iconOffset'] = 734.5;
      customizationValues['buttonPadding'] = 38.0;
      customizationValues['fontSize'] = 15.0;
    }
    if (screenWidth == 834) {
      // iPad Pro (11-inch)
      customizationValues['cardWidth'] = 600.0;
      customizationValues['cardHeight'] = 655.0;
      customizationValues['cardMargin'] = 30.0;
      customizationValues['cardOffset'] = 20.0;
      customizationValues['iconOffset'] = 604.5;
      customizationValues['buttonPadding'] = 38.0;
      customizationValues['fontSize'] = 16.0;
    }
    if (screenWidth == 430) {
      // iPhone 15 Plus and Pro Max
      customizationValues['cardWidth'] = 335.0;
      customizationValues['cardHeight'] = 620.0;
      customizationValues['cardMargin'] = 30.0;
      customizationValues['cardOffset'] = -40.0;
      customizationValues['iconOffset'] = 145.5;
      customizationValues['buttonPadding'] = 26.0;
      customizationValues['fontSize'] = 11.0;
    } else if (screenWidth == 393) {
      // iPhone 15 and 15 Pro
      customizationValues['cardWidth'] = 800.0;
      customizationValues['cardHeight'] = 640.0;
      customizationValues['cardMargin'] = 30.0;
      customizationValues['cardOffset'] = -85.0;
      customizationValues['iconOffset'] = 734.5;
      customizationValues['buttonPadding'] = 38.0;
      customizationValues['fontSize'] = 13.0;
    } else if (screenWidth <= 600 && screenWidth > 400) {
      // Customization for medium-sized Android screens (Pixel 7 Pro API 29)
      customizationValues['cardMargin'] = 30.0;
      customizationValues['cardHeight'] = 640.0;
      customizationValues['cardOffset'] = -90.0;
      customizationValues['iconOffset'] = 192.5;
      customizationValues['buttonPadding'] = 30.0;
      customizationValues['appBarOffsetPercentage'] = 0.30;
      customizationValues['fontSize'] = 14.0;
    } else if (screenWidth == 375) {
      // iPhone SE
      customizationValues['cardWidth'] = 305.0;
      customizationValues['cardHeight'] = 590.0;
      customizationValues['cardMargin'] = 30.0;
      customizationValues['cardOffset'] = -122.0;
      customizationValues['iconOffset'] = 145.5;
      customizationValues['buttonPadding'] = 26.0;
      customizationValues['fontSize'] = 8.9;
    } else if (screenWidth >= 768) {
      // iPad or larger screens
      customizationValues['cardWidth'] = 620.0;
      customizationValues['cardHeight'] = 660.0;
      customizationValues['cardMargin'] = 56.0;
      customizationValues['cardOffset'] = 08.0;
      customizationValues['iconOffset'] = 538.5;
      customizationValues['buttonPadding'] = 54.0;
      customizationValues['fontSize'] = 16.0;
    } else if (screenWidth <= 768) {
      // iPad mini (6th Gen)
      customizationValues['cardWidth'] = 540.0;
      customizationValues['cardHeight'] = 650.0;
      customizationValues['cardMargin'] = 30.0;
      customizationValues['cardOffset'] = 20.0;
      customizationValues['iconOffset'] = 515.5;
      customizationValues['buttonPadding'] = 36.0;
      customizationValues['fontSize'] = 16.0;
    } else {
      customizationValues['cardWidth'] = 330.0;
      customizationValues['cardHeight'] = 640.0;
      customizationValues['cardMargin'] = 16.0;
      customizationValues['cardOffset'] = -90.0;
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

  void _showAlert(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            TextButton(
              child: Text('Dismiss'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
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

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    Map<String, dynamic> customizationValues =
        customizeLoadibilityCard(screenWidth);
    Map<String, double> appBarCustomization = customizeAppBar(screenWidth);

    return Scaffold(
      appBar: AppBar(
        leading: Transform.translate(
          offset: Offset(8.0, -6.0),
          child: BackButton(color: Colors.white),
        ),
        title: Transform.translate(
          offset: Offset(appBarCustomization['titleXOffset'] ?? 0.0, -6.0),
          child: Text('Loadibility',
              style: TextStyle(
                  color: Colors.white, fontFamily: 'SriLankan Regular')),
        ),
        actions: [
          Transform.translate(
            offset: Offset(-10.0, -6.0),
            child: IconButton(
              onPressed: () {
                Navigator.popUntil(context, (route) => route.isFirst);
              },
              icon: Icon(Icons.home, color: Colors.white),
            ),
          ),
        ],
        backgroundColor: Color.fromARGB(255, 3, 75, 135),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Center(
          child: Transform.translate(
            offset: Offset(0.0, customizationValues['cardOffset'] ?? 0.0),
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5.0,
              margin: EdgeInsets.fromLTRB(
                customizationValues['cardMargin'] ?? 0.0,
                0.0,
                customizationValues['cardMargin'] ?? 0.0,
                16.0,
              ),
              surfaceTintColor: Color.fromARGB(255, 255, 255, 255),
              child: Container(
                width: customizationValues['cardWidth'] ?? double.infinity,
                height: customizationValues['cardHeight'] ?? double.infinity,
                child: Padding(
                  padding: const EdgeInsets.all(7.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      ClipRRect(
                        borderRadius:
                            BorderRadius.vertical(top: Radius.circular(15.0)),
                        child: Container(
                          color: Color.fromARGB(255, 3, 75, 135),
                          width: double.infinity,
                          padding: EdgeInsets.symmetric(vertical: 28.0),
                          child: Center(
                            child: Text(
                              'Loadibility Form',
                              style: TextStyle(
                                  fontSize: 10.83,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 14.0),

                      // Length Text Entry
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.grey[100],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: TextField(
                            controller: _lengthController,
                            decoration: InputDecoration(
                              labelText: 'Enter Length - cm',
                              labelStyle: TextStyle(
                                  fontSize:
                                      customizationValues['fontSize'] ?? 16.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                                fontSize:
                                    customizationValues['fontSize'] ?? 16.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(height: 14.0),

                      // Width Text Entry
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.grey[100],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: TextField(
                            controller: _widthController,
                            decoration: InputDecoration(
                              labelText: 'Enter Width - cm',
                              labelStyle: TextStyle(
                                  fontSize:
                                      customizationValues['fontSize'] ?? 16.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                                fontSize:
                                    customizationValues['fontSize'] ?? 16.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      SizedBox(height: 14.0),

                      // Height Text Entry
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.grey[100],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: TextField(
                            controller: _heightController,
                            decoration: InputDecoration(
                              labelText: 'Enter Height - cm',
                              labelStyle: TextStyle(
                                  fontSize:
                                      customizationValues['fontSize'] ?? 16.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                                fontSize:
                                    customizationValues['fontSize'] ?? 16.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),

                      SizedBox(height: 14.0),

                      // Tilted Permitted Checkbox
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: Row(
                          children: [
                            Checkbox(
                              value: _isTiltedPermitted,
                              onChanged: (bool? newValue) {
                                setState(() {
                                  _isTiltedPermitted = newValue ?? false;
                                });
                              },
                            ),
                            Text('Tilted Permitted'),
                          ],
                        ),
                      ),
                      SizedBox(height: 14.0),

                      // Aircraft Type Dropdown
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: DropdownButton<String>(
                          value: _selectedAircraftType,
                          hint: Text('Select Aircraft Type'),
                          items:
                              ['A320', 'A321', 'A320neo'].map((String value) {
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
                      SizedBox(height: 16.0),

                      // Cargo Hold Dropdown
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 8.0),
                        child: DropdownButton<String>(
                          value: _selectedCargoHold,
                          hint: Text('Select Cargo Hold'),
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
                      SizedBox(
                        height: 14,
                      ),
                      Center(
                        child: ElevatedButton(
                          onPressed: _lodabilityCheck,
                          child: Text(
                            'Calculate',
                            style: TextStyle(
                              fontSize: customizationValues['fontSize'] ?? 16.0,
                              color: Colors.white, // Text color
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                              backgroundColor: Color.fromARGB(255, 3, 75, 135)),
                        ),
                      ),

                      SizedBox(height: 14),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 0.5),
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Color.fromARGB(173, 196, 197, 201),
                        ),
                        child: Transform.translate(
                          offset: Offset(-1.0, 0.0),
                          child: Text(
                            'Maximum Weight per Package : 150Kg',
                            style: TextStyle(
                                fontSize:
                                    customizationValues['fontSize'] ?? 16.0,
                                color: Color.fromARGB(255, 3, 75, 135),
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
