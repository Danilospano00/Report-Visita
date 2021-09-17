import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ScegliAllerta extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ScegliAllertaState();
}

class ScegliAllertaState extends State<ScegliAllerta> {
  var settimane = ["ciao", "ciao"];
  var dropdownValue = "1 settimana";

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
                Text(
                  "Definisci le soglie di allerta",
                  style: TextStyle(
                    fontSize: 24.151785.sp,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[700],
                  ),
                ),
                Column(
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                      padding: EdgeInsets.all(16.w),
                      child: DropdownButton(
                        isExpanded: true,
                        icon: Icon(
                        Icons.edit_rounded,
                      ),
                        value: "1 settimana",
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
                            dropdownValue = value.toString();
                          })
                        },
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
