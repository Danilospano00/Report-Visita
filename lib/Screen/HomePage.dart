import 'dart:convert';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
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
import 'package:report_visita_danilo/generateFromtoJson/genetareFormtoJson.dart';

import '../objectbox.g.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
  }) : super(key: key);

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

  static final _scaffoldKey = GlobalKey<ScaffoldState>();

  late Store _store;
  bool hasBeenInitialized = false;
  late Report _report;
  late Iterable<Contact> _contacts;
  Azienda? aziendaSelezionata;
  Contact? contattoSelezionato;
  late String configurazione;

  @override
  void initState() {
    super.initState();
    openStore().then((Store store) {
      _store = store;
      mainStore = _store;
      setState(() {
        hasBeenInitialized = true;
      });
    });
    setState(() {
      configurazione = config;
      formKeyBodyMain = formKeyBody;
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
      key: _scaffoldKey,
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
                          form: configurazione,
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
    formKeyBodyMain.currentState!.saveAndValidate();
    _report = Report();

    if (response["azienda"] != null) {
      _report.azienda.target = response["azienda"];
    } else if (response["indirizzo"] != null &&
        response["aziendaName"] != null &&
        response["partitaIva"] != null) {
      List<Location> locations =
          await locationFromAddress(response["indirizzo"]);
      _report.azienda.target = Azienda()
        ..nome = response["aziendaName"]
        ..indirizzo = response["indirizzo"]
        ..partitaIva = response["partitaIva"]
        ..lng = locations[0].longitude
        ..lat = locations[0].latitude;
    } else {
      _showSnackBar("Campi mancanti");
      return;
    }
    if (response["contatto"] != null) {
      Contact contact = response["contatto"];
      _report.referente.target = Referente(
          nome: contact.givenName ?? " ",
          cognome: contact.familyName ?? " ",
          telefono: contact.phones!.isNotEmpty
              ? contact.phones!.elementAt(0).value
              : null,
         // id: contact.identifier!=null?int.parse(contact.identifier!):-1,
          email: contact.emails!.isNotEmpty
              ? contact.emails!.elementAt(0).value
              : null);
    } else {
      _showSnackBar("Campi mancanti");
      return;
    }

    if (response["dateCompilazione"] != null)
      _report.compilazione = DateTime.parse(response["dateCompilazione"]);
    else {
      _showSnackBar("Campi mancanti");
      return;
    }

    if (response["prossimaVisita"] != null)
      _report.compilazione = DateTime.parse(response["prossimaVisita"]);
    else {
      _showSnackBar("Campi mancanti");
      return;
    }

    if (response["note"] != null)
      _report.note.addAll(response["note"]);
    else {
      _showSnackBar("Campi mancanti");
      return;
    }

    int count = await mainStore.box<Report>().put(_report);

    if (count > 0) {
      List<dynamic> mappaJsonConfigurazione = json.decode(config);
      bool change = false;
      mappaJsonConfigurazione.forEach((element) {
        if (element['type'] == "note") if (element['label'].length <
            response["note"].length) {
          change = true;
          return;
        }
      });
      if (change)
        showSConafigChange(mappaJsonConfigurazione);
      else
        _showSnackBar("report salvato");
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

  void showSConafigChange(List<dynamic> mappa) {
    showDialog(
      context: _scaffoldKey.currentContext!,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          title: Text(
            "ATTENZIONE",
            textAlign: TextAlign.center,
          ),
          content: Container(
              width: MediaQuery.of(context).size.width * .60,
              height: MediaQuery.of(context).size.height * .20,
              child: Center(
                  child: AutoSizeText(
                      "Report aggiunto con successo,è stato rilevato un cambiamento della configuraziona,"
                      "vuoi sostituirla ?"))),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ButtonTheme(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              child: RaisedButton(
                color: rvTheme.primaryColor,
                elevation: 2,
                child: Text(
                  "Indietro",
                  style: TextStyle(color: rvTheme.canvasColor),
                ),
                onPressed: () {
                  Navigator.pop(context);
                },
              ),
            ),
            ButtonTheme(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              child: RaisedButton(
                color: rvTheme.primaryColor,
                elevation: 2,
                child: Text(
                  "Sostituisci",
                  style: TextStyle(color: rvTheme.canvasColor),
                ),
                onPressed: () {
                  List<String> label = [];
                  response["note"].forEach((element) {
                    label.add(element.titolo);
                  });

                  for (var i = 0; i < mappa.length; i++) {
                    if (mappa[i]['type'] == "note") mappa[i]['label'] = label;
                  }

                  config = json.encode(mappa);
                  _showSnackBar("configurazione sostituita");

                  Navigator.pop(context);
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
