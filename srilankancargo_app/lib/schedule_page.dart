import 'package:flutter/material.dart';

class SchedulePage extends StatelessWidget {
  Map<String, double> customizeFormCard(double screenWidth) {
    Map<String, double> customizationValues = {};

    if (screenWidth >= 768) {
      // iPad or larger screens
      customizationValues['cardMargin'] = 56.0;
      customizationValues['cardOffset'] = -158.0;
      customizationValues['iconOffset'] = 538.5;
      customizationValues['buttonPadding'] = 54.0;
    } else if (screenWidth <= 768 && screenWidth > 600) {
      // Customization for larger Android screens
      customizationValues['cardMargin'] = 30.0;
      customizationValues['cardOffset'] = -120.0;
      customizationValues['iconOffset'] = 199.5;
      customizationValues['buttonPadding'] = 30.0;
    } if (screenWidth >= 810 && screenWidth < 834) {
      // iPad 10th gen
      customizationValues['cardMargin'] = 56.0;
      customizationValues['cardOffset'] = -158.0;
      customizationValues['iconOffset'] = 538.5;
      customizationValues['buttonPadding'] = 54.0;
    } else if (screenWidth == 430) {
      // iPhone 15 Plus and 15 Pro Max
      customizationValues['cardMargin'] = 30.0;
      customizationValues['cardOffset'] = -90.0;
      customizationValues['iconOffset'] = 199.5;
      customizationValues['buttonPadding'] = 30.0;
    } else if (screenWidth == 375) {
      // iPhone SE
      customizationValues['cardMargin'] = 30.0;
      customizationValues['cardOffset'] = -30.0;
      customizationValues['iconOffset'] = 162.5;
      customizationValues['buttonPadding'] = 26.0;
      customizationValues['fontSize'] = 13.0;
    } else if (screenWidth == 393) {
      // iPhone 15 Pro
      customizationValues['cardMargin'] = 30.0;
      customizationValues['cardOffset'] = -120.0;
      customizationValues['iconOffset'] = 162.5;
      customizationValues['buttonPadding'] = 36.0;
    }     else if (screenWidth <= 600 && screenWidth > 400) {
      // Customization for medium-sized Android screens (Pixel 7 Pro API 29)
      customizationValues['cardMargin'] = 30.0;
      customizationValues['cardOffset'] = -60.0;
      customizationValues['iconOffset'] = 192.5;
      customizationValues['buttonPadding'] = 30.0;
    } else if (screenWidth <= 768 && screenWidth <= 830) {
      // iPad Air (5th Gen) and iPad mini (6th Gen)
      customizationValues['cardMargin'] = 70.0;
      customizationValues['cardOffset'] = -120.0;
      customizationValues['iconOffset'] = 433.5;
      customizationValues['buttonPadding'] = 36.0;
    } else if (screenWidth >= 834 && screenWidth < 1024) {
      // iPad Pro (11-inch)
      customizationValues['cardMargin'] = 50.0;
      customizationValues['cardOffset'] = -120.0;
      customizationValues['iconOffset'] = 563.5;
      customizationValues['buttonPadding'] = 38.0;
    } else if (screenWidth == 1024) {
      // iPad Pro (12.9-inch)
      customizationValues['cardMargin'] = 60.0;
      customizationValues['cardOffset'] = -140.0;
      customizationValues['iconOffset'] = 734.5;
      customizationValues['buttonPadding'] = 38.0;
    } else {
      // iPhone 15 and 15 Pro
      customizationValues['cardMargin'] = 30.0;
      customizationValues['cardOffset'] = -90.0;
      customizationValues['iconOffset'] = 180.0;
      customizationValues['buttonPadding'] = 36.0;
      customizationValues['fontSize'] = 13.0;
    }

    return customizationValues;
  }

  Map<String, double> customizeAppBar(double screenWidth) {
    Map<String, double> customizationValues = {};

     if (screenWidth <= 600 && screenWidth > 400) {
      // Customization for medium-sized Android screens (Pixel 7 Pro API 29)
      customizationValues['appBarOffsetPercentage'] = -0.60;
      customizationValues['titleXOffset'] = 60.0; // Adjust this value as needed
    }  if (screenWidth == 430) {
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
      appBar: AppBar(
        leading: Transform.translate(
          offset: Offset(8.0, -6.0),
          child: BackButton(color: Colors.white),
        ),
        title: Transform.translate(
          offset: Offset(appBarCustomization['titleXOffset'] ?? 0.0, -6.0),
          child: Text(
            'Flight Schedule',
            style: TextStyle(color: Colors.white, fontFamily: 'SriLankan Regular'),
          ),
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
        flexibleSpace: Center(
          child: LayoutBuilder(
            builder: (context, constraints) {
              double offset = constraints.maxHeight * (appBarCustomization['appBarOffsetPercentage'] ?? 0.25);

              return Transform.translate(
                offset: Offset(0.0, offset),
                child: Transform.scale(
                  scale: 1.0,
                ),
              );
            },
          ),
        ),
      ),
      backgroundColor: Colors.white,
      body: Center(
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
                          'Flight Schedule Form',
                          style: TextStyle(color: Colors.white, fontSize: 19.0, fontWeight: FontWeight.bold),
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
                      child: DropdownButton<String>(
                        icon: Icon(Icons.arrow_drop_down),
                        iconSize: 36.0,
                        underline: SizedBox(),
                        style: TextStyle(fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold),
                        hint: Text(
                          'Select Origin Country',
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: customizationValues['fontSize'] ?? 16.0),
                        ),
                        isExpanded: true,
                        items: <String>['Country 1', 'Country 2', 'Country 3', 'Country 4'].map((String value) {
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
                  Container(
                    width: double.infinity,
                    margin: EdgeInsets.only(top: 16.0),
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
                        style: TextStyle(fontSize: 16.0, color: Colors.black, fontWeight: FontWeight.bold),
                        hint: Text(
                          'Select Destination Country',
                          style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: customizationValues['fontSize'] ?? 16.0),
                        ),
                        isExpanded: true,
                        items: <String>['Country A', 'Country B', 'Country C', 'Country D'].map((String value) {
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
                                Text(
                                  'Select Date',
                                  style: TextStyle(color: Colors.black, fontWeight: FontWeight.bold, fontSize: customizationValues['fontSize'] ?? 16.0),
                                ),
                                Transform.translate(
                                  offset: Offset(customizationValues['iconOffset'] ?? 0.0, 0.0),
                                  child: Icon(Icons.calendar_today, color: Color.fromARGB(255, 93, 93, 93)),
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
                        padding: EdgeInsets.symmetric(horizontal: customizationValues['buttonPadding'] ?? 0.0),
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
    );
  }
}
