import 'package:flutter/material.dart';
import 'package:universal_calculator/general/BMI/BMI_calculation.dart';
import 'package:universal_calculator/general/Discount/discount_main_page.dart';
import 'package:universal_calculator/general/GPA/gpa_calculations_main.dart';
import 'package:universal_calculator/general/Length/length_conversion_main.dart';
import 'package:universal_calculator/general/age/age_conversion_main.dart';
import 'package:universal_calculator/general/area/area_calculation_mainpage.dart';
import 'package:universal_calculator/general/data/data_calculation_main.dart';
import 'package:universal_calculator/general/fuel/fuel_calculations_main.dart';
import 'package:universal_calculator/general/speed/speed_calculation_main.dart';
import 'package:universal_calculator/general/temperature/temperature_main.dart';
import 'package:universal_calculator/general/time/time_conversion_main.dart';
import 'package:universal_calculator/general/volume/volume_calculation_main.dart';
import 'package:universal_calculator/general/weight/weight_calculations_main.dart';

class GeneralCalculationsPage extends StatelessWidget {
  const GeneralCalculationsPage({super.key});

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
              padding: EdgeInsets.all(5),
              crossAxisCount: 3,
              children: [
                _buildbutton(Icon(Icons.square_sharp), 'Area', context,
                    () => AreaCalcMainpage()),
                _buildbutton(Icon(Icons.accessibility_new), 'BMI', context,
                    () => BMICalcMainPage()),
                _buildbutton(Icon(Icons.discount), 'Discount', context,
                    () => DiscountMainPage()),
                _buildbutton(Icon(Icons.straighten), 'Length', context,
                    () => LengthConversionMainPage()),
                _buildbutton(Icon(Icons.assignment), 'weight', context,
                    () => WeightCalculationsMainPage()),
                _buildbutton(Icon(Icons.transform), 'Data', context,
                    () => DataCalculationMainPage()),
                _buildbutton(Icon(Icons.thermostat_outlined), 'Temperature',
                    context, () => TemperatureConversionMainPage()),
                _buildbutton(Icon(Icons.speed), 'Speed', context,
                    () => SpeedCalculationMainPage()),
                _buildbutton(Icon(Icons.category), 'Volume', context,
                    () => VolumeCalculationMainPage()),
                _buildbutton(Icon(Icons.access_time), 'Time', context,
                    () => TimeConversionMainPage()),
                _buildbutton(Icon(Icons.cake), 'Age', context,
                    () => AgeConversionMainPage()),
                _buildbutton(Icon(Icons.local_gas_station), 'Fuel', context,
                    () => FuelCalculationsMainPage()),
                _buildbutton(Icon(Icons.format_list_numbered), 'GPA', context,
                    () => GPACalculationsMain()),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildbutton<T extends Widget>(
      Icon icon, String text, BuildContext context,
      [Widget Function()? navClass]) {
    return GestureDetector(
      onTap: () {
        if (navClass != null) {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => navClass()));
        }
      },
      child: Container(
        color: Colors.white10,
        width: MediaQuery.of(context).size.width / 3,
        child: Column(
          children: [
            IconButton(
                onPressed: () {
                  if (navClass != null) {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => navClass()));
                  }
                },
                icon: icon),
            Text(text, style: TextStyle(fontSize: 16)),
          ],
        ),
      ),
    );
  }
}
