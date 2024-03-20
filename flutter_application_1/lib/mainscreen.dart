import 'package:flutter/material.dart';
import 'comparenumber.dart';
import 'numberorder.dart';
import 'composenumber.dart';

class MainScreen extends StatefulWidget {
  const MainScreen({super.key});

  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
          image: DecorationImage(
              image: AssetImage('assets/mainscreen.png'),
              fit: BoxFit.cover)),
                child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              ElevatedButton(
                onPressed: () {
                  // Navigate to CompareNumber screen when Button 1 is pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => CompareNumber()),
                  );
                },
                child: Text('Compare Number'),
              ),
              SizedBox(height: 20), // Add spacing between buttons
              ElevatedButton(
                onPressed: () {
                  // Navigate to NumberOrder when Button 1 is pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => NumberOrder()),
                  );
                },
                child: Text('Number Ordering'),
              ),
              SizedBox(height: 20), // Add spacing between buttons
              ElevatedButton(
                onPressed: () {
                  // Navigate to ComposeNumber when Button 1 is pressed
                  Navigator.push(
                    context,
                    MaterialPageRoute(builder: (context) => ComposeNumber()),
                  );
                },
                child: Text('Compose Number'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
