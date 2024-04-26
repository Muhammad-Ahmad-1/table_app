import 'package:flutter/material.dart';

void main() {
  runApp(CountingTableGenerator());
}

class CountingTableGenerator extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Table Generator App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int tableLimit = 100;
  int startValue = 1;
  int endValue = 100;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF4B6CB7), Color(0xFF182848), Color(0xFF4B6CB7)],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              _buildSlider(
                value: tableLimit.toDouble(),
                min: 1,
                max: 100,
                label: '     SELECT RANGE\n \n \n \nSet Table Number',
                onChanged: (newValue) {
                  setState(() {
                    tableLimit = newValue.round();
                  });
                },
              ),
              _buildSlider(
                value: startValue.toDouble(),
                min: 1,
                max: endValue.toDouble(),
                label: 'Table Starting Point',
                onChanged: (newValue) {
                  setState(() {
                    startValue = newValue.round();
                  });
                },
              ),
              _buildSlider(
                value: endValue.toDouble(),
                min: startValue.toDouble(),
                max: 100,
                label: 'Table Ending Limit',
                onChanged: (newValue) {
                  setState(() {
                    endValue = newValue.round();
                  });
                },
              ),
              SizedBox(height: 20),
              Container(
                margin: EdgeInsets.symmetric(vertical: 10),
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => CountingTablePage(
                          tableLimit: tableLimit,
                          startValue: startValue,
                          endValue: endValue,
                        ),
                      ),
                    );
                  },
                  child: Text('Generate Table', style: TextStyle(color: Colors.white, fontSize: 20)),
                  style: ElevatedButton.styleFrom(
                    foregroundColor: Colors.transparent, backgroundColor: Colors.transparent, padding: EdgeInsets.symmetric(vertical: 15, horizontal: 45), disabledForegroundColor: Colors.transparent.withOpacity(0.38), disabledBackgroundColor: Colors.transparent.withOpacity(0.12),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    textStyle: TextStyle(fontSize: 18),
                    elevation: 0,
                    shadowColor: Colors.transparent,
                    side: BorderSide(color: Colors.white),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildSlider({
    required double value,
    required double min,
    required double max,
    required String label,
    required Function(double) onChanged,
  }) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          '$label: ${value.round()}',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        Slider(
          value: value,
          min: min,
          max: max,
          onChanged: onChanged,
        ),
      ],
    );
  }
}

class CountingTablePage extends StatelessWidget {
  final int tableLimit;
  final int startValue;
  final int endValue;

  CountingTablePage({
    required this.tableLimit,
    required this.startValue,
    required this.endValue,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF4B6CB7), Color(0xFF182848), Color(0xFF4B6CB7)],
          ),
        ),
        child: Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                DataTable(
                  columns: _generateColumns(),
                  rows: _generateRows(),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.yellowAccent),
                    borderRadius: BorderRadius.circular(10.0),
                  ),
                ),
                SizedBox(height: 20),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10),
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => QuizPage(
                            startValue: startValue,
                            endValue: endValue,
                            tableLimit: tableLimit,
                          ),
                        ),
                      );
                    },
                    child: Text('Generate Quiz', style: TextStyle(color: Colors.white, fontSize: 20)),
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.transparent, backgroundColor: Colors.transparent, padding: EdgeInsets.symmetric(vertical: 15, horizontal: 45), disabledForegroundColor: Colors.transparent.withOpacity(0.38), disabledBackgroundColor: Colors.transparent.withOpacity(0.12),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      textStyle: TextStyle(fontSize: 18),
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      side: BorderSide(color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<DataColumn> _generateColumns() {
    return [
      DataColumn(label: Text('Numbers', style: TextStyle(color: Colors.white))),
      DataColumn(label: Text('Results', style: TextStyle(color: Colors.white))),
    ];
  }

  List<DataRow> _generateRows() {
    List<DataRow> rows = [];
    for (int i = startValue; i <= endValue; i++) {
      rows.add(DataRow(
        cells: [
          DataCell(Text('$tableLimit x $i', style: TextStyle(color: Colors.white))),
          DataCell(Text('${tableLimit * i}', style: TextStyle(color: Colors.white))),
        ],
      ));
    }
    return rows;
  }
}

class QuizPage extends StatefulWidget {
  final int startValue;
  final int endValue;
  final int tableLimit;

  QuizPage({
    required this.startValue,
    required this.endValue,
    required this.tableLimit,
  });

  @override
  _QuizPageState createState() => _QuizPageState();
}

class _QuizPageState extends State<QuizPage> {
  int _currentQuestionIndex = 0;
  late List<List<int>> _questions;
  late List<List<int>> _options;
  late List<int> _correctAnswers;

  @override
  void initState() {
    super.initState();
    _generateQuestions();
  }

  void _generateQuestions() {
    _questions = [];
    _options = [];
    _correctAnswers = [];

    // Iterate through each table value
    for (int i = widget.startValue; i <= widget.endValue; i++) {
      // Iterate through multipliers for each table
      for (int j = 1; j <= 1; j++) {
        int table = widget.tableLimit;
        int multiplier = i;

        // Add the question to the lists
        _questions.add([table, multiplier]);
        int correctAnswer = table * multiplier;
        _correctAnswers.add(correctAnswer);
        _options.add(_generateOptions(correctAnswer));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Color(0xFF4B6CB7), Color(0xFF182848), Color(0xFF4B6CB7)],
          ),
        ),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'SELECT CORRECT OPTION\n \n \n Question Number : ${_currentQuestionIndex + 1}= ${_questions[_currentQuestionIndex][0]} x ${_questions[_currentQuestionIndex][1]}',
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
              SizedBox(height: 20),
              Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: List.generate(
                  3,
                      (index) => Container(
                    margin: EdgeInsets.symmetric(vertical: 10),
                    child: ElevatedButton(
                      onPressed: () {
                        _showResult(context, _options[_currentQuestionIndex][index]);
                      },
                      child: Text(
                        '${String.fromCharCode(index + 97)}) ${_options[_currentQuestionIndex][index]}',
                        style: TextStyle(fontSize: 18, color: Colors.white),
                      ),
                      style: ElevatedButton.styleFrom(
                        padding: EdgeInsets.symmetric(vertical: 15, horizontal: 45), backgroundColor: Colors.transparent,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10.0),
                        ),
                        side: BorderSide(color: Colors.white),
                        textStyle: TextStyle(fontSize: 20),
                      ),
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Navigator.popUntil(context, ModalRoute.withName('/'));
                    },
                    child: Text('Generate Table', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 45), backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      textStyle: TextStyle(fontSize: 18),
                      side: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                  SizedBox(width: 20),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        if (_currentQuestionIndex < _questions.length - 1) {
                          _currentQuestionIndex++;
                        } else {
                          _currentQuestionIndex = 0;
                          _generateQuestions();
                        }
                      });
                    },
                    child: Text('Next Question', style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      padding: EdgeInsets.symmetric(vertical: 15, horizontal: 45), backgroundColor: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      elevation: 0,
                      shadowColor: Colors.transparent,
                      textStyle: TextStyle(fontSize: 18),
                      side: BorderSide(
                        color: Colors.white,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<int> _generateOptions(int correctAnswer) {
    List<int> options = [correctAnswer];
    int incorrect1 = correctAnswer + 10;
    int incorrect2 = correctAnswer + 20;
    options.add(incorrect1);
    options.add(incorrect2);
    options.shuffle();
    return options;
  }

  void _showResult(BuildContext context, int selectedAnswer) {
    int correctAnswer = _correctAnswers[_currentQuestionIndex];
    String resultMessage = selectedAnswer == correctAnswer
        ? 'Correct! ${_questions[_currentQuestionIndex][0]} x ${_questions[_currentQuestionIndex][1]} = $correctAnswer'
        : 'Incorrect! The correct answer is $correctAnswer';

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Result', style: TextStyle(color: Colors.white)),
          content: Text(resultMessage, style: TextStyle(color: Colors.white)),
          backgroundColor: Color(0xFF24243e),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('OK', style: TextStyle(color: Colors.white)),
            ),
          ],
        );
      },
    );
  }
}
