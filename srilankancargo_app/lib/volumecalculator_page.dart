import 'package:flutter/material.dart';

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

class VolumeCalculatorPage extends StatefulWidget {
  @override
  _VolumeCalculatorPageState createState() => _VolumeCalculatorPageState();
}

class _VolumeCalculatorPageState extends State<VolumeCalculatorPage> {
  List<UserSelection> userSelections = [];
  double finalTotal = 0;
  final TextEditingController lengthController = TextEditingController();
  final TextEditingController widthController = TextEditingController();
  final TextEditingController heightController = TextEditingController();
  final TextEditingController piecesController = TextEditingController();
  bool isTiltedPermitted = false;
  Map<String, dynamic> customizeLoadibilityCard(double screenWidth) {
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
    double length = double.tryParse(lengthController.text) ?? 0;
    double width = double.tryParse(widthController.text) ?? 0;
    double height = double.tryParse(heightController.text) ?? 0;
    double numberOfPieces = double.tryParse(piecesController.text) ?? 0;

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
    lengthController.clear();
    widthController.clear();
    heightController.clear();
    piecesController.clear();
  }

  void clearSelections() {
    setState(() {
      userSelections.clear();
    });
    print('Selections cleared');
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
          child: Text('Volume Calculator',
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
                  padding: const EdgeInsets.all(16.0),
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
                              'Dimensions',
                              style: TextStyle(
                                  fontSize: 19.0,
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
                            controller: lengthController,
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
                            controller: widthController,
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
                            controller: heightController,
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
                            controller: piecesController,
                            decoration: InputDecoration(
                              labelText: 'Number of Pieces',
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
                      SizedBox(height: 16.0),
                      // Calculate and Clear Buttons
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          ElevatedButton(
                            onPressed: calculateVolume,
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 3, 75, 135),
                                foregroundColor: Colors.white),
                            child: Text('Calculate'),
                          ),
                          ElevatedButton(
                            onPressed: clearSelections,
                            style: ElevatedButton.styleFrom(
                                backgroundColor:
                                    const Color.fromARGB(255, 3, 75, 135),
                                foregroundColor: Colors.white),
                            child: Text('Clear'),
                          ),
                        ],
                      ),
                      SizedBox(height: 10.0),
                      Expanded(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: SingleChildScrollView(
                            scrollDirection: Axis.horizontal,
                            child: DataTable(
                              columnSpacing: 10.0,
                              columns: const <DataColumn>[
                                DataColumn(label: Text('Length (cm)')),
                                DataColumn(label: Text('Width (cm)')),
                                DataColumn(label: Text('Height (cm)')),
                                DataColumn(label: Text('Pieces')),
                                DataColumn(label: Text('CBM')),
                                DataColumn(label: Text('Final CBM')),
                              ],
                              rows: userSelections.map((selection) {
                                return DataRow(
                                  cells: <DataCell>[
                                    DataCell(Text(
                                        '${selection.length.toStringAsFixed(2)}')),
                                    DataCell(Text(
                                        '${selection.width.toStringAsFixed(2)}')),
                                    DataCell(Text(
                                        '${selection.height.toStringAsFixed(2)}')),
                                    DataCell(Text(
                                        '${selection.numberOfPieces.toStringAsFixed(2)}')),
                                    DataCell(Text(
                                        '${selection.total.toStringAsFixed(2)}')),
                                    DataCell(Text(
                                        '${selection.finalTotal.toStringAsFixed(5)}')),
                                  ],
                                );
                              }).toList(),
                            ),
                          ),
                        ),
                      )
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
