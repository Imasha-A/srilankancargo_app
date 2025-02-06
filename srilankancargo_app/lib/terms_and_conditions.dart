import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

Future<Map<String, dynamic>> fetchData() async {
  final response = await http.get(Uri.parse(
      'https://ulmobservices.srilankan.com/ULMOBTEAMSERVICES/api/CargoMobileAppCorp/GetTermsAndConditions'));

  if (response.statusCode == 200) {
    Map<String, dynamic> data = jsonDecode(response.body);
    List<dynamic> termsList = data['terms'] ?? [];
    List<Map<String, String>> sections = [];

    for (var term in termsList) {
      String section = term['section']?.trim() ?? 'Unknown Section';
      String content = term['content']?.trim() ?? 'No Content';

      content = content
          .replaceAll(RegExp(r'\s*\n\s*'), '\n\n')
          .replaceAll(RegExp(r'\n{2,}'), '\n\n')
          .trim();

      sections.add({
        'section': section,
        'content': content,
      });
    }

    String lastUpdated = data['lastUpdated']?.trim() ?? 'Not available';

    return {
      'sections': sections,
      'lastUpdated': lastUpdated,
    };
  } else {
    throw Exception('Failed to load terms and conditions');
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
          // Title and close icon
          Positioned(
            top: screenHeight * 0.035,
            left: 0.0,
            right: 0.0,
            child: Container(
              color: const Color.fromARGB(1, 243, 247, 249),
              padding: EdgeInsets.symmetric(
                vertical: screenHeight * 0.02,
                horizontal: screenWidth * 0.025,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Terms and Conditions',
                    style: TextStyle(
                      fontSize: screenWidth * 0.063,
                      fontWeight: FontWeight.bold,
                      color: const Color.fromARGB(255, 28, 31, 106),
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.close,
                      color: const Color.fromARGB(255, 28, 31, 106),
                    ),
                    iconSize: 30.0,
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          ),

          Padding(
            padding: EdgeInsets.only(top: screenHeight * 0.105),
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
                  final sections =
                      data['sections'] as List<Map<String, String>>;
                  return SingleChildScrollView(
                    child: Padding(
                      padding: const EdgeInsets.all(12.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          for (var section in sections)
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  section['section']!,
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.0445,
                                    fontWeight: FontWeight.w600,
                                    color:
                                        const Color.fromARGB(255, 27, 27, 30),
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(height: 8.0),
                                Text(
                                  section['content']!,
                                  style: TextStyle(
                                    fontSize: screenWidth * 0.04,
                                    color:
                                        const Color.fromARGB(255, 51, 51, 51),
                                  ),
                                  textAlign: TextAlign.left,
                                ),
                                SizedBox(height: 16.0),
                              ],
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
