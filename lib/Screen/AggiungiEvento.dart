import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:report_visita_danilo/Models/Azienda.dart';
import 'package:report_visita_danilo/Models/Event.dart';
import 'package:report_visita_danilo/Models/Nota.dart';
import 'package:report_visita_danilo/Models/Report.dart';
import 'package:report_visita_danilo/generateFromtoJson/genetareFormtoJson.dart';
import 'package:report_visita_danilo/i18n/AppLocalizations.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../costanti.dart';
import '../objectbox.g.dart';

class AggiungiEvento extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AggiungiEventoState();
}

class AggiungiEventoState extends State<AggiungiEvento> {
  DateTime currentDate = DateTime.now();

  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _keyFormAggiungiEvento = GlobalKey<FormBuilderState>();
  late Store _store;

  bool showDate = false;

  late String? configurazione;

  initState() {
    super.initState();
    if (mainStore != null) {
      configurazione = configurazioneAggiuntaEvento;
      _store = mainStore!;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldKey,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.grey[700]),
        title: Text(
          AppLocalizations.of(context).translate('aggiungiEvento'),
          textAlign: TextAlign.left,
          style: TextStyle(
              fontSize: 24.151785.sp,
              fontWeight: FontWeight.w400,
              color: Colors.grey[700]),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 16.h),
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: FormBuilder(
                    key: _keyFormAggiungiEvento,
                    child: GeneratorFormToJson(
                      form: configurazione!,
                      onChanged: (dynamic value) {
                        print(value);
                        setState(() {
                          response = value;
                        });
                        print(response.toString());
                      },
                      store: _store,
                      active: true,
                      initialReport: null,
                      export: false,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 4.h, bottom: 8.h),
                child: GestureDetector(
                  onTap: () async {
                    if(_keyFormAggiungiEvento.currentState!.saveAndValidate()){
                      _addEvent();
                    }
                  },
                  child: Container(
                    height: 56.w,
                    width: 328.w,
                    color: Colors.red,
                    child: Padding(
                      padding: const EdgeInsets.only(
                        left: 12.0,
                        right: 12,
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                              AppLocalizations.of(context)
                                  .translate('aggiungiEvento'),
                              style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w700,
                                letterSpacing: 0.15,
                              )),
                        ],
                      ),
                    ),
                  ),
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _addEvent() async {
    _keyFormAggiungiEvento.currentState!.save();
    Report _report = Report();
    if (response["azienda"] != null) {
      _report.azienda.target = response["azienda"];
    } else {
      _showSnackBar("Campi mancanti");
      return;
    }
    if (response["dateCompilazione"] != null)
      _report.compilazione = DateTime.parse(response["dateCompilazione"]);
    else {
      _report.compilazione = DateTime.now();
    }
    if (response["prossimaVisita"] != null)
      _report.prossimaVisita = DateTime.parse(response["prossimaVisita"]);
    else {
      _showSnackBar("Campi mancanti");
      return;
    }

    List<dynamic> mappa=json.decode(config);

    mappa.forEach((element) {
      if(element["type"]=="note") {
        if (element["label"] != null) {
          element["label"].forEach((item) {
            _report.note.add(Nota(titolo: item, testo: ""));
          });
        }
      }
      });

    Event evento = Event();
    evento.descrizione = response["descrizione"] ?? "Nessuna descrizione";


    evento.date = DateTime.parse(response["prossimaVisita"]);
    Azienda azienda = response["azienda"];
    evento.azienda.target = azienda;
    evento.referente.addAll(azienda.referenti);
    int idEvento = mainStore!.box<Event>().put(evento);

    evento = mainStore!.box<Event>().get(idEvento)!;
    _report.azienda.target!.events.add(evento);
    _report.configurationJson = config;

    int count = await mainStore!.box<Report>().put(_report);
    print('re-read rPORT: ${mainStore!.box<Report>().get(count)}');

    if (count > 0) {
      _showSnackBar(
          AppLocalizations.of(context).translate('snackBarAggiuntaTesto'));
      Navigator.pop(context);
    } else {
      _showSnackBar(AppLocalizations.of(context)
          .translate("snackBarErroreAggiuntaTesto"));
    }
  }


  void _showSnackBar(String text) {
    final snackBar = SnackBar(
      duration: Duration(seconds: 2),
      content: Text(text),
     margin: EdgeInsets.only(bottom: 60.h, left: 16.w, right: 16.w),
      backgroundColor: Colors.black,
      padding: EdgeInsets.all(15.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(snackBar);
  }
}
