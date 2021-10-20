import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:report_visita_danilo/Screen/whitePage.dart';
import 'package:report_visita_danilo/generateFromtoJson/genetareFormtoJson.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../costanti.dart';
import 'MostraConfigurazioni.dart';
import 'ScegliAllerta.dart';

class Preferences extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => PreferencesState();
}

class PreferencesState extends State<Preferences> {
  Future<SharedPreferences> _prefs = SharedPreferences.getInstance();
  late String _datiConfigurazione;
  late String configurazioneFormDiEsempio;

  dynamic configurazioniPreferences;

  @override
  initState() {
    super.initState();
    setState(() {
      configurazioneFormDiEsempio = configPerConfigurazioniUtente;
      configurazioniPreferences = configPreferences;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.max,
          children: [
            Padding(
              padding: EdgeInsets.all(ScreenUtil().setHeight(16)),
              child: AutoSizeText(
                "Seleziona la tipologia di configurazione che vuoi usare",
                maxLines: 2,
                style: TextStyle(
                  fontSize: ScreenUtil().setSp(20),
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: configPreferences.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: EdgeInsets.only(
                      left: 16.0.w, top: 8.h, bottom: 16.h, right: 16.w),
                  child: Container(
                    height: 120.h,
                    child: Card(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: 8.0.h, bottom: 8.h, left: 8.w, right: 8.w),
                        child: Stack(
                          children: [
                            Row(
                              mainAxisSize: MainAxisSize.max,
                              children: [
                                configPreferences[index].containsKey("icon")
                                    ? CircleAvatar(
                                        backgroundColor: Colors.red,
                                        minRadius: 20,
                                        maxRadius: 40,
                                        child: Image.asset(
                                          "assets/${configPreferences[index]['icon']}.png",
                                          color: Colors.white,
                                          width: 40.w,
                                        ),
                                      )
                                    : Container(),
                                Padding(
                                  padding:
                                      EdgeInsets.only(left: 16.w, top: 20.h),
                                  child: Container(
                                    width: 200.w,
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        AutoSizeText(
                                          configPreferences[index]['name'],
                                          style: TextStyle(
                                            fontSize: 15.712129.sp,
                                            fontWeight: FontWeight.w700,
                                            fontStyle: FontStyle.normal,
                                          ),
                                          textAlign: TextAlign.left,
                                        ),
                                        Flexible(
                                          child: AutoSizeText(
                                            configPreferences[index]
                                                ['description'],
                                            maxLines: 3,
                                            overflow: TextOverflow.fade,
                                            style: TextStyle(
                                              fontSize: 15.sp,
                                              fontWeight: FontWeight.w300,
                                              fontStyle: FontStyle.normal,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Align(
                              alignment: Alignment.bottomRight,
                              child: ElevatedButton(
                                onPressed: () async {
                                  _saveConfiguration("Stringa configurazione");
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute<void>(
                                      builder: (context) =>
                                          _mostraConfigurazione(
                                              configPreferences[index]['name'],
                                              json.encode(
                                                  configPreferences[index]
                                                      ['jsonConfig'])),
                                    ),
                                  );
                                },
                                child: Text("Seleziona",
                                    style: TextStyle(
                                      color: Colors.white,
                                      fontSize: 15.712129.sp,
                                      fontWeight: FontWeight.w700,
                                      fontStyle: FontStyle.normal,
                                    )),
                                style: ElevatedButton.styleFrom(
                                    primary: Colors.red,
                                    padding: EdgeInsets.all(4.w)),
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

  Future<void> _saveConfiguration(String datiConfigurazione) async {
    final SharedPreferences prefs = await _prefs;
    prefs.setString("datiConfigurazione", datiConfigurazione.toString());
    print(prefs.getString("datiConfigurazione"));
  }

  Widget _mostraConfigurazione(String titolo, String configurazione) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.grey[700]),
        title: AutoSizeText(
          titolo,
          textAlign: TextAlign.left,
          style: TextStyle(
              fontSize: 21.sp,
              fontWeight: FontWeight.w400,
              color: Colors.grey[700]),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(right: 16.w, left: 16.w),
        child: Stack(
          children: [
            SingleChildScrollView(
              child: GeneratorFormToJson(
                form: configurazione,
                store: mainStore!,
                onChanged: (dynamic value) {
                  print(value);
                  setState(() {
                    response = value;
                  });
                  print(response.toString());
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(bottom: 16.h, right: 8.w),
              child: Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () {
                    _saveConfiguration("datiConfigurazione");
                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute<void>(
                          builder: (context) => ScegliAllerta()),
                    );
                  },
                  child: Text(
                    "ACCETTA",
                    style: TextStyle(
                      color: Colors.red,
                      fontSize: 14.sp,
                      fontWeight: FontWeight.w700,
                      letterSpacing: 1.25,
                    ),
                  ),
                  style: ElevatedButton.styleFrom(
                    fixedSize: Size(125.w, 56.h),
                    primary: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(4.0),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
