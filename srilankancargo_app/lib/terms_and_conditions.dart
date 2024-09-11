import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> fetchData() async {
  final response =
      await http.get(Uri.parse('http://10.60.11.102:5063/api/contacts'));

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
    return Scaffold(
      body: Stack(
        children: [
          // Background image
          Positioned.fill(
            child: Image.asset(
              'assets/images/terms_and_conditions.png', // Replace with your image path
              fit: BoxFit.cover, // Cover the whole screen
            ),
          ),
          // White background behind title and close icon
          Positioned(
            top: 40.0, // Adjust the distance from the top
            left: 0.0, // Align with the left side
            right: 0.0, // Align with the right side
            child: Container(
              color: const Color.fromARGB(1, 243, 247, 249), // White background
              padding:
                  const EdgeInsets.symmetric(vertical: 10.0, horizontal: 20.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Terms and Conditions',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 28, 31, 106),
                    ),
                  ),
                  IconButton(
                    icon: Icon(Icons.close,
                        color: const Color.fromARGB(255, 28, 31, 106)),
                    iconSize: 30.0, // Adjust the size of the button
                    onPressed: () {
                      Navigator.of(context).pop(); // Close the page
                    },
                  ),
                ],
              ),
            ),
          ),
          // Scrollable content below the title and icon
          Padding(
            padding: const EdgeInsets.only(
                top: 100.0), // To place content below the fixed header
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
                              fontSize: 14,
                              color: const Color.fromARGB(
                                  255, 51, 51, 51), // Text color
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
