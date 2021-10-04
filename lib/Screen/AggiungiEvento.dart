import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:report_visita_danilo/Models/Azienda.dart';
import 'package:report_visita_danilo/Models/Event.dart';
import 'package:report_visita_danilo/Models/Referente.dart';
import 'package:report_visita_danilo/Utils/FormatDate.dart';

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
        key: _keyFormAggiungiEvento,
        child: Padding(
          padding: EdgeInsets.only(right: 16.w, left: 16.w, top: 43.w),
          child: Column(
            children: [
              Row(
                children: [
                  Text(
                    "Aggiungi Evento",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 24.151785.sp,
                      color: Colors.grey[700],
                    ),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 6.w),
                child: FormBuilderTextField(
                  name: 'azienda',
                  decoration: InputDecoration(
                    labelText: "Azienda",
                    fillColor: Colors.grey.shade300,
                    filled: true,
                    border: InputBorder.none,
                  ),
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(context),
                    ],
                  ),
                ),
              ),Padding(
                padding: EdgeInsets.symmetric(vertical: 6.w),
                child: FormBuilderTextField(
                  name: 'posizione',
                  decoration: InputDecoration(
                    labelText: "Posizione",
                    fillColor: Colors.grey.shade300,
                    filled: true,
                    border: InputBorder.none,
                  ),
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(context),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 6.w),
                child: GestureDetector(
                  onTap: () => _selectDate(context),
                  child: Container(
                    color: Colors.grey[300],
                    height: 60,
                    width: double.infinity,
                    child: Padding(
                      padding: EdgeInsets.only(left: 8.0),
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: !showDate?Text(
                          "Scegli data evento",
                          textAlign: TextAlign.start,
                          style: TextStyle(color: Colors.grey[700]),
                        ):
                            Text(FormatDate.fromDateTimeToString(currentDate,"data"),
                              textAlign: TextAlign.start,
                              style: TextStyle(color: Colors.grey[700]),
                            ),
                      ),
                    ),
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 6.w),
                child: FormBuilderTextField(
                  name: 'referente',
                  decoration: InputDecoration(
                    labelText: "Referente",
                    fillColor: Colors.grey.shade300,
                    filled: true,
                    border: InputBorder.none,
                  ),
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(context),
                    ],
                  ),
                ),
              ),
              Padding(
                padding: EdgeInsets.symmetric(vertical: 6.w),
                child: FormBuilderTextField(
                  name: 'descrizione',
                  minLines: 4,
                  maxLines: 6,
                  decoration: InputDecoration(
                    labelText: "Descrizione evento...",
                    fillColor: Colors.grey.shade300,
                    filled: true,
                    border: InputBorder.none,
                    alignLabelWithHint: true,
                  ),
                  validator: FormBuilderValidators.compose(
                    [
                      FormBuilderValidators.required(context),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton.icon(
                  icon: Icon(
                    Icons.add,
                    color: Colors.red,
                  ),
                  onPressed: () {
                    aggiungiEvento();
                  },
                  label: Text(
                    "EVENT",
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
            ],
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
        showDate=true;
      });
  }


  //i dati inseriti nel form sono stringhe ma devo trasformarle in azienda/referente, prima devo cercare
  // di aggiungere le aziende alla DB in modo da non doverle ciclare ogni volta
  void aggiungiEvento(){
      Azienda azienda =
          _keyFormAggiungiEvento.currentState?.fields['azienda']!.value ?? " ";
      Referente referente =
          _keyFormAggiungiEvento.currentState?.fields['referente']!.value ??
              " ";
      DateTime data = currentDate;

      Event event = new Event();
      event.azienda.target = azienda;
      event.referente.target = referente;
      event.date = data;

      print(event.azienda.target.toString()+"\n");
      print(event.referente.target.toString()+"\n");
      print(event.date.toString()+"\n");

      _store.box<Event>().put(event);


  }
}
