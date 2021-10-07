import 'dart:convert';
import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:image_picker/image_picker.dart';
import 'package:report_visita_danilo/Models/Azienda.dart';
import 'package:report_visita_danilo/Models/Nota.dart';
import 'package:report_visita_danilo/Utils/theme.dart';
import '../objectbox.g.dart';
import 'package:path/path.dart' as p;


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
  final Store store;

  GeneratorFormToJson(
      {required this.form, required this.onChanged, required this.store});

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
  List<TextEditingController> controllerNote = [];
  List<TextEditingController> controllerNoteDesc = [];
  List<FocusNode> focusList = [];

  List<Contact> contattoSelezionato = [];

  bool loadContact = false;
  List<Nota> listaNote = [];
  final noteKey = GlobalKey<FormBuilderState>();
  TextEditingController noteController = TextEditingController();
  File? fileSelected;

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
            "Seleziona Referente",
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
                                contattoSelezionato.add(contact);
                                formResults[title]  = contattoSelezionato;
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
            "Aggiungi o Seleziona un Referente",
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
              "Aggiungi Referente",
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
                                      "Salvare il contatto nella rubrica",
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
                      contattoSelezionato.add(contact);

                      formResults[title] = contattoSelezionato;
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
            firstDate: DateTime(2020),
            lastDate: DateTime(2050),
            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  primaryColor: Colors.red,
                  accentColor: const Color(0xFF8CE7F1),
                  colorScheme: ColorScheme.light(primary: Colors.red),
                  buttonTheme:
                      ButtonThemeData(textTheme: ButtonTextTheme.primary),
                ),
                child: child!,
              );
            },
          );
          if (picked != null) {
            setState(() => _datevalueMap[item["title"]] =
                picked.toString().substring(0, 10));
          }
        }

        Future selectTime() async {
          final TimeOfDay? picked = await showTimePicker(
            context: context,
            builder: (BuildContext context, Widget? child) {
              return Theme(
                data: ThemeData.light().copyWith(
                  primaryColor: Colors.red,
                  accentColor: const Color(0xFF8CE7F1),
                  colorScheme: ColorScheme.light(primary: Colors.red),
                  buttonTheme:
                      ButtonThemeData(textTheme: ButtonTextTheme.primary),
                ),
                child: child!,
              );
            },
            initialTime: TimeOfDay.now(),
          );
          if (picked != null)
            setState(() {
              TimeOfDay selectedTime = picked;
              String dateS = _datevalueMap[item["title"]]!;
              DateTime date = DateTime.parse(dateS);

              _datevalueMap[item["title"]] = DateTime(date.year, date.month,
                      date.day, selectedTime.hour, selectedTime.minute)
                  .toString()
                  .substring(0, 16);
            });
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
                  await selectTime();
                  formResults[item["title"]] = _datevalueMap[item["title"]];
                  _handleChanged();
                },
                decoration: InputDecoration(
                  //label: Text(item["label"]),

                  contentPadding: EdgeInsets.fromLTRB(10, 0, 10, 0),
                  labelText: item["label"],
                  focusedBorder: OutlineInputBorder(
                      borderSide:
                          const BorderSide(color: Colors.red, width: 2.0),
                      borderRadius: BorderRadius.circular(5)),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(5.0)),
                  suffixIcon: Icon(
                    Icons.calendar_today,
                    color: Colors.red,
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

      if (item['type'] == 'file') {
        listWidget.add(Padding(
            padding: EdgeInsets.only(top: ScreenUtil().setHeight(8)),
            child: Column(children: [
              Row(
                children: <Widget>[
                  Text(
                    "Allegati",
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
              Row(
                children: [
                  Padding(
                    padding: EdgeInsets.only(top: 4.h, bottom: 4.h, left: 4.w),
                    child: Container(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                        splashRadius: 1,
                        icon: Icon(Icons.add_circle_outlined),
                        iconSize: 40,
                        color: Colors.red,
                        onPressed: () {
                          FocusScope.of(context).unfocus();
                          showSolutionFile(item["title"]);
                        },
                      ),
                    ),
                  ),
                  fileSelected!=null?GestureDetector(
                    onLongPress: () {
                      setState(() {

                        fileSelected=null;
                        formResults[item["title"]]  = fileSelected;
                        _handleChanged();
                      });
                    },
                    child:Container(
                      width: MediaQuery.of(context).size.width*.60,
                      child: AutoSizeText(
                        p.basename(fileSelected!.path),
                        style: homePageMainTextStyle,
                        overflow:TextOverflow.ellipsis ,
                      ),
                    ),
                  ):Container()
                ],
              )
            ])));
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
              SingleChildScrollView(
                scrollDirection: Axis.horizontal,
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Padding(
                      padding:
                          EdgeInsets.only(top: 4.h, bottom: 4.h),
                      child: Container(
                        alignment: Alignment.centerLeft,
                        child: IconButton(
                          splashRadius: 1,
                          icon: Icon(Icons.add_circle_outlined),
                          iconSize: 40,
                          color: Colors.red,
                          onPressed: () {
                            FocusScope.of(context).unfocus();
                            showSolutionReferente(item["title"]);
                          },
                        ),
                      ),
                    ),
                    Container(
                      height: 50,
                      width: 273.w,
                      child: ListView.builder(
                          shrinkWrap: true,
                          itemCount: contattoSelezionato.length,
                          scrollDirection: Axis.horizontal,
                          // physics: NeverScrollableScrollPhysics(),
                          itemBuilder: (context, i) {
                            return (contattoSelezionato[i].avatar != null &&
                                    contattoSelezionato[i].avatar!.isNotEmpty)
                                ? Padding(
                                    padding: EdgeInsets.all(4.0.h),
                                    child: GestureDetector(
                                      onLongPress: () {
                                        setState(() {
                                          contattoSelezionato.removeAt(i);
                                          formResults[item["title"]]  = contattoSelezionato;
                                          _handleChanged();
                                        });
                                      },
                                      child: CircleAvatar(
                                        backgroundImage: MemoryImage(
                                            contattoSelezionato[i].avatar!),
                                      ),
                                    ),
                                  )
                                : Padding(
                                    padding: EdgeInsets.all(4.0.h),
                                    child: GestureDetector(
                                      onLongPress: () {
                                        setState(() {
                                          contattoSelezionato.removeAt(i);
                                          formResults[item["title"]]  = contattoSelezionato;
                                          _handleChanged();
                                        });
                                      },
                                      child: CircleAvatar(
                                        child: Text(
                                          contattoSelezionato[i].initials(),
                                          style: TextStyle(
                                              color: rvTheme.canvasColor),
                                        ),
                                        backgroundColor: rvTheme.primaryColor,
                                      ),
                                    ),
                                  );
                          }),
                    ),
                  ],
                ),
              ),
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
            Padding(
              padding: EdgeInsets.only(bottom: 8.h),
              child: TypeAheadField<dynamic>(
                onSuggestionSelected: (select) {
                  formResults[item['title']] = select;
                  _handleChanged();
                  setState(() {
                    selectObject = select;
                  });
                },
                hideSuggestionsOnKeyboardHide: false,
                suggestionsCallback: (String query) {
                  dynamic lista = widget.store.box<Azienda>().getAll();
                  // da impostare la chiamata al db in base all entity

                  return List.of(lista).where((aziende) {
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
                    if (selectObject == null) {
                      formResults[item['title'] + "Name"] =
                          formFieldController.value.text;
                    } else if (formResults
                        .containsKey(item['title'] + "Name")) {
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
                        if (formResults.containsKey(item['title'])) {
                          formResults.remove(item['title']);
                        }
                        selectObject = null;
                      },
                    ),
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
                      textInputAction: TextInputAction.next,
                      onChanged: (value) {
                        if (selectObject == null) {
                          formResults[item['field'][i]['label']] =
                              controller[i].value.text;
                        } else {
                          setNewValueObject(item['field'][i]['label'],
                              controller[i].value.text, item['title']);
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
        if (listaNote.isEmpty || listaNote == null) {
          for (var i = 0; i < item['label'].length; i++) {
            listaNote.add(Nota(titolo: item['label'][i], testo: ""));
            controllerNote.add(TextEditingController());
            controllerNoteDesc.add(TextEditingController());
          }
        }
        listWidget.add(Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top: 8.h, bottom: 12.h),
              child: Row(
                children: <Widget>[
                  Text(
                    "Informazioni",
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
                      Padding(
                        padding:
                            EdgeInsets.only(bottom: ScreenUtil().setHeight(4)),
                        child: FormBuilderTextField(
                          name: listaNote[i].titolo!,
                          controller: controllerNote[i]
                            ..text = listaNote[i].titolo!,
                          minLines: 2,
                          maxLines: 6,
                          textInputAction: TextInputAction.done,
                          onChanged: (value) {
                            listaNote[i].titolo = controllerNote[i].value.text;
                          },
                          onSubmitted: (value) {
                            formResults[item['title']] = listaNote;
                            _handleChanged();
                          },
                          validator: (String? value) {
                            if (value!.isEmpty) {
                              return 'Please ${item['title']} cannot be empty';
                            }
                            return null;
                          },
                          cursorColor: Colors.grey[700],
                          decoration: InputDecoration(
                            suffix: IconButton(
                                onPressed: () {
                                  setState(() {
                                    listaNote.removeAt(i);
                                    formResults[item['title']] = listaNote;
                                    _handleChanged();
                                  });
                                },
                                icon: Icon(Icons.cancel_rounded,
                                    color: Colors.black)),
                            fillColor: Colors.grey.shade300,
                            filled: true,
                            border: InputBorder.none,
                            //labelText: listaNote[i].titolo==""?"Titolo":listaNote[i].titolo,
                            focusedBorder: formUnderlineInputBorder,
                            labelStyle: homePageMainTextStyle,
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(vertical: 8),
                        child: FormBuilderTextField(
                          name: listaNote[i].titolo! + "desc",
                          //keyboardType: TextInputType.multiline,
                          minLines: 2,
                          maxLines: 5,
                          maxLength: 1000,
                          textInputAction: TextInputAction.done,

                          controller: controllerNoteDesc[i]
                            ..text = listaNote[i].testo!,
                          validator: FormBuilderValidators.required(context),
                          decoration: InputDecoration(
                            alignLabelWithHint: true,
                            labelStyle:
                                TextStyle(decorationColor: Colors.grey[800]),
                            floatingLabelBehavior: FloatingLabelBehavior.never,
                            filled: true,
                            fillColor: Colors.grey.shade300,
                            labelText: "Inserisci testo...",
                            border: InputBorder.none,
                            disabledBorder: InputBorder.none,
                          ),
                          onSubmitted: (value) {
                            formResults[item['title']] = listaNote;
                            _handleChanged();
                          },
                          onChanged: (value) {
                            listaNote[i].testo =
                                controllerNoteDesc[i].value.text;
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
            Padding(
              padding: EdgeInsets.only(top: 4.h, bottom: 8.h),
              child: GestureDetector(
                onTap: () async {
                  FocusScope.of(context).unfocus();
                  controllerNote.add(TextEditingController());
                  controllerNoteDesc.add(TextEditingController());

                  await addNote("Titolo");
                  //noteController.clear();
                },
                child: Container(
                  height: 56.w,
                  width: 328.w,
                  color: Colors.red,
                  child: Padding(
                    padding: const EdgeInsets.only(
                      left: 12.0,
                      right: 12,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text("Aggiungi Campo",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 20.sp,
                              fontWeight: FontWeight.w700,
                              letterSpacing: 0.15,
                            )),
                        Spacer(),
                        Icon(
                          Icons.unfold_more_outlined,
                          color: Colors.white,
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

  Future<void> addNote(String titolo) async {
    listaNote.add(Nota(titolo: titolo, testo: ""));
    setState(() {});
  }

  dynamic getValueField(String field) {
    Map<String, dynamic> objectMap = selectObject.toMap();

    return objectMap[field] ?? "";
  }

  void setNewValueObject(String field, String value, String title) {
    Map<String, dynamic> objectMap = selectObject.toMap();
    objectMap[field] = value;
    selectObject = selectObject.fromMap(objectMap);
    formResults[title] = selectObject;
  }

  void showSolutionFile( String title) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(15))),
          title: Text(
            "Aggiungi File",
            textAlign: TextAlign.center,
          ),
          content: Container(
              width: MediaQuery.of(context).size.width * .60,
              height: MediaQuery.of(context).size.height * .20,
              child: Center(
                  child: AutoSizeText(
                      "Puoi selezionare un File presente sull'archivio o scattare una foto."))),
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
                onPressed: () async {

                  FilePickerResult? result = await FilePicker.platform.pickFiles(
                      type: FileType.custom,
                      allowedExtensions: ['jpg', 'pdf', 'doc','png']
                  );

                  if (result != null) {
                    File file = File(result.files.single.path!);
                    setState(() {
                      fileSelected=file;
                    });
                    formResults[title]  = file;
                    _handleChanged();
                    Navigator.pop(context);
                  } else {
                    // User canceled the picker
                  }


                 // Navigator.pop(context);

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
                  "Scatta",
                  style: TextStyle(color: rvTheme.canvasColor),
                ),
                onPressed: () async {
                  final ImagePicker _picker = ImagePicker();

                  final XFile? photo = await _picker.pickImage(source: ImageSource.camera);

                  if(photo!=null) {
                    File file = File(photo.path);
                    setState(() {
                      fileSelected=file;
                    });
                    formResults[title] = file;
                    _handleChanged();
                    Navigator.pop(context);
                  }else{

                  }

                },
              ),
            ),
          ],
        );
      },
    );



  }
}
