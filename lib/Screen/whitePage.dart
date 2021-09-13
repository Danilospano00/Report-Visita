import 'package:flutter/material.dart';

class WhitePage extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => WhitePageState();

}

class WhitePageState extends State<WhitePage>{
  @override
  Widget build(BuildContext context) {
    return ColoredBox(
      color: Colors.blue,
    );
  }

}