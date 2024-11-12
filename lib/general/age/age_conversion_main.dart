import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class AgeConversionMainPage extends StatefulWidget {
  @override
  _AgeConversionMainPageState createState() => _AgeConversionMainPageState();
}

class _AgeConversionMainPageState extends State<AgeConversionMainPage> {
  DateTime? _birthdate;
  String? _ageResult;

  void _pickBirthDate() async {
    DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _birthdate = picked;
        _ageResult = null;
      });
    }
  }

  void _calculateAge() {
    if (_birthdate == null) return;

    DateTime now = DateTime.now();
    int years = now.year - _birthdate!.year;
    int months = now.month - _birthdate!.month;
    int days = now.day - _birthdate!.day;

    if (days < 0) {
      months -= 1;
      days += DateTime(now.year, now.month, 0).day;
    }
    if (months < 0) {
      years -= 1;
      months += 12;
    }

    setState(() {
      _ageResult = '$years years\n $months months\n  $days days\n';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Age Converter'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Select Your Birthdate',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            GestureDetector(
              onTap: _pickBirthDate,
              child: Container(
                padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: Text(
                  _birthdate != null
                      ? DateFormat('dd-MM-yyyy').format(_birthdate!)
                      : 'Tap to select date',
                  style: TextStyle(fontSize: 16),
                ),
              ),
            ),
            SizedBox(height: 20),
            if (_ageResult != null)
              Padding(
                padding: const EdgeInsets.only(top: 30),
                child: Text(
                  "Your age:\n$_ageResult",
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
            Spacer(),
            ElevatedButton(
              onPressed: _calculateAge,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Calculate Age',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
