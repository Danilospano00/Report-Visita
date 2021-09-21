import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:report_visita_danilo/Models/Azienda.dart';
import 'package:report_visita_danilo/Utils/theme.dart';





/*
esempio json
{
      "title": "name",
      "label": "what is your name",
      "type": "text",
      "required": "yes"
    }*/

class GeneratorFromToJson extends StatefulWidget {

  final String form;
  final ValueChanged<Map> onChanged;


  GeneratorFromToJson(
      {required this.form,required this.onChanged});

  @override
  _GeneratorFromToJsonState createState() =>
      _GeneratorFromToJsonState(json.decode(form));
}

class _GeneratorFromToJsonState extends State<GeneratorFromToJson> {
  final dynamic formItems;
  final Map<String, dynamic> formResults = {};
  Map<String, dynamic> radioValueMap = {};
  Map<String, String> dropDownMap = {};
  Map<String, String> _datevalueMap = {};
  Map<String, bool> switchValueMap = {};
  late Iterable<Contact> _contacts;
  Azienda? aziendaSelezionata;
  final formKeyAddReferente = GlobalKey<FormBuilderState>();
  final formKeyBody = GlobalKey<FormBuilderState>();
  TextEditingController formFieldController = TextEditingController();
  TextEditingController formFieldControllerIndirizzo = TextEditingController();
  TextEditingController formFieldControllerCap = TextEditingController();
  TextEditingController formFieldControllerCitta = TextEditingController();
  TextEditingController formFieldControllerIva = TextEditingController();
  TextEditingController formFieldControllerCodicefiscale =
  TextEditingController();


  _GeneratorFromToJsonState(this.formItems);


  @override
  void initState() {
    super.initState();
    getContacts();
  }


  Future<void> getContacts() async {
    final Iterable<Contact> contacts = await ContactsService.getContacts();
    setState(() {
      _contacts = contacts;
    });
  }

  void _handleChanged() {
    widget.onChanged(formResults);
  }

  void updateSwitchValue(dynamic item, bool value) {
    setState(() {
      switchValueMap[item] = value;
    });
  }


  void showReferente(String title) {
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
                      formResults[title] = contact;
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

  void showSolutionReferente(String title) {
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
                  showReferente(title);
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
                  showAddReferente(title);
                },
              ),
            ),
          ],
        );
      },
    );
  }

  void showAddReferente(String title) {
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

                      Contact contact = Contact(
                          givenName: nome,
                          familyName: cognome,
                          displayName: nome + " " + cognome,
                          company: ruolo,
                          emails: [Item(label: "email", value: email)],
                          phones: [Item(label: "telefono", value: telefono)]);
                      if (saveContact)
                        await ContactsService.addContact(contact);
                      formResults[title] = contact;

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

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: ScreenUtil().setHeight(30),
        bottom: ScreenUtil().setHeight(30),
        left: ScreenUtil().setWidth(16),
        right: ScreenUtil().setWidth(16)
      ),
      child: new Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: jsonToForm(),
      ),
    );
  }



  List<Widget> jsonToForm() {
    List<Widget> listWidget = [];

    for (var item in formItems) {

      if (item['type'] == 'text' ||
          item['type'] == 'integer' ||
          item['type'] == "password" ||
          item['type'] == "multiline") {
        listWidget.add(
          Container(
            margin: EdgeInsets.symmetric(vertical: 10.0),
            child: TextFormField(
              //initialValue: _initValue != null ? _initValue[item["title"]] : null,
              autofocus: false,
              onChanged: (String value) {
                formResults[item["title"]] = value;
                _handleChanged();
              },
              keyboardType:
              item['type'] == 'integer' ? TextInputType.number : null,
              validator: ( String? value) {
                if (item['required'] == 'no') {
                  return null;
                }
                if (value!.isEmpty) {
                  return 'Please ${item['title']} cannot be empty';
                }
                return null;
              },
              maxLines: item['type'] == "multiline" ? 10 : 1,
              obscureText: item['type'] == "password" ? true : false,
              decoration: InputDecoration(
                contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                labelText: item['label'],
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(5.0)),
              ),
            ),
          ),
        );
      }


      if (item['type'] == 'select') {
        var newlist = List<String>.from(item['items']);

        listWidget.add(Container(
          margin: EdgeInsets.symmetric(vertical: 10.0),
          child: DropdownButtonFormField<String>(
            decoration: InputDecoration(
              contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
              border:
              OutlineInputBorder(borderRadius: BorderRadius.circular(5.0)),
            ),
            hint: Text('Select ${item['title']}'),
            validator: (String? value) {
              if (item['required'] == 'no') {
                return null;
              }
              if (value == null) {
                return 'Please ${item['title']} cannot be empty';
              }
              return null;
            },
            value: dropDownMap[item["title"]],
            isExpanded: true,
           // style: Theme.of(context).textTheme.subhead,
            onChanged: (String? newValue) {
              setState(() {
                dropDownMap[item["title"]] = newValue!;
                formResults[item["title"]] = newValue.trim();
              });
              _handleChanged();
            },
            items: newlist.map<DropdownMenuItem<String>>((String value) {
              return DropdownMenuItem<String>(
                value: value,
                child: Text(value),
              );
            }).toList(),
          ),
        ));
      }

      if (item['type'] == 'date') {
        Future _selectDate() async {
           DateTime? picked = await showDatePicker(
            context: context,
            initialDate: DateTime.now(),
            firstDate: DateTime(1880),
            lastDate: DateTime(2021),
            builder: (BuildContext context, Widget? child) {

              return  child!;

            },
          );
          if (picked != null) {
            setState(() => _datevalueMap[item["title"]] =
                picked.toString().substring(0, 10));
          }
        }

        listWidget.add(
          Container(
              margin: EdgeInsets.symmetric(vertical: 10.0),
              child: TextFormField(
                //initialValue: _initValue != null ? _initValue[item["title"]] : null,
                autofocus: false,
                readOnly: true,
                controller:
                TextEditingController(text: _datevalueMap[item["title"]]),
                validator: (String? value) {

                  if (value ==null || value.isEmpty) {
                    return 'Please  cannot be empty';
                  }
                  return null;
                },
                onChanged: (String value) {
                  _handleChanged();
                },
                onTap: () async {
                  await _selectDate();
                  formResults[item["title"]] = _datevalueMap[item["title"]];
                  _handleChanged();
                },
                decoration: InputDecoration(
                  contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  labelText: item["label"],
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  suffixIcon: Icon(
                    Icons.calendar_today,
                  ),
                ),
              )),
        );
      }

      if (item['type'] == 'radio') {
        radioValueMap["${item["title"]}"] =
        radioValueMap["${item["title"]}"] == null
            ? 'lost'
            : radioValueMap["${item["title"]}"];

        listWidget.add(new Container(
            margin: new EdgeInsets.only(top: 5.0, bottom: 5.0),
            child: new Text(item['label'],
                style: new TextStyle(
                    fontWeight: FontWeight.bold, fontSize: 16.0))));

        for (var i = 0; i < item['items'].length; i++) {
          listWidget.add(
            new Row(
              children: <Widget>[
                new Expanded(child: new Text(item['items'][i])),
                new Radio<dynamic>(
                    hoverColor: Colors.red,
                    value: item['items'][i],
                    groupValue: radioValueMap["${item["title"]}"],
                    onChanged: (dynamic value) {
                      setState(() {
                        radioValueMap["${item["title"]}"] = value;
                      });
                      formResults[item["title"]] = value;

                      _handleChanged();
                    })
              ],
            ),
          );
        }
      }


      if (item['type'] == 'switch') {
        if (switchValueMap["${item["title"]}"] == null) {
          setState(() {
            switchValueMap["${item["title"]}"] = false;
          });
        }
        listWidget.add(Row(
          children: <Widget>[
            new Expanded(child: new Text(item["label"])),
            Switch(
                value: switchValueMap!["${item["title"]}"]!,
                onChanged: (bool value) {
                  updateSwitchValue(item["title"], value);
                  formResults[item["title"]] = value;
                  _handleChanged();
                }),
          ],
        ));
      }

      if (item['type'] == 'contact') {
        listWidget.add(
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
                  showSolutionReferente(item["title"]);
                },
              ),
            ],
          ),
        ));
      }

      /*if(item['type']=='company'){

        listWidget.add(
          Column(
            children: [
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
              )
            ],
          )

        );
      }*/










    }
    return listWidget;
  }









}