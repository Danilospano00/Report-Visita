import 'package:flutter/material.dart';
import 'package:report_visita_danilo/AccountEmpty.dart';
import 'package:report_visita_danilo/costanti.dart';

import 'Models/Nota.dart';

class MyHomePage extends StatefulWidget {
  MyHomePage({Key? key}) : super(key: key);

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  final formGlobalKey = GlobalKey<FormState>();

  TextEditingController noteController = TextEditingController();
  TextEditingController formFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
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
                          style:
                              TextStyle(fontSize: 28, color: Colors.grey[700])),
                    ],
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(6.0),
                  child: TextFormField(
                    controller: formFieldController,
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
                        },
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(6.0),
                  child: TextFormField(
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
                  child: TextFormField(
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
                  child: TextFormField(
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
                  child: TextFormField(
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
                  child: TextFormField(
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
                Padding(
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
                ),
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
                        onPressed: () {},
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
                    return Column(
                      children: [
                        Container(
                          height: 55,
                          width: double.infinity,
                          color: Colors.grey.shade300,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 20, left: 12),
                            child: Text(
                              listaNote[i].titolo.toString(),
                              style: TextStyle(
                                  color: Colors.grey[700], fontSize: 15),
                            ),
                          ),
                        ),
                        Container(
                          width: double.infinity,
                          child: Padding(
                            padding: const EdgeInsets.symmetric(
                              horizontal: 24.0,
                              vertical: 12,
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
                  padding: EdgeInsets.only(right: 6.0, left: 6, bottom: 6),
                  child: GestureDetector(
                    onTap: () {
                      showDialog(
                          context: context,
                          builder: (BuildContext context) => showPopUp());
                    },
                    child: Container(
                      height: 58,
                      width: double.infinity,
                      color: Colors.grey.shade300,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 12.0, right: 12,),
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
      bottomNavigationBar: BottomAppBar(
        shape: CircularNotchedRectangle(),
        color: Colors.red,
        child: IconTheme(
          data: IconThemeData(),
          child: Row(
            children: <Widget>[
              IconButton(
                onPressed: () {
                  Navigator.push(context, MaterialPageRoute(builder: (context) => AccountEmpty()));
                },
                icon: Icon(Icons.perm_identity_outlined),
                color: Colors.white,
              ),
              Spacer(),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.move_to_inbox_rounded),
                color: Colors.white,
              ),
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.event_rounded),
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.archive_rounded),
        onPressed: () {},
        backgroundColor: Colors.grey.shade700,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  Widget showPopUp() {
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
            showError("Argomenti/Problemi/Opportunità/Dubbi", 1);
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
            showError("Criteri primari e secondari cliente", 1);
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
            showError("Punti di forza concorrenza", 1);
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
            showError("Punti deboli concorrenza", 1);
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
            showError("Prossime azioni/Assegnazione Task/Tempi", 1);
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
            showError("Prossimi step", 1);
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
            showError("Note amministrazione", 1);
          },
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

  @override
  void initState() {
    super.initState();
  }

  Future<void> addNote(String titolo, String testo) async {
    listaNote.add(Nota(titolo, testo));
  }
}
