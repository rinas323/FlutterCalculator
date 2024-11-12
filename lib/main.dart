import 'package:flutter/material.dart';
import 'package:universal_calculator/finance/finance_calculator_page.dart';
import 'package:universal_calculator/general/general_calculations_mainpage.dart';
import 'package:universal_calculator/scientific/scientific_calculations_mainpage.dart';
import 'package:math_expressions/math_expressions.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() {
  tz.initializeTimeZones();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Calculator App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Color _iconColor0 = Colors.black;
  Color _iconColor1 = Colors.black;
  Color _iconColor2 = Colors.black;
  Color _iconColor3 = Colors.black;
  int _currentPageIndex = 0;
  void _changeColor(int index) {
    setState(() {
      switch (index) {
        case 0:
          _iconColor0 = Colors.orange;
          _iconColor1 = Colors.black;
          _iconColor2 = Colors.black;
          _iconColor3 = Colors.black;
          break;
        case 1:
          _iconColor0 = Colors.black;
          _iconColor1 = Colors.orange;
          _iconColor2 = Colors.black;
          _iconColor3 = Colors.black;
          break;
        case 2:
          _iconColor0 = Colors.black;
          _iconColor1 = Colors.black;
          _iconColor2 = Colors.orange;
          _iconColor3 = Colors.black;
          break;
        case 3:
          _iconColor0 = Colors.black;
          _iconColor1 = Colors.black;
          _iconColor2 = Colors.black;
          _iconColor3 = Colors.orange;
          break;
        default:
      }
    });
  }

  void _changePage(int index) {
    setState(() {
      _currentPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          SizedBox(
            width: MediaQuery.of(context).size.width /
                4, // Distribute equally among 4 icons
            child: IconButton(
              icon: Icon(
                Icons.calculate_rounded,
                color: _iconColor0,
              ),
              iconSize: 28, // Set the size of the icon
              onPressed: () {
                _changePage(0);
                _changeColor(0);
              },
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 4,
            child: IconButton(
              icon: Icon(
                Icons.grid_view_rounded,
                color: _iconColor1,
              ),
              iconSize: 25,
              onPressed: () {
                _changePage(1);
                _changeColor(1);
              },
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 4,
            child: IconButton(
              icon: Icon(
                Icons.attach_money,
                color: _iconColor2,
              ),
              iconSize: 29,
              onPressed: () {
                _changePage(2);
                _changeColor(2);
              },
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 4,
            child: IconButton(
              icon: Icon(
                Icons.science_outlined,
                color: _iconColor3,
              ),
              iconSize: 25,
              onPressed: () {
                _changePage(3);
                _changeColor(3);
              },
            ),
          ),
        ],
      ),
      body: _buildBody(),
    );
  }

  Widget _buildBody() {
    switch (_currentPageIndex) {
      case 0:
        return GeneralCalculatorPage();
      case 1:
        return GeneralCalculationsPage();
      case 2:
        return FinanceCalculatorPage();
      case 3:
        return ScientificCalculatorPage();
      default:
        return Container();
    }
  }
}

class GeneralCalculatorPage extends StatefulWidget {
  @override
  _GeneralCalculatorPageState createState() => _GeneralCalculatorPageState();
}

class _GeneralCalculatorPageState extends State<GeneralCalculatorPage> {
  String _output = ''; // Output displayed on the calculator screen
  String _currentExpression = ''; // Currently inputted expression

  void _handleButtonPressed(String buttonText) {
    setState(() {
      if (buttonText == 'C') {
        // Clear button
        _output = '';
        _currentExpression = '';
      } else if (buttonText == '=') {
        // Equals button
        _output = _evaluate();
        _currentExpression = ''; // Clear current expression
      } else if (buttonText == '⌫') {
        int len = _currentExpression.length;
        _currentExpression = _currentExpression.substring(0, len - 1);
        _output = _currentExpression;
      } else {
        // Number or operator button
        _currentExpression += buttonText;
        _output = _currentExpression;
      }
    });
  }

  String _evaluate() {
    try {
      // Try evaluating the expression
      return _currentExpression.isNotEmpty
          ? evalExpression(_currentExpression)
          : '';
    } catch (e) {
      return 'Error';
    }
  }

  String evalExpression(String expression) {
    expression = expression.replaceAll('×', '*');
    expression = expression.replaceAll('÷', '/');
    Parser p = Parser();
    Expression exp = p.parse(expression);
    double eval = exp.evaluate(EvaluationType.REAL, ContextModel());
    return eval.toString();
  }

  Widget _buildButton(
      String buttonText, double buttonWidth, Color buttonColor) {
    // Build a calculator button
    return Container(
      width: MediaQuery.of(context).size.width * buttonWidth,
      padding: EdgeInsets.all(2),
      child: ElevatedButton(
        onPressed: () => _handleButtonPressed(buttonText),
        child: Text(
          buttonText,
          style: TextStyle(fontSize: 25, color: buttonColor),
        ),
        style: ButtonStyle(
          elevation: MaterialStateProperty.all<double>(0),
          backgroundColor: MaterialStateProperty.all<Color>(Colors.white10),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 100),
          Container(
            height: 100,
            padding: EdgeInsets.symmetric(vertical: 20.0, horizontal: 12.0),
            alignment: Alignment.centerRight,
            child: FittedBox(
              child: Text(
                _output,
                style: TextStyle(fontSize: 48.0, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          Container(
            height: 1,
            color: Colors.grey,
          ),
          Expanded(
            child: GridView.count(
              mainAxisSpacing: 0,
              crossAxisCount: 4,
              children: [
                _buildButton('C', 0.25, Colors.orange),
                _buildButton('÷', 0.25, Colors.orange),
                _buildButton('×', 0.25, Colors.orange),
                _buildButton('⌫', 0.25, Colors.orange),
                _buildButton('7', 0.25, Colors.black),
                _buildButton('8', 0.25, Colors.black),
                _buildButton('9', 0.25, Colors.black),
                _buildButton('-', 0.25, Colors.orange),
                _buildButton('4', 0.25, Colors.black),
                _buildButton('5', 0.25, Colors.black),
                _buildButton('6', 0.25, Colors.black),
                _buildButton('+', 0.25, Colors.orange),
                _buildButton('1', 0.25, Colors.black),
                _buildButton('2', 0.25, Colors.black),
                _buildButton('3', 0.25, Colors.black),
                _buildButton('=', 0.25, Colors.orange),
                _buildButton('.', 0.25, Colors.black),
                _buildButton('0', 0.25, Colors.black),
                _buildButton('00', 0.25, Colors.black),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
