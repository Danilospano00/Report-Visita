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
  dynamic response;

  @override
  void initState() {
    super.initState();
    openStore().then((Store store) {
      _store = store;
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
      resizeToAvoidBottomInset: false,
      body: !hasBeenInitialized?Center(child:CircularProgressIndicator(color: Colors.red,)):
          Padding(
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
                /* Padding(
                    padding: EdgeInsets.symmetric(vertical: 3.h),
                    child: TypeAheadField<Azienda?>(
                      onSuggestionSelected: (azienda) {
                        setState(() {
                          aziendaSelezionata = azienda;
                        });
                      },
                      hideSuggestionsOnKeyboardHide: false,
                      suggestionsCallback: getSuggestion,
                      itemBuilder: (context, Azienda? suggestion) {
                        final azienda = suggestion!;
                        return ListTile(
                          title: Text(azienda.nome.toString()),
                        );
                      },
                      textFieldConfiguration: TextFieldConfiguration(
                        controller: formFieldController
                          ..text = aziendaSelezionata != null
                              ? aziendaSelezionata!.nome!
                              : "",
                        decoration: InputDecoration(
                          labelText: "Nome Azienda",
                          fillColor: Colors.grey.shade300,
                          filled: true,
                          labelStyle: homePageMainTextStyle,
                          focusedBorder: formUnderlineInputBorder,
                          prefixIcon: Icon(
                            Icons.business_outlined,
                            color: Colors.black,
                          ),
                          suffixIcon: IconButton(
                            icon: Icon(Icons.cancel_outlined),
                            color: Colors.black,
                            onPressed: () {
                              formFieldController.clear();
                              formFieldControllerIndirizzo.clear();
                              formFieldControllerCitta.clear();
                              formFieldControllerCap.clear();
                              formFieldControllerIva.clear();
                              formFieldControllerCodicefiscale.clear();
                              aziendaSelezionata=null;
                            },
                          ),
                        ),
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 3.h),
                    child: FormBuilderTextField(
                      name: "indirizzo",
                      controller: formFieldControllerIndirizzo
                        ..text = aziendaSelezionata != null
                            ? aziendaSelezionata!.indirizzo!
                            : "",
                      cursorColor: Colors.grey[700],
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade300,
                        filled: true,
                        border: InputBorder.none,
                        labelText: "Indirizzo",
                        focusedBorder: formUnderlineInputBorder,
                        labelStyle: homePageMainTextStyle,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 3.h),
                    child: FormBuilderTextField(
                      name: "cap",
                      controller: formFieldControllerCap
                        ..text = aziendaSelezionata != null
                            ? aziendaSelezionata!.cap!
                            : "",
                      cursorColor: Colors.grey[700],
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade300,
                        filled: true,
                        border: InputBorder.none,
                        labelText: "CAP",
                        labelStyle: homePageMainTextStyle,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 3.h),
                    child: FormBuilderTextField(
                      name: "citta",
                      controller: formFieldControllerCitta
                        ..text = aziendaSelezionata != null
                            ? aziendaSelezionata!.citta!
                            : "",
                      cursorColor: Colors.grey[700],
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade300,
                        filled: true,
                        border: InputBorder.none,
                        labelText: "Città",
                        focusedBorder: formUnderlineInputBorder,
                        labelStyle: homePageMainTextStyle,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 3.h),
                    child: FormBuilderTextField(
                      name: "iva",
                      controller: formFieldControllerIva
                        ..text = aziendaSelezionata != null
                            ? aziendaSelezionata!.partitaIva!
                            : "",
                      cursorColor: Colors.grey[700],
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade300,
                        filled: true,
                        border: InputBorder.none,
                        labelText: "Partita IVA",
                        focusedBorder: formUnderlineInputBorder,
                        labelStyle: homePageMainTextStyle,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 3.h),
                    child: FormBuilderTextField(
                      name: "codicefiscale",
                      controller: formFieldControllerCodicefiscale
                        ..text = aziendaSelezionata != null
                            ? aziendaSelezionata!.codiceFiscale!
                            : "",
                      cursorColor: Colors.grey[700],
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade300,
                        filled: true,
                        border: InputBorder.none,
                        labelText: "Codice fiscale",
                        focusedBorder: formUnderlineInputBorder,
                        labelStyle: homePageMainTextStyle,
                      ),
                    ),
                  ),*/
                  GeneratorFormToJson(form: json.encode([
                    {
                      "title": "azineda",
                      "type": "autocomplete",
                      "hint": "inserisci la tua azienda",
                      "entity": "Azienda",
                      "field": [{"label":"indirizzo","required":true},{"label":"cap","required":true},
                        {"label":"citta","required":true}],
                      "empty": false,
                      "validation": true
                    },
                    {
                    "title": "contatto",
                    "type": "contact",
                  },
                    {
                    "title":"note",
                    "type":"note",
                    "label":["q1","q2","q3"]
                  }
                  ]),onChanged:(dynamic value) {
                    print(value);
                    setState(() {
                      this.response = value;
                    });
                    print(response.toString());
                  },),



                ],
              ),
            ),
          ),
        ),
      ),
    );
  }


  Future<void> addReport( ) async {



  if(formKeyBody.currentState!.saveAndValidate()) {
    if (aziendaSelezionata == null) {
      String adress = formFieldControllerIndirizzo.value.text + "," + formFieldControllerCitta.value.text + ","
          + formFieldControllerCap.value.text;

      List<Location> locations = await locationFromAddress(adress);
      print(locations.toString());

    }else {
      _report = Report();
      _report.azienda.target = Azienda()
        ..nome = "roma";
      _report.referente.target = Referente(
          nome: "Giuseppe", cognome: "Scalesse", telefono: "3290611539");
      _report.note.addAll(listaNote);

      _store.box<Report>().put(_report);

      List<Report> lista = _store.box<Report>().getAll();

      lista.forEach((element) {
        print("Report add -------------" + element.id.toString());
        print(
            "Report add -------------" +
                element.azienda.target!.nome.toString());
        print("Report add -------------" +
            element.referente.target!.nome.toString());
      });
    }
  }
  }


}
