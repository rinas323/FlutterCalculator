import 'package:flutter/material.dart';
import 'package:universal_calculator/widgets/common_widgets.dart';

class WeightCalculationsMainPage extends StatefulWidget {
  @override
  _WeightCalculationsMainPageState createState() =>
      _WeightCalculationsMainPageState();
}

class _WeightCalculationsMainPageState
    extends State<WeightCalculationsMainPage> {
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _outputController = TextEditingController();

  String _inputUnit = 'Gram';
  String _outputUnit = 'Kilogram';

  final List<String> _units = [
    'Nanogram',
    'Microgram',
    'Milligram',
    'Centigram',
    'Decigram',
    'Hectogram',
    'Gram',
    'Kilogram',
    'Stone',
    'Short Ton',
    'Long Ton',
    'Grain',
  ];

  @override
  void initState() {
    super.initState();
    _inputController.addListener(_convertWeight);
  }

  @override
  void dispose() {
    _inputController.dispose();
    _outputController.dispose();
    super.dispose();
  }

  void _convertWeight() {
    double input = double.tryParse(_inputController.text) ?? 0.0;
    double output = convertWeight(input, _inputUnit, _outputUnit);

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
        title: Text('Weight'),
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
                    _convertWeight();
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
                      labelText: 'Input Weight',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            Row(
              children: [
                _buildDropdown(_outputUnit, (String? newValue) {
                  setState(() {
                    _outputUnit = newValue!;
                    _convertWeight();
                  });
                }),
                Expanded(
                  child: TextField(
                    controller: _outputController,
                    readOnly: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: 'Converted Weight',
                    ),
                  ),
                ),
              ],
            ),
            const SizedBox(height: 35),
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

  double convertWeight(double value, String fromUnit, String toUnit) {
    // Conversion factors to grams
    Map<String, double> toGrams = {
      'Nanogram': 1e-9,
      'Microgram': 1e-6,
      'Milligram': 1e-3,
      'Centigram': 1e-2,
      'Decigram': 1e-1,
      'Hectogram': 100.0,
      'Gram': 1.0,
      'Kilogram': 1e3,
      'Stone': 6350.29318,
      'Short Ton': 907184.74,
      'Long Ton': 1016046.91,
      'Grain': 0.06479891,
    };

    // Convert from the input unit to grams
    double valueInGrams = value * toGrams[fromUnit]!;

    // Convert from grams to the output unit
    double valueInOutputUnit = valueInGrams / toGrams[toUnit]!;

    return valueInOutputUnit;
  }
}
