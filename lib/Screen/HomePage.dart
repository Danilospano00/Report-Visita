import 'dart:convert';
import 'dart:ui';

import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:report_visita_danilo/Models/Azienda.dart';
import 'package:report_visita_danilo/Models/Referente.dart';
import 'package:report_visita_danilo/Models/Report.dart';
import 'package:report_visita_danilo/Utils/theme.dart';
import 'package:report_visita_danilo/costanti.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:report_visita_danilo/generateFromtoJson/genetareFormtoJson.dart';

import '../objectbox.g.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  final formGlobalKey = GlobalKey<FormState>();
  final formKeyBody = GlobalKey<FormBuilderState>();
  final formKeyAddReferente = GlobalKey<FormBuilderState>();
  final noteKey = GlobalKey<FormBuilderState>();

  TextEditingController noteController = TextEditingController();
  TextEditingController formFieldController = TextEditingController();
  TextEditingController formFieldControllerIndirizzo = TextEditingController();
  TextEditingController formFieldControllerCap = TextEditingController();
  TextEditingController formFieldControllerCitta = TextEditingController();
  TextEditingController formFieldControllerIva = TextEditingController();
  TextEditingController formFieldControllerCodicefiscale =
      TextEditingController();

  late Store _store;
  bool hasBeenInitialized = false;
  late Report _report;
  late Iterable<Contact> _contacts;
  Azienda? aziendaSelezionata;
  Contact? contattoSelezionato;


  @override
  void initState() {
    super.initState();
    openStore().then((Store store) {
      _store = store;
      mainStore=_store;
      setState(() {
        hasBeenInitialized = true;
      });
    });
  }

  @override
  void dispose() {
    _store.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: !hasBeenInitialized
          ? Center(
              child: CircularProgressIndicator(
              color: Colors.red,
            ))
          : Padding(
              padding: EdgeInsets.symmetric(horizontal: 16.w),
              child: SingleChildScrollView(
                child: FormBuilder(
                  key: formKeyBody,
                  child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 22.h),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          child: Row(
                            children: [
                              Text(
                                "Nuovo Report",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 24.151785.sp,
                                  color: Colors.grey[700],
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ),
                        GeneratorFormToJson(
                          store: _store,
                          form: json.encode([
                            {
                              "title": "azienda",
                              "type": "autocomplete",
                              "hint": "inserisci la tua azienda",
                              "entity": "Azienda",
                              "field": [
                                {"label": "indirizzo", "required": true},
                                {"label": "Partita IVA", "required": true},
                              ],
                              "empty": false,
                              "validation": true
                            },
                            {
                              "title": "dateCompilazione",
                              "label": "compilazione",
                              "type": "date",
                              "required": "no"
                            },
                            {
                              "title": "prossimaVisita",
                              "label": "prossima visita",
                              "type": "date",
                              "required": "no"
                            },
                            {
                              "title": "contatto",
                              "type": "contact",
                            },
                            {
                              "title": "note",
                              "type": "note",
                              "label": [
                                "Scopo della visita/Argomenti discussi",
                                "Richiste/Prospettive",
                                "Punti forti concorrenza"
                              ]
                            }
                          ]),
                          onChanged: (dynamic value) {
                            print(value);
                            setState(() {
                             response = value;
                            });
                            print(response.toString());
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
    );
  }

  Future<void> addReport() async {
    _report = Report();

    if (response["azienda"]!=null) {
      _report.azienda.target = response["azienda"];
    } else {
      List<Location> locations =
          await locationFromAddress(response["indirizzo"]);
      _report.azienda.target = Azienda()
        ..nome = response["aziendaName"]
        ..indirizzo = response["indirizzo"]
        ..partitaIva = response["Partita IVA"]
        ..lng = locations[0].longitude
        ..lat = locations[0].latitude;
    }
    if(response["contatto"]!=null){
      Contact contact=response["contatto"];
      _report.referente.target = Referente(
          nome: contact.givenName??" ",
          cognome: contact.familyName??" ",
          telefono:  contact.phones!.isNotEmpty? contact.phones!.elementAt(0).value:null,
      id:int.parse(contact.identifier!),
          email:contact.emails!.isNotEmpty? contact.emails!.elementAt(0).value:null);
      
    }

    if(response["dateCompilazione"]!=null)
      _report.compilazione= DateTime.parse(response["dateCompilazione"]);

    if(response["prossimaVisita"]!=null)
      _report.compilazione=DateTime.parse(response["prossimaVisita"]);

    if(response["note"]!=null)
    _report.note.addAll(response["note"]);



    int count= await mainStore.box<Report>().put(_report);
    print("aggiunto  $count");


  }
}
