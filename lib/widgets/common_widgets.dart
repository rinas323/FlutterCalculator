import 'package:flutter/material.dart';

Widget buildButton(String buttonText, double buttonSize, Color buttonColor,
    BuildContext context, VoidCallback pressed) {
  return Container(
    width: MediaQuery.of(context).size.width * buttonSize,
    padding: EdgeInsets.all(10),
    child: ElevatedButton(
      onPressed: pressed,
      child: Text(
        buttonText,
        style: TextStyle(fontSize: 25, color: buttonColor),
      ),
    ),
  );
}

Widget calculatorButton(String buttonText, double buttonSize, Color buttonColor,
    BuildContext context, VoidCallback pressed) {
  return Container(
    width: MediaQuery.of(context).size.width * buttonSize,
    padding: EdgeInsets.all(10),
    child: ElevatedButton(
      style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(0),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white10)),
      onPressed: pressed,
      child: Text(
        buttonText,
        style: TextStyle(
          fontSize: 25,
          color: buttonColor,
        ),
      ),
    ),
  );
}
