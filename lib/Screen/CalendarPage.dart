import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../Models/Eventi.dart';
import 'AccountEmpty.dart';

class CalendarPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CalendarPageState();
}

class CalendarPageState extends State<CalendarPage> {
  List<Eventi> listaEventi = [];

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(360, 760),
      builder: () => Scaffold(
        floatingActionButton: Padding(
          padding: EdgeInsets.only(right: 17.w, top: 39.w),
          child: FloatingActionButton(
            child: const Icon(
              Icons.filter_list_outlined,
            ),
            backgroundColor: Colors.red,
            onPressed: () {
              setState(() {
                listaEventi.add(
                    new Eventi("10:30", "Nome Azienda", "Indirizzo", "Citta"));
              });
            },
          ),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        body: ListView.builder(
          itemCount: listaEventi.length,
          padding: EdgeInsets.only(top: 73.0.w, left: 16.w, right: 16.w),
          itemBuilder: (context, index) {
            return Column(
              children: [
                Stack(
                  children: [
                    SizedBox(
                      height: 104.w,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Row(
                            children: [
                              Text(
                                listaEventi[index].orario,
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                    fontSize: 12.075892.sp,
                                    fontWeight: FontWeight.w400,
                                    letterSpacing: 2.w),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Padding(
                                padding: EdgeInsets.symmetric(vertical: 7.0.w),
                                child: Text(
                                  listaEventi[index].nomeAzienda,
                                  textAlign: TextAlign.left,
                                  style: TextStyle(
                                    fontSize: 20.126488.sp,
                                    fontWeight: FontWeight.w400,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              Text(
                                "${listaEventi[index].indirizzo} - ${listaEventi[index].citta}",
                                textAlign: TextAlign.left,
                                style: TextStyle(
                                  fontSize: 12.075892.sp,
                                  fontWeight: FontWeight.w400,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Container(
                      height: 104.w,
                      child: Align(
                        alignment: Alignment.bottomRight,
                        child: ElevatedButton(
                          child: Text(
                            "map",
                            style: TextStyle(
                                fontSize: 10.sp, fontWeight: FontWeight.bold),
                          ),
                          onPressed: () {},
                          style: ElevatedButton.styleFrom(
                            minimumSize: Size(18.w, 25.w),
                            primary: Colors.red,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(32.0),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
                Divider(
                  height: 2,
                  thickness: 2,
                ),
              ],
            );
          },
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
                  onPressed: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> CalendarPage()));
                  },
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
      ),
    );
  }
}
