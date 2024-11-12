import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:universal_calculator/general/BMI/current_bmi.dart';

class BMICalcMainPage extends StatelessWidget {
  final TextEditingController _ageController = TextEditingController();
  final TextEditingController _heightController = TextEditingController();
  final TextEditingController _weightController = TextEditingController();
  BMICalcMainPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text("BMI"),
          centerTitle: true,
        ),
        resizeToAvoidBottomInset: false,
        body: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Age",
                style: TextStyle(color: Colors.blueGrey, fontSize: 15),
              ),
              TextFormField(
                controller: _ageController,
                decoration: InputDecoration(
                  labelText: "Enter age",
                  labelStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 35,
              ),
              Text(
                "Height(cm)",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.blueGrey,
                ),
              ),
              TextFormField(
                controller: _heightController,
                decoration: InputDecoration(
                  labelText: "Enter Height",
                  labelStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 35,
              ),
              Text(
                "Weight(kg)",
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.blueGrey,
                ),
              ),
              TextFormField(
                controller: _weightController,
                decoration: InputDecoration(
                  labelText: "Enter Weight",
                  labelStyle: TextStyle(
                    fontSize: 20,
                    color: Colors.grey,
                    fontWeight: FontWeight.w300,
                  ),
                ),
                keyboardType: TextInputType.number,
              ),
              SizedBox(
                height: 35,
              ),
              Text(
                "About BMI",
                style: TextStyle(
                    fontWeight: FontWeight.w700, color: Colors.grey.shade700),
              ),
              Text(
                '''Body mass index (BMI) is a person's weight in
kilograms divided by the square of height in meters.
BMI is an easy screening method for weight category.''',
                style: TextStyle(color: Colors.grey),
              ),
              Spacer(),
              Container(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () {
                    if (_ageController.text.isNotEmpty &&
                        _heightController.text.isNotEmpty &&
                        _weightController.text.isNotEmpty) {
                      int age = int.parse(_ageController.text);
                      if (age <= 14) {
                        showDialog(
                            context: context,
                            builder: (context) {
                              Timer(Duration(seconds: 2), () {
                                Navigator.of(context).pop();
                              });
                              return AlertDialog(
                                content: Text(
                                    "Can't display BMI for people younger than 14"),
                              );
                            });
                        return;
                      }
                      int height = int.parse(_heightController.text);
                      int weight = int.parse(_weightController.text);
                      double bmi = calculateBMI(height, weight);
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => CurrentBMI(
                                  age: age,
                                  height: height,
                                  weight: weight,
                                  bmi: bmi)));
                    }
                  },
                  child: Text(
                    'Calculate',
                    style: TextStyle(color: Colors.white, fontSize: 18),
                  ),
                  style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.orange, // Button color
                      padding: EdgeInsets.symmetric(vertical: 15),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ) // Button padding
                      ),
                ),
              ),
            ],
          ),
        ));
  }

  double calculateBMI(int height, int weight) {
    double heightM = height / 100;
    double bmi = weight / (heightM * heightM);
    return double.parse(bmi.toStringAsFixed(1));
  }
}
