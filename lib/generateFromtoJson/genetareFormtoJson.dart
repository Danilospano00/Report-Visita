import 'dart:convert';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:report_visita_danilo/Models/Azienda.dart';
import 'package:report_visita_danilo/Models/Nota.dart';
import 'package:report_visita_danilo/Utils/theme.dart';
import 'package:rflutter_alert/rflutter_alert.dart';

/*
esempio json
{
      "title": "name",
      "label": "what is your name",
      "type": "text",
      "required": "yes"
    }*/

class GeneratorFormToJson extends StatefulWidget {
  final String form;
  final ValueChanged<Map> onChanged;

  GeneratorFormToJson({required this.form, required this.onChanged});

  @override
  _GeneratorFromToJsonState createState() =>
      _GeneratorFromToJsonState(json.decode(form));
}

class _GeneratorFromToJsonState extends State<GeneratorFormToJson> {
  final dynamic formItems;
  final Map<String, dynamic> formResults = {};
  Map<String, dynamic> radioValueMap = {};
  Map<String, String> dropDownMap = {};
  Map<String, String> _datevalueMap = {};
  Map<String, bool> switchValueMap = {};
  late Iterable<Contact> _contacts = [];
  dynamic selectObject;
  final formKeyAddReferente = GlobalKey<FormBuilderState>();
  final formKeyBody = GlobalKey<FormBuilderState>();

  TextEditingController formFieldController = TextEditingController();
  List<TextEditingController> controller = [];
  Contact? contattoSelezionato;

  bool loadContact = false;
  List<Nota> listaNote = [];
  final noteKey = GlobalKey<FormBuilderState>();
  TextEditingController noteController = TextEditingController();

  _GeneratorFromToJsonState(this.formItems);

  @override
  void initState() {
    super.initState();
    getContacts();
  }

  Future<void> getContacts() async {
    final Iterable<Contact> contacts = await ContactsService.getContacts();
    setState(() {
      loadContact = true;
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
                loadContact
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
                                formResults[title] = contact;
                                _handleChanged();
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
                      contattoSelezionato = contact;

                      formResults[title] = contact;
                      _handleChanged();
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
              validator: (String? value) {
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
              return child!;
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
                  if (value == null || value.isEmpty) {
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
                value: switchValueMap["${item["title"]}"]!,
                onChanged: (bool value) {
                  updateSwitchValue(item["title"], value);
                  formResults[item["title"]] = value;
                  _handleChanged();
                }),
          ],
        ));
      }

      if (item['type'] == 'contact') {
        listWidget.add(Padding(
          padding: EdgeInsets.only(top: ScreenUtil().setHeight(8)),
          child: Column(
            children: [
              Row(
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
                                  backgroundImage:
                                      MemoryImage(contattoSelezionato!.avatar!),
                                )
                              : CircleAvatar(
                                  child: Text(
                                    contattoSelezionato!.initials(),
                                    style:
                                        TextStyle(color: rvTheme.canvasColor),
                                  ),
                                  backgroundColor: rvTheme.primaryColor,
                                ),
                          title: Text(contattoSelezionato!.displayName ?? ''),
                          //This can be further expanded to showing contacts detail
                          onTap: () {
                            setState(() {
                              contattoSelezionato = null;
                            });
                          }),
                    )
                  : Container(),
            ],
          ),
        ));
      }

      /*{
      "title": "Azienda",
"hint": "inserisci la tua azienda"
"type": "autocomplete",
"entity": "Azienda",
"field": "name",
"empty": false,
"validation": true
}*/
      if (item['type'] == 'autocomplete') {
        listWidget.add(Column(
          children: [
            TypeAheadField<dynamic>(
              onSuggestionSelected: (select) {
                formResults[item['title']] = select;
                _handleChanged();
                setState(() {
                  selectObject = select;
                });
              },
              hideSuggestionsOnKeyboardHide: false,
              suggestionsCallback: (String query) {
                // da impostare la chiamata al db in base all entity
                return List.of(listaAziende).where((aziende) {
                  final aziendaLower = aziende.nome.toString().toLowerCase();
                  final queryLower = query.toLowerCase();

                  return aziendaLower.contains(queryLower);
                }).toList();
              },
              itemBuilder: (context, dynamic suggestions) {
                final suggestion = suggestions!;
                return ListTile(
                  title: Text(suggestion.nome.toString()),
                );
              },
              textFieldConfiguration: TextFieldConfiguration(
                controller: formFieldController
                  ..text = selectObject != null
                      ? getValueField("nome")
                      : formFieldController.value.text,
                onChanged: (value) {
                  if(selectObject==null){
                  formResults[item['title'] + "Name"] =
                      formFieldController.value.text;
                  }else if(formResults.containsKey(item['title'] + "Name") ){
                    formResults.remove(item['title'] + "Name");
                  }
                },
                onSubmitted: (value) {
                  _handleChanged();
                },
                decoration: InputDecoration(
                  labelText: item['hint'],
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
                      controller.forEach((element) {
                        element.clear();
                      });
                      if(formResults.containsKey(item['title']) ){
                        formResults.remove(item['title']);
                      }
                      selectObject = null;
                    },
                  ),
                ),
              ),
            ),

            //list builder
            ListView.builder(
                addAutomaticKeepAlives: true,
                shrinkWrap: true,
                itemCount: item['field'].length,
                physics: NeverScrollableScrollPhysics(),
                itemBuilder: (context, i) {
                  controller.add(TextEditingController());
                  return Padding(
                    padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(4)),
                    child: FormBuilderTextField(
                      name: item['field'][i]['label'],
                      controller: controller[i]
                        ..text = selectObject != null
                            ? getValueField(item['field'][i]['label'])
                            : controller[i].value.text,
                      textInputAction: TextInputAction.done,
                      onChanged: (value) {

                        if(selectObject==null){
                        formResults[item['field'][i]['label']] =
                            controller[i].value.text;
                        }else{
                          setNewValueObject(item['field'][i]['label'],controller[i].value.text,item['title']);

                        }
                      },
                      onSubmitted: (value) {
                        _handleChanged();
                      },
                      validator: (String? value) {
                        if (item['field'][i]["required"]) {
                          return null;
                        }
                        if (value!.isEmpty) {
                          return 'Please ${item['title']} cannot be empty';
                        }
                        return null;
                      },
                      cursorColor: Colors.grey[700],
                      decoration: InputDecoration(
                        fillColor: Colors.grey.shade300,
                        filled: true,
                        border: InputBorder.none,
                        labelText: item['field'][i]['label'],
                        focusedBorder: formUnderlineInputBorder,
                        labelStyle: homePageMainTextStyle,
                      ),
                    ),
                  );
                })
          ],
        ));
      }

      if (item['type'] == "note") {
        listWidget.add(Column(
          children: [
            Padding(
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
                  padding: EdgeInsets.only(bottom: ScreenUtil().setHeight(16)),
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
                  showPopUp(item);
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
                        Text("Aggiungi nota", style: homePageMainTextStyle),
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
            )
          ],
        ));
      }
    }
    return listWidget;
  }

  Future<void> addNote(String titolo, String testo, String title) async {
    setState(() {});
    listaNote.add(Nota(titolo: titolo, testo: testo));
    formResults[title] = listaNote;
    _handleChanged();
  }

  void showPopUp(dynamic item) {
    Alert(
      context: context,
      style: AlertStyle(
        titleTextAlign: TextAlign.left,
        alertAlignment: Alignment.center,
        titleStyle: homePageMainTextStyle,
        isButtonVisible: false,
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
          Container(
            height: 200,
            width: 300,
            child: ListView.builder(
                //addAutomaticKeepAlives: true,
                shrinkWrap: true,
                itemCount: item['label'].length,
                physics: NeverScrollableScrollPhysics(),
                //scrollDirection: Axis.vertical,
                itemBuilder: (context, i) {
                  return Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          Navigator.pop(context);
                          showPopUp2(item['label'][i], item['title']);
                        },
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          children: [
                            Flexible(
                              child: Text(
                                item['label'][i],
                                style: homePageMainTextStyle,
                                maxLines: 2,
                              ),
                            )
                          ],
                        ),
                      ),
                      Padding(
                        padding:
                            EdgeInsets.only(top: ScreenUtil().setHeight(4)),
                        child: Divider(),
                      ),
                    ],
                  );
                }),
          )
        ],
      ),
    ).show();
  }

  void showPopUp2(String mess, String title) {
    Alert(
      context: context,
      buttons: [
        DialogButton(
          onPressed: () {
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
            if (noteKey.currentState!.validate()) {
              await addNote(mess, noteController.text, title);
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
      setState(() {});
    });
  }

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

  List<Azienda> getSuggestion(String query) =>
      List.of(listaAziende).where((aziende) {
        final aziendaLower = aziende.nome.toString().toLowerCase();
        final queryLower = query.toLowerCase();

        return aziendaLower.contains(queryLower);
      }).toList();

  dynamic getValueField(String field) {
    Map<String, dynamic> objectMap = selectObject.toMap();

    return objectMap[field];
  }

  void setNewValueObject(String field,String value,String title) {

    Map<String, dynamic> objectMap = selectObject.toMap();
    objectMap[field]=value;
    selectObject= selectObject.fromMap(objectMap);
    formResults[title] = selectObject;



  }
}
