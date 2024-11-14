import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> fetchData() async {
  final response = await http.get(Uri.parse(
      'https://ulmobservices.srilankan.com/ULMOBTEAMSERVICES/api/CargoMobileAppCorp/GetTermsAndConditions'));

  if (response.statusCode == 200) {
    List<dynamic> contacts = jsonDecode(response.body);
    if (contacts.isNotEmpty) {
      return {
        'termsAndConditions':
            contacts[0]['termsandConditions'] ?? 'Not available',
      };
    } else {
      return {
        'termsAndConditions': 'Not available',
      };
    }
  } else {
    throw Exception('Failed to load contacts');
  }
}

class TermsAndConditionsPage extends StatefulWidget {
  @override
  _TermsAndConditionsPageState createState() => _TermsAndConditionsPageState();
}

class _TermsAndConditionsPageState extends State<TermsAndConditionsPage> {
  late Future<Map<String, dynamic>> _data;

  @override
  void initState() {
    super.initState();
    _data = fetchData();
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/terms_and_conditions.png',
              fit: BoxFit.cover,
            ),
          ),

          Positioned(
            top: screenHeight * 0.01,
            left: 0.0,
            right: 0.0,
            child: Container(
              color: const Color.fromARGB(1, 243, 247, 249),
              padding: EdgeInsets.symmetric(
                  vertical: screenHeight * 0.02,
                  horizontal: screenWidth * 0.06),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Terms and Conditions',
                    style: TextStyle(
                      fontSize: screenWidth * 0.06,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 28, 31, 106),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close,
                        color: const Color.fromARGB(255, 28, 31, 106)),
                    iconSize: 30.0,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ),
          // Scrollable content below the title and icon
          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.02),
            child: FutureBuilder<Map<String, dynamic>>(
              future: _data,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(child: CircularProgressIndicator());
                } else if (snapshot.hasError) {
                  return Center(child: Text('Error: ${snapshot.error}'));
                } else if (!snapshot.hasData || snapshot.data == null) {
                  return Center(child: Text('No data available'));
                } else {
                  final data = snapshot.data!;
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            data['termsAndConditions'],
                            style: TextStyle(
                              fontSize: screenWidth * 0.03,
                              color: const Color.fromARGB(255, 51, 51, 51),
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
