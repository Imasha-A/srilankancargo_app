import 'package:flutter/material.dart';

class FlightStatusPage extends StatelessWidget {
  Map<String, double> customizeFormCard(double screenWidth) {
    Map<String, double> customizationValues = {};

    if (screenWidth == 1024) {
      // iPad Pro (12.9-inch)
      customizationValues['cardMargin'] = 70.0;
      customizationValues['cardOffset'] = 400.0;
      customizationValues['iconOffset'] = 660.5;
      customizationValues['buttonPadding'] = 40.0;
      customizationValues['cardHeight'] =
          333; // Added card height customization
    } else if (screenWidth == 834) {
      // iPad Pro (11-inch)
      customizationValues['cardMargin'] = 50.0;
      customizationValues['cardOffset'] = 280.0;
      customizationValues['iconOffset'] = 515.5;
      customizationValues['buttonPadding'] = 38.0;
    } else if (screenWidth >= 768) {
      // iPad or larger screens
      customizationValues['cardMargin'] = 86.0;
      customizationValues['cardOffset'] = 278.0;
      customizationValues['iconOffset'] = 425.5;
      customizationValues['buttonPadding'] = 54.0;
    } else if (screenWidth == 375) {
      // iPhone SE
      customizationValues['cardMargin'] = 30.0;
      customizationValues['cardOffset'] = 73.0;
      customizationValues['iconOffset'] = 116.0;
      customizationValues['buttonPadding'] = 26.0;
      customizationValues['fontSize'] = 14.0;
    } else if (screenWidth == 393) {
      // iPhone 15
      customizationValues['cardMargin'] = 30.0;
      customizationValues['cardOffset'] = 110.0;
      customizationValues['iconOffset'] = 116.5;
      customizationValues['buttonPadding'] = 30.0;
    } else if (screenWidth == 430) {
      // iPhone 15 Plus
      customizationValues['cardMargin'] = 30.0;
      customizationValues['cardOffset'] = 130.0;
      customizationValues['iconOffset'] = 150.5;
      customizationValues['buttonPadding'] = 32.0;
    } else if (screenWidth <= 600 && screenWidth > 400) {
      // Customization for medium-sized Android screens (Pixel 7 Pro API 29)
      customizationValues['cardMargin'] = 30.0;
      customizationValues['cardOffset'] = 120.0;
      customizationValues['iconOffset'] = 146.5;
      customizationValues['buttonPadding'] = 30.0;
    } else if (screenWidth <= 768) {
      // iPad mini (6th Gen)
      customizationValues['cardMargin'] = 45.0;
      customizationValues['cardOffset'] = -110.0;
      customizationValues['iconOffset'] = 435.5;
      customizationValues['buttonPadding'] = 36.0;
    } else if (screenWidth <= 768 && screenWidth < 830) {
      // iPad Air (5th Gen) and iPad mini (6th Gen)
      customizationValues['cardMargin'] = 30.0;
      customizationValues['cardOffset'] = -120.0;
      customizationValues['iconOffset'] = 162.5;
      customizationValues['buttonPadding'] = 33.0;
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
      // Customization for medium-sized Android screens (Pixel 7 Pro API 29)
      customizationValues['appBarOffsetPercentage'] = -0.60;
      customizationValues['titleXOffset'] = 60.0; // Adjust this value as needed
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
    Map<String, double> customizationValues = customizeFormCard(screenWidth);
    Map<String, double> appBarCustomization = customizeAppBar(screenWidth);

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        leading: Transform.translate(
          offset: Offset(8.0, -6.0),
          child: BackButton(color: Colors.white),
        ),
        title: Transform.translate(
          offset: Offset(appBarCustomization['titleXOffset'] ?? 0.0, -6.0),
          child: Text('Flight Status',
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
                height: customizationValues['cardHeight'] ?? null,
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
                              'Flight Status Form',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 19.0,
                                  fontWeight: FontWeight.bold),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
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
                              labelText: 'Enter Flight No',
                              hintText: '(Ex: UL121)',
                              hintStyle: TextStyle(
                                  color: Colors.grey,
                                  fontSize:
                                      customizationValues['fontSize'] ?? 16.0),
                              labelStyle: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold,
                                  fontSize:
                                      customizationValues['fontSize'] ?? 16.0),
                              border: InputBorder.none,
                            ),
                            style: TextStyle(
                                fontSize: 16.0,
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                      ),
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: 16.0),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(8.0),
                          color: Colors.grey[100],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextButton(
                                onPressed: () async {
                                  DateTime? pickedDate = await showDatePicker(
                                    context: context,
                                    initialDate: DateTime.now(),
                                    firstDate: DateTime.now(),
                                    lastDate: DateTime(DateTime.now().year + 1),
                                  );

                                  if (pickedDate != null) {
                                    // Handle picked date
                                  }
                                },
                                child: Row(
                                  children: [
                                    Text('Select Flight Date',
                                        style: TextStyle(
                                            color: Colors.black,
                                            fontWeight: FontWeight.bold,
                                            fontSize: customizationValues[
                                                    'fontSize'] ??
                                                16.0)),
                                    Transform.translate(
                                      offset: Offset(
                                          customizationValues['iconOffset'] ??
                                              0.0,
                                          0.0),
                                      child: Icon(Icons.calendar_today,
                                          color:
                                              Color.fromARGB(255, 93, 93, 93)),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      SizedBox(height: 20.0),
                      Center(
                        child: ElevatedButton(
                          onPressed: () {
                            // Handle form submission
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Color.fromARGB(255, 3, 75, 135),
                            padding: EdgeInsets.symmetric(
                                horizontal:
                                    customizationValues['buttonPadding'] ??
                                        0.0),
                          ),
                          child: Text(
                            'Submit',
                            style: TextStyle(color: Colors.white),
                          ),
                        ),
                      ),
                      SizedBox(height: 15.0),
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
