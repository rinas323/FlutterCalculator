import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class FinanceCalculatorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Container(
            height: 17,
          ),
          Expanded(
              child: GridView.count(
            crossAxisCount: 3,
            children: [
              _buildbutton(Icon(Icons.monetization_on), 'Currency', context),
              _buildbutton(Icon(Icons.account_balance), 'Loan', context),
              _buildbutton(Icon(Icons.trending_up), 'Interest', context),
              _buildbutton(Icon(Icons.receipt), 'Sales tax', context),
              _buildbutton(Icon(Icons.bar_chart), 'Stock returns', context),
              _buildbutton(Icon(FontAwesomeIcons.calculator), 'tax', context)
            ],
          )),
        ],
      ),
    );
  }

  Widget _buildbutton(Icon icon, String text, BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width / 3,
      child: Column(
        children: [
          IconButton(onPressed: () {}, icon: icon),
          Text(text, style: TextStyle(fontSize: 16)),
        ],
      ),
    );
  }
}
