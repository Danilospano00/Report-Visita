import 'package:auto_size_text/auto_size_text.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:report_visita_danilo/Models/Azienda.dart';
import 'package:report_visita_danilo/Models/Referente.dart';
import 'package:report_visita_danilo/Models/Report.dart';
import 'package:report_visita_danilo/Utils/theme.dart';
import 'package:report_visita_danilo/costanti.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';

import '../Models/Nota.dart';
import '../objectbox.g.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  MyHomePageState createState() => MyHomePageState();
}

class MyHomePageState extends State<MyHomePage> {
  List<Azienda> listaAziende = [
    Azienda(
        nome: "Azienda 1",
        indirizzo: "via casa mia",
        cap: "04040",
        partitaIva: "jhsonasdo",
        codiceFiscale: "dsnflksdnflk",
        citta: "priverno"),
    Azienda(
        nome: "Azienda 1",
        indirizzo: "via casa tua",
        cap: "0400",
        partitaIva: "jhsonasdo",
        codiceFiscale: "dsnflksdnflk",
        citta: "roma")
  ];

  final formGlobalKey = GlobalKey<FormState>();
  final formKeyBody = GlobalKey<FormBuilderState>();
  final formKeyAddReferente = GlobalKey<FormBuilderState>();

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

  @override
  void initState() {
    super.initState();
    /*getApplicationDocumentsDirectory().then((dir) {
      _store =
          Store(getObjectBoxModel(), directory: "${dir.path}/objectbox");
      setState(() {
        hasBeenInitialized=true;
      });
    });*/
    getContacts();
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
        child: FormBuilder(
          key: formKeyBody,
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
                          style:
                              TextStyle(fontSize: 28, color: Colors.grey[700])),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(6.0),
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
                        focusedBorder: UnderlineInputBorder(
                            borderSide: BorderSide(color: Colors.red)),
                        labelStyle: TextStyle(
                          color: Colors.black,
                        ),
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
                            formFieldControllerCap.clear();
                            formFieldControllerCitta.clear();
                            formFieldControllerIva.clear();

                            formFieldControllerCodicefiscale.clear();
                            aziendaSelezionata = null;
                          },
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(6.0),
                  child: FormBuilderTextField(
                    name: "indirizzo",
                    controller: formFieldControllerIndirizzo
                      ..text = aziendaSelezionata != null
                          ? aziendaSelezionata!.indirizzo!
                          : "",
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade300,
                      filled: true,
                      border: InputBorder.none,
                      labelText: "Indirizzo",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(6.0),
                  child: FormBuilderTextField(
                    name: "cap",
                    controller: formFieldControllerCap
                      ..text = aziendaSelezionata != null
                          ? aziendaSelezionata!.cap!
                          : "",
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade300,
                      filled: true,
                      border: InputBorder.none,
                      labelText: "CAP",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(6.0),
                  child: FormBuilderTextField(
                    name: "citta",
                    controller: formFieldControllerCitta
                      ..text = aziendaSelezionata != null
                          ? aziendaSelezionata!.citta!
                          : "",
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade300,
                      filled: true,
                      border: InputBorder.none,
                      labelText: "Città",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(6.0),
                  child: FormBuilderTextField(
                    name: "iva",
                    controller: formFieldControllerIva
                      ..text = aziendaSelezionata != null
                          ? aziendaSelezionata!.partitaIva!
                          : "",
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade300,
                      filled: true,
                      border: InputBorder.none,
                      labelText: "Partita IVA",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(6.0),
                  child: FormBuilderTextField(
                    name: "codicefiscale",
                    controller: formFieldControllerCodicefiscale
                      ..text = aziendaSelezionata != null
                          ? aziendaSelezionata!.codiceFiscale!
                          : "",
                    decoration: InputDecoration(
                      fillColor: Colors.grey.shade300,
                      filled: true,
                      border: InputBorder.none,
                      labelText: "Codice fiscale",
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(6.0),
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
                /*   Padding(
                  padding: EdgeInsets.all(6.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        fillColor: Colors.grey.shade300,
                        filled: true,
                        border: InputBorder.none,
                        labelText: "Nome"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(6.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        fillColor: Colors.grey.shade300,
                        filled: true,
                        border: InputBorder.none,
                        labelText: "Cogome"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(6.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        fillColor: Colors.grey.shade300,
                        filled: true,
                        border: InputBorder.none,
                        labelText: "Ruolo"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(6.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        fillColor: Colors.grey.shade300,
                        filled: true,
                        border: InputBorder.none,
                        labelText: "Telefono"),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(6.0),
                  child: TextFormField(
                    decoration: InputDecoration(
                        fillColor: Colors.grey.shade300,
                        filled: true,
                        border: InputBorder.none,
                        labelText: "E-mail"),
                  ),
                ),*/
                Padding(
                  padding: EdgeInsets.all(6.0),
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
                          FocusScope.of(context).unfocus();
                          showSolutionReferente();
                        },
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(top: 6.0),
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
                    return Padding(
                      padding:
                          EdgeInsets.only(bottom: ScreenUtil().setHeight(16)),
                      child: Column(
                        children: [
                          Container(
                            height: 55,
                            //width: double.infinity,
                            color: Colors.grey.shade300,
                            child: ListTile(
                              title: Text(
                                listaNote[i].titolo.toString(),
                                style: TextStyle(
                                    color: Colors.grey[700], fontSize: 15),
                              ),
                              trailing: IconButton(
                                  onPressed: () {
                                    setState(() {
                                      listaNote.removeAt(i);
                                    });
                                  },
                                  icon: Icon(Icons.cancel_rounded,
                                      color: Colors.black)),
                            ),
                          ),
                          Container(
                            width: double.infinity,
                            child: Padding(
                              padding: EdgeInsets.only(
                                  left: ScreenUtil().setWidth(16),
                                  right: ScreenUtil().setWidth(16),
                                  top: ScreenUtil().setHeight(8),
                                  bottom: ScreenUtil().setHeight(8)),
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
                      ),
                    );
                  },
                ),
                Padding(
                  padding: EdgeInsets.only(right: 6.0, left: 6, bottom: 6),
                  child: GestureDetector(
                    onTap: () {
                      FocusScope.of(context).unfocus();
                      showDialog(
                          context: context,
                          builder: (BuildContext context) =>
                              showPopUp(context));
                    },
                    child: Container(
                      height: 58,
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
                              style: TextStyle(
                                  color: Colors.grey[700], fontSize: 15),
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
        ),
      ),
    );
  }

  Widget showPopUp(context) {
    return new AlertDialog(
      actions: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 10.0),
          child: Row(
            mainAxisSize: MainAxisSize.max,
            children: [
              Align(
                  alignment: Alignment.topLeft,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 5),
                    child: Text(
                      "Aggiungi nota",
                      style: TextStyle(fontSize: 20),
                    ),
                  )),
              Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: Align(
                  alignment: Alignment.topRight,
                  child: CircleAvatar(
                    radius: 14.0,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.cancel_rounded, color: Colors.black),
                  ),
                ),
              ),
            ],
          ),
        ),
        ListTile(
          title: Text(
            "Argomenti/Problemi/Opportunità/Dubbi",
            textAlign: TextAlign.left,
          ),
          onTap: () {
            Navigator.pop(context);
            showError("Argomenti/Problemi/Opportunità/Dubbi", 1, context);
          },
        ),
        Divider(),
        ListTile(
          title: Text(
            "Criteri primari e secondari cliente",
            textAlign: TextAlign.left,
          ),
          onTap: () {
            Navigator.pop(context);
            showError("Criteri primari e secondari cliente", 1, context);
          },
        ),
        Divider(),
        ListTile(
          title: Text(
            "Punti di forza concorrenza",
            textAlign: TextAlign.left,
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
            textAlign: TextAlign.left,
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
            textAlign: TextAlign.left,
          ),
          onTap: () {
            Navigator.pop(context);
            showError("Prossime azioni/Assegnazione Task/Tempi", 1, context);
          },
        ),
        Divider(),
        ListTile(
          title: Text(
            "Prossimi step",
            textAlign: TextAlign.left,
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
            textAlign: TextAlign.left,
          ),
          onTap: () {
            Navigator.pop(context);
            showError("Note amministrazione", 1, context);
          },
        ),
        Divider(),
      ],
    );
  }

  Future<void> getContacts() async {
    final Iterable<Contact> contacts = await ContactsService.getContacts();
    setState(() {
      _contacts = contacts;
    });
  }

  void showReferente() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          title: Text(
            "Seleziona Referenete",
            textAlign: TextAlign.center,
          ),
          content: Container(
            width: MediaQuery.of(context).size.width * .70,
            height: MediaQuery.of(context).size.height * .50,
            child: /*Column(
              children: [
            ,
*/
                _contacts != null
                    //Build a list view of all contacts, displaying their avatar and
                    // display name
                    ? ListView.builder(
                        shrinkWrap: false,
                        scrollDirection: Axis.vertical,
                        itemCount: _contacts.length,
                        itemBuilder: (BuildContext context, int index) {
                          late Contact contact = _contacts.elementAt(index);
                          return ListTile(
                            contentPadding: const EdgeInsets.symmetric(
                                vertical: 2, horizontal: 18),
                            leading: (contact.avatar != null &&
                                    contact.avatar!.isNotEmpty)
                                ? CircleAvatar(
                                    backgroundImage:
                                        MemoryImage(contact.avatar!),
                                  )
                                : CircleAvatar(
                                    child: Text(
                                      contact.initials(),
                                      style:
                                          TextStyle(color: rvTheme.canvasColor),
                                    ),
                                    backgroundColor: rvTheme.primaryColor,
                                  ),
                            title: Text(contact.displayName ?? ''),
                            //This can be further expanded to showing contacts detail
                            // onPressed().
                          );
                        },
                      )
                    : Center(child: Text("Nessun Contatto Presente")),
            /*  ],
            ),*/
          ),
          actions: [
            ButtonTheme(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              child: RaisedButton(
                color: rvTheme.primaryColor,
                elevation: 2,
                child: Text(
                  "Annulla",
                  style: TextStyle(color: rvTheme.canvasColor),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  //Navigator.pop(context);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void showSolutionReferente() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          title: Text(
            "Aggiungi o Seleziona un Referenete",
            textAlign: TextAlign.center,
          ),
          content: Container(
              width: MediaQuery.of(context).size.width * .60,
              height: MediaQuery.of(context).size.height * .20,
              child: Center(
                  child: AutoSizeText(
                      "Puoi selezionare un referente dai tuoi contatti o creare un nuovo referente."))),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ButtonTheme(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              child: RaisedButton(
                color: rvTheme.primaryColor,
                elevation: 2,
                child: Text(
                  "Seleziona",
                  style: TextStyle(color: rvTheme.canvasColor),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  showReferente();
                  //Navigator.pop(context);
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
                  "Nuovo",
                  style: TextStyle(color: rvTheme.canvasColor),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  showAddReferente();
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void showAddReferente() {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          title: Text(
            "Aggiungi Referenete",
            textAlign: TextAlign.center,
          ),
          content: Container(
            width: MediaQuery.of(context).size.width * .80,
            height: MediaQuery.of(context).size.height * .50,
            child: SingleChildScrollView(
                child: FormBuilder(
                    key: formKeyAddReferente,
                    child: Padding(
                        padding: EdgeInsets.all(ScreenUtil().setHeight(8)),
                        child: Column(children: [
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: ScreenUtil().setHeight(6)),
                            child: FormBuilderTextField(
                              name: "nome",
                              decoration: InputDecoration(
                                  fillColor: Colors.grey.shade300,
                                  filled: true,
                                  border: InputBorder.none,
                                  labelText: "Nome"),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context),
                              ]),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: ScreenUtil().setHeight(6)),
                            child: FormBuilderTextField(
                              name: "cognome",
                              decoration: InputDecoration(
                                  fillColor: Colors.grey.shade300,
                                  filled: true,
                                  border: InputBorder.none,
                                  labelText: "Cognome"),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context),
                              ]),
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: ScreenUtil().setHeight(6)),
                            child: FormBuilderTextField(
                              name: "ruolo",
                              decoration: InputDecoration(
                                  fillColor: Colors.grey.shade300,
                                  filled: true,
                                  border: InputBorder.none,
                                  labelText: "Ruolo"),
                             
                            ),
                          ),
                          Padding(
                            padding: EdgeInsets.only(
                                bottom: ScreenUtil().setHeight(6)),
                            child: FormBuilderTextField(
                              name: "telefono",
                              decoration: InputDecoration(
                                  fillColor: Colors.grey.shade300,
                                  filled: true,
                                  border: InputBorder.none,
                                  labelText: "Telefono"),
                              validator: FormBuilderValidators.compose([
                                FormBuilderValidators.required(context),
                              ]),
                            ),
                          ),
                          Padding(
                              padding: EdgeInsets.only(
                                  bottom: ScreenUtil().setHeight(6)),
                              child: FormBuilderTextField(
                                name: "email",
                                decoration: InputDecoration(
                                    fillColor: Colors.grey.shade300,
                                    filled: true,
                                    border: InputBorder.none,
                                    labelText: "E-mail"),
                                validator: FormBuilderValidators.compose([
                                  FormBuilderValidators.email(context),
                                ]),
                              )),
                        ])))),
          ),
          actionsAlignment: MainAxisAlignment.center,
          actions: [
            ButtonTheme(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25)),
              child: RaisedButton(
                color: rvTheme.primaryColor,
                elevation: 2,
                child: Text(
                  "Annulla",
                  style: TextStyle(color: rvTheme.canvasColor),
                ),
                onPressed: () {
                  Navigator.pop(context);
                  //showReferente();
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
                  "Aggiungi",
                  style: TextStyle(color: rvTheme.canvasColor),
                ),
                onPressed: () async {
                  if (formKeyAddReferente.currentState?.validate() ?? false) {
                    String nome = formKeyAddReferente
                            .currentState?.fields['nome']!.value
                             ??
                        " ";
                    String cognome = formKeyAddReferente
                            .currentState?.fields['cognome']!.value
                             ??
                        " ";
                    String ruolo = formKeyAddReferente
                            .currentState?.fields['ruolo']!.value
                             ??
                        " ";
                    String email = formKeyAddReferente
                            .currentState?.fields['email']!.value
                             ??
                        " ";
                    String telefono = formKeyAddReferente
                            .currentState?.fields['telefono']!.value
                             ??
                        " ";

                    Contact contatto = Contact(
                        givenName: nome ,
                        familyName: cognome,
                        displayName: nome + " " + cognome,
                        company: ruolo ,
                        emails: [Item(label: "email", value: email)] ,
                        phones: [Item(label: "telefono", value: telefono)]);
                    await ContactsService.addContact(contatto);
                    Navigator.pop(context);
                  }
                },
              ),
            ),
          ],
        );
      },
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
}
