import 'package:flutter/material.dart';

class VolumeCalculatorPage extends StatelessWidget {
  Map<String, dynamic> customizeVolumeCalculatorCard(double screenWidth) {
    Map<String, dynamic> customizationValues = {};

    if (screenWidth == 1024) { // iPad Pro (12.9-inch)
      customizationValues['cardWidth'] = 800.0;
      customizationValues['cardHeight'] = 600.0;
      customizationValues['cardMargin'] = 80.0;
      customizationValues['cardOffset'] = 270.0;
      customizationValues['fontSize'] = 16.0;
      customizationValues['buttonPadding'] = 36.0;
    } else if (screenWidth == 834) { // iPad Pro (11-inch)
      customizationValues['cardWidth'] = 600.0;
      customizationValues['cardHeight'] = 500.0;
      customizationValues['cardMargin'] = 70.0;
      customizationValues['cardOffset'] = 210.0;
      customizationValues['fontSize'] = 14.0;
      customizationValues['buttonPadding'] = 34.0;
    } else if (screenWidth >= 768) { // iPad or larger screens
      customizationValues['cardWidth'] = 620.0;
      customizationValues['cardHeight'] = 530.0;
      customizationValues['cardMargin'] = 66.0;
      customizationValues['cardOffset'] = 200.0;
      customizationValues['fontSize'] = 16.0;
      customizationValues['buttonPadding'] = 36.0;
    } else if (screenWidth == 375) {  // iPhone SE
      customizationValues['cardWidth'] = 305.0;
      customizationValues['cardHeight'] = 350.0;
      customizationValues['cardMargin'] = 38.0;
      customizationValues['cardOffset'] = 70.0;
      customizationValues['fontSize'] = 12.0;
      customizationValues['buttonPadding'] = 28.0;
    } else if (screenWidth == 393) { // iPhone 15
      customizationValues['cardWidth'] = 340.0;
      customizationValues['cardHeight'] = 450.0;
      customizationValues['cardMargin'] = 30.0;
      customizationValues['fontSize'] = 14.0;
      customizationValues['cardOffset'] = 75.0;
      customizationValues['buttonPadding'] = 30.0;
    } else if (screenWidth == 430) {  // iPhone 15 Plus
      customizationValues['cardWidth'] = 400.0;
      customizationValues['cardHeight'] = 500.0;
      customizationValues['cardMargin'] = 30.0;
      customizationValues['fontSize'] = 16.0;
      customizationValues['cardOffset'] = 120.0;
      customizationValues['buttonPadding'] = 32.0;
    } else if (screenWidth <= 600 && screenWidth > 400 && screenWidth < 430) {  // iPhone 15 Plus
      customizationValues['cardWidth'] = 400.0;
      customizationValues['cardHeight'] = 500.0;
      customizationValues['cardMargin'] = 30.0;
      customizationValues['fontSize'] = 16.0;
      customizationValues['cardOffset'] = 120.0;
      customizationValues['buttonPadding'] = 32.0;
    } else if (screenWidth <= 768) {  // iPad mini (6th Gen)
      customizationValues['cardWidth'] = 540.0;
      customizationValues['cardHeight'] = 550.0;
      customizationValues['cardMargin'] = 60.0;
      customizationValues['fontSize'] = 16.0;
      customizationValues['cardOffset'] = 185.0;
      customizationValues['buttonPadding'] = 36.0;
    } else if (screenWidth == 393) {  //iPhone 15 Pro
      customizationValues['cardWidth'] = 450.0;
      customizationValues['cardHeight'] = 600.0;
      customizationValues['cardMargin'] = 30.0;
      customizationValues['fontSize'] = 16.0;
      
      customizationValues['buttonPadding'] = 36.0;
    } else {
      customizationValues['cardWidth'] = 300.0;
      customizationValues['cardHeight'] = 400.0;
      customizationValues['cardMargin'] = 16.0;
      customizationValues['fontSize'] = 14.0;
      customizationValues['buttonPadding'] = 28.0;
    }

    return customizationValues;
  }

  Map<String, double> customizeAppBar(double screenWidth) {
    Map<String, double> customizationValues = {};

     if (screenWidth <= 600 && screenWidth >= 400) {
      // Customization for medium-sized Android screens (Pixel 7 Pro API 29)
      customizationValues['appBarOffsetPercentage'] = -0.60;
      customizationValues['titleXOffset'] = 45.0; // Adjust this value as needed
    } if (screenWidth == 430) {
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
    Map<String, dynamic> customizationValues = customizeVolumeCalculatorCard(screenWidth);
    Map<String, double> appBarCustomization = customizeAppBar(screenWidth);

    return Scaffold(
      appBar: AppBar(
        leading: Transform.translate(
          offset: Offset(8.0, -6.0),
          child: BackButton(color: Colors.white),
        ),
        title: Transform.translate(
          offset: Offset(appBarCustomization['titleXOffset'] ?? 0.0, -6.0),
          child: Text('Volume Calculator', style: TextStyle(color: Colors.white, fontFamily: 'SriLankan Regular')),
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
            child: Padding(
              padding: const EdgeInsets.all(7.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  ClipRRect(
                    borderRadius: BorderRadius.vertical(top: Radius.circular(15.0)),
                    child: Container(
                      color: Color.fromARGB(255, 3, 75, 135),
                      width: double.infinity,
                      padding: EdgeInsets.symmetric(vertical: 28.0),
                      child: Center(
                        child: Text(
                          'Dimensions',
                          style: TextStyle(fontSize: customizationValues['fontSize'] ?? 19.0, color: Colors.white, fontWeight: FontWeight.bold),
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
                          labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: customizationValues['fontSize'] ?? 19.0),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(fontSize: customizationValues['fontSize'] ?? 19.0, color: Colors.black, fontWeight: FontWeight.bold),
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
                          labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: customizationValues['fontSize'] ?? 19.0),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(fontSize: customizationValues['fontSize'] ?? 19.0, color: Colors.black, fontWeight: FontWeight.bold),
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
                          labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: customizationValues['fontSize'] ?? 19.0),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(fontSize: customizationValues['fontSize'] ?? 19.0, color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                  // Number of Pieces Text Entry
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
                          labelText: 'Enter Number of Pieces',
                          labelStyle: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: customizationValues['fontSize'] ?? 19.0),
                          border: InputBorder.none,
                        ),
                        style: TextStyle(fontSize: customizationValues['fontSize'] ?? 19.0, color: Colors.black, fontWeight: FontWeight.bold),
                      ),
                    ),
                  ),
                  SizedBox(height: 20.0),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

