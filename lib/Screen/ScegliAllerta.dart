import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScegliAllerta extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ScegliAllertaState();
}

class ScegliAllertaState extends State<ScegliAllerta> {
  var settimane = ["ciao", "ciao"];
  var dropdownValue = "1 settimana";
  String valore = "1 settimana";
  String valore2 = "1 settimana";
  String valore3 = "1 settimana";


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 52.w),
        child: Card(
          child: Align(
            alignment: Alignment.center,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: ScreenUtil().setHeight(40),
                      left: ScreenUtil().setWidth(16),
                      right: ScreenUtil().setWidth(16)),
                  child: AutoSizeText(
                    "Definisci le soglie di allerta",
                    style: TextStyle(
                      fontSize: ScreenUtil().setSp(20),
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
                Expanded(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(50),
                          left: ScreenUtil().setWidth(16),
                          right: ScreenUtil().setWidth(16),
                        ),
                        child: DropdownButton(
                          isExpanded: true,

                          icon: Icon(
                            Icons.circle_rounded,
                            color: Colors.green,
                          ),
                          value: valore,
                          //elevation: 5,
                          style: TextStyle(color: Colors.black),
                          items: <String>[
                            "1 settimana",
                            "2 settimane",
                            "3 settimane",
                            "4 settimane",
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) => {
                            setState(() {
                              valore = value.toString();
                            })
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(30),
                          left: ScreenUtil().setWidth(16),
                          right: ScreenUtil().setWidth(16),
                        ),
                        child: DropdownButton(
                          isExpanded: true,

                          icon: Icon(
                            Icons.circle_rounded,
                            color: Colors.orange,
                          ),
                          value: valore2,
                          //elevation: 5,
                          style: TextStyle(color: Colors.black),
                          items: <String>[
                            "1 settimana",
                            "2 settimane",
                            "3 settimane",
                            "4 settimane",
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) => {
                            setState(() {
                              valore2 = value.toString();
                            })
                          },
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(30),
                          left: ScreenUtil().setWidth(16),
                          right: ScreenUtil().setWidth(16),
                        ),
                        child: DropdownButton(
                          isExpanded: true,

                          icon: Icon(
                            Icons.circle_rounded,
                            color: Colors.red,
                          ),
                          value: valore3,
                          //elevation: 5,
                          style: TextStyle(color: Colors.black),
                          items: <String>[
                            "1 settimana",
                            "2 settimane",
                            "3 settimane",
                            "4 settimane",
                          ].map<DropdownMenuItem<String>>((String value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            );
                          }).toList(),
                          onChanged: (value) => {
                            setState(() {
                              valore3 = value.toString();
                            })
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  padding: EdgeInsets.all(ScreenUtil().setWidth(8)),
                  alignment: Alignment.bottomRight,
                  child:
                  RichText(
                    text:
                TextSpan(
                  text: 'Conferma',
                  style: new TextStyle(
                      color: Colors.black,
                      fontSize: ScreenUtil().setSp(18),
                      ),
                  recognizer: new TapGestureRecognizer()
                    ..onTap = () {

                    Navigator.pop(context);

                    },
                )))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
