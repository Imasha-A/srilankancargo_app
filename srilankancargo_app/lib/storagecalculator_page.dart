import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_svg/svg.dart';
import 'package:srilankancargo_app/about_us_page.dart';
import 'package:srilankancargo_app/contact_us_page.dart';
import 'package:srilankancargo_app/main.dart';

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

class StorageCalPage extends StatefulWidget {
  @override
  _StorageCalPageState createState() => _StorageCalPageState();
}

class _StorageCalPageState extends State<StorageCalPage> {
  DateTime? _arrivalDate;
  DateTime? _clearingDate;
  String? _selectedLocation;
  String? _selectedTaxType;
  String? _selectedCargoType;
  bool _canNavigate = true;
  bool _fetched = false;
  TextEditingController _weightController = TextEditingController();

  String? _weightErrorMessage;
  //holidays of 2024
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

  Map<String, double> customizeFormCard(double screenWidth) {
    Map<String, double> customizationValues = {};

    if (screenWidth == 1024) {
      customizationValues['cardMargin'] = 70.0;
      customizationValues['cardOffset'] = 400.0;
      customizationValues['iconOffset'] = 660.5;
      customizationValues['buttonPadding'] = 40.0;
      customizationValues['cardHeight'] = 333;
    } else if (screenWidth == 834) {
      customizationValues['cardMargin'] = 50.0;
      customizationValues['cardOffset'] = 280.0;
      customizationValues['iconOffset'] = 515.5;
      customizationValues['buttonPadding'] = 38.0;
    } else if (screenWidth >= 768) {
      customizationValues['cardMargin'] = 86.0;
      customizationValues['cardOffset'] = 278.0;
      customizationValues['iconOffset'] = 425.5;
      customizationValues['buttonPadding'] = 54.0;
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
      customizationValues['appBarOffsetPercentage'] = -0.60;
      customizationValues['titleXOffset'] = 60.0;
    }
    if (screenWidth == 430) {
      customizationValues['appBarOffsetPercentage'] = -0.60;
      customizationValues['titleXOffset'] = 0.0;
    }

    return customizationValues;
  }

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

  TableRow _buildTableRow(String description, double value) {
    return TableRow(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            description,
            style: TextStyle(color: Color.fromARGB(255, 28, 31, 106)),
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 4.0),
          child: Text(
            value.toStringAsFixed(2),
            textAlign: TextAlign.right,
            style: TextStyle(color: Color.fromARGB(255, 28, 31, 106)),
          ),
        ),
      ],
    );
  }

  Future<void> _selectedDate(BuildContext context, bool isArrivalDate) async {
    if (isArrivalDate) {
      // For Arrival Date
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: DateTime.now(),
          firstDate: DateTime.now(),
          lastDate: DateTime(DateTime.now().year + 1),
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: Color.fromARGB(255, 28, 31, 106),
                hintColor: Color.fromARGB(255, 28, 31, 106),
                buttonTheme:
                    ButtonThemeData(textTheme: ButtonTextTheme.primary),
                dialogBackgroundColor: Colors.lightBlue[50],
                colorScheme: ColorScheme.light(
                    primary: Color.fromARGB(255, 28, 31, 106)),
              ),
              child: child!,
            );
          });
      if (picked != null) {
        setState(() {
          _arrivalDate = picked;

          if (_clearingDate != null && _clearingDate!.isBefore(_arrivalDate!)) {
            _clearingDate = null;
          }
        });
      }
    } else {
      final DateTime firstDate = _arrivalDate ?? DateTime.now();
      final DateTime? picked = await showDatePicker(
          context: context,
          initialDate: _clearingDate ?? firstDate,
          firstDate: firstDate,
          lastDate: DateTime(DateTime.now().year + 1),
          builder: (BuildContext context, Widget? child) {
            return Theme(
              data: ThemeData.light().copyWith(
                primaryColor: Color.fromARGB(255, 28, 31, 106),
                hintColor: Color.fromARGB(255, 28, 31, 106),
                buttonTheme:
                    ButtonThemeData(textTheme: ButtonTextTheme.primary),
                dialogBackgroundColor: Colors.lightBlue[50],
                colorScheme: ColorScheme.light(
                    primary: Color.fromARGB(255, 28, 31, 106)),
              ),
              child: child!,
            );
          });
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
    _fetched = true;

    finalCharge = finalCharge + socialSecurityContributionLevy + VAT;

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
            title: Center(
              child: Text(
                'Storage Charge',
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                  color: Color.fromARGB(255, 28, 31, 106),
                ),
              ),
            ),
            content: SingleChildScrollView(
              child: Column(
                children: [
                  Table(
                    columnWidths: {
                      0: FlexColumnWidth(2),
                      1: FlexColumnWidth(1),
                    },
                    children: [
                      const TableRow(
                        children: [
                          Text(
                            'Description',
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Color.fromARGB(255, 28, 31, 106),
                            ),
                          ),
                          Text(
                            'Price (LKR)',
                            textAlign: TextAlign.right,
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 14,
                              color: Color.fromARGB(255, 28, 31, 106),
                            ),
                          ),
                        ],
                      ),
                      _buildTableRow(
                          'Documentation Charge', documentationCharge),
                      _buildTableRow('Handling Charge', handlingCharge),
                      _buildTableRow('Storage Charge', storageCharge),
                      _buildTableRow('Old Cargo Charge', oldCargoCharges),
                      _buildTableRow(
                          'SSC Levy', socialSecurityContributionLevy),
                      _buildTableRow('VAT', VAT),
                    ],
                  ),
                  SizedBox(height: 5),
                  Divider(
                    thickness: 1,
                    color: Color.fromARGB(255, 28, 31, 106),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Final Charges',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color.fromARGB(255, 28, 31, 106),
                        ),
                      ),
                      Text(
                        '${finalCharge.toStringAsFixed(2)}',
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                          color: Color.fromARGB(255, 28, 31, 106),
                        ),
                        textAlign: TextAlign.right,
                      ),
                    ],
                  ),
                ],
              ),
            ),
            actions: <Widget>[
              Center(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    padding: EdgeInsets.symmetric(horizontal: 102),
                    backgroundColor: Color.fromARGB(255, 28, 31, 106),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                  ),
                  child: Text(
                    'Close',
                    style: TextStyle(
                      fontSize: 16,
                      color: Colors.white,
                    ),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
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
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12.0),
          ),
          title: Text(
            'Incomplete Form',
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Color.fromARGB(255, 28, 31, 106),
              fontWeight: FontWeight.bold,
              fontSize: 22,
            ),
          ),
          content: Text(
            "Please fill all the fields.",
            textAlign: TextAlign.center,
          ),
          actions: <Widget>[
            Center(
              child: SizedBox(
                width: 250,
                height: 50,
                child: TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: Text(
                    'OK',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                  style: TextButton.styleFrom(
                    backgroundColor: Color.fromARGB(255, 28, 31, 106),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  Future<void> _showInfoDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true,
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

  Future<void> _handleBackButton(BuildContext context) async {
    double screenWidth = MediaQuery.of(context).size.width;

    if (_fetched) {
      bool? shouldExit = await showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text('Confirm Exit'),
            titleTextStyle: TextStyle(
                color: Color.fromARGB(255, 21, 5, 126),
                fontWeight: FontWeight.bold,
                fontSize: screenWidth * 0.06),
            content: Text(
                'Are you sure you want to leave? Flight information will be lost.'),
            contentTextStyle: TextStyle(
                color: Color.fromARGB(255, 21, 7, 110),
                fontSize: screenWidth * 0.045),
            actions: <Widget>[
              TextButton(
                onPressed: () {
                  _canNavigate = false;
                  Navigator.of(context).pop(false); // Stay on the page
                },
                child: Text('Cancel',
                    style: TextStyle(
                        color: Color.fromARGB(255, 25, 7, 138),
                        fontSize: screenWidth * 0.043)),
              ),
              TextButton(
                onPressed: () {
                  _canNavigate = true;
                  Navigator.of(context).pop(true); // Exit the page
                },
                child: Text('Yes',
                    style: TextStyle(
                        color: Color.fromARGB(255, 25, 7, 138),
                        fontSize: screenWidth * 0.043)),
              ),
            ],
          );
        },
      );

      if (shouldExit == true) {
        _canNavigate = true;
        Navigator.of(context).pop(); // Perform the back navigation if confirmed
      }
    } else {
      _canNavigate = true;
      Navigator.of(context)
          .pop(); // Allow back navigation if no flight info is loaded
    }
  }

  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    double buttonPadding = screenWidth * 0.128;
    Map<String, double> customizationValues = customizeFormCard(screenWidth);

    return Scaffold(
      body: GestureDetector(
        onTap: () {
          FocusScope.of(context).unfocus(); // Dismiss the keyboard
        },
        child: Stack(
          children: [
            // Top Banner Image (bottom layer)
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Image.asset(
                'assets/images/storage_calculator.png',
                fit: BoxFit.cover,
                height: 185,
              ),
            ),
            Positioned(
              top: screenHeight * 0.04,
              left: screenWidth * 0.001,
              child: SizedBox(
                width: 58,
                height: 48,
                child: BackButton(
                  color: Color.fromARGB(255, 255, 255, 255),
                ),
              ),
            ),

            // Outer White Card (middle layer) wrapping the form
            Positioned(
              top: screenHeight * 0.18,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.all(18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      spreadRadius: 2,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      'Storage Calculator',
                      style: TextStyle(
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                        color: Color.fromARGB(255, 28, 31, 106),
                      ),
                    ),

                    const SizedBox(height: 10),
                    // Inner White Card with the Flight Form
                    Container(
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(10),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5),
                            spreadRadius: 1,
                            blurRadius: 3,
                            offset: Offset(0, 3),
                          ),
                        ],
                      ),
                      padding: EdgeInsets.all(16),
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Flight Actual Arrival Date',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 28, 31, 106)),
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: const Color.fromARGB(255, 245, 245, 245),
                              border: Border.all(
                                color: Color.fromARGB(255, 204, 203, 203),
                                width: 1.0,
                              ),
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
                                              ? 'YYYY-MM-DD'
                                              : 'Arrival: ${_arrivalDate.toString().split(' ')[0]}',
                                          style: TextStyle(
                                            color: _arrivalDate == null
                                                ? Color.fromARGB(
                                                    255, 204, 203, 203)
                                                : const Color.fromARGB(
                                                    255, 135, 130, 130),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  IconButton(
                                    onPressed: () =>
                                        _selectedDate(context, true),
                                    icon: Icon(Icons.calendar_today,
                                        color: Color.fromARGB(255, 93, 93, 93)),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Flight Cargo Clearing Date',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 28, 31, 106)),
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Color.fromARGB(255, 245, 245, 245),
                              border: Border.all(
                                color: Color.fromARGB(255, 204, 203, 203),
                                width: 1.0,
                              ),
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
                                              ? 'YYYY-MM-DD'
                                              : 'Clearing: ${_clearingDate.toString().split(' ')[0]}',
                                          style: TextStyle(
                                            color: _clearingDate == null
                                                ? Color.fromARGB(
                                                    255, 204, 203, 203)
                                                : const Color.fromARGB(
                                                    255, 135, 130, 130),
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14,
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
                          SizedBox(height: 10.0),
                          Text(
                            'Chargeable Weight',
                            style: TextStyle(
                              fontSize: 14,
                              fontWeight: FontWeight.w600,
                              color: Color.fromARGB(255, 28, 31, 106),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Color.fromARGB(255, 245, 245, 245),
                              border: Border.all(
                                color: Color.fromARGB(255, 204, 203, 203),
                                width: 1.0,
                              ),
                            ),
                            child: Row(
                              children: [
                                Expanded(
                                  child: Padding(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8.0),
                                    child: TextFormField(
                                      controller: _weightController,
                                      decoration: InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                          vertical: 18.0,
                                          horizontal: 8.0,
                                        ),
                                        hintText: 'Chargeable Weight',
                                        hintStyle: TextStyle(
                                          color: const Color.fromARGB(
                                              255, 204, 203, 203),
                                          fontWeight: FontWeight.bold,
                                          fontSize:
                                              customizationValues['fontSize'] ??
                                                  14.0,
                                        ),
                                        border: InputBorder.none,
                                        errorText: _weightErrorMessage,
                                      ),
                                      style: TextStyle(
                                        fontSize:
                                            customizationValues['fontSize'] ??
                                                14.0,
                                        color: const Color.fromARGB(
                                            255, 135, 130, 130),
                                        fontWeight: FontWeight.bold,
                                      ),
                                      keyboardType:
                                          TextInputType.numberWithOptions(
                                              decimal: true),
                                      onChanged: (value) {
                                        setState(() {
                                          _weightErrorMessage = double.tryParse(
                                                      value) ==
                                                  null
                                              ? 'Invalid number. Please try again.'
                                              : null;
                                        });
                                      },
                                    ),
                                  ),
                                ),
                                // Box with "kg" on the right
                                Container(
                                  height: 57.0,
                                  padding:
                                      EdgeInsets.symmetric(horizontal: 12.0),
                                  decoration: BoxDecoration(
                                    color: Color.fromARGB(255, 170, 170,
                                        170), // Darker grey background
                                    borderRadius: BorderRadius.only(
                                      topRight: Radius.circular(8.0),
                                      bottomRight: Radius.circular(8.0),
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    'kg',
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 14.0,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            'Cargo Type',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 28, 31, 106)),
                          ),
                          Container(
                            width: double.infinity,
                            padding: EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Colors.grey[100],
                              border: Border.all(
                                  color: Color.fromARGB(255, 204, 203, 203),
                                  width: 1.0),
                            ),
                            child: Transform.translate(
                              offset: Offset(-1.0, 0.0),
                              child: DropdownButton<String>(
                                icon: Icon(Icons.arrow_drop_down),
                                iconSize: 36.0,
                                underline: SizedBox(),
                                style: TextStyle(
                                    fontSize:
                                        customizationValues['fontSize'] ?? 14.0,
                                    color: const Color.fromARGB(
                                        255, 135, 130, 130),
                                    fontWeight: FontWeight.bold),
                                hint: Text('Select Cargo Type',
                                    style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 204, 203, 203),
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
                          SizedBox(height: 10.0),
                          Text(
                            'Room Type',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 28, 31, 106)),
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: Color.fromARGB(255, 245, 245, 245),
                              border: Border.all(
                                color: Color.fromARGB(255, 204, 203, 203),
                                width: 1.0,
                              ),
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
                                        customizationValues['fontSize'] ?? 14.0,
                                    color: const Color.fromARGB(
                                        255, 135, 130, 130),
                                    fontWeight: FontWeight.bold),
                                hint: Text('Select Room Type',
                                    style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 204, 203, 203),
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
                          SizedBox(height: 10.0),
                          Text(
                            'Tax Type',
                            style: TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w600,
                                color: Color.fromARGB(255, 28, 31, 106)),
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(8.0),
                              color: const Color.fromARGB(255, 245, 245, 245),
                              border: Border.all(
                                color: Color.fromARGB(255, 204, 203, 203),
                                width: 1.0,
                              ),
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
                                        customizationValues['fontSize'] ?? 14.0,
                                    color: Color.fromARGB(255, 135, 130, 130),
                                    fontWeight: FontWeight.bold),
                                hint: Text('Select Tax Type',
                                    style: TextStyle(
                                        color: const Color.fromARGB(
                                            255, 204, 203, 203),
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
                          SizedBox(height: 10.0),
                          Center(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                ElevatedButton(
                                  onPressed: () {
                                    _clearForm();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    foregroundColor:
                                        Color.fromARGB(255, 28, 31, 106),
                                    backgroundColor: Colors.white,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: buttonPadding,
                                        vertical: 10),
                                    side: BorderSide(
                                        color: Color.fromARGB(255, 28, 31, 106),
                                        width: 1),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    'Clear',
                                    style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color:
                                            Color.fromARGB(255, 28, 31, 106)),
                                  ),
                                ),
                                const SizedBox(width: 8),
                                ElevatedButton(
                                  onPressed: () {
                                    _handleFormSubmision();
                                  },
                                  style: ElevatedButton.styleFrom(
                                    padding: EdgeInsets.symmetric(
                                        horizontal: buttonPadding,
                                        vertical: 10),
                                    backgroundColor: Color.fromARGB(
                                        255, 28, 31, 106), // Blue fill
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                  ),
                                  child: Text(
                                    'Calculate',
                                    style: TextStyle(
                                      fontSize: 16,
                                      color: Color.fromARGB(255, 255, 255,
                                          255), // White text color
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: screenHeight),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
       // Bottom Navigation Bar
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            color: Colors.white,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.1), // Shadow color
                offset: Offset(0, -2), // Shadow position
                blurRadius: 4, // Shadow blur radius
              ),
            ],
          ),
          child: BottomNavigationBar(
            backgroundColor: Colors.white,
            elevation: 0,
            items: [

          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/home_icon.svg',
              height: screenHeight * .03,
              width: screenWidth * .03,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/contact_us_icon.svg',
              height: screenHeight * .03,
              width: screenWidth * .03,
            ),
            label: 'Contact Us',
          ),
          BottomNavigationBarItem(
            icon: SvgPicture.asset(
              'assets/images/about_us_icon.svg',
              height: screenHeight * .03,
              width: screenWidth * .03,
            ),
            label: 'About Us',
          ),
        ],
        selectedItemColor: Color.fromARGB(255, 28, 31, 106),
        unselectedItemColor: Color.fromARGB(255, 28, 31, 106),
        onTap: (index) {
          _handleNavigation(index, context);
        },
      ),
        ),
    );
  }

  Future<void> _handleNavigation(int index, BuildContext context) async {
    _canNavigate = true;

    await _handleBackButton(context);

    if (_canNavigate) {
      if (index == 0) {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => MyHomePage(title: 'Flutter Demo Home Page'),
          ),
        );
      } else if (index == 1) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => ContactUsPage()),
        );
      } else if (index == 2) {
        Navigator.push(
          context,
          MaterialPageRoute(builder: (context) => AboutUsPage()),
        );
      }
    }
  }
}
