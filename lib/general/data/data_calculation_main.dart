import 'package:flutter/material.dart';
import 'package:universal_calculator/widgets/common_widgets.dart';

class DataCalculationMainPage extends StatefulWidget {
  @override
  _DataCalculationMainPageState createState() =>
      _DataCalculationMainPageState();
}

class _DataCalculationMainPageState extends State<DataCalculationMainPage> {
  final TextEditingController _inputController = TextEditingController();
  final TextEditingController _outputController = TextEditingController();

  String _inputUnit = 'Bit';
  String _outputUnit = 'Byte';

  final List<String> _units = [
    'Bit',
    'Kilobit',
    'Kibibit',
    'Mebibit',
    'Gibibit',
    'Terabit',
    'Tebibit',
    'Petabit',
    'Byte',
    'Kilobyte',
    'Kibibyte',
    'Mebibyte',
    'Gibibyte',
    'Terabyte',
    'Tebibyte',
    'Petabyte',
    'Pebibyte',
  ];

  @override
  void initState() {
    super.initState();
    _inputController.addListener(_convertData);
  }

  @override
  void dispose() {
    _inputController.dispose();
    _outputController.dispose();
    super.dispose();
  }

  void _convertData() {
    double input = double.tryParse(_inputController.text) ?? 0.0;
    double output = convertData(input, _inputUnit, _outputUnit);

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
        title: Text('Data'),
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
                    _convertData();
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
                      labelText: 'Input Data',
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
                    _convertData();
                  });
                }),
                Expanded(
                  child: TextField(
                    controller: _outputController,
                    readOnly: true,
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10)),
                      labelText: 'Converted Data',
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

  double convertData(double value, String fromUnit, String toUnit) {
    // Conversion factors to bits
    Map<String, double> toBits = {
      'Bit': 1.0,
      'Kilobit': 1e3,
      'Kibibit': 1024.0,
      'Mebibit': 1048576.0,
      'Gibibit': 1073741824.0,
      'Terabit': 1e12,
      'Tebibit': 1099511627776.0,
      'Petabit': 1e15,
      'Byte': 8.0,
      'Kilobyte': 8e3,
      'Kibibyte': 8192.0,
      'Mebibyte': 8388608.0,
      'Gibibyte': 8589934592.0,
      'Terabyte': 8e12,
      'Tebibyte': 8796093022208.0,
      'Petabyte': 8e15,
      'Pebibyte': 9007199254740992.0,
    };

    // Convert from the input unit to bits
    double valueInBits = value * toBits[fromUnit]!;

    // Convert from bits to the output unit
    double valueInOutputUnit = valueInBits / toBits[toUnit]!;

    return valueInOutputUnit;
  }
}
