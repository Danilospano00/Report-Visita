import 'package:flutter/material.dart';

class AddNoteFormPopUp extends StatefulWidget{
  @override
  State<StatefulWidget> createState() => AddNoteFormPopUpState();


}

class AddNoteFormPopUpState extends State<AddNoteFormPopUp>{
  @override
  Widget build(BuildContext context) {
 return Column();
  }

    void showError(String mess, int pop) {
      showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: Text("ATTENZIONE"),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(12))),
            content: Text(mess),
            actions: [
              FlatButton(
                child: Text("OK"),
                onPressed: () {
                  if (pop == 1)
                    Navigator.pop(context);
                  else {
                    Navigator.pop(context);
                    Navigator.pop(context);
                  }
                },
              ),
            ],
          );
        },
      );
    }
  }

