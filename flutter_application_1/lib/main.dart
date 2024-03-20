import 'dart:async';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';
import 'mainscreen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MY Tutor',
      theme: ThemeData(
        primarySwatch: Colors.amber,
        textTheme: GoogleFonts.oxygenTextTheme(
          Theme.of(context).textTheme,
        ),
      ),
      home: const MySplashScreen(title: 'MY Tutor'),
    );
  }
}

class MySplashScreen extends StatefulWidget {
  const MySplashScreen({super.key, required String title});

  @override
  State<MySplashScreen> createState() => _MySplashScreenState();
}

class _MySplashScreenState extends State<MySplashScreen> {
  @override
  void initState() {
    super.initState();
    Timer(
        const Duration(seconds: 3),
        () => Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (content) => const MainScreen())));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        alignment: Alignment.center,
        children: [
          Container(
              decoration: const BoxDecoration(
                  image: DecorationImage(
                      image: AssetImage('assets/books.jpg'),
                      fit: BoxFit.cover))),
          Padding(
            padding: const EdgeInsets.fromLTRB(0, 50, 0, 10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: const [
                Text("MY Tutor",
                    style: TextStyle(
                      fontSize: 40,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 255, 255, 255),
                    )),
                CircularProgressIndicator(),
                Text("Version 1.0",
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    )),
              ],
            ),
          )
        ],
      ),
    );
  }
}