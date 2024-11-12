import 'package:flutter/material.dart';

class GPACalculationsMain extends StatefulWidget {
  @override
  _GPACalculationsMainState createState() => _GPACalculationsMainState();
}

class _GPACalculationsMainState extends State<GPACalculationsMain> {
  List<Map<String, dynamic>> _subjects = [];

  int _totalCredits = 0;
  double _totalGradePoints = 0.0;

  void _addSubject(String name, int credits, double grade) {
    setState(() {
      _subjects.add({'name': name, 'credits': credits, 'grade': grade});
      _calculateGPA();
    });
  }

  void _calculateGPA() {
    _totalCredits = 0;
    _totalGradePoints = 0.0;

    for (var subject in _subjects) {
      _totalCredits += subject['credits'] as int;
      _totalGradePoints += subject['grade'];
    }
  }

  void _showAddSubjectDialog() {
    String name = '';
    int credits = 0;
    double grade = 0.0;

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Add Subject'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                decoration: InputDecoration(labelText: 'Subject Name'),
                onChanged: (value) {
                  name = value;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Credits'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  credits = int.tryParse(value) ?? 0;
                },
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Grade'),
                keyboardType: TextInputType.number,
                onChanged: (value) {
                  grade = double.tryParse(value) ?? 0.0;
                },
              ),
            ],
          ),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Add'),
              onPressed: () {
                if (name.isNotEmpty && credits > 0 && grade > 0.0) {
                  _addSubject(name, credits, grade);
                  Navigator.of(context).pop();
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('GPA Calculator'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Subject',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Credits',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text(
                  'Grade',
                  style: TextStyle(
                    fontSize: 16.0,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
            SizedBox(height: 8),
            Expanded(
              child: ListView.builder(
                itemCount: _subjects.length,
                itemBuilder: (context, index) {
                  final subject = _subjects[index];
                  return Container(
                    margin: const EdgeInsets.only(bottom: 8.0),
                    padding: const EdgeInsets.all(8.0),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.circular(8.0),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.2),
                          spreadRadius: 2,
                          blurRadius: 5,
                          offset: Offset(0, 3),
                        ),
                      ],
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          subject['name'],
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          '${subject['credits']}',
                          style: TextStyle(fontSize: 16.0),
                        ),
                        Text(
                          subject['grade'].toStringAsFixed(1),
                          style: TextStyle(fontSize: 16.0),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                FloatingActionButton(
                  onPressed: _showAddSubjectDialog,
                  child: Icon(Icons.add),
                ),
              ],
            ),
            SizedBox(height: 25),
            Container(
              padding: const EdgeInsets.all(16.0),
              decoration: BoxDecoration(
                color: Colors.blueAccent,
                borderRadius: BorderRadius.circular(8.0),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       'Total Credits',
                  //       style: TextStyle(
                  //         fontSize: 18.0,
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //     Text(
                  //       _totalCredits.toString(),
                  //       style: TextStyle(
                  //         fontSize: 18.0,
                  //         fontWeight: FontWeight.bold,
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(height: 8),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       'Total Grade Points',
                  //       style: TextStyle(
                  //         fontSize: 18.0,
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //     Text(
                  //       _totalGradePoints.toStringAsFixed(2),
                  //       style: TextStyle(
                  //         fontSize: 18.0,
                  //         fontWeight: FontWeight.bold,
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  // SizedBox(height: 8),
                  // Row(
                  //   mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  //   children: [
                  //     Text(
                  //       'Total GPA',
                  //       style: TextStyle(
                  //         fontSize: 18.0,
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //     Text(
                  //       _totalGPA.toStringAsFixed(2),
                  //       style: TextStyle(
                  //         fontSize: 18.0,
                  //         fontWeight: FontWeight.bold,
                  //         color: Colors.white,
                  //       ),
                  //     ),
                  //   ],
                  // ),
                  Text("GPA",
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                  Text(_totalCredits.toString(),
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      )),
                  Text(_totalGradePoints.toString(),
                      style: TextStyle(
                        fontSize: 18.0,
                        fontWeight: FontWeight.bold,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
