import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:universal_calculator/widgets/common_widgets.dart';

class VolumeCalculationMainPage extends StatefulWidget {
  const VolumeCalculationMainPage({Key? key}) : super(key: key);

  @override
  _VolumeCalculationMainPageState createState() =>
      _VolumeCalculationMainPageState();
}

class _VolumeCalculationMainPageState extends State<VolumeCalculationMainPage> {
  final _inputController = TextEditingController();
  final _outputController = TextEditingController();
  String _inputUnit = 'Kilometer\u00B3';
  String _outputUnit = 'Meter\u00B3';

  final List<String> _units = [
    'Micrometer\u00B3',
    'Millimeter\u00B3',
    'Centimeter\u00B3',
    'Decimeter\u00B3',
    'Meter\u00B3',
    'Dekameter\u00B3',
    'Hectometer\u00B3',
    'Kilometer\u00B3',
    'Nanoliter',
    'Microliter',
    'Milliliter',
    'Centiliter',
    'Dekaliter',
    'Hectoliter',
    'Kiloliter',
    'Inch\u00B3',
    'Foot\u00B3',
    'Yard\u00B3',
    'Mile\u00B3',
    'US Tablespoon',
    'US Teaspoon',
    'US Ounce',
    'US Cup',
    'US Pint',
    'US Quart',
    'US Gallon',
    'IMP Teaspoon',
    'IMP Tablespoon',
    'IMP Ounce',
    'IMP Cup',
    'IMP Pint',
    'IMP Quart',
    'IMP Gallon'
  ];

  void _convertVolume() {
    double inputValue = double.tryParse(_inputController.text) ?? 0;
    double result = _convert(inputValue, _inputUnit, _outputUnit);

    String formattedResult = result.toString();
    if (formattedResult.contains('e')) {
      formattedResult = result
          .toStringAsFixed(10)
          .replaceAll(RegExp(r'0+$'), '')
          .replaceAll(RegExp(r'\.$'), '');
    }

    setState(() {
      _outputController.text = formattedResult;
    });
  }

  double _convert(double value, String fromUnit, String toUnit) {
    Map<String, double> conversionRates = {
      'Micrometer\u00B3': 1e-18,
      'Millimeter\u00B3': 1e-9,
      'Centimeter\u00B3': 1e-6,
      'Decimeter\u00B3': 1e-3,
      'Meter\u00B3': 1.0,
      'Dekameter\u00B3': 1e3,
      'Hectometer\u00B3': 1e6,
      'Kilometer\u00B3': 1e9,
      'Nanoliter': 1e-12,
      'Microliter': 1e-9,
      'Milliliter': 1e-6,
      'Centiliter': 1e-5,
      'Decaliter': 1e-2,
      'Hectoliter': 0.1,
      'Kiloliter': 1.0,
      'Inch\u00B3': 1.6387e-5,
      'Foot\u00B3': 0.0283168,
      'Yard\u00B3': 0.764555,
      'Mile\u00B3': 4.16818e9,
      'US Tablespoon': 1.47868e-5,
      'US Teaspoon': 4.92892e-6,
      'US Ounce': 2.95735e-5,
      'US Cup': 2.36588e-4,
      'US Pint': 4.73176e-4,
      'US Quart': 9.46353e-4,
      'US Gallon': 3.78541e-3,
      'IMP Teaspoon': 5.91939e-6,
      'IMP Tablespoon': 1.77576e-5,
      'IMP Ounce': 2.84131e-5,
      'IMP Cup': 2.84131e-4,
      'IMP Pint': 5.68261e-4,
      'IMP Quart': 1.13652e-3,
      'IMP Gallon': 4.54609e-3,
    };

    double valueInCubicMeters = value * conversionRates[fromUnit]!;

    double result = valueInCubicMeters / conversionRates[toUnit]!;

    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Volume Calculator'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            _buildInputOutputField(
              inputLabel: 'Input',
              inputController: _inputController,
              selectedUnit: _inputUnit,
              onUnitChanged: (newValue) {
                setState(() {
                  _inputUnit = newValue!;
                });
                _convertVolume();
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
                _convertVolume();
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
              onChanged: readOnly ? null : (value) => _convertVolume(),
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
    _convertVolume();
  }

  void _clearInput() {
    _inputController.clear();
    _outputController.clear();
  }
}
