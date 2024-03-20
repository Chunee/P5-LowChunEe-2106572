import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class ComposeNumber extends StatefulWidget {
  @override
  _ComposeNumberState createState() => _ComposeNumberState();
}

class _ComposeNumberState extends State<ComposeNumber> {
  int targetNumber = 0;
  List<int> numbers = [];
  List<int> userAnswer = [];
  bool showTryAgain = false;
  bool showCorrectAnswer = false;
  bool showCheckAnswerButton = true;

  @override
  void initState() {
    super.initState();
    generateNumbers();
  }

  void generateNumbers() {
    final random = Random();
    targetNumber = random.nextInt(91) + 10; // Generate a number between 10 and 100
    numbers.clear();

    // Generate two numbers that can sum up to the targetNumber
    int firstNumber = random.nextInt(targetNumber);
    int secondNumber = targetNumber - firstNumber;

    // Generate three additional random numbers
    List<int> additionalNumbers = [];
    while (additionalNumbers.length < 3) {
      int randomNumber = random.nextInt(targetNumber);
      if (randomNumber != firstNumber && randomNumber != secondNumber) {
        additionalNumbers.add(randomNumber);
      }
    }

    // Shuffle the numbers and add them to the list
    numbers.addAll([firstNumber, secondNumber, ...additionalNumbers]);
    numbers.shuffle();
    userAnswer.clear();
    showTryAgain = false;
    showCorrectAnswer = false;
    showCheckAnswerButton = true;
  }

  void checkAnswer() {
    if (userAnswer.length == 2 && userAnswer[0] + userAnswer[1] == targetNumber) {
      setState(() {
        showCorrectAnswer = true;
        showCheckAnswerButton = false;
        Timer(Duration(seconds: 2), () {
          setState(() {
            generateNumbers(); // Call generateNumbers after a delay
          });
        });
      });
    } else {
      setState(() {
        showTryAgain = true;
        showCheckAnswerButton = false;
        Timer(Duration(seconds: 2), () {
          setState(() {
            showTryAgain = false;
            showCheckAnswerButton = true;
          });
        });
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Compose Number'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Select two numbers that can be added together to get $targetNumber:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Wrap(
              alignment: WrapAlignment.center,
              spacing: 10,
              runSpacing: 10,
              children: numbers.map((number) {
                return ElevatedButton(
                  onPressed: () {
                    setState(() {
                      if (userAnswer.length < 2) {
                        userAnswer.add(number);
                      } else {
                        // Only allow selecting two numbers
                        userAnswer.clear();
                        userAnswer.add(number);
                      }
                    });
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: userAnswer.contains(number) ? Colors.green : null,
                  ),
                  child: Text(number.toString()),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
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
            SizedBox(height: 20),
            if (showCheckAnswerButton)
              ElevatedButton(
                onPressed: () {
                  checkAnswer();
                },
                child: Text('Check Answer'),
              ),
          ],
        ),
      ),
    );
  }
}
