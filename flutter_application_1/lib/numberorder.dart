import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:math';

class NumberOrder extends StatefulWidget {
  @override
  _NumberOrderState createState() => _NumberOrderState();
}

class _NumberOrderState extends State<NumberOrder> {
  List<int> numbers = [];
  bool ascendingOrder = false;
  List<int> sortedNumbers = [];
  List<int> userAnswer = [];
  bool showTryAgain = false;
  bool showCorrectAnswer = false;
  bool showRearrangeButton = true;

  @override
  void initState() {
    super.initState();
    generateNumbers();
  }

  void generateNumbers() {
    setState(() {
      final random = Random();
      numbers.clear();
      userAnswer.clear();
      for (int i = 0; i < 5; i++) {
        numbers.add(random.nextInt(100)); // Generate random numbers between 0 and 99
      }
      ascendingOrder = random.nextBool(); // Randomly choose ascending or descending order
      sortedNumbers = List.from(numbers);
      sortedNumbers.sort();
      if (!ascendingOrder) {
        sortedNumbers = sortedNumbers.reversed.toList(); // Reverse for descending order
      }
      showTryAgain = false;
      showCorrectAnswer = false;
      showRearrangeButton = true;
    });
  }

  void checkAnswer() {
    setState(() {
      if (listEquals(sortedNumbers, userAnswer)) {
        showCorrectAnswer = true;
        showRearrangeButton = false;
        Timer(Duration(seconds: 2), () {
          generateNumbers();
        });
      } else {
        showTryAgain = true;
        showRearrangeButton = false; // Hide the Check Answer button
        Timer(Duration(seconds: 2), () {
          setState(() {
            showTryAgain = false;
            showRearrangeButton = true; // Show the Check Answer button again
          });
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Number Ordering'),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Rearrange the numbers ${ascendingOrder ? 'in ascending' : 'in descending'} order:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 20),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: numbers
                  .asMap()
                  .entries
                  .map(
                    (entry) => Draggable<int>(
                      data: entry.key,
                      feedback: Material(
                        child: Container(
                          width: 70,
                          height: 70,
                          color: Colors.blue.withOpacity(0.5),
                          child: Center(
                            child: Text(
                              numbers[entry.key].toString(),
                              style: TextStyle(color: Colors.white),
                            ),
                          ),
                        ),
                      ),
                      childWhenDragging: Container(
                        width: 70,
                        height: 70,
                        color: Colors.transparent,
                      ),
                      child: DragTarget<int>(
                        builder: (BuildContext context,
                            List<int?> candidateData, List<dynamic> rejectedData) {
                          return Material(
                            color: Colors.blue,
                            child: SizedBox(
                              width: 70,
                              height: 70,
                              child: Center(
                                child: Text(
                                  numbers[entry.key].toString(),
                                  style: TextStyle(color: Colors.white),
                                ),
                              ),
                            ),
                          );
                        },
                        onWillAcceptWithDetails: (data) => true,
                        onAcceptWithDetails: (data) {
                          setState(() {
                            final draggedIndex = data.data;
                            final targetIndex = entry.key;
                            if (draggedIndex != targetIndex) {
                              final temp = numbers[draggedIndex];
                              numbers[draggedIndex] = numbers[targetIndex];
                              numbers[targetIndex] = temp;
                              userAnswer = List.from(numbers);
                            }
                          });
                        },
                      ),
                    ),
                  )
                  .toList(),
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
            if (showRearrangeButton)
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
