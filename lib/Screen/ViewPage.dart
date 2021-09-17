import 'package:flutter/material.dart';
import 'package:report_visita_danilo/Models/Report.dart';
import 'package:report_visita_danilo/Screen/CalendarPage.dart';
import 'package:report_visita_danilo/Screen/HomePage.dart';
import 'package:report_visita_danilo/Screen/whitePage.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'AccountEmpty.dart';
import 'Preferences.dart';

class ViewPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => ViewPageState();
}

class ViewPageState extends State<ViewPage> {
  //istanza di MyHomePage per usare il metodo addReport()
  MyHomePageState myHomePage = new MyHomePageState();

  final PageController controller = PageController(initialPage: 0);
  List<Widget> screens = [
    MyHomePage(),
    //Preferences(),
    CalendarPage(),
  ];
  int _selectedIndex = 0;
  final PageStorageBucket bucket = PageStorageBucket();

  late Report _report;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: PageView(
        physics: NeverScrollableScrollPhysics(),
        controller: controller,
        children: screens,
      ),
      bottomNavigationBar: BottomAppBar(

        elevation: 10,
        shape: CircularNotchedRectangle(),
        color: Colors.red,
        child: IconTheme(
          data: IconThemeData(),
          child: Row(
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.perm_identity_outlined),
                color: Colors.white,
                onPressed: () {
                  Navigator.push(context,
                      MaterialPageRoute(builder: (context) => AccountEmpty()));
                },
              ),
              Spacer(),
              IconButton(
                icon: Icon(Icons.move_to_inbox_rounded),
                color: Colors.white,
                onPressed: () {
                  setState(() {
                    if (_selectedIndex != 1) {
                      _selectedIndex = 1;
                      controller.jumpToPage(_selectedIndex);
                    }
                  });
                },
              ),
              IconButton(
                icon: Icon(Icons.event_rounded),
                color: Colors.white,
                onPressed: () {
                  _selectedIndex = 2;
                  controller.jumpToPage(_selectedIndex);
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.archive_rounded),
        backgroundColor: Colors.grey.shade700,
        onPressed: () {
          if (_selectedIndex == 0) {
            myHomePage.addReport();
          } else {
            _selectedIndex = 0;
            controller.jumpToPage(_selectedIndex);
          }
        },
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }


}