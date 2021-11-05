import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:report_visita_danilo/i18n/AppLocalizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'HomePage.dart';
import 'ViewPage.dart';

class ScegliAllerta extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ScegliAllertaState();
}

class ScegliAllertaState extends State<ScegliAllerta> {
  final formKeyScegliAllerta = GlobalKey<FormBuilderState>();
  late final List<String> scegliPeriodoSoglia=[];

  late int _valoreSoglia1 = 1;
  late int _valoreSoglia2 = 1;
  late int _valoreSoglia3 = 1;
  late String giorni;
  late String settimane;
  late String mesi;
  late String anni;

  @override
  initState() {
    super.initState();

    Future.delayed(Duration.zero,() {
      giorni = AppLocalizations.of(context).translate('giorni');
      settimane = AppLocalizations.of(context).translate('settimane');
      mesi = AppLocalizations.of(context).translate('mesi');
      anni = AppLocalizations.of(context).translate('anni');
      scegliPeriodoSoglia.add(giorni);
      scegliPeriodoSoglia.add(settimane);
      scegliPeriodoSoglia.add(mesi);
      scegliPeriodoSoglia.add(anni);

    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding:
            EdgeInsets.only(left: 16.w, right: 16.w, top: 52.h, bottom: 52.h),
        child: Card(
          child: Padding(
            padding: EdgeInsets.only(left: 16.w, right: 16.w),
            child: FormBuilder(
              key: formKeyScegliAllerta,
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        icon: Icon(
                          Icons.arrow_back,
                          size: 36,
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                          top: ScreenUtil().setHeight(20),
                          left: ScreenUtil().setWidth(16),
                          right: ScreenUtil().setWidth(16)),
                      child: AutoSizeText(
                        AppLocalizations.of(context)
                            .translate('definisciSoglieAllerta'),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 24.sp,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.9092158,
                            color: Colors.grey[700]),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 16.h),
                      child: AutoSizeText(
                        AppLocalizations.of(context)
                            .translate('testoScegliAllerta'),
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            fontSize: 16.sp,
                            fontWeight: FontWeight.w300,
                            letterSpacing: 0.9092158,
                            color: Colors.grey[700]),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 40.h),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 8.0.w),
                            child: Icon(
                              Icons.circle,
                              color: Colors.green,
                            ),
                          ),
                          Container(
                            width: 50.w,
                            height: 30.h,
                            decoration: BoxDecoration(color: Colors.grey[300]),
                            child: Center(
                              child: Text(
                                _valoreSoglia1.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20.sp,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.north_outlined,
                            ),
                            onPressed: () {
                              setState(() {
                                ++_valoreSoglia1;
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.south_outlined,
                            ),
                            onPressed: () {
                              setState(() {
                                if (_valoreSoglia1 > 0) --_valoreSoglia1;
                              });
                            },
                          ),
                          Container(
                            width: 120.w,
                            child: FormBuilderDropdown(
                              decoration: InputDecoration(
                                labelText: AppLocalizations.of(context)
                                    .translate('giorni'),
                                labelStyle: TextStyle(color: Colors.black),
                                alignLabelWithHint: true,
                                floatingLabelStyle:
                                    TextStyle(color: Colors.transparent),
                              ),
                              items: scegliPeriodoSoglia
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              name: 'scegliAllerta1',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      endIndent: 16.w,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 12.h),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 8.0.w),
                            child: Icon(
                              Icons.circle,
                              color: Colors.yellow,
                            ),
                          ),
                          Container(
                            width: 50.w,
                            height: 30.h,
                            decoration: BoxDecoration(color: Colors.grey[300]),
                            child: Center(
                              child: Text(
                                _valoreSoglia2.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20.sp,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.north_outlined,
                            ),
                            onPressed: () {
                              setState(() {
                                ++_valoreSoglia2;
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.south_outlined,
                            ),
                            onPressed: () {
                              setState(() {
                                if (_valoreSoglia2 > 0) --_valoreSoglia2;
                              });
                            },
                          ),
                          Container(
                            width: 120.w,
                            child: FormBuilderDropdown(
                              decoration: InputDecoration(
                                labelText: AppLocalizations.of(context)
                                    .translate('giorni'),
                                labelStyle: TextStyle(color: Colors.black),
                                alignLabelWithHint: true,
                                floatingLabelStyle:
                                    TextStyle(color: Colors.transparent),
                              ),
                              items: scegliPeriodoSoglia
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              name: 'scegliAllerta2',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      endIndent: 16.w,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 12.h),
                      child: Row(
                        children: [
                          Padding(
                            padding: EdgeInsets.only(right: 8.0),
                            child: Icon(
                              Icons.circle,
                              color: Colors.red,
                            ),
                          ),
                          Container(
                            width: 50.w,
                            height: 30.h,
                            decoration: BoxDecoration(color: Colors.grey[300]),
                            child: Center(
                              child: Text(
                                _valoreSoglia3.toString(),
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                  fontWeight: FontWeight.w300,
                                  fontSize: 20.sp,
                                ),
                              ),
                            ),
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.north_outlined,
                            ),
                            onPressed: () {
                              setState(() {
                                ++_valoreSoglia3;
                              });
                            },
                          ),
                          IconButton(
                            icon: Icon(
                              Icons.south_outlined,
                            ),
                            onPressed: () {
                              setState(() {
                                if (_valoreSoglia3 > 0) --_valoreSoglia3;
                              });
                            },
                          ),
                          Container(
                            width: 120.w,
                            child: FormBuilderDropdown(
                              decoration: InputDecoration(
                                labelText: AppLocalizations.of(context)
                                    .translate('giorni'),
                                labelStyle: TextStyle(color: Colors.black),
                                alignLabelWithHint: true,
                                floatingLabelStyle:
                                    TextStyle(color: Colors.transparent),
                              ),
                              items: scegliPeriodoSoglia
                                  .map<DropdownMenuItem<String>>(
                                      (String value) {
                                return DropdownMenuItem<String>(
                                  value: value,
                                  child: Text(value),
                                );
                              }).toList(),
                              name: 'scegliAllerta3',
                            ),
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      endIndent: 16.w,
                      indent: 16.w,
                    ),
                    Padding(
                      padding: EdgeInsets.only(top: 50.h),
                      child: Container(
                        padding: EdgeInsets.all(ScreenUtil().setWidth(8)),
                        alignment: Alignment.bottomRight,
                        child: RichText(
                          text: TextSpan(
                            text: AppLocalizations.of(context)
                                .translate('conferma'),
                            style: new TextStyle(
                                fontSize: ScreenUtil().setSp(18),
                                fontWeight: FontWeight.w700,
                                color: Colors.grey[700]),
                            recognizer: new TapGestureRecognizer()
                              ..onTap = () {
                                _aggiungiSoglieAllerta();
                                Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => MyHomePage()),
                                );
                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  String _calcolaSoglieAllerta(String soglia, int value) {
    late int fascia;

    switch (formKeyScegliAllerta.currentState?.fields[soglia]!.value) {
      case 'Giorni':
        fascia = value;
        break;
      case 'Settimane':
        fascia = value * 7;
        break;
      case 'Mesi':
        fascia = value * 30;
        break;
      case 'Anni':
        fascia = value * 365;
        break;
      default:
        return "";
    }
    return fascia.toString();
  }

  _aggiungiSoglieAllerta() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    String scegliAllerta1 = "";
    if (_calcolaSoglieAllerta("scegliAllerta1", _valoreSoglia1) == "") {
      //nel caso l'utente non inserisca nessun dato vengono dati dei giorni di deafult per le soglie
      scegliAllerta1 =
          "14"; //in questo caso vengono date 2 settimane alla prima soglia
    } else {
      scegliAllerta1 = _calcolaSoglieAllerta("scegliAllerta1", _valoreSoglia1);
    }

    String scegliAllerta2 = "";
    if (_calcolaSoglieAllerta("scegliAllerta2", _valoreSoglia2) == "") {
      scegliAllerta2 = "30";
    } else {
      scegliAllerta2 = _calcolaSoglieAllerta("scegliAllerta2", _valoreSoglia2);
    }

    String scegliAllerta3 = "";
    if (_calcolaSoglieAllerta("scegliAllerta3", _valoreSoglia3) == "") {
      scegliAllerta3 = "60";
    } else {
      scegliAllerta3 = _calcolaSoglieAllerta("scegliAllerta3", _valoreSoglia3);
    }

    print("Soglia 1 " + scegliAllerta1 + " giorni");
    print("Soglia 2 " + scegliAllerta2 + " giorni");
    print("Soglia 3 " + scegliAllerta3 + " giorni");

    await prefs.setString("prioritaBassa", scegliAllerta1);
    await prefs.setString("prioritaMedia", scegliAllerta2);
    await prefs.setString("prioritaAlta", scegliAllerta3);
  }
}
