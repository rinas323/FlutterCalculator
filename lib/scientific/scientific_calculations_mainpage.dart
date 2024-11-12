import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ScientificCalculatorPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Container(
            height: 17,
          ),
          Expanded(
            child: GridView.count(
              padding: EdgeInsets.all(5),
              crossAxisCount: 3,
              children: [
                _buildbutton(Icon(FontAwesomeIcons.diagramProject),
                    "combination", context),
                _buildbutton(
                    Icon(FontAwesomeIcons.crown), "Prime checker", context),
                _buildbutton(
                    Icon(FontAwesomeIcons.layerGroup), "GCF/LCM", context),
                _buildbutton(Icon(FontAwesomeIcons.bolt), "ohms law", context)
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildbutton(
    Icon icon,
    String text,
    BuildContext context,
  ) {
    return GestureDetector(
      onTap: () {},
      child: Container(
        color: Colors.white10,
        width: MediaQuery.of(context).size.width / 3,
        child: Column(
          children: [
            IconButton(onPressed: () {}, icon: icon),
            Text(text, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
