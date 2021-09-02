import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:report_visita_danilo/Models/Nota.dart';

class FormPopUp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => FormPopUpState();
}

class FormPopUpState extends State<FormPopUp> {
  List<Nota>? lista = [];
  final formGlobalKey = GlobalKey<FormState>();

  TextEditingController noteController = TextEditingController();

  @override
  Widget build(context) {
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
          key: Key("Argomenti/Problemi/Opportunità/Dubbi"),
          title: Text(
            "Argomenti/Problemi/Opportunità/Dubbi",
            textAlign: TextAlign.left,
          ),
          onTap: () {
            Navigator.pop(context);
            showError("Argomenti/Problemi/Opportunità/Dubbi", 1);
            //AggiungiNotaPopUp("Argomenti/Problemi/Opportunità/Dubbi");
          },
        ),
        Divider(),
        ListTile(
          title: Text(
            "Criteri primari e secondari cliente",
            textAlign: TextAlign.left,
          ),
          onTap: () {},
        ),
        Divider(),
        ListTile(
          title: Text(
            "Punti di forza concorrenza",
            textAlign: TextAlign.left,
          ),
          onTap: () {},
        ),
        Divider(),
        ListTile(
          title: Text(
            "Punti deboli concorrenza",
            textAlign: TextAlign.left,
          ),
          onTap: () {},
        ),
        Divider(),
        ListTile(
          title: Text(
            "Prossime azioni/Assegnazione Task/Tempi",
            textAlign: TextAlign.left,
          ),
          onTap: () {},
        ),
        Divider(),
        ListTile(
          title: Text(
            "Prossimi step",
            textAlign: TextAlign.left,
          ),
          onTap: () {},
        ),
        Divider(),
        ListTile(
          title: Text(
            "Note amministrazione",
            textAlign: TextAlign.left,
          ),
          onTap: () {},
        ),
        Divider(),
      ],
    );
  }

  void showError(String mess, int pop) {
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

  @override
  void initState() {
    super.initState();
  }

  Future<void> addNote(String titolo, String testo) async {
    lista!.add(Nota(titolo, testo));
  }
/*
  @override
  void dispose() {
    noteController.dispose();
    super.dispose();
  }*/
}
