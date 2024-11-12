import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CurrentBMI extends StatelessWidget {
  final int age;
  final int height;
  final int weight;
  final double bmi;
  const CurrentBMI({
    super.key,
    required this.age,
    required this.height,
    required this.weight,
    required this.bmi,
  });

  @override
  Widget build(BuildContext context) {
    final txtStylContainer = TextStyle(fontSize: 18, color: Colors.black);
    return Scaffold(
      appBar: AppBar(
        title: Text("Your current BMI"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "${bmi}",
              style: TextStyle(
                fontSize: 55,
                fontWeight: FontWeight.w500,
              ),
            ),
            Text(
              "Body mass index",
              style: TextStyle(fontSize: 15, color: Colors.grey),
            ),
            SizedBox(
              height: 50,
            ),
            Center(child: _calc(bmi)),
            SizedBox(
              height: 50,
            ),
            Center(
              child: Container(
                child: Column(
                  //crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      "Underweight     0 - 18.5",
                      style: txtStylContainer,
                    ),
                    Container(
                      height: 1,
                      color: Colors.black,
                    ),
                    Text(
                      "Normal Weight     18.5 - 24.9",
                      style: txtStylContainer,
                    ),
                    Container(
                      height: 1,
                      color: Colors.black,
                    ),
                    Text(
                      "Overweight        25 - 29.9",
                      style: txtStylContainer,
                    ),
                    Container(
                      height: 1,
                      color: Colors.black,
                    ),
                    Text(
                      "Obese          30+",
                      style: txtStylContainer,
                    )
                  ],
                ),
                decoration: BoxDecoration(
                    color: Colors.grey,
                    border: Border.all(color: Colors.black38),
                    borderRadius: BorderRadius.circular(12)),
                height: 250,
                width: 250,
              ),
            ),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 1,
              color: Colors.grey,
            ),
          ],
        ),
      ),
    );
  }

  Widget _calc(double bmi) {
    if (bmi >= 0.0 && bmi <= 18.5) {
      return Text(
        "underweight",
        style: TextStyle(fontSize: 25, color: Colors.blue),
      );
    } else if (bmi >= 18.5 && bmi <= 24.9) {
      return Text(
        "normal weight",
        style: TextStyle(fontSize: 25, color: Colors.green),
      );
    } else if (bmi >= 25.0 && bmi <= 29.9) {
      return Text(
        "Overweight",
        style: TextStyle(fontSize: 25, color: Colors.orange),
      );
    } else {
      return Text(
        "Obese",
        style: TextStyle(fontSize: 25, color: Colors.red),
      );
    }
  }
}
