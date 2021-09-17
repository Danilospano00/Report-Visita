import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:report_visita_danilo/Screen/whitePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ScegliAllerta.dart';

class Preferences extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PreferencesState();
}

class PreferencesState extends State<Preferences> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late String _datiConfigurazione;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding:  EdgeInsets.all(ScreenUtil().setHeight(16)),
              child: AutoSizeText("Seleziona la tipologia di configurazione che vuoi usare",
                maxLines: 2,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(20),
                  fontWeight: FontWeight.w400,

                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Padding(
                    padding: EdgeInsets.symmetric(horizontal: 16.0.w, vertical: 8.w),
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.all( 8.0.w),
                        child: SizedBox(
                          height: 100.w,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                "Nome Configurazione "+ (++index).toString(),
                                style: TextStyle(
                                  fontSize: 15.712129,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,),
                                textAlign: TextAlign.left,
                              ),
                              Spacer(),
                              Text(
                                "Descrizione configurazione "+ (index++).toString(),
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 15.712129,
                                  fontWeight: FontWeight.w700,
                                  fontStyle: FontStyle.normal,),
                              ),
                              Align(
                                alignment: Alignment.bottomRight,
                                child: ElevatedButton(
                                  onPressed: () async {
                                    _datiConfigurazione = "Stringa configurazione";
                                    _saveConfiguration(_datiConfigurazione);
                                    Navigator.pushReplacement(context,
                                      MaterialPageRoute<void>(
                                          builder: (context) => ScegliAllerta()),);
                                  },
                                  child: Text(
                                    "Seleziona",
                                      style: TextStyle(color: Colors.white,
                                        fontSize: 15.712129,
                                        fontWeight: FontWeight.w700,
                                        fontStyle: FontStyle.normal,)
                                  ),
                                  style: ElevatedButton.styleFrom(
                                      primary: Colors.red, padding: EdgeInsets.all(4.w)),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
            ),
          ],
        ),
      ),
    );
  }
  Future<void> _saveConfiguration(String datiConfigurazione)async{
    final SharedPreferences prefs = await _prefs;
    prefs.setString("datiConfigurazione", datiConfigurazione.toString());
    print(prefs.getString("datiConfigurazione"));
    }
}
