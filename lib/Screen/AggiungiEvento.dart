import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:report_visita_danilo/Models/Azienda.dart';
import 'package:report_visita_danilo/Models/Event.dart';
import 'package:report_visita_danilo/Models/Referente.dart';
import 'package:report_visita_danilo/Models/Report.dart';
import 'package:report_visita_danilo/Utils/FormatDate.dart';
import 'package:report_visita_danilo/generateFromtoJson/genetareFormtoJson.dart';

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
      _store = mainStore!;
    }
    configurazione = configurazioneAggiuntaEvento;
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
          "Aggiungi evento",
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
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.only(top: 4.h, bottom: 8.h),
                child: GestureDetector(
                  onTap: () async {
                    _addEvent();
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
                          Text("Aggiungi Evento",
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

  //i dati inseriti nel form sono stringhe ma devo trasformarle in azienda/referente, prima devo cercare
  // di aggiungere le aziende alla DB in modo da non doverle ciclare ogni volta


  void _addEvent() async {
    _keyFormAggiungiEvento.currentState!.saveAndValidate();
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

    if (response["descrizione"] != null) {
      Event evento = Event();
      evento.descrizione = response["descrizione"];
      evento.date = DateTime.parse(response["prossimaVisita"]);
      Azienda azienda = response["azienda"];
      evento.azienda.target = azienda;
      evento.referente.addAll(azienda.referenti);
      int idEvento = mainStore!.box<Event>().put(evento);

      evento = mainStore!.box<Event>().get(idEvento)!;
      _report.azienda.target!.events.add(evento);
    } else {
      _showSnackBar("Campi mancanti");
      return;
    }

    int count = await mainStore!.box<Report>().put(_report);
    print('re-read rPORT: ${mainStore!.box<Report>().get(count)}');

    if (count > 0) {
      _showSnackBar("Evento aggiunto correttamente");
    } else {
      _showSnackBar("Errore aggiunta Report");
    }
  }

  void _showSnackBar(String text) {
    final snackBar = SnackBar(
      duration: Duration(seconds: 8),
      content: Text(text),
      backgroundColor: Colors.black,
      padding: EdgeInsets.all(15.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(_scaffoldKey.currentContext!).showSnackBar(snackBar);
  }
}
