import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:report_visita_danilo/Utils/theme.dart';

class ScegliAllerta extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ScegliAllertaState();
}

class ScegliAllertaState extends State<ScegliAllerta> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 52.w),
        child: Card(
          child: Align(
            alignment: Alignment.center,
            child: Padding(
              padding: EdgeInsets.only(left: 16.w),
              child: Column(
                children: [
                  Padding(
                    padding: EdgeInsets.only(
                        top: ScreenUtil().setHeight(40),
                        left: ScreenUtil().setWidth(16),
                        right: ScreenUtil().setWidth(16)),
                    child:  AutoSizeText(
                      "Definisci le soglie di allerta",
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          fontSize: 24.sp,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 0.9092158,
                          color: Colors.grey[700]),
                    ),
                  ),
                  Expanded(
                    child: FormBuilder(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        mainAxisSize: MainAxisSize.max,
                        children: [
                          FormBuilderDropdown(
                            name: 'scegliAllerta1',
                            style: homePageMainTextStyle,
                            isExpanded: true,
                            items:
                            creaListaNumeri(24).map<DropdownMenuItem<String>>((int value) {
                              return DropdownMenuItem<String>(
                                value: value.toString(),
                                child: value == 1
                                    ? Text("$value settimana")
                                    : Text("$value settimane"),
                              );
                            }).toList(),
                            decoration: InputDecoration(
                              labelText: "Scegli soglia allerta",
                              labelStyle: homePageMainTextStyle,
                              suffixIcon: Icon(
                                Icons.circle,
                                color: Colors.green,
                              ),
                              icon: Icon(
                                Icons.edit_rounded,
                              ),
                            ),
                          ),
                          FormBuilderDropdown(
                            name: 'scegliAllerta2',
                            style: homePageMainTextStyle,
                            isExpanded: true,
                            items:
                            creaListaNumeri(24).map<DropdownMenuItem<String>>((int value) {
                              return DropdownMenuItem<String>(
                                value: value.toString(),
                                child: value == 1
                                    ? Text("$value settimana")
                                    : Text("$value settimane"),
                              );
                            }).toList(),
                            decoration: InputDecoration(
                              labelText: "Scegli soglia allerta",
                              labelStyle: homePageMainTextStyle,
                              suffixIcon: Icon(
                                Icons.circle,
                                color: Colors.yellowAccent,
                              ),
                              icon: Icon(
                                Icons.edit_rounded,
                              ),
                            ),
                          ),
                          FormBuilderDropdown(
                            name: 'scegliAllerta3',
                            style: homePageMainTextStyle,
                            isExpanded: true,
                            items:
                            creaListaNumeri(24).map<DropdownMenuItem<String>>((int value) {
                              return DropdownMenuItem<String>(
                                value: value.toString(),
                                child: value == 1
                                    ? Text("$value settimana")
                                    : Text("$value settimane"),
                              );
                            }).toList(),
                            decoration: InputDecoration(
                              labelText: "Scegli soglia allerta",
                              labelStyle: homePageMainTextStyle,
                              suffixIcon: Icon(
                                Icons.circle,
                                color: Colors.redAccent,
                              ),
                              icon: Icon(
                                Icons.edit_rounded,
                              ),
                            ),
                          ),
                        ],
                      ),
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
      ),
    );
  }
  List<int> creaListaNumeri(int value) {
    List<int> list = [];
    if (value != 0) {
      for (int i = 0; i < value; i++) {
        list.add(i+1);
      }
      return list;
    }
    else throw "Errore";
  }
}
