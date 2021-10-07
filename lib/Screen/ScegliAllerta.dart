import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:report_visita_danilo/Utils/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:counter/counter.dart';

class ScegliAllerta extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ScegliAllertaState();
}

class ScegliAllertaState extends State<ScegliAllerta> {
  final formKeyScegliAllerta = GlobalKey<FormBuilderState>();

  final List<String> scegliPeriodoSoglia = [
    "Giorni",
    "Settimane",
    "Mesi",
    "Anni"
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 52.w),
        child: Card(
          child: Padding(
            padding: EdgeInsets.only(left: 16.w),
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: ScreenUtil().setHeight(40),
                      left: ScreenUtil().setWidth(16),
                      right: ScreenUtil().setWidth(16)),
                  child: AutoSizeText(
                    "Definisci le soglie di allerta",
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontSize: 24.sp,
                        fontWeight: FontWeight.w700,
                        letterSpacing: 0.9092158,
                        color: Colors.grey[700]),
                  ),
                ),
                Row(
                  children: [
                    Counter(
                      min: 1,
                      max: 10,
                      bound: 1,
                      step: 1,
                      onValueChanged: print,
                    ),
                    DropdownButton(items: <DropdownMenuItem<String>>[
                      new DropdownMenuItem(child: Text("Ciao"),),
                    ])
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<int> _creaListaNumeri(int value) {
    List<int> list = [];
    if (value != 0) {
      for (int i = 0; i < value; i++) {
        list.add(i + 1);
      }
      return list;
    } else
      throw "Errore";
  }

  _aggiungiSoglieAllerta() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String scegliAllerta1 =
        formKeyScegliAllerta.currentState?.fields['scegliAllerta1']!.value ??
            "7";

    String scegliAllerta2 =
        formKeyScegliAllerta.currentState?.fields['scegliAllerta2']!.value ??
            "14";

    String scegliAllerta3 =
        formKeyScegliAllerta.currentState?.fields['scegliAllerta3']!.value ??
            "21";

    print("Soglia 1 " + scegliAllerta1);
    print("Soglia 2 " + scegliAllerta2);
    print("Soglia 3 " + scegliAllerta3);

    await prefs.setString("prioritaBassa", scegliAllerta1);
    await prefs.setString("prioritaMedia", scegliAllerta2);
    await prefs.setString("prioritaAlta", scegliAllerta3);
  }
}







/*FormBuilderDropdown(
                            name: 'scegliAllerta1',
                            style: homePageMainTextStyle,
                            isExpanded: true,
                            items: _creaListaNumeri(24)
                                .map<DropdownMenuItem<String>>((int value) {
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

                          Container(
                  padding: EdgeInsets.all(ScreenUtil().setWidth(8)),
                  alignment: Alignment.bottomRight,
                  child: RichText(
                    text: TextSpan(
                      text: 'Conferma',
                      style: new TextStyle(
                          fontSize: ScreenUtil().setSp(18),
                          fontWeight: FontWeight.w700,
                          color: Colors.grey[700]),
                      recognizer: new TapGestureRecognizer()
                        ..onTap = () {
                          _aggiungiSoglieAllerta();
                          Navigator.pop(context);
                        },
                    ),
                  ),
                ),





                          */
