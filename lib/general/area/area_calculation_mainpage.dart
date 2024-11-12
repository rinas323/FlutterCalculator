import 'package:flutter/material.dart';
import 'package:universal_calculator/widgets/common_widgets.dart';

class AreaCalcMainpage extends StatefulWidget {
  @override
  _AreaCalcMainpageState createState() => _AreaCalcMainpageState();
}

class _AreaCalcMainpageState extends State<AreaCalcMainpage> {
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _outputController = TextEditingController();

  String _inputUnit = 'Square Kilometer';
  String _outputUnit = 'Square Meter';

  final List<String> _units = [
    'Square Kilometer',
    'Hectare',
    'Are',
    'Square decimeter',
    'Acre',
    'Qing',
    'Mu',
    'Square Meter',
    'Square Centimeter',
    'Square Millimeter',
    'Square Mile',
    'Square Yard',
    'Square Foot',
    'Square Inch',
    'Square rod',
    'Square chi',
    'Square cun',
  ];

  @override
  void initState() {
    super.initState();
    _inputController.addListener(_convertArea);
  }

  @override
  void dispose() {
    _inputController.dispose();
    _outputController.dispose();
    super.dispose();
  }

  void _convertArea() {
    double input = double.tryParse(_inputController.text) ?? 0.0;
    double output = convertArea(input, _inputUnit, _outputUnit);

    _outputController.text = output.toString();
  }

  Widget _buildDropdown(String value, ValueChanged<String?> onChanged) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: DropdownButton<String>(
        value: value,
        onChanged: onChanged,
        items: _units.map<DropdownMenuItem<String>>((String value) {
          return DropdownMenuItem<String>(
            value: value,
            child: Text(value),
          );
        }).toList(),
      ),
    );
  }

  Widget _buildCalculatorButton(String text, VoidCallback onPressed) {
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: ElevatedButton(
          onPressed: onPressed,
          child: Text(
            text,
            style: TextStyle(fontSize: 24, color: Colors.black),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Area Converter'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Row(
              children: [
                _buildDropdown(_inputUnit, (String? newValue) {
                  setState(() {
                    _inputUnit = newValue!;
                    _convertArea();
                  });
                }),
                Expanded(
                  child: TextField(
                    readOnly: true,
                    controller: _inputController,
                    keyboardType: TextInputType.number,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: 'Input Area',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              height: 10,
            ),
            Row(
              children: [
                _buildDropdown(_outputUnit, (String? newValue) {
                  setState(() {
                    _outputUnit = newValue!;
                    _convertArea();
                  });
                }),
                Expanded(
                  child: TextField(
                    controller: _outputController,
                    readOnly: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: 'Converted Area',
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(height: 35),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(13.0),
                child: GridView.count(
                  crossAxisCount: 3,
                  children: [
                    calculatorButton(
                      '7',
                      0.33,
                      Colors.black,
                      context,
                      () => _appendValue('7'),
                    ),
                    calculatorButton('8', 0.33, Colors.black, context,
                        () => _appendValue('8')),
                    calculatorButton('9', 0.33, Colors.black, context,
                        () => _appendValue('9')),
                    calculatorButton('4', 0.33, Colors.black, context,
                        () => _appendValue('4')),
                    calculatorButton('5', 0.33, Colors.black, context,
                        () => _appendValue('5')),
                    calculatorButton('6', 0.33, Colors.black, context,
                        () => _appendValue('6')),
                    calculatorButton('1', 0.33, Colors.black, context,
                        () => _appendValue('1')),
                    calculatorButton('2', 0.33, Colors.black, context,
                        () => _appendValue('2')),
                    calculatorButton('3', 0.33, Colors.black, context,
                        () => _appendValue('3')),
                    calculatorButton('0', 0.33, Colors.black, context,
                        () => _appendValue('0')),
                    calculatorButton('.', 0.33, Colors.black, context,
                        () => _appendValue('.')),
                    calculatorButton(
                        'C', 0.33, Colors.orange, context, _clearInput),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _appendValue(String value) {
    setState(() {
      _inputController.text = _inputController.text + value;
    });
  }

  void _clearInput() {
    setState(() {
      _inputController.clear();
    });
  }

  double convertArea(double value, String fromUnit, String toUnit) {
    // Conversion factors to square meters
    Map<String, double> toSquareMeter = {
      'Square Kilometer': 1e6,
      'Hectare': 1e4,
      'Are': 1e2,
      'Square decimeter': 1e-2,
      'Acre': 4046.85642,
      'Qing': 66666.6667,
      'Mu': 666.666667,
      'Square Meter': 1.0,
      'Square Centimeter': 1e-4,
      'Square Millimeter': 1e-6,
      'Square Mile': 2.58998811e6,
      'Square Yard': 0.83612736,
      'Square Foot': 0.09290304,
      'Square Inch': 0.00064516,
      'Square rod': 25.2929,
      'Square chi': 0.111111,
      'Square cun': 0.00111111,
    };

    // Convert from the input unit to square meters
    double valueInSquareMeters = value * toSquareMeter[fromUnit]!;

    // Convert from square meters to the output unit
    double valueInOutputUnit = valueInSquareMeters / toSquareMeter[toUnit]!;

    return valueInOutputUnit;
  }
}
