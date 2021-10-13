import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:report_visita_danilo/Models/Azienda.dart';
import 'package:report_visita_danilo/Models/Event.dart';
import 'package:report_visita_danilo/Models/Referente.dart';
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
      body: Padding(
        padding: EdgeInsets.only(left: 8.w, right: 8.w, top: 40.h),
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
    );
  }

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2050),
    );
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
        showDate = true;
      });
  }

  //i dati inseriti nel form sono stringhe ma devo trasformarle in azienda/referente, prima devo cercare
  // di aggiungere le aziende alla DB in modo da non doverle ciclare ogni volta

  void aggiungiEvento() {
    Azienda azienda =
        _keyFormAggiungiEvento.currentState?.fields['azienda']!.value ?? " ";
    Referente referente =
        _keyFormAggiungiEvento.currentState?.fields['referente']!.value ?? " ";
    DateTime data = currentDate;

    Event event = new Event();
    event.azienda.target = azienda;
    event.referente.add(referente);
    event.date = data;

    print(event.azienda.target.toString() + "\n");
    print(event.referente.toString() + "\n");
    print(event.date.toString() + "\n");

    _store.box<Event>().put(event);
  }
}
