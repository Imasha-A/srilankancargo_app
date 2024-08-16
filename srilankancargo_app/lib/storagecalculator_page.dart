import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:http/http.dart' as http;

class UserSelection {
  DateTime arrivalDate;
  DateTime clearingDate;
  String location;
  String taxType;
  String cargoType;
  double chargeableWeight;

  UserSelection({
    required this.arrivalDate,
    required this.clearingDate,
    required this.location,
    required this.taxType,
    required this.cargoType,
    required this.chargeableWeight,
  });

  Map<String, dynamic> toJson() {
    return {
      'arrivalDate': _formatDate(arrivalDate),
      'clearanceDate': _formatDate(clearingDate),
      'aircraftType': location,
      'taxType': taxType,
      'cargoType': cargoType,
      'chargeableWeight': chargeableWeight,
    };
  }

  String _formatDate(DateTime date) {
    return '${date.year.toString().padLeft(4, '0')}-${date.month.toString().padLeft(2, '0')}-${date.day.toString().padLeft(2, '0')}';
  }
}

class StorageCalculatorPage extends StatefulWidget {
  @override
  _StorageCalculatorPageState createState() => _StorageCalculatorPageState();
}

class _StorageCalculatorPageState extends State<StorageCalculatorPage> {
  DateTime? _arrivalDate;
  DateTime? _clearingDate;
  String? _selectedLocation;
  String? _selectedTaxType;
  String? _selectedCargoType;
  TextEditingController _weightController = TextEditingController();

  String? _weightErrorMessage;

  //holiday of 2024
  final List<DateTime> holidays = [
    DateTime(2024, 8, 19), // Poya
    DateTime(2024, 9, 16), // Holy Prophet's Birthday
    DateTime(2024, 9, 17), // Poya
    DateTime(2024, 10, 17), // Poya
    DateTime(2024, 10, 31), // Deepavali
    DateTime(2024, 11, 15), // Poya
    DateTime(2024, 12, 14), // Poya
    DateTime(2024, 12, 24), // Christmas Eve
    DateTime(2024, 12, 25), // Christmas
  ];

  Map<String, dynamic> customizeStorageCalculatorCard(double screenWidth) {
    Map<String, dynamic> customizationValues = {};

    if (screenWidth == 1024) {
      // iPad Pro (12.9-inch)
      customizationValues['cardWidth'] = 800.0;
      customizationValues['cardHeight'] = 600.0;
      customizationValues['cardMargin'] = 60.0;
      customizationValues['cardOffset'] = 220.0;
      customizationValues['iconOffset'] = 513.0;
      customizationValues['iconOffset1'] = 545.5;
      customizationValues['buttonPadding'] = 26.0;
      customizationValues['fontSize'] = 13.0;
      customizationValues['noteFontSize'] = 14.0;
      customizationValues['noteTextOffsetX'] = -270.0;
      customizationValues['noteTextOffsetY'] = 215.0;
    } else if (screenWidth == 834) {
      // iPad Pro (11-inch)
      customizationValues['cardWidth'] = 600.0;
      customizationValues['cardHeight'] = 600.0;
      customizationValues['cardMargin'] = 30.0;
      customizationValues['cardOffset'] = 140.0;
      customizationValues['iconOffset'] = 313.0;
      customizationValues['iconOffset1'] = 345.5;
      customizationValues['buttonPadding'] = 26.0;
      customizationValues['fontSize'] = 13.0;
      customizationValues['noteFontSize'] = 14.0;
      customizationValues['noteTextOffsetX'] = -174.0;
      customizationValues['noteTextOffsetY'] = 135.0;
    } else if (screenWidth == 375) {
      // iPhone SE
      customizationValues['cardWidth'] = 305.0;
      customizationValues['cardHeight'] = 565.0;
      customizationValues['cardMargin'] = 20.0;
      customizationValues['cardOffset'] = 16.0;
      customizationValues['iconOffset'] = 108.90;
      customizationValues['iconOffset1'] = 127.8;
      customizationValues['buttonPadding'] = 26.0;
      customizationValues['fontSize'] = 7.335;
      customizationValues['noteFontSize'] = 0.0;
    } else if (screenWidth == 393) {
      // iPhone 15
      customizationValues['cardWidth'] = 300.0;
      customizationValues['cardHeight'] = 680.0;
      customizationValues['cardMargin'] = 16.0;
      customizationValues['cardOffset'] = 20.0;
      customizationValues['buttonPadding'] = 36.0;
      customizationValues['fontSize'] = 10.0;
      customizationValues['noteFontSize'] = 11.0;
      customizationValues['noteTextOffsetX'] = -45.0;
      customizationValues['noteTextOffsetY'] = 12.0;
      customizationValues['iconOffset'] = 60.0;
      customizationValues['iconOffset1'] = 85.0;
    } else if (screenWidth <= 600 && screenWidth > 400 && screenWidth < 430) {
      // Customization for medium-sized Android screens (Pixel 7 Pro API 29)
      customizationValues['cardWidth'] = 450.0;
      customizationValues['cardHeight'] = 600.0;
      customizationValues['cardMargin'] = 30.0;
      customizationValues['cardOffset'] = 40.0;
      customizationValues['buttonPadding'] = 36.0;
      customizationValues['fontSize'] = 13.0;
      customizationValues['noteFontSize'] = 11.0;
      customizationValues['noteTextOffsetX'] = -80.0;
      customizationValues['noteTextOffsetY'] = 25.0;
      customizationValues['iconOffset'] = 85.35;
      customizationValues['iconOffset1'] = 115.0;
    } else if (screenWidth <= 430 && screenWidth <= 600) {
      // iPhone 15 Plus and 15 Pro Max
      customizationValues['cardWidth'] = 400.0;
      customizationValues['cardHeight'] = 600.0;
      customizationValues['cardMargin'] = 30.0;
      customizationValues['cardOffset'] = 60.0;
      customizationValues['iconOffset'] = 82.45;
      customizationValues['iconOffset1'] = 115.0;
      customizationValues['buttonPadding'] = 30.0;
      customizationValues['fontSize'] = 13.0;
      customizationValues['noteFontSize'] = 11.0;
      customizationValues['noteTextOffsetX'] = -80.0;
      customizationValues['noteTextOffsetY'] = 45.0;
    } else if (screenWidth <= 768) {
      // iPad mini (6th Gen)
      customizationValues['cardWidth'] = 550.0;
      customizationValues['cardHeight'] = 600.0;
      customizationValues['cardMargin'] = 30.0;
      customizationValues['cardOffset'] = 130.0;
      customizationValues['iconOffset'] = 278.85;
      customizationValues['iconOffset1'] = 309.0;
      customizationValues['buttonPadding'] = 30.0;
      customizationValues['fontSize'] = 12.0;
      customizationValues['noteFontSize'] = 11.0;
      customizationValues['noteTextOffsetX'] = -170.0;
      customizationValues['noteTextOffsetY'] = 125.0;
    } else if (screenWidth >= 768) {
      // iPad or larger screens
      customizationValues['cardWidth'] = 620.0;
      customizationValues['cardHeight'] = 615.0;
      customizationValues['cardMargin'] = 56.0;
      customizationValues['cardOffset'] = 138.0;
      customizationValues['iconOffset'] = 317.0;
      customizationValues['iconOffset1'] = 351.5;
      customizationValues['buttonPadding'] = 26.0;
      customizationValues['fontSize'] = 14.0;
      customizationValues['noteFontSize'] = 14.0;
      customizationValues['noteTextOffsetX'] = -178.0;
      customizationValues['noteTextOffsetY'] = 135.0;
    } else if (screenWidth <= 768) {
      // iPad Air (5th Gen) and iPad mini (6th Gen)
      customizationValues['cardWidth'] = 620.0;
      customizationValues['cardHeight'] = 615.0;
      customizationValues['cardMargin'] = 56.0;
      customizationValues['cardOffset'] = 138.0;
      customizationValues['iconOffset'] = 317.0;
      customizationValues['iconOffset1'] = 351.5;
      customizationValues['buttonPadding'] = 26.0;
      customizationValues['fontSize'] = 14.0;
      customizationValues['noteFontSize'] = 14.0;
      customizationValues['noteTextOffsetX'] = -178.0;
      customizationValues['noteTextOffsetY'] = 135.0;
    } else {
      //iPhone 15 and 15 Pro
      customizationValues['cardWidth'] = 300.0;
      customizationValues['cardHeight'] = 615.0;
      customizationValues['cardMargin'] = 16.0;
      customizationValues['cardOffset'] = 20.0;
      customizationValues['buttonPadding'] = 36.0;
      customizationValues['fontSize'] = 10.0;
      customizationValues['noteFontSize'] = 11.0;
      customizationValues['noteTextOffsetX'] = -45.0;
      customizationValues['noteTextOffsetY'] = 12.0;
      customizationValues['iconOffset'] = 60.0;
      customizationValues['iconOffset1'] = 85.0;
    }

    return customizationValues;
  }

  Map<String, double> customizeAppBar(double screenWidth) {
    Map<String, double> customizationValues = {};

    if (screenWidth <= 600 && screenWidth >= 400) {
      // Customization for medium-sized Android screens (Pixel 7 Pro API 29)
      customizationValues['appBarOffsetPercentage'] = -0.60;
      customizationValues['titleXOffset'] = 46.0; // Adjust this value as needed
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

  Future<void> _selectedDate(BuildContext context, bool isArrivalDate) async {
    if (isArrivalDate) {
      // For Arrival Date
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime.now(),
        lastDate: DateTime(DateTime.now().year + 1),
      );
      if (picked != null) {
        setState(() {
          _arrivalDate = picked;
          // Clear the clearing date if the new arrival date is later than the current clearing date
          if (_clearingDate != null && _clearingDate!.isBefore(_arrivalDate!)) {
            _clearingDate = null;
          }
        });
      }
    } else {
      // For Clearing Date
      final DateTime firstDate = _arrivalDate ??
          DateTime.now(); // Use arrival date if set, otherwise now
      final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: _clearingDate ?? firstDate,
        firstDate: firstDate,
        lastDate: DateTime(DateTime.now().year + 1),
      );
      if (picked != null) {
        setState(() {
          _clearingDate = picked;
        });
      }
    }
  }

  void _clearForm() {
    setState(() {
      _arrivalDate = null;
      _clearingDate = null;
      _selectedLocation = null;
      _selectedTaxType = null;
      _selectedCargoType = null;
      _weightController.clear();
      _weightErrorMessage = null;
    });
  }

  void _handleFormSubmision() async {
    bool hasError = false;

    if (_arrivalDate == null) {
      hasError = true;
    }
    if (_clearingDate == null) {
      hasError = true;
    }
    if (_selectedLocation == null) {
      hasError = true;
    }
    if (_selectedTaxType == null) {
      hasError = true;
    }
    if (_selectedCargoType == null) {
      hasError = true;
    }
    if (_weightController == null) {
      hasError = true;
      setState(() {
        _weightErrorMessage = 'Invalid number. Please try again.';
      });
    } else {
      setState(() {
        _weightErrorMessage = null;
      });
    }

    if (hasError) {
      _showIncompleteFormDialog(context);
      return;
    }

    if (_arrivalDate == null ||
        _clearingDate == null ||
        _selectedLocation == null ||
        _selectedTaxType == null ||
        _selectedCargoType == null ||
        _weightController.text.isEmpty) {
      hasError = true;
      setState(() {
        _weightErrorMessage = 'All fields are required. Please fill them out.';
      });
    } else {
      // Validate weight input
      final chargeableWeight = double.tryParse(_weightController.text);
      if (chargeableWeight == null) {
        hasError = true;
        setState(() {
          _weightErrorMessage = 'Invalid number. Please enter a valid weight.';
        });
      } else {
        setState(() {
          _weightErrorMessage = null;
        });
      }
    }
    if (hasError) {
      _showIncompleteFormDialog(context);
      return;
    }

    final chargeableWeight = double.parse(_weightController.text);

    const documentationCharge = 2000.0;
    double handlingCharge;
    double storageCharge = 0.0;
    double storageChargeafter5weeks = 0.0;
    double weeksPassed = 0.0;
    double chargePerKg = 0.0;
    double oldCargoCharges = 0.0;
    double socialSecurityContributionLevy = 0.0;
    double VAT = 0.0;
    double finalCharge = 0.0;

    switch (_selectedCargoType) {
      case 'General Cargo':
        handlingCharge = 27.0 * chargeableWeight;
        handlingCharge = handlingCharge < 2500.0 ? 2500.0 : handlingCharge;
        break;
      case 'Special Cargo':
        handlingCharge = 60.0 * chargeableWeight;
        handlingCharge = handlingCharge < 6000.0 ? 6000.0 : handlingCharge;
        break;
      case 'Courier':
        handlingCharge = 40.0 * chargeableWeight;
        handlingCharge = handlingCharge < 3700.0 ? 3700.0 : handlingCharge;
        break;
      case 'Courier Detained':
        handlingCharge = 15.0 * chargeableWeight;
        handlingCharge = handlingCharge < 25000.0 ? 25000.0 : handlingCharge;
        break;
      case 'Courier House Airway Bill':
        handlingCharge = 1500.0;
        break;
      default:
        handlingCharge = 0.0;
    }

    final arrivalDate = _arrivalDate!;
    final clearingDate = _clearingDate!;
    final differenceInDays = clearingDate.difference(arrivalDate).inDays +
        1; //difference in days is duration days + clearing day as well
    print('Difference in days: \$${differenceInDays}');

    if (_selectedLocation == 'Cool Room (20 to -20 degrees celcius)')
    //condition for temperature regulated cargo
    {
      if (differenceInDays > 28) {
        storageCharge = 55.0 * chargeableWeight;
        storageCharge *= differenceInDays;
        storageCharge = storageCharge < 7700.0 ? 7700.0 : storageCharge;
        oldCargoCharges = 25000.0;
      } else {
        storageCharge = 45.0 * chargeableWeight;
        storageCharge *= differenceInDays;
        storageCharge = storageCharge < 3200.0 ? 3200.0 : storageCharge;
      }
    } else //condition for normal cargo
    {
      bool isHoliday(DateTime date) {
        return holidays.any((holiday) =>
            holiday.year == date.year &&
            holiday.month == date.month &&
            holiday.day == date.day);
      }

      DateTime getFreeEndDate(DateTime arrivalDate) {
        DateTime freeEndDate = arrivalDate.add(Duration(days: 2));
        while (freeEndDate.weekday > 5) {
          // to skip weekends (mon to tues is 1 to 5, 6 & 7 are weekends)
          freeEndDate = freeEndDate.add(Duration(days: 1));
        }
        return freeEndDate;
      }

      DateTime freeEndDate = getFreeEndDate(arrivalDate);
      for (DateTime date = arrivalDate;
          date.isBefore(clearingDate
              .add(Duration(days: 1))); // Include clearingDate in the loop
          date = date.add(Duration(days: 1))) {
        if (isHoliday(date)) {
          freeEndDate = freeEndDate.add(Duration(days: 1));
        }
      }

      int daysElapsed = clearingDate.difference(freeEndDate).inDays;

      weeksPassed = differenceInDays / 7;

      if (weeksPassed <= 1) {
        chargePerKg = 35.0;
      } else if (weeksPassed <= 2) {
        chargePerKg = 70.0;
      } else if (weeksPassed <= 3) {
        chargePerKg = 135.0;
      } else if (weeksPassed <= 4) {
        chargePerKg = 225.0;
      } else {
        chargePerKg = 305.0;
        oldCargoCharges = 25000.0;
      }
      storageCharge = chargeableWeight * chargePerKg;
      storageCharge = storageCharge < 2500.0 ? 2500.0 : storageCharge;

      if (daysElapsed < 0) {
        storageCharge = 0.0;
      }
    }

    finalCharge =
        documentationCharge + handlingCharge + storageCharge + oldCargoCharges;

    if (_selectedTaxType == 'VAT') {
      socialSecurityContributionLevy = (finalCharge * (2.5 / 100));
      VAT = ((finalCharge + socialSecurityContributionLevy) * (18 / 100));
    } else if (_selectedTaxType == 'SVAT') {
      socialSecurityContributionLevy = (finalCharge * (2.5 / 100));
      VAT = 0.0;
    } else //no tax
    {
      socialSecurityContributionLevy = 0.0;
      VAT = 0.0;
    }

    finalCharge = finalCharge + socialSecurityContributionLevy + VAT;

    print('Documentation Charge: \Rs. ${documentationCharge}');
    print('Handling Charge: \Rs. ${handlingCharge}');
    print('Storage Charge: \Rs. ${storageCharge}');
    print('Old cargo charges: \Rs. ${oldCargoCharges}');
    print(
        'Social security contribution levy: \Rs. ${socialSecurityContributionLevy}');
    print('VAT: \Rs. ${VAT}');
    print('Final Charges: \Rs. ${finalCharge}');

    final userSelection = UserSelection(
      arrivalDate: _arrivalDate!,
      clearingDate: _clearingDate!,
      location: _selectedLocation!,
      taxType: _selectedTaxType!,
      cargoType: _selectedCargoType!,
      chargeableWeight: chargeableWeight,
    );

    void _showChargesDialog(BuildContext context) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Charges Breakdown'),
            content: SingleChildScrollView(
              child: ListBody(
                children: <Widget>[
                  Text(
                      'Documentation Charge: \Rs. ${documentationCharge.toStringAsFixed(2)}'),
                  Text(
                      'Handling Charge: \Rs. ${handlingCharge.toStringAsFixed(2)}'),
                  Text(
                      'Storage Charge: \Rs. ${storageCharge.toStringAsFixed(2)}'),
                  Text(
                      'Old Cargo Charges: \Rs. ${oldCargoCharges.toStringAsFixed(2)}'),
                  Text(
                      'Social Security Contribution Levy: \Rs. ${socialSecurityContributionLevy.toStringAsFixed(2)}'),
                  Text('VAT: \Rs. ${VAT.toStringAsFixed(2)}'),
                  Text('Final Charges: \Rs. ${finalCharge.toStringAsFixed(2)}'),
                ],
              ),
            ),
            actions: <Widget>[
              TextButton(
                child: Text('OK'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
            ],
          );
        },
      );
    }

    print(userSelection.toJson());
    _showChargesDialog(context);
  }

  void _showIncompleteFormDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Incomplete Form'),
          content: Text("Please fill all the fields."),
          actions: <Widget>[
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: Text('OK')),
          ],
        );
      },
    );
  }

  Future<void> _showInfoDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible:
          true, // User can dismiss the dialog by tapping outside
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Special Cargo Info'),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text(
                  'VALUABLES (STORED AT CUSTOMS BOND) AND LIVE ANIMALS/ LIVE CHICKS/LIVE FISH/FLOWERS\n'
                  'DANGEROUS GOODS.\n'
                  'EXPRESS HANDLING CHARGES (Courier Delivery within 01 Hour From ATA)',
                ),
              ],
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    Map<String, dynamic> customizationValues =
        customizeStorageCalculatorCard(screenWidth);
    Map<String, double> appBarCustomization = customizeAppBar(screenWidth);

    return Scaffold(
      appBar: AppBar(
        leading: Transform.translate(
          offset: Offset(8.0, -6.0),
          child: BackButton(color: Colors.white),
        ),
        title: Transform.translate(
          offset: Offset(appBarCustomization['titleXOffset'] ?? 0.0, -6.0),
          child: Text('Storage Calculator',
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
        child: Column(
          children: [
            Transform.translate(
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
                                'Storage Calculator Form',
                                style: TextStyle(
                                    fontSize:
                                        customizationValues['fontSize'] ?? 19.0,
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold),
                              ),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.grey[100],
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextButton(
                                    onPressed: () =>
                                        _selectedDate(context, true),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        _arrivalDate == null
                                            ? 'Select Flight Actual Arrival Date'
                                            : 'Arrival: ${_arrivalDate.toString().split(' ')[0]}',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              customizationValues['fontSize'] ??
                                                  19.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () => _selectedDate(context, true),
                                  icon: Icon(Icons.calendar_today,
                                      color: Color.fromARGB(255, 93, 93, 93)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          margin: EdgeInsets.only(top: 10.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.grey[100],
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 5.0),
                            child: Row(
                              children: [
                                Expanded(
                                  child: TextButton(
                                    onPressed: () =>
                                        _selectedDate(context, false),
                                    child: Align(
                                      alignment: Alignment.centerLeft,
                                      child: Text(
                                        _clearingDate == null
                                            ? 'Select Cargo Clearing Date'
                                            : 'Clearing: ${_clearingDate.toString().split(' ')[0]}',
                                        style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              customizationValues['fontSize'] ??
                                                  19.0,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                  onPressed: () =>
                                      _selectedDate(context, false),
                                  icon: Icon(Icons.calendar_today,
                                      color: Color.fromARGB(255, 93, 93, 93)),
                                ),
                              ],
                            ),
                          ),
                        ),
                        SizedBox(height: 14.0),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.grey[100],
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: DropdownButton<String>(
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 36.0,
                              underline: SizedBox(),
                              style: TextStyle(
                                  fontSize:
                                      customizationValues['fontSize'] ?? 19.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              hint: Text('Select Room Type',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              value: _selectedLocation,
                              isExpanded: true,
                              items: <String>[
                                'Normal Room',
                                'Cool Room (20 to -20 degrees celcius)'
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedLocation = newValue;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 14.0),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.grey[100],
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: DropdownButton<String>(
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 36.0,
                              underline: SizedBox(),
                              style: TextStyle(
                                  fontSize:
                                      customizationValues['fontSize'] ?? 19.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              hint: Text('Select Tax Type',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              value: _selectedTaxType,
                              isExpanded: true,
                              items: <String>['VAT', 'SVAT', 'No VAT']
                                  .map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              onChanged: (String? newValue) {
                                setState(() {
                                  _selectedTaxType = newValue;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 14.0),
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
                            child: DropdownButton<String>(
                              icon: Icon(Icons.arrow_drop_down),
                              iconSize: 36.0,
                              underline: SizedBox(),
                              style: TextStyle(
                                  fontSize:
                                      customizationValues['fontSize'] ?? 19.0,
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                              hint: Text('Select Cargo Type',
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold)),
                              value: _selectedCargoType,
                              isExpanded: true,
                              items: <String>[
                                'General Cargo',
                                'Special Cargo',
                                'Courier',
                                'Courier Detained',
                                'Courier House Airway Bill'
                              ].map((String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(value),
                                      if (value == 'Special Cargo')
                                        IconButton(
                                          icon: Icon(Icons.info_outline,
                                              size: 20.0),
                                          onPressed: _showInfoDialog,
                                        ),
                                    ],
                                  ),
                                );
                              }).toList(),
                              onChanged: (value) {
                                setState(() {
                                  _selectedCargoType = value;
                                });
                              },
                            ),
                          ),
                        ),
                        SizedBox(height: 14.0),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(8.0),
                            color: Colors.grey[100],
                          ),
                          child: Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 12.0),
                            child: TextFormField(
                                controller: _weightController,
                                decoration: InputDecoration(
                                  labelText: 'Chargeable Weight - kg',
                                  labelStyle: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize:
                                          customizationValues['fontSize'] ??
                                              19.0),
                                  border: InputBorder.none,
                                  errorText: _weightErrorMessage,
                                ),
                                style: TextStyle(
                                    fontSize:
                                        customizationValues['fontSize'] ?? 8.0,
                                    color: Colors.black,
                                    fontWeight: FontWeight.bold),
                                keyboardType: TextInputType.numberWithOptions(
                                    decimal: true),
                                onChanged: (value) {
                                  setState(() {
                                    _weightErrorMessage = double.tryParse(
                                                value) ==
                                            null
                                        ? 'Invalid number. Please try again.'
                                        : null;
                                  });
                                }),
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ), // Calculate and Clear Buttons
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: <Widget>[
                            ElevatedButton(
                              onPressed: _handleFormSubmision,
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 3, 75, 135),
                                  foregroundColor: Colors.white),
                              child: Text('Calculate'),
                            ),
                            ElevatedButton(
                              onPressed: _clearForm,
                              style: ElevatedButton.styleFrom(
                                  backgroundColor:
                                      const Color.fromARGB(255, 3, 75, 135),
                                  foregroundColor: Colors.white),
                              child: Text('Clear'),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Transform.translate(
              offset: Offset(customizationValues['noteTextOffsetX'] ?? 0.0,
                  customizationValues['noteTextOffsetY'] ?? 0.0),
              child: Padding(
                padding: const EdgeInsets.all(10.0),
                child: Text(
                  'Note : "Multiple cargo type for single \nshipment and future delivery dates\n selection option will be promoted\n with next release"',
                  style: TextStyle(
                    fontSize: customizationValues['noteFontSize'] ?? 16.0,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ],
        ),
      )),
    );
  }
}
