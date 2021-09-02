import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:report_visita_danilo/HomePage.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: SplashPage(),
    );
  }
}

class SplashPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    startTimer(context);
    return Stack(children: [
      Image.asset(
        'assets/splashpage_background1.png',
        fit: BoxFit.cover,
        height: double.infinity,
        width: double.infinity,
      ),
      Align(
          alignment: Alignment.center,
          child: Image.asset('assets/logo_splash.png')),
    ]);
  }

  void startTimer(context) {
    Future.delayed(Duration(seconds: 5), () {
      Navigator.pushAndRemoveUntil(
        context,
        MaterialPageRoute<void>(builder: (context) => MyHomePage()),
        (route) => false,
      );
    });
  }
}
