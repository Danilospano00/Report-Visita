import 'dart:ui';

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
import 'package:rflutter_alert/rflutter_alert.dart';

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
        indirizzo: "via prova 1",
        cap: "04040",
        partitaIva: "re3456yf",
        codiceFiscale: "re3456yf",
        citta: "priverno"),
    Azienda(
        nome: "Azienda 2",
        indirizzo: "via prova 2",
        cap: "0400",
        partitaIva: "pt5677po",
        codiceFiscale: "pt5677po",
        citta: "Roma")
  ];

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
                  Padding(
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
                            onPressed: () {},
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
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(vertical: 12.h),
                    child: Row(
                      children: <Widget>[
                        Text(
                          "Referente",
                          style: homePageMainTextStyle,
                        ),
                        Expanded(
                          child: new Container(
                            margin: EdgeInsets.only(left: 20),
                            child: Divider(
                              color: Colors.grey[700],
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
                    padding: EdgeInsets.symmetric(vertical: 3.h),
                    child: Row(
                      children: [
                        Text(
                          "Referente",
                          style: TextStyle(
                            color: Colors.red,
                            fontSize: 15.712129.sp,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.15,
                          ),
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
                  contattoSelezionato != null
                      ? Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 2, horizontal: 18),
                              leading: (contattoSelezionato!.avatar != null &&
                                      contattoSelezionato!.avatar!.isNotEmpty)
                                  ? CircleAvatar(
                                      backgroundImage: MemoryImage(
                                          contattoSelezionato!.avatar!),
                                    )
                                  : CircleAvatar(
                                      child: Text(
                                        contattoSelezionato!.initials(),
                                        style: TextStyle(
                                            color: rvTheme.canvasColor),
                                      ),
                                      backgroundColor: rvTheme.primaryColor,
                                    ),
                              title:
                                  Text(contattoSelezionato!.displayName ?? ''),
                              //This can be further expanded to showing contacts detail
                              onTap: () {
                                setState(() {
                                  contattoSelezionato = null;
                                });
                              }),
                        )
                      : Padding(
                          padding: EdgeInsets.symmetric(vertical: 12.h),
                          child: Row(
                            children: <Widget>[
                              Text(
                                "Note",
                                style: homePageMainTextStyle,
                              ),
                              Expanded(
                                child: Container(
                                  margin: const EdgeInsets.only(left: 20),
                                  child: Divider(
                                    color: Colors.grey[700],
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
                    padding: EdgeInsets.symmetric(vertical: 3.h),
                    child: GestureDetector(
                      onTap: () {
                        FocusScope.of(context).unfocus();
                        showPopUp();
                      },
                      child: Container(
                        height: 56.w,
                        width: 328.w,
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
                              Text("Aggiungi nota",
                                  style: homePageMainTextStyle),
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
      ),
    );
  }

  /*Widget showPopUp(context) {
    return Padding(
      padding: EdgeInsets.only(top: 35.0.h),
      child: Column(
        children: [
          Stack(
            children: [
              Align(
                alignment: Alignment.topRight,
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: CircleAvatar(
                    radius: 14.0,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.cancel_rounded, color: Colors.black),
                  ),
                ),
              ),
              AlertDialog(
                title: Text(
                  "Aggiungi nota",
                ),
                titlePadding:
                    EdgeInsets.only(top: 26.w, left: 16.w, bottom: 16.w),
                titleTextStyle: homePageMainTextStyle,
                content: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    /*Row(
                      mainAxisSize: MainAxisSize.max,
                      children: [
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
                    ),*/
                    ListTile(
                      title: Text(
                        "Argomenti/Problemi/Opportunità/Dubbi",
                        textAlign: TextAlign.left,
                        style: homePageMainTextStyle,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                       // popUpDialog();
                      },
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        "Criteri primari e secondari cliente",
                        textAlign: TextAlign.left,
                        style: homePageMainTextStyle,
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
                        textAlign: TextAlign.left,
                        style: homePageMainTextStyle,
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
                        style: homePageMainTextStyle,
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
                        style: homePageMainTextStyle,
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        showError("Prossime azioni/Assegnazione Task/Tempi", 1,
                            context);
                      },
                    ),
                    Divider(),
                    ListTile(
                      title: Text(
                        "Prossimi step",
                        textAlign: TextAlign.left,
                        style: homePageMainTextStyle,
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
                        style: homePageMainTextStyle,
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
        ],
      ),
    );
  }
*/
  Future<void> getContacts() async {
    final Iterable<Contact> contacts = await ContactsService.getContacts();
    setState(() {
      _contacts = contacts;
    });
  }

  void showReferente() {
    showDialog(
      barrierDismissible: false,
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
                                        style: TextStyle(
                                            color: rvTheme.canvasColor),
                                      ),
                                      backgroundColor: rvTheme.primaryColor,
                                    ),
                              title: Text(contact.displayName ?? ''),
                              //This can be further expanded to showing contacts detail
                              onTap: () {
                                contattoSelezionato = contact;
                                Navigator.pop(context);
                              });
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
    ).then((value) {
      setState(() {});
    });
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
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        bool saveContact = false;
        return StatefulBuilder(builder: (context, setState) {
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
                            Padding(
                              padding: EdgeInsets.only(
                                  top: ScreenUtil().setHeight(6),
                                  bottom: ScreenUtil().setHeight(6)),
                              child: Row(
                                children: [
                                  Checkbox(
                                    value: saveContact,
                                    activeColor: rvTheme.primaryColor,
                                    onChanged: (value) {
                                      setState(() {
                                        saveContact = value as bool;
                                      });
                                    },
                                  ),
                                  Flexible(
                                      child: Container(
                                    child: AutoSizeText(
                                      "Salvere il contatto nella rubrica",
                                      style: new TextStyle(
                                        color: Colors.black,
                                        fontSize: ScreenUtil().setSp(12),
                                      ),
                                      maxLines: 2,
                                    ),
                                  ))
                                ],
                              ),
                            ),
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
                              .currentState?.fields['nome']!.value ??
                          " ";
                      String cognome = formKeyAddReferente
                              .currentState?.fields['cognome']!.value ??
                          " ";
                      String ruolo = formKeyAddReferente
                              .currentState?.fields['ruolo']!.value ??
                          " ";
                      String email = formKeyAddReferente
                              .currentState?.fields['email']!.value ??
                          " ";
                      String telefono = formKeyAddReferente
                              .currentState?.fields['telefono']!.value ??
                          " ";

                      Contact contatto = Contact(
                          givenName: nome,
                          familyName: cognome,
                          displayName: nome + " " + cognome,
                          company: ruolo,
                          emails: [Item(label: "email", value: email)],
                          phones: [Item(label: "telefono", value: telefono)]);
                      if (saveContact)
                        await ContactsService.addContact(contatto);
                      contattoSelezionato = contatto;
                      Navigator.pop(context);
                    }
                  },
                ),
              ),
            ],
          );
        });
      },
    ).then((value) {
      setState(() {});
    });
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
                    child: Text(
                      mess,
                    ),
                  ),
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
            Form(
              key: formGlobalKey,
              child: TextFormField(
                keyboardType: TextInputType.multiline,
                minLines: 5,
                maxLines: 10,
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

  void showPopUp() {
    Alert(
      context: context,
      style: AlertStyle(
        titleTextAlign: TextAlign.left,
        alertAlignment: Alignment.center,
        titleStyle: homePageMainTextStyle,
        isButtonVisible: false,
        overlayColor: Color.fromRGBO(255, 255, 255, 100),
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),
      closeIcon: Icon(Icons.cancel_rounded, color: Colors.grey[700]),
      content: Column(
        mainAxisSize: MainAxisSize.max,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Aggiungi nota\n",
            style: homePageMainTextStyle,
          ),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              showPopUp2("Argomenti/Problemi/\nOpportunità/Dubbi");
            },
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    "Argomenti/Problemi/Opportunità/Dubbi",
                    style: homePageMainTextStyle,
                    maxLines: 2,
                  ),
                )
              ],
            ),
          ),
          Divider(),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);

              showPopUp2("Criteri primari e\nsecondari cliente");
            },
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    "Criteri primari e secondari cliente",
                    style: homePageMainTextStyle,
                    maxLines: 2,
                  ),
                )
              ],
            ),
          ),
          Divider(),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);

              showPopUp2("Punti di forza concorrenza");
            },
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    "Punti di forza concorrenza",
                    style: homePageMainTextStyle,
                    maxLines: 2,
                  ),
                )
              ],
            ),
          ),
          Divider(),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              showPopUp2("Punti deboli concorrenza");
            },
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    "Punti deboli concorrenza",
                    style: homePageMainTextStyle,
                    maxLines: 2,
                  ),
                )
              ],
            ),
          ),
          Divider(),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);
              showPopUp2("Prossime azioni/Assegnazione Task/Tempi");
            },
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    "Prossime azioni/Assegnazione Task/Tempi",
                    style: homePageMainTextStyle,
                    maxLines: 2,
                  ),
                )
              ],
            ),
          ),
          Divider(),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);

              showPopUp2("Prossimi step");
            },
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    "Prossimi step",
                    style: homePageMainTextStyle,
                    maxLines: 2,
                  ),
                )
              ],
            ),
          ),
          Divider(),
          GestureDetector(
            onTap: () {
              Navigator.pop(context);

              showPopUp2("Note amministrazione");
            },
            child: Row(
              children: [
                Flexible(
                  child: Text(
                    "Note amministrazione",
                    style: homePageMainTextStyle,
                    maxLines: 2,
                  ),
                )
              ],
            ),
          ),
        ],
      ),
    ).show();
  }

  void showPopUp2(String mess) {
    Alert(
      context: context,
      buttons: [
        DialogButton(
          onPressed: () {
            Navigator.pop(context);
            Navigator.pop(context);
          },
          child: Text(
            "ANNULLA",
            style: TextStyle(
                color: Colors.red,
                fontSize: 13.748113.sp,
                fontWeight: FontWeight.w700),
          ),
          color: Colors.transparent,
        ),
        DialogButton(
          color: Colors.transparent,
          child: Text(
            "OK",
            style: TextStyle(
                color: Colors.red,
                fontSize: 13.748113.sp,
                fontWeight: FontWeight.w700),
          ),
          onPressed: () async {
            if(noteKey.currentState!.validate()) {
              await addNote(mess, noteController.text);
              noteController.clear();
              Navigator.pop(context);
            }
          },
        ),
      ],
      closeIcon: Icon(
        Icons.cancel_rounded,
        color: Colors.grey[700],
      ),
      style: AlertStyle(
        alertAlignment: Alignment.center,
        buttonAreaPadding: EdgeInsets.only(left: 110.w),
        overlayColor: Color.fromRGBO(255, 255, 255, 100),
        alertBorder: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(
            color: Colors.transparent,
          ),
        ),
      ),

      content: FormBuilder(
        key: noteKey,
        child: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              mess,
              style: homePageMainTextStyle,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: 8),
              child: FormBuilderTextField(
                name: 'popUpForm',
                keyboardType: TextInputType.multiline,
                minLines: 5,
                maxLines: 10,
                controller: noteController,
                validator: FormBuilderValidators.required(context),
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
          ],
        ),
      ),
    ).show().then((value) {
      setState(() {

      });
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
    setState(() {

    });
    listaNote.add(Nota(titolo: titolo, testo: testo));
  }
}
