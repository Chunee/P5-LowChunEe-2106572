import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class CompareNumber extends StatefulWidget {
  @override
  _CompareNumberState createState() => _CompareNumberState();
}

class _CompareNumberState extends State<CompareNumber> {
  int number1 = 0;
  int number2 = 0;
  String answer = '';
  bool showTryAgain = false;
  bool showButtons = true;
  bool showCorrectAnswer = false;

  @override
  void initState() {
    super.initState();
    generateNumbers();
  }

  void generateNumbers() {
    setState(() {
      final random = Random();
      number1 = random.nextInt(100); // Generate random number between 0 and 99
      number2 = random.nextInt(100);
      answer = '';
      showTryAgain = false;
      showButtons = true;
      showCorrectAnswer = false;
    });
  }

  void showTryAgainMessage() {
    setState(() {
      showTryAgain = true;
      showButtons = false;
      showCorrectAnswer = false;
    });
    Timer(Duration(seconds: 2), () {
      setState(() {
        showTryAgain = false;
        showButtons = true;
      });
    });
  }

  void showCorrectAnswerMessage() {
    setState(() {
      showCorrectAnswer = true;
      showButtons = false;
    });
    Timer(Duration(seconds: 2), () {
      setState(() {
        showCorrectAnswer = false;
        generateNumbers();
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Compare Number'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Is $number1 greater than or less than $number2?',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                _NumberBox(number: number1),
                _NumberBox(number: number2),
              ],
            ),
            SizedBox(height: 20),
            if (showButtons)
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        answer = 'greater';
                        if ((number1 > number2 && answer == 'greater') ||
                            (number1 < number2 && answer == 'less')) {
                          showCorrectAnswerMessage();
                        } else {
                          showTryAgainMessage();
                        }
                      });
                    },
                    child: Text('Greater Than'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      setState(() {
                        answer = 'less';
                        if ((number1 > number2 && answer == 'greater') ||
                            (number1 < number2 && answer == 'less')) {
                          showCorrectAnswerMessage();
                        } else {
                          showTryAgainMessage();
                        }
                      });
                    },
                    child: Text('Less Than'),
                  ),
                ],
              ),
            if (showTryAgain)
              Text(
                'Try Again!',
                style: TextStyle(color: Colors.red),
              ),
            if (showCorrectAnswer)
              Text(
                'Correct Answer!',
                style: TextStyle(color: Colors.green),
              ),
          ],
        ),
      ),
    );
  }
}

class _NumberBox extends StatelessWidget {
  final int number;

  const _NumberBox({Key? key, required this.number}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 100,
      height: 100,
      color: Colors.blue,
      child: Center(
        child: Text(
          number.toString(),
          style: TextStyle(fontSize: 24, color: Colors.white),
        ),
      ),
    );
  }
}




