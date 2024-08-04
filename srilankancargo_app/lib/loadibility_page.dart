import 'package:flutter/material.dart';

class LoadibilityPage extends StatefulWidget {
  @override
  _LoadibilityPageState createState() => _LoadibilityPageState();
}

class _LoadibilityPageState extends State<LoadibilityPage> {
  bool isTiltedPermitted = false;
  List<dynamic> _contacts = [];

  Map<String, dynamic> customizeLoadibilityCard(double screenWidth) {
    Map<String, dynamic> customizationValues = {};

    if (screenWidth == 1024) {
      // iPad Pro (12.9-inch)
      customizationValues['cardWidth'] = 800.0;
      customizationValues['cardHeight'] = 645.0;
      customizationValues['cardMargin'] = 60.0;
      customizationValues['cardOffset'] = 220.0;
      customizationValues['iconOffset'] = 734.5;
      customizationValues['buttonPadding'] = 38.0;
      customizationValues['fontSize'] = 15.0;
    }
    if (screenWidth == 834) {
      // iPad Pro (11-inch)
      customizationValues['cardWidth'] = 600.0;
      customizationValues['cardHeight'] = 655.0;
      customizationValues['cardMargin'] = 30.0;
      customizationValues['cardOffset'] = 140.0;
      customizationValues['iconOffset'] = 604.5;
      customizationValues['buttonPadding'] = 38.0;
      customizationValues['fontSize'] = 16.0;
    }
    if (screenWidth == 430) {
      // iPhone 15 Plus and Pro Max
      customizationValues['cardWidth'] = 335.0;
      customizationValues['cardHeight'] = 620.0;
      customizationValues['cardMargin'] = 30.0;
      customizationValues['cardOffset'] = 80.0;
      customizationValues['iconOffset'] = 145.5;
      customizationValues['buttonPadding'] = 26.0;
      customizationValues['fontSize'] = 11.0;
    } else if (screenWidth == 393) {
      // iPhone 15 and 15 Pro
      customizationValues['cardWidth'] = 800.0;
      customizationValues['cardHeight'] = 640.0;
      customizationValues['cardMargin'] = 30.0;
      customizationValues['cardOffset'] = 45.0;
      customizationValues['iconOffset'] = 734.5;
      customizationValues['buttonPadding'] = 38.0;
      customizationValues['fontSize'] = 13.0;
    } else if (screenWidth <= 600 && screenWidth > 400) {
      // Customization for medium-sized Android screens (Pixel 7 Pro API 29)
      customizationValues['cardMargin'] = 30.0;
      customizationValues['cardHeight'] = 640.0;
      customizationValues['cardOffset'] = 50.0;
      customizationValues['iconOffset'] = 192.5;
      customizationValues['buttonPadding'] = 30.0;
      customizationValues['appBarOffsetPercentage'] = 0.30;
      customizationValues['fontSize'] = 14.0;
    } else if (screenWidth == 375) {
      // iPhone SE
      customizationValues['cardWidth'] = 305.0;
      customizationValues['cardHeight'] = 590.0;
      customizationValues['cardMargin'] = 30.0;
      customizationValues['cardOffset'] = -2.0;
      customizationValues['iconOffset'] = 145.5;
      customizationValues['buttonPadding'] = 26.0;
      customizationValues['fontSize'] = 8.9;
    } else if (screenWidth >= 768) {
      // iPad or larger screens
      customizationValues['cardWidth'] = 620.0;
      customizationValues['cardHeight'] = 660.0;
      customizationValues['cardMargin'] = 56.0;
      customizationValues['cardOffset'] = 128.0;
      customizationValues['iconOffset'] = 538.5;
      customizationValues['buttonPadding'] = 54.0;
      customizationValues['fontSize'] = 16.0;
    } else if (screenWidth <= 768) {
      // iPad mini (6th Gen)
      customizationValues['cardWidth'] = 540.0;
      customizationValues['cardHeight'] = 650.0;
      customizationValues['cardMargin'] = 30.0;
      customizationValues['cardOffset'] = 160.0;
      customizationValues['iconOffset'] = 515.5;
      customizationValues['buttonPadding'] = 36.0;
      customizationValues['fontSize'] = 16.0;
    } else {
      customizationValues['cardWidth'] = 330.0;
      customizationValues['cardHeight'] = 640.0;
      customizationValues['cardMargin'] = 16.0;
      customizationValues['cardOffset'] = 30.0;
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
                      SizedBox(height: 20.0),

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
                      SizedBox(height: 20.0),

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
                      SizedBox(height: 20.0),

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

                      SizedBox(height: 20.0),

                      // Toggle Switch Container
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 0.9),
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.grey[100],
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Tilted Permitted?',
                              style: TextStyle(
                                  fontSize:
                                      customizationValues['fontSize'] ?? 16.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Switch(
                              value: isTiltedPermitted,
                              onChanged: (bool value) {
                                setState(() {
                                  isTiltedPermitted = value;
                                });
                                // Handle any other logic based on the switch state change
                              },
                              activeTrackColor: Color.fromARGB(255, 3, 75, 135),
                              activeColor: Colors.white,
                            ),
                          ],
                        ),
                      ),

                      SizedBox(height: 20.0),

                      // Aircraft Type Dropdown
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.grey[100],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: DropdownButton<String>(
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 36.0,
                            underline: SizedBox(),
                            style: TextStyle(
                                fontSize:
                                    customizationValues['fontSize'] ?? 16.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            hint: Text('Select Aircraft Type',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            isExpanded: true,
                            items: <String>['A320', 'A321', 'A320neo']
                                .map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              // Handle aircraft type selection
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),

                      // Cargo Hold Dropdown
                      Container(
                        width: double.infinity,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.grey[100],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: DropdownButton<String>(
                            icon: Icon(Icons.arrow_drop_down),
                            iconSize: 36.0,
                            underline: SizedBox(),
                            style: TextStyle(
                                fontSize:
                                    customizationValues['fontSize'] ?? 16.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                            hint: Text('Select Cargo Hold',
                                style: TextStyle(
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold)),
                            isExpanded: true,
                            items: <String>[
                              'Forward Cargo Hold',
                              'After Cargo Hold',
                              'Rear (bulk) Cargo Hold'
                            ].map((String value) {
                              return DropdownMenuItem<String>(
                                value: value,
                                child: Text(value),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              // Handle cargo hold selection
                            },
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),

                      // Container with Text
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.symmetric(horizontal: 0.5),
                        padding: EdgeInsets.all(16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.grey[100],
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
