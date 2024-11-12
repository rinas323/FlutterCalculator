import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:timezone/timezone.dart' as tz;

class TimeConversionMainPage extends StatefulWidget {
  @override
  _TimeConversionMainPageState createState() => _TimeConversionMainPageState();
}

class _TimeConversionMainPageState extends State<TimeConversionMainPage> {
  DateTime _selectedTime = DateTime.now();
  String _fromTimeZone = 'America/New_York';
  String _toTimeZone = 'Asia/Kolkata';
  DateTime? _convertedTime;

  final DateFormat _dateTimeFormat = DateFormat('dd-MM-yyyy – HH:mm');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('World Time Converter'),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            _buildTimeSelector(),
            SizedBox(height: 20),
            _buildTimeZoneSelector(
              label: 'From Time Zone',
              selectedValue: _fromTimeZone,
              onChanged: (newValue) {
                setState(() {
                  _fromTimeZone = newValue!;
                });
              },
            ),
            SizedBox(height: 10),
            _buildTimeZoneSelector(
              label: 'To Time Zone',
              selectedValue: _toTimeZone,
              onChanged: (newValue) {
                setState(() {
                  _toTimeZone = newValue!;
                });
              },
            ),
            SizedBox(height: 20),
            if (_convertedTime != null) ...[
              SizedBox(height: 20),
              _buildConvertedTimeDisplay(),
            ],
            Spacer(),
            ElevatedButton(
              onPressed: _convertSelectedTime,
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.orange,
                padding: EdgeInsets.symmetric(vertical: 15),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
              ),
              child: Text(
                'Convert Time',
                style: TextStyle(color: Colors.white, fontSize: 18),
              ),
            ),
          ],
        ),
      ),
      backgroundColor: Colors.white,
    );
  }

  Widget _buildTimeSelector() {
    return GestureDetector(
      onTap: _pickDateTime,
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 12, horizontal: 16),
        decoration: BoxDecoration(
          color: Colors.grey[100],
          borderRadius: BorderRadius.circular(12),
          border: Border.all(color: Colors.orange),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Selected Time:',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              _dateTimeFormat.format(_selectedTime),
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildTimeZoneSelector({
    required String label,
    required String selectedValue,
    required ValueChanged<String?> onChanged,
  }) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: Colors.grey[100],
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange),
      ),
      child: DropdownButtonHideUnderline(
        child: DropdownButton<String>(
          value: selectedValue,
          onChanged: onChanged,
          items: tz.timeZoneDatabase.locations.keys.map((String key) {
            return DropdownMenuItem<String>(
              value: key,
              child: Text(_formatTimeZone(key)),
            );
          }).toList(),
        ),
      ),
    );
  }

  Widget _buildConvertedTimeDisplay() {
    return Container(
      padding: EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.orange.withOpacity(0.1),
        borderRadius: BorderRadius.circular(12),
        border: Border.all(color: Colors.orange),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Converted Time:',
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Colors.orange,
            ),
          ),
          SizedBox(height: 8),
          Text(
            _dateTimeFormat.format(_convertedTime!),
            style: TextStyle(fontSize: 16),
          ),
        ],
      ),
    );
  }

  String _formatTimeZone(String timeZone) {
    return timeZone.replaceAll('_', ' ');
  }

  void _pickDateTime() async {
    DateTime? dateTime = await showDatePicker(
      context: context,
      initialDate: _selectedTime,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (dateTime != null) {
      TimeOfDay? timeOfDay = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedTime),
      );

      if (timeOfDay != null) {
        setState(() {
          _selectedTime = DateTime(
            dateTime.year,
            dateTime.month,
            dateTime.day,
            timeOfDay.hour,
            timeOfDay.minute,
          );
        });
      }
    }
  }

  void _convertSelectedTime() {
    setState(() {
      _convertedTime = convertTime(
        _selectedTime,
        _fromTimeZone,
        _toTimeZone,
      );
    });
  }

  tz.Location getSystemTimeZone() {
    return tz.getLocation(DateTime.now().timeZoneName);
  }

  DateTime convertTime(
      DateTime dateTime, String fromTimeZone, String toTimeZone) {
    tz.Location fromLocation = tz.getLocation(fromTimeZone);
    tz.Location toLocation = tz.getLocation(toTimeZone);

    tz.TZDateTime utcTime = tz.TZDateTime.from(dateTime, fromLocation).toUtc();
    tz.TZDateTime convertedTime = tz.TZDateTime.from(utcTime, toLocation);

    return convertedTime;
  }
}
