import 'package:flutter/material.dart';

class TermsConditionsPage extends StatelessWidget {
  final String termsAndConditions;

  const TermsConditionsPage({Key? key, required this.termsAndConditions})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    Map<String, double> appBarCustomization = customizeAppBar(screenWidth);

    return Scaffold(
      appBar: AppBar(
        leading: Transform.translate(
          offset: Offset(8.0, -6.0),
          child: BackButton(color: Colors.white),
        ),
        title: Transform.translate(
          offset: Offset(appBarCustomization['titleXOffset'] ?? 0.0, -6.0),
          child: Text('Terms & Conditions',
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
            offset: Offset(0.0, 16.0), // Adjust this value as needed
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15.0),
              ),
              elevation: 5.0,
              margin: EdgeInsets.fromLTRB(
                16.0, // Adjust this value as needed
                0.0,
                16.0, // Adjust this value as needed
                16.0,
              ),
              surfaceTintColor: Color.fromARGB(255, 255, 255, 255),
              child: Container(
                width: screenWidth - 32.0, // Adjust to match card width
                padding: const EdgeInsets.all(16.0),
                child: Text(
                  termsAndConditions,
                  style: const TextStyle(fontSize: 16.0),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Map<String, double> customizeAppBar(double screenWidth) {
    // Adjust this method based on your specific customization needs
    return {
      'titleXOffset': screenWidth * 0.02, // Example offset
    };
  }
}
