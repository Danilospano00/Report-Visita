import 'package:flutter/material.dart';
import 'package:report_visita_danilo/Models/Azienda.dart';
import 'package:report_visita_danilo/Models/Referente.dart';
import 'package:report_visita_danilo/Models/Report.dart';
import 'package:report_visita_danilo/costanti.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:contacts_service/contacts_service.dart';

import '../objectbox.g.dart';
import '../Models/Nota.dart';
import 'AccountEmpty.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  var size = Size(360, 760);
  var stileLabel = TextStyle(
    fontSize: 15.712129,
    fontWeight: FontWeight.w700,
  );

  Azienda? aziendaPerAppoggioNelForm;
  bool mostraFormReferente = false;

  bool showFormIconButton = false;
  TextEditingController nomeAziendaField = TextEditingController();
  TextEditingController indirizzoField = TextEditingController();

  List<Azienda> listaAziende = [
    Azienda(nome: "Azienda 1", indirizzo: "via casa mia"),
    Azienda(nome: "Azienda 1", indirizzo: "via casa tua")
  ];

  List<Contact> contacts = [];
  final formGlobalKey = GlobalKey<FormState>();

  TextEditingController noteController = TextEditingController();
  TextEditingController formFieldController = TextEditingController();

  late Store _store;
  bool hasBeenInitialized = false;
  late Report _report;

  @override
  void initState() {
    super.initState();
    getAllContacts();

    /*getApplicationDocumentsDirectory().then((dir) {
      _store =
          Store(getObjectBoxModel(), directory: "${dir.path}/objectbox");
      setState(() {
        hasBeenInitialized=true;
      });
    });*/

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
      body: //!hasBeenInitialized?Center(child:CircularProgressIndicator(color: Colors.red,)):
          SingleChildScrollView(
        child: Form(
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
            child: Column(
              children: [
                Padding(
                  padding:
                      EdgeInsets.only(bottom: 6.0, left: 6, right: 6, top: 32),
                  child: Row(
                    children: [
                      Text("Nuovo Report",
                          textAlign: TextAlign.left,
                          style: TextStyle(
                              fontSize: 24.151785.sp, color: Colors.grey[700])),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 6.w),
                    child: TypeAheadField<Azienda?>(
                      onSuggestionSelected: (azienda) {
                        setState(() {
                          showFormIconButton = true;
                          aziendaPerAppoggioNelForm = azienda;
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
                        controller: formFieldController,
                        decoration: InputDecoration(
                          labelText: "Nome Azienda",
                          fillColor: Colors.grey.shade300,
                          filled: true,
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(color: Colors.red)),
                          labelStyle: stileLabel,
                          prefixIcon: Icon(
                            Icons.business_outlined,
                            color: Colors.black,
                          ),
                          suffixIcon: (showFormIconButton)
                              ? IconButton(
                                  icon: Icon(Icons.cancel_outlined),
                                  color: Colors.black,
                                  onPressed: () {
                                    cancellaTesto(formFieldController);
                                  },
                                )
                              : IconButton(
                                  icon: Icon(Icons.add),
                                  color: Colors.transparent,
                                  onPressed: () {},
                                ),
                        ),
                      ),
                    ),
                  ),

                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 6.w),
                    child: TextFormField(
                      initialValue: (aziendaPerAppoggioNelForm != null &&
                              aziendaPerAppoggioNelForm!.indirizzo != null)
                          ? aziendaPerAppoggioNelForm!.indirizzo.toString()
                          : "",
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade300,
                        filled: true,
                        border: InputBorder.none,
                        labelText: "Indirizzo",
                        labelStyle: stileLabel,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 6.w),
                    child: TextFormField(
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade300,
                        filled: true,
                        border: InputBorder.none,
                        labelText: "CAP",
                        labelStyle: stileLabel,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 6.w),
                    child: TextFormField(
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade300,
                        filled: true,
                        border: InputBorder.none,
                        labelText: "Città",
                        labelStyle: stileLabel,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 6.w),
                    child: TextFormField(
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade300,
                        filled: true,
                        border: InputBorder.none,
                        labelText: "Partita IVA",
                        labelStyle: stileLabel,
                      ),
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 6.w),
                    child: TextFormField(
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade300,
                        filled: true,
                        border: InputBorder.none,
                        labelText: "Codice fiscale",
                        labelStyle: stileLabel,
                      ),
                    ),
                  ),
                  (mostraFormReferente)
                      ? WidgetReferente(stileLabel: stileLabel)
                      : SizedBox(),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 6.w),
                    child: Row(
                      children: [
                        Text(
                          "Referente",
                          style: TextStyle(color: Colors.red),
                          textAlign: TextAlign.left,
                        ),
                        IconButton(
                          splashRadius: 1,
                          icon: Icon(Icons.add_circle_outlined),
                          color: Colors.red,
                          onPressed: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    showPopUpReferente(context));
                          },
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 6.w),
                    child: Row(
                      children: <Widget>[
                        Text("Note"),
                        Expanded(
                          child: Container(
                            margin: const EdgeInsets.only(left: 20, right: 10),
                            child: Divider(
                              color: Colors.black,
                              thickness: 3,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  ListView.builder(
                    addAutomaticKeepAlives: true,
                    shrinkWrap: true,
                    itemCount: listaNote.length,
                    physics: NeverScrollableScrollPhysics(),
                    itemBuilder: (context, i) {
                      return Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade300,
                                filled: true,
                                border: InputBorder.none,
                                labelText: listaNote[i].titolo.toString()),
                          ),
                          Container(
                            width: double.infinity,
                            child: Padding(
                              padding: EdgeInsets.symmetric(
                                horizontal: 44.5.w,
                                vertical: 27.w,
                              ),
                              child: Text(
                                listaNote[i].testo.toString(),
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.grey[700],
                                ),
                                overflow: TextOverflow.clip,
                                textAlign: TextAlign.justify,
                              ),
                            ),
                          ),
                        ],
                      );
                    },
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 6.w),
                    child: GestureDetector(
                      onTap: () {
                        showDialog(
                            context: context,
                            builder: (BuildContext context) =>
                                showPopUp(context));
                      },
                      child: Container(
                        height: 52.w,
                        width: double.infinity,
                        color: Colors.grey.shade300,
                        child: Padding(
                          padding: const EdgeInsets.only(
                            left: 12.0,
                            right: 12,
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text(
                                "Aggiungi nota",
                                style: stileLabel,
                              ),
                              Spacer(),
                              Icon(
                                Icons.unfold_more_outlined,
                                color: Colors.grey[700],
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget showPopUp(context) {
    return Center(
      child: AlertDialog(
        actions: [
          Padding(
            padding: EdgeInsets.only(left: 16.0.w),
            child: Column(
              children: [
                Align(
                  alignment: Alignment.topRight,
                  child: GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: Icon(Icons.cancel_rounded, color: Colors.black),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(bottom: 32.0.w),
                  child: Row(
                    mainAxisSize: MainAxisSize.max,
                    children: [
                      Text(
                        "Aggiungi nota",
                        style: stileLabel,
                      ),
                      Spacer(),
                    ],
                  ),
                ),
                ListTile(
                  title: Text(
                    "Argomenti/Problemi/Opportunità/Dubbi",
                    style: stileLabel,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    showError(
                        "Argomenti/Problemi/Opportunità/Dubbi", 1, context);
                  },
                ),
                Divider(),
                ListTile(
                  title: Text(
                    "Criteri primari e secondari cliente",
                    style: stileLabel,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    showError(
                        "Criteri primari e secondari cliente", 1, context);
                  },
                ),
                Divider(),
                ListTile(
                  title: Text(
                    "Punti di forza concorrenza",
                    style: stileLabel,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    showError("Punti di forza concorrenza", 1, context);
                  },
                ),
                Divider(),
                ListTile(
                  title: Text(
                    "Punti deboli concorrenza",
                    style: stileLabel,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    showError("Punti deboli concorrenza", 1, context);
                  },
                ),
                Divider(),
                ListTile(
                  title: Text(
                    "Prossime azioni/Assegnazione Task/Tempi",
                    style: stileLabel,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    showError(
                        "Prossime azioni/Assegnazione Task/Tempi", 1, context);
                  },
                ),
                Divider(),
                ListTile(
                  title: Text(
                    "Prossimi step",
                    style: stileLabel,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    showError("Prossimi step", 1, context);
                  },
                ),
                Divider(),
                ListTile(
                  title: Text(
                    "Note amministrazione",
                    style: stileLabel,
                  ),
                  onTap: () {
                    Navigator.pop(context);
                    showError("Note amministrazione", 1, context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  List<Azienda> getSuggestion(String query) =>
      List.of(listaAziende).where((aziende) {
        final aziendaLower = aziende.nome.toString().toLowerCase();
        final queryLower = query.toLowerCase();

        return aziendaLower.contains(queryLower);
      }).toList();

  void showError(String mess, int pop, context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          actions: [
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 10.0),
              child: Row(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Align(
                    alignment: Alignment.topLeft,
                    child: Flexible(
                      flex: 3,
                      child: Text(
                        mess,
                        style: stileLabel,
                      ),
                    ),
                  ),
                  Spacer(),
                  Flexible(
                    flex: 1,
                    child: GestureDetector(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: Align(
                        alignment: Alignment.topRight,
                        child: CircleAvatar(
                          radius: 14.0,
                          backgroundColor: Colors.white,
                          child:
                              Icon(Icons.cancel_rounded, color: Colors.black),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Form(
              key: formGlobalKey,
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                minLines: 5,
                maxLines: 10,
                controller: noteController,
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter some text';
                  }
                  return null;
                },
                decoration: InputDecoration(
                  alignLabelWithHint: true,
                  labelStyle: TextStyle(decorationColor: Colors.grey[800]),
                  floatingLabelBehavior: FloatingLabelBehavior.never,
                  filled: true,
                  fillColor: Colors.grey.shade300,
                  labelText: "Inserisci testo...",
                  border: InputBorder.none,
                  disabledBorder: InputBorder.none,
                ),
              ),
            ),
            Row(
              children: [
                Spacer(),
                FlatButton(
                  onPressed: () {
                    if (pop == 1)
                      Navigator.pop(context);
                    else {
                      Navigator.pop(context);
                      Navigator.pop(context);
                    }
                  },
                  child: Text(
                    "ANNULLA",
                    style: TextStyle(color: Colors.red),
                  ),
                ),
                FlatButton(
                  child: Text(
                    "OK",
                    style: TextStyle(color: Colors.red),
                  ),
                  onPressed: () async {
                    if (formGlobalKey.currentState!.validate()) {
                      await addNote(mess, noteController.text);
                      noteController.clear();
                      Navigator.pop(context);
                    }
                  },
                ),
              ],
            ),
          ],
        );
      },
    ).then((value) {
      setState(() {});
    });
  }

  showPopUpReferente(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: EdgeInsets.all(20.0.w),
            child: Text(
              "Scegli un referente",
              style: stileLabel,
            ),
          ),
          Row(
            children: [
              FlatButton(
                child: Text(
                  "Aggiungi",
                  style: stileLabel,
                ),
                onPressed: () {
                  setState(() {
                    mostraFormReferente = true;
                  });
                  Navigator.pop(context);
                },
              ),
              Spacer(),
              FlatButton(
                child: Text(
                  "Rubrica",
                  style: stileLabel,
                ),
                onPressed: () {
                  showPopUpScegliReferente();
                },
              )
            ],
          ),
        ],
      ),
    );
  }

  void addReport() {
    _report = Report();
    _report.azienda.target = Azienda()..nome = "roma";
    _report.referente.target = Referente(
        nome: "Giuseppe", cognome: "Scalesse", telefono: "3290611539");
    _report.note.addAll(listaNote);

    _store.box<Report>().put(_report);

    List<Report> lista = _store.box<Report>().getAll();

    lista.forEach((element) {
      print("Report add -------------" + element.id.toString());
      print(
          "Report add -------------" + element.azienda.target!.nome.toString());
      print("Report add -------------" +
          element.referente.target!.nome.toString());
    });
  }

  Future<void> addNote(String titolo, String testo) async {
    listaNote.add(Nota(titolo: titolo, testo: testo));
  }

  void cancellaTesto(TextEditingController textEditingController) {
    textEditingController.clear();
  }

  getAllContacts() async {
    List<Contact> _contacts = (await ContactsService.getContacts()).toList();
    setState(() {
      contacts = _contacts;
    });
  }

  Widget showPopUpScegliReferente() {
    return AlertDialog(
      content: ListView.builder(
        itemBuilder: (context, index) {
          Contact contact = contacts[index];
          return ListTile(
            title: Text(contact.displayName.toString()),
            subtitle: Text(contact.phones!.elementAt(0).value.toString()),
          );
        },
        itemCount: contacts.length,
      ),
    );
  }
}

class WidgetReferente extends StatefulWidget {
  const WidgetReferente({
    Key? key,
    required this.stileLabel,
  }) : super(key: key);

  final TextStyle stileLabel;

  @override
  _WidgetReferenteState createState() => _WidgetReferenteState();
}

class _WidgetReferenteState extends State<WidgetReferente> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(vertical: 6.w),
          child: Row(
            children: <Widget>[
              Text("Referente"),
              Expanded(
                child: new Container(
                  margin: const EdgeInsets.only(left: 20, right: 10),
                  child: Divider(
                    color: Colors.black,
                    thickness: 3,
                  ),
                ),
              ),
            ],
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 6.w),
          child: TextFormField(
            decoration: InputDecoration(
              fillColor: Colors.grey.shade300,
              filled: true,
              border: InputBorder.none,
              labelText: "Nome",
              labelStyle: widget.stileLabel,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 6.w),
          child: TextFormField(
            decoration: InputDecoration(
              fillColor: Colors.grey.shade300,
              filled: true,
              border: InputBorder.none,
              labelText: "Cognome",
              labelStyle: widget.stileLabel,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 6.w),
          child: TextFormField(
            decoration: InputDecoration(
              fillColor: Colors.grey.shade300,
              filled: true,
              border: InputBorder.none,
              labelText: "Ruolo",
              labelStyle: widget.stileLabel,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 6.w),
          child: TextFormField(
            decoration: InputDecoration(
              fillColor: Colors.grey.shade300,
              filled: true,
              border: InputBorder.none,
              labelText: "Telefono",
              labelStyle: widget.stileLabel,
            ),
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(vertical: 6.w),
          child: TextFormField(
            decoration: InputDecoration(
              fillColor: Colors.grey.shade300,
              filled: true,
              border: InputBorder.none,
              labelText: "E-mail",
              labelStyle: widget.stileLabel,
            ),
          ),
        ),
      ],
    );
  }
}
