import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';
import 'dart:ui';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:geocoding/geocoding.dart';
import 'package:report_visita_danilo/Models/Azienda.dart';
import 'package:report_visita_danilo/Models/Event.dart';
import 'package:report_visita_danilo/Models/Referente.dart';
import 'package:report_visita_danilo/Models/Report.dart';
import 'package:report_visita_danilo/Utils/theme.dart';
import 'package:report_visita_danilo/costanti.dart';
import 'package:report_visita_danilo/generateFromtoJson/genetareFormtoJson.dart';
import 'package:material_floating_search_bar/material_floating_search_bar.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../objectbox.g.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({
    Key? key,
  }) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  final formKeyBody = GlobalKey<FormBuilderState>();

  static final _scaffoldKey = GlobalKey<ScaffoldState>();

  late Store _store;
  bool hasBeenInitialized = false;
  late Report _report;
  late String configurazione;

  bool showSearchBar = false;

  List<dynamic> searchresult = [];

  List<Azienda> listaAziendePerRicerca = [];
  List<Report> listaReportPerRicerca = [];

  @override
  initState(){
    super.initState();
    startTimer();
  }

  startTimer() {
    Future.delayed(Duration(seconds: 5), () async {
      if (mainStore == null) {
        openStore().then((Store store) {
          _store = store;
          mainStore = _store;
          setState(() {
            listaAziendePerRicerca = mainStore!.box<Azienda>().getAll();
            listaReportPerRicerca = mainStore!.box<Report>().getAll();
          });
        });
      } else {
        _store = mainStore!;
      }

      setState(() {
        configurazione = config;
        formKeyBodyMain = formKeyBody;
      });
        hasBeenInitialized = true;
    });

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      key: _scaffoldKey,
      backgroundColor: Colors.white,
      body: !hasBeenInitialized
          ? Center(child: CircularProgressIndicator(color: Colors.red,))
          : Padding(
              padding: EdgeInsets.only(top: 4.h, left: 16.w, right: 16.w),
              child: SafeArea(
                child: SingleChildScrollView(
                  child: FormBuilder(
                    key: formKeyBody,
                    child: Stack(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 50),
                          child: GeneratorFormToJson(
                            store: _store,
                            form: configurazione,
                            active: true,
                            initialReport: null,
                            onChanged: (dynamic value) {
                              print(value);
                              setState(() {
                                response = value;
                              });
                              print(response.toString());
                            },
                          ),
                        ),
                        cambiaAppBar(),
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

    if(response.length!=0)
    {
      if (response["azienda"] != null) {
        _report.azienda.target = response["azienda"];
      } else if (response["aziendaName"] != null) {
        _report.azienda.target = Azienda()
          ..nome = response["aziendaName"];

        if (response["indirizzo"] != null) {
          List<Location> locations;
          try {
            locations = await locationFromAddress(response["indirizzo"]);
          } on Exception catch (e) {
            _showSnackBar("Indirizzo non valido");
            return;
          }

          _report.azienda.target!.indirizzo = response["indirizzo"];
          print("Indirizzo: "+ _report.azienda.target!.indirizzo.toString());
          _report.azienda.target!.lat = locations[0].latitude;
          print("Latitudine: "+_report.azienda.target!.lat.toString());
          _report.azienda.target!.lng = locations[0].longitude;
          print("Longitudine: "+_report.azienda.target!.lng.toString());
        }
        if (response["partitaIva"] != null) {
          _report.azienda.target!.partitaIva = response["partitaIva"];
        }
      } else {
        _showSnackBar("Campi mancanti");
        return;
      }
      if (response["contatto"] != null) {
        List<Contact> contact = response["contatto"];
        contact.forEach((contact) {
          _report.referente.add(Referente(
              nome: contact.givenName ?? " ",
              cognome: contact.familyName ?? " ",
              telefono: contact.phones!.isNotEmpty
                  ? contact.phones!.elementAt(0).value
                  : null,
              // id: contact.identifier!=null?int.parse(contact.identifier!):-1,
              email: contact.emails!.isNotEmpty
                  ? contact.emails!.elementAt(0).value
                  : null));
        });
      }

      if (response["file"] != null) {
        File file = response["file"];

        //ByteData fileByteData = await rootBundle.load(file.path);
        Uint8List fileUint8List = await file.readAsBytes();
        //fileByteData.buffer.asUint8List(fileByteData.offsetInBytes, fileByteData.lengthInBytes);
        List<int> fileListInt = fileUint8List.cast<int>();
        _report.byteListFile = fileListInt;
      }

      if (response["dateCompilazione"] != null)
        _report.compilazione = DateTime.parse(response["dateCompilazione"]);
      else {
        _report.compilazione = DateTime.now();
      }

      if (response["prossimaVisita"] != null) {
        _report.prossimaVisita = DateTime.parse(response["prossimaVisita"]);

        Event evento = Event();
        evento.date = DateTime.parse(response["prossimaVisita"]);
        evento.azienda.target = _report.azienda.target;
        evento.referente.addAll(_report.referente);
        int idEvento = mainStore!.box<Event>().put(evento);

        evento = mainStore!.box<Event>().get(idEvento)!;
        _report.azienda.target!.events.add(evento);
      }

      if (response["note"] != null) _report.note.addAll(response["note"]);

      //int count = await mainStore!.box<Report>().put(_report);
      //print('\n\n\n\nre-read rPORT: ${mainStore!.box<Report>().get(count)}');

      List<dynamic> mappaJsonConfigurazione = json.decode(config);

      //controllo se la config è cambiata solo sulle note
      if (checkChange(mappaJsonConfigurazione)) {
        showSConafigChange(mappaJsonConfigurazione);
      } else {
        //se non è cambiata setto la config nel report
        addToDBReport(config, "report salvato");
      }
    }else{

    }
  }


 void addToDBReport(String configDaSalvare,String msg)async{
    _report.configurationJson = configDaSalvare;
    int id = await mainStore!.box<Report>().put(_report);
    if (id > 0) {

        response = [];

      _showSnackBar(msg);
    } else {
      _showSnackBar("Errore aggiunta Report");
    }
  }

  bool checkChange(List<dynamic> mappaJsonConfigurazione) {
    bool change = false;



    //ciclo la configurazione trasformandola in una mappa
    mappaJsonConfigurazione.forEach((element) {
      if (element['type'] == "note") {
        //controllo se le leunghezze delle liste sono cambiate, se si aggiorno la config
        if (element['label'].length != response["note"].length) {
          change = true;
          return;
        }

        element['label'].forEach((notaConfig) {
          bool trovata = false;

          response["note"].forEach((notaResponse) {
            if (notaConfig == notaResponse.titolo) {
              trovata = true;
            }
          });
          if (!trovata) {
            change = true;
            return;
          }
        });
      }
    });

    return change;
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
                      "E' stato rilevato un cambiamento della configuraziona,"
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
                  addToDBReport(config,"report salvato");
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
                onPressed: () async {
                  List<String> label = [];
                  response["note"].forEach((element) {
                    label.add(element.titolo);
                  });

                  for (var i = 0; i < mappa.length; i++) {
                    if (mappa[i]['type'] == "note")
                      mappa[i]['label'] = label;
                  }
                  String newConfig=json.encode(mappa);
                  SharedPreferences pref= await SharedPreferences.getInstance();
                  pref.setString(keyConfigurazione,newConfig);
                  addToDBReport(newConfig,"Report salvato e configurazione sostituita");
                  Navigator.pop(context);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  Widget cambiaAppBar() {
    return !showSearchBar ? appBar() : searchBarUI();
  }

  Widget appBar() {
    return SafeArea(
      child: Row(
        children: [
          Text(
            "Nuovo Report",
            style: TextStyle(
              fontSize: 24.151785.sp,
              color: Colors.grey[700],
              fontWeight: FontWeight.w400,
            ),
          ),
          Spacer(),
          CircularButton(
              icon: Icon(
                Icons.search,
                color: Colors.grey[700],
              ),
              onPressed: () {
                setState(() {
                  showSearchBar = true;
                });
              }),
        ],
      ),
    );
  }

  Widget searchBarUI() {
    return Padding(
      padding: EdgeInsets.only(left: 16.w, right: 16.w),
      child: Container(
        height: searchresult.isNotEmpty
            ? MediaQuery.of(context).size.height * .30
            : MediaQuery.of(context).size.height * .15,
        // decoration: BoxDecoration(),
        child: FloatingSearchBar(
          builder: (BuildContext context, Animation<double> transition) {
            return SingleChildScrollView(
              child: Column(
                children: [
                  ListView.builder(
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: searchresult.length,
                    shrinkWrap: true,
                    itemBuilder: (BuildContext context, int i) {
                      bool istanza = searchresult[i] is Azienda;
                      print(istanza);
                      return Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          searchresult[i] is Azienda
                              ? Column(
                                  children: [
                                    ListTile(
                                      dense: true,
                                      title: Text(searchresult[i].nome),
                                      subtitle: Text(searchresult[i].indirizzo),
                                      leading: Icon(
                                        Icons.location_city_outlined,
                                      ),
                                    ),
                                    Divider(),
                                  ],
                                )
                              : Column(
                                  children: [
                                    ListTile(
                                      dense: true,
                                      title: Text(searchresult[i]
                                              .nome
                                              .toString() +
                                          searchresult[i].cognome.toString()),
                                      leading: Icon(
                                        Icons.people_outlined,
                                      ),
                                    ),
                                    Divider(),
                                  ],
                                )
                        ],
                      );
                    },
                  ),
                ],
              ),
            );
          },
          backgroundColor: Colors.white,
          clearQueryOnClose: true,
          backdropColor: Colors.white,
          hint: 'Search...',
          openAxisAlignment: 0,
          axisAlignment: 0.0,
          elevation: 4,
          automaticallyImplyDrawerHamburger: false,
          closeOnBackdropTap: true,
          transitionCurve: Curves.easeInOut,
          transitionDuration: Duration(milliseconds: 500),
          transition: CircularFloatingSearchBarTransition(),
          debounceDelay: Duration(milliseconds: 500),
          actions: [
            FloatingSearchBarAction(
              showIfOpened: false,
              child: CircularButton(
                icon: Icon(Icons.close),
                onPressed: () {
                  setState(() {
                    showSearchBar = false;
                  });
                },
              ),
            ),
            FloatingSearchBarAction.searchToClear(
              showIfClosed: false,
            ),
          ],
          onQueryChanged: (query) {
            searchresult.clear();
            print(query);
            if (listaAziendePerRicerca.isNotEmpty) {
              for (int i = 0; i < listaAziendePerRicerca.length; i++) {
                String? data = listaAziendePerRicerca[i].nome;
                if (data!.toLowerCase().contains(query)) {
                  setState(() {
                    searchresult.add(listaAziendePerRicerca[i]);
                  });
                } else {
                  setState(() {});
                }
              }
            }

            if (listaReportPerRicerca.isNotEmpty) {
              for (int i = 0; i < listaReportPerRicerca.length; i++) {
                List<Referente> data = listaReportPerRicerca[i].referente;
                for (int i = 0; i < data.length; i++) {
                  if (data[i].nome!.toLowerCase().contains(query) ||
                      data[i].cognome!.toLowerCase().contains(query)) {
                    setState(() {
                      searchresult.add(data[i]);
                    });
                  } else {
                    print("Non contiene");
                  }
                }
              }
            }
          },
        ),
      ),
    );
  }
}
