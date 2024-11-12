import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:universal_calculator/widgets/common_widgets.dart';

class SpeedCalculationMainPage extends StatefulWidget {
  const SpeedCalculationMainPage({Key? key}) : super(key: key);

  @override
  _SpeedCalculationMainPageState createState() =>
      _SpeedCalculationMainPageState();
}

class _SpeedCalculationMainPageState extends State<SpeedCalculationMainPage> {
  final _inputController = TextEditingController();
  final _outputController = TextEditingController();
  String _inputUnit = 'Meter/second';
  String _outputUnit = 'Kilometer/Hour';

  final List<String> _units = [
    'Meter/second',
    'Kilometer/second',
    'Kilometer/Hour',
    'Mile/Hour',
    'Speed of Sound'
  ];

  void _convertSpeed() {
    double inputValue = double.tryParse(_inputController.text) ?? 0;
    double result = _convert(inputValue, _inputUnit, _outputUnit);
    _outputController.text = result.toStringAsFixed(2);
  }

  double _convert(double value, String fromUnit, String toUnit) {
    Map<String, double> conversionRates = {
      'Meter/second': 1.0,
      'Kilometer/second': 1000.0,
      'Kilometer/Hour': 0.277778,
      'Mile/Hour': 0.44704,
      'Speed of Sound': 343.0,
    };

    double valueInMetersPerSecond = value * conversionRates[fromUnit]!;
    return valueInMetersPerSecond / conversionRates[toUnit]!;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Speed Calculator'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildInputOutputField(
              inputLabel: 'Input',
              readOnly: true,
              inputController: _inputController,
              selectedUnit: _inputUnit,
              onUnitChanged: (newValue) {
                setState(() {
                  _inputUnit = newValue!;
                });
                _convertSpeed();
              },
            ),
            const SizedBox(height: 20),
            _buildInputOutputField(
              inputLabel: 'Output',
              inputController: _outputController,
              selectedUnit: _outputUnit,
              readOnly: true,
              onUnitChanged: (newValue) {
                setState(() {
                  _outputUnit = newValue!;
                });
                _convertSpeed();
              },
            ),
            SizedBox(height: 60),
            Expanded(
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
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget _buildInputOutputField({
    required String inputLabel,
    required TextEditingController inputController,
    required String selectedUnit,
    required Function(String?) onUnitChanged,
    bool readOnly = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange),
      ),
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        children: [
          DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: selectedUnit,
              onChanged: onUnitChanged,
              items: _units.map((String unit) {
                return DropdownMenuItem<String>(
                  value: unit,
                  child: Text(unit),
                );
              }).toList(),
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: TextField(
              controller: inputController,
              keyboardType: TextInputType.number,
              readOnly: readOnly,
              decoration: const InputDecoration(
                border: InputBorder.none,
              ),
              onChanged: readOnly ? null : (value) => _convertSpeed(),
            ),
          ),
        ],
      ),
    );
  }

  void _appendValue(String txt) {
    setState(() {
      _inputController.text += txt;
    });
    _convertSpeed();
  }

  void _clearInput() {
    _inputController.clear();
    _outputController.clear();
  }
}
