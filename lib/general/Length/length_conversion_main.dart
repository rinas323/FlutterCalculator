import 'package:flutter/material.dart';
import 'package:universal_calculator/widgets/common_widgets.dart';

class LengthConversionMainPage extends StatefulWidget {
  @override
  _LengthConversionMainPageState createState() =>
      _LengthConversionMainPageState();
}

class _LengthConversionMainPageState extends State<LengthConversionMainPage> {
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _outputController = TextEditingController();

  String _inputUnit = 'Meter';
  String _outputUnit = 'Kilometer';

  final List<String> _units = [
    'Nanometer',
    'Micrometer',
    'Millimeter',
    'Centimeter',
    'Decimeter',
    'Meter',
    'Dekameter',
    'Hectometer',
    'Kilometer',
    'Yard',
    'Nautical Mile',
    'Astronomical Unit',
    'Light Second',
    'Light Minute',
    'Light Hour',
    'Light Day',
    'Light Week',
    'Light Year',
    'Parsec',
  ];

  @override
  void initState() {
    super.initState();
    _inputController.addListener(_convertLength);
  }

  @override
  void dispose() {
    _inputController.dispose();
    _outputController.dispose();
    super.dispose();
  }

  void _convertLength() {
    double input = double.tryParse(_inputController.text) ?? 0.0;
    double output = convertLength(input, _inputUnit, _outputUnit);

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Length Converter'),
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
                    _convertLength();
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
                      labelText: 'Input Length',
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
                    _convertLength();
                  });
                }),
                Expanded(
                  child: TextField(
                    controller: _outputController,
                    readOnly: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: 'Converted Length',
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
                    calculatorButton('7', 0.33, Colors.black, context,
                        () => _appendValue('7')),
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
                        'C', 0.33, Colors.orange, context, _clearInput)
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

  double convertLength(double value, String fromUnit, String toUnit) {
    // Conversion factors to meters
    Map<String, double> toMeters = {
      'Nanometer': 1e-9,
      'Micrometer': 1e-6,
      'Millimeter': 1e-3,
      'Centimeter': 1e-2,
      'Decimeter': 1e-1,
      'Meter': 1.0,
      'Dekameter': 10.0,
      'Hectometer': 100.0,
      'Kilometer': 1e3,
      'Yard': 0.9144,
      'Nautical Mile': 1852.0,
      'Astronomical Unit': 1.496e11,
      'Light Second': 2.99792458e8,
      'Light Minute': 1.798754748e10,
      'Light Hour': 1.0792528488e12,
      'Light Day': 2.59020683712e13,
      'Light Week': 1.813144786e14,
      'Light Year': 9.4607e15,
      'Parsec': 3.085677581e16,
    };

    // Convert from the input unit to meters
    double valueInMeters = value * toMeters[fromUnit]!;

    // Convert from meters to the output unit
    double valueInOutputUnit = valueInMeters / toMeters[toUnit]!;

    return valueInOutputUnit;
  }
}
