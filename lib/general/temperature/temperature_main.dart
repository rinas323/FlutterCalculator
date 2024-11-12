import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:universal_calculator/widgets/common_widgets.dart';

class TemperatureConversionMainPage extends StatefulWidget {
  static int selected = 0;
  const TemperatureConversionMainPage({super.key});

  @override
  State<TemperatureConversionMainPage> createState() =>
      _TemperatureConversionMainPageState();
}

class _TemperatureConversionMainPageState
    extends State<TemperatureConversionMainPage> {
  final _celsuisInputController = TextEditingController();
  final _kelvinInputController = TextEditingController();
  final _fahrenheitInputcontroller = TextEditingController();
  final _rankineInputController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Temperature"),
      ),
      body: Center(
        child: Column(
          children: [
            customInputField(
              inputFieldName: "Celsuis",
              controller: _celsuisInputController,
              onTapFunction: _appendValues,
              position: 0,
            ),
            const SizedBox(height: 10),
            customInputField(
              inputFieldName: "Fahrenheit",
              controller: _fahrenheitInputcontroller,
              onTapFunction: _appendValues,
              position: 1,
            ),
            const SizedBox(height: 10),
            customInputField(
              inputFieldName: "Kelvin",
              controller: _kelvinInputController,
              onTapFunction: _appendValues,
              position: 2,
            ),
            const SizedBox(height: 10),
            customInputField(
              inputFieldName: "Rankine",
              controller: _rankineInputController,
              onTapFunction: _appendValues,
              position: 3,
            ),
            const SizedBox(height: 10),
            Expanded(
              child: GridView.count(
                crossAxisCount: 4,
                children: [
                  calculatorButton(
                      '7',
                      0.25,
                      Colors.black,
                      context,
                      () => _appendValues(
                          "7", TemperatureConversionMainPage.selected)),
                  calculatorButton(
                      '8',
                      0.25,
                      Colors.black,
                      context,
                      () => _appendValues(
                          "8", TemperatureConversionMainPage.selected)),
                  calculatorButton(
                      '9',
                      0.25,
                      Colors.black,
                      context,
                      () => _appendValues(
                          "9", TemperatureConversionMainPage.selected)),
                  calculatorButton(
                      'C', 0.25, Colors.orange, context, () => _clear()),
                  calculatorButton(
                      '4',
                      0.25,
                      Colors.black,
                      context,
                      () => _appendValues(
                          "4", TemperatureConversionMainPage.selected)),
                  calculatorButton(
                      '5',
                      0.25,
                      Colors.black,
                      context,
                      () => _appendValues(
                          "5", TemperatureConversionMainPage.selected)),
                  calculatorButton(
                      '6',
                      0.25,
                      Colors.black,
                      context,
                      () => _appendValues(
                          "6", TemperatureConversionMainPage.selected)),
                  calculatorButton('⌫', 0.25, Colors.orange, context,
                      () => _backSpace(TemperatureConversionMainPage.selected)),
                  calculatorButton(
                      '1',
                      0.25,
                      Colors.black,
                      context,
                      () => _appendValues(
                          "1", TemperatureConversionMainPage.selected)),
                  calculatorButton(
                      '2',
                      0.25,
                      Colors.black,
                      context,
                      () => _appendValues(
                          "2", TemperatureConversionMainPage.selected)),
                  calculatorButton(
                      '3',
                      0.25,
                      Colors.black,
                      context,
                      () => _appendValues(
                          "3", TemperatureConversionMainPage.selected)),
                  calculatorButton('=', 0.25, Colors.orange, context, () {}),
                  calculatorButton(
                      '.',
                      0.25,
                      Colors.black,
                      context,
                      () => _appendValues(
                          ".", TemperatureConversionMainPage.selected)),
                  calculatorButton(
                      '0',
                      0.25,
                      Colors.black,
                      context,
                      () => _appendValues(
                          "0", TemperatureConversionMainPage.selected)),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void _appendValues(String txt, int num) {
    if (num == 0) {
      setState(() {
        _celsuisInputController.text += txt;
      });
    } else if (num == 1) {
      setState(() {
        _fahrenheitInputcontroller.text += txt;
      });
    } else if (num == 2) {
      setState(() {
        _kelvinInputController.text += txt;
      });
    } else if (num == 3) {
      setState(() {
        _rankineInputController.text += txt;
      });
    }
    _convertTemperature(num);
  }

  void _backSpace(int position) {
    setState(() {
      if (position == 0) {
        String _txt = _celsuisInputController.text;
        _celsuisInputController.text = _txt.substring(0, _txt.length - 1);
      } else if (position == 1) {
        String _txt = _fahrenheitInputcontroller.text;
        _fahrenheitInputcontroller.text = _txt.substring(0, _txt.length - 1);
      } else if (position == 2) {
        String _txt = _kelvinInputController.text;
        _kelvinInputController.text = _txt.substring(0, _txt.length - 1);
      } else if (position == 4) {
        String _txt = _rankineInputController.text;
        _rankineInputController.text = _txt.substring(0, _txt.length - 1);
      }
      if (_celsuisInputController.text.isEmpty ||
          _kelvinInputController.text.isEmpty ||
          _fahrenheitInputcontroller.text.isEmpty ||
          _rankineInputController.text.isEmpty) {
        _clear();
      }
    });
    _convertTemperature(position);
  }

  void _clear() {
    setState(() {
      _kelvinInputController.clear();
      _fahrenheitInputcontroller.clear();
      _rankineInputController.clear();
      _celsuisInputController.clear();
    });
  }

  Widget customInputField({
    required String inputFieldName,
    required TextEditingController controller,
    required int position,
    required Function onTapFunction,
  }) {
    final screenSize = MediaQuery.of(context).size;
    bool isSelected = TemperatureConversionMainPage.selected == position;

    return GestureDetector(
      onTap: () {
        setState(() {
          TemperatureConversionMainPage.selected = position;
        });
        onTapFunction();
      },
      child: AnimatedContainer(
        duration: Duration(milliseconds: 300),
        width: screenSize.width * 0.9,
        height: screenSize.width * 0.9 * 0.15,
        constraints: BoxConstraints(
          minHeight: 48,
          maxHeight: 70,
        ),
        decoration: BoxDecoration(
            border: isSelected
                ? Border.all(color: Colors.blueGrey)
                : Border.all(color: Colors.grey),
            color: isSelected ? Colors.grey[200] : Colors.grey[100],
            borderRadius: BorderRadius.circular(12)),
        padding: isSelected
            ? EdgeInsets.symmetric(horizontal: 20)
            : EdgeInsets.symmetric(horizontal: 16),
        child: Row(
          children: [
            Expanded(
              child: Text(
                inputFieldName,
                style: TextStyle(
                  fontSize: 18,
                  color: isSelected ? Colors.black : Colors.black54,
                ),
              ),
            ),
            Expanded(
              child: TextField(
                controller: controller,
                readOnly: true,
                decoration: const InputDecoration(border: InputBorder.none),
                style: TextStyle(
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _convertTemperature(int selected) {
    double? celsius, fahrenheit, kelvin, rankine;

    switch (selected) {
      case 0:
        celsius = double.tryParse(_celsuisInputController.text);
        if (celsius != null) {
          fahrenheit = (celsius * 9 / 5) + 32;
          kelvin = celsius + 273.15;
          rankine = (celsius * 9 / 5) + 491.67;

          _fahrenheitInputcontroller.text = fahrenheit.toStringAsFixed(2);
          _kelvinInputController.text = kelvin.toStringAsFixed(2);
          _rankineInputController.text = rankine.toStringAsFixed(2);
        }
        break;

      case 1:
        fahrenheit = double.tryParse(_fahrenheitInputcontroller.text);
        if (fahrenheit != null) {
          celsius = (fahrenheit - 32) * 5 / 9;
          kelvin = (fahrenheit + 459.67) * 5 / 9;
          rankine = fahrenheit + 459.67;

          _celsuisInputController.text = celsius.toStringAsFixed(2);
          _kelvinInputController.text = kelvin.toStringAsFixed(2);
          _rankineInputController.text = rankine.toStringAsFixed(2);
        }
        break;

      case 2:
        kelvin = double.tryParse(_kelvinInputController.text);
        if (kelvin != null) {
          celsius = kelvin - 273.15;
          fahrenheit = (kelvin * 9 / 5) - 459.67;
          rankine = kelvin * 9 / 5;

          _celsuisInputController.text = celsius.toStringAsFixed(2);
          _fahrenheitInputcontroller.text = fahrenheit.toStringAsFixed(2);
          _rankineInputController.text = rankine.toStringAsFixed(2);
        }
        break;

      case 3:
        rankine = double.tryParse(_rankineInputController.text);
        if (rankine != null) {
          celsius = (rankine - 491.67) * 5 / 9;
          fahrenheit = rankine - 459.67;
          kelvin = rankine * 5 / 9;

          _celsuisInputController.text = celsius.toStringAsFixed(2);
          _fahrenheitInputcontroller.text = fahrenheit.toStringAsFixed(2);
          _kelvinInputController.text = kelvin.toStringAsFixed(2);
        }
        break;
    }
  }
}
