import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:report_visita_danilo/Models/Azienda.dart';
import 'package:report_visita_danilo/Models/Event.dart';
import 'package:report_visita_danilo/Models/Referente.dart';
import 'package:report_visita_danilo/Utils/FormatDate.dart';
import 'package:report_visita_danilo/Utils/MyDrawer.dart';
import 'package:report_visita_danilo/Utils/theme.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../costanti.dart';
import '../objectbox.g.dart';
import 'AggiungiEvento.dart';

class CalendarPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => CalendarPageState();
}

class CalendarPageState extends State<CalendarPage> {
  DateTime currentDate = DateTime.now();

  late Stream<List<Event>> stream;

  List<Event> listaEventi = [];
  int contagiorni = 0;
  late SharedPreferences prefs;

  GlobalKey<ScaffoldState> _keyDrawer = GlobalKey<ScaffoldState>();
  final _addEvent = GlobalKey<FormBuilderState>();

  bool loading = true;

  bool dataGiaStampata = false;

  late Store _store;

  @override
  initState() {
    super.initState();

    SharedPreferences.getInstance().then((value) {
      prefs = value;
      setState(() {
        loading = false;

        stream = mainStore!
            .box<Event>()
            .query()
            .watch(triggerImmediately: true)
            .map((query) => query.find());
      });
    });

    /*  Query<Event> query = mainStore!
        .box<Event>()
        .query(Event_.date.between(DateTime.now().millisecond,
            DateTime.now().add(Duration(days: 365)).millisecond))
        .build();
    listaEventi = query.find();*/

    listaEventi = mainStore!.box<Event>().getAll();

    listaEventi.sort((a, b) {
      return a.date!.compareTo(b.date!);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _keyDrawer,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          print("aperto");
          _keyDrawer.currentState!.openEndDrawer();
        },
        child: Icon(
          Icons.filter_list_outlined,
          size: 36,
        ),
        backgroundColor: Colors.red,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
      endDrawer: MyDrawer(),
      body: loading
          ? CircularProgressIndicator()
          : StreamBuilder<List<Event>>(
          stream: stream,
          builder:
              (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
                if(snapshot.hasData){
                listaEventi = snapshot.data;
                }
                else{
                  listaEventi = [];
                }
            return Stack(
              children: [
                SafeArea(
                  child: SingleChildScrollView(
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16.w),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          ListView.builder(
                            shrinkWrap: true,
                            physics: const NeverScrollableScrollPhysics(),
                            itemCount: listaEventi.length,
                            itemBuilder: (context, index) {
                              return Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  ritornaDataEvento(index),
                                  Column(
                                    crossAxisAlignment:
                                    CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        children: [
                                          Text(
                                            FormatDate.fromDateTimeToString(
                                                listaEventi[index].date!,
                                                "orario"),
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                                fontSize: 12.075892.sp,
                                                fontWeight: FontWeight.w400,
                                                letterSpacing: 2.w),
                                          ),
                                          Padding(
                                            padding:
                                            EdgeInsets.only(left: 8.0),
                                            child:
                                            calcolaLivelloAllerta(index),
                                          ),
                                        ],
                                      ),
                                      Padding(
                                        padding: EdgeInsets.only(top: 8.h),
                                        child: Text(
                                          listaEventi[index]
                                              .azienda
                                              .target!
                                              .nome
                                              .toString(),
                                          textAlign: TextAlign.left,
                                          style: TextStyle(
                                            fontSize: 20.126488.sp,
                                            fontWeight: FontWeight.w400,
                                            letterSpacing: 0.25,
                                            color: Colors.grey[700],
                                          ),
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "${listaEventi[index].azienda
                                                .target!.indirizzo.toString()}",
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize: 12.075892.sp,
                                              fontWeight: FontWeight.w400,
                                              letterSpacing: 0.4,
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                          ElevatedButton(
                                            child: Text(
                                              "map",
                                              style: TextStyle(
                                                  fontSize: 10.sp,
                                                  fontWeight:
                                                  FontWeight.bold),
                                            ),
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                              minimumSize: Size(18.w, 25.h),
                                              primary: Colors.red,
                                              shape: RoundedRectangleBorder(
                                                borderRadius:
                                                BorderRadius.circular(
                                                    32.0),
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                  Divider(
                                    height: 1,
                                    thickness: 2,
                                  ),
                                ],
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.only(right: 16.w, bottom: 20.h),
                  child: Align(
                    alignment: Alignment.bottomRight,
                    child: ElevatedButton.icon(
                      icon: Icon(
                        Icons.add,
                        color: Colors.red,
                      ),
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => AggiungiEvento()));
                      },
                      label: Text(
                        "EVENT",
                        style: TextStyle(
                          color: Colors.red,
                          fontSize: 14.sp,
                          fontWeight: FontWeight.w700,
                          letterSpacing: 1.25,
                        ),
                      ),
                      style: ElevatedButton.styleFrom(
                        fixedSize: Size(125.w, 56.h),
                        primary: Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(4.0),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            );
          }
      ),
    );
  }

  Widget calcolaLivelloAllerta(int i) {
    if (listaEventi[i].date!.isBefore(DateTime.now())) {
      if (listaEventi[i]
          .date!
          .add(Duration(
          days: int.parse(prefs.getString("prioritaAlta") ?? "21")))
          .isAfter(DateTime.now())) {
        return Icon(
          Icons.circle,
          color: Colors.redAccent,
        );
      } else if (listaEventi[i]
          .date!
          .add(Duration(
          days: int.parse(prefs.getString("prioritaMedia") ?? "14")))
          .isAfter(DateTime.now())) {
        return Icon(
          Icons.circle,
          color: Colors.yellowAccent,
        );
      } else {
        return Icon(
          Icons.circle,
          color: Colors.greenAccent,
        );
      }
    } else {
      return Icon(
        Icons.circle,
        color: Colors.greenAccent,
      );
    }
  }

  /*void showAddEvento() {
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
                  key: _addEvent,
                  child: Padding(
                    padding: EdgeInsets.all(ScreenUtil().setHeight(8)),
                    child: Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(6)),
                          child: FormBuilderTextField(
                            name: "azienda",
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade300,
                                filled: true,
                                border: InputBorder.none,
                                labelText: "Azienda"),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context),
                            ]),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(6)),
                          child: FormBuilderTextField(
                            name: "referente",
                            decoration: InputDecoration(
                                fillColor: Colors.grey.shade300,
                                filled: true,
                                border: InputBorder.none,
                                labelText: "Referente "),
                            validator: FormBuilderValidators.compose([
                              FormBuilderValidators.required(context),
                            ]),
                          ),
                        ),
                        Padding(
                          padding: EdgeInsets.only(
                              bottom: ScreenUtil().setHeight(6)),
                          child: GestureDetector(
                            onTap: () => _selectDate(context),
                            child: Container(
                              color: Colors.grey[300],
                              height: 60,
                              width: double.infinity,
                              child: Padding(
                                padding: EdgeInsets.only(left: 8.0),
                                child: Align(
                                    alignment: Alignment.centerLeft,
                                    child: Text(
                                      "Scegli data evento",
                                      textAlign: TextAlign.start,
                                    )),
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
            actionsAlignment: MainAxisAlignment.center,
            actions: [
              ButtonTheme(
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(25),
                ),
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
                    if (_addEvent.currentState?.validate() ?? false) {
                      Azienda azienda =
                          _addEvent.currentState?.fields['azienda']!.value ?? " ";
                      Referente referente =
                          _addEvent.currentState?.fields['referente']!.value ??
                              " ";
                      DateTime data = currentDate;

                      Event event = new Event();
                      event.azienda.target = azienda;
                      event.referente.target = referente;
                      event.date = data;

                      _store.box<Event>().put(event);
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
  }*/

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: currentDate,
      firstDate: DateTime(2020),
      lastDate: DateTime(2050),
    );
    if (pickedDate != null && pickedDate != currentDate)
      setState(() {
        currentDate = pickedDate;
      });
  }

  Widget ritornaDataEvento(int i) {
    DateTime date = listaEventi[i].date!;
    if (i == 0) {
      dataGiaStampata = true;
      return Padding(
        padding: EdgeInsets.only(top: 50.h, bottom: 10.h),
        child: AutoSizeText(
          FormatDate.fromDateTimeToString(listaEventi[i].date!, "data"),
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 20.126488.sp,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.25,
          ),
        ),
      );
    } else if (!dataGiaStampata || date != listaEventi[i - 1].date!) {
      return Padding(
        padding: EdgeInsets.only(top: 73.h, bottom: 7.h),
        child: AutoSizeText(
          FormatDate.fromDateTimeToString(listaEventi[i].date!, "data"),
          style: TextStyle(
            color: Colors.grey[500],
            fontSize: 20.126488.sp,
            fontWeight: FontWeight.w400,
            letterSpacing: 0.25,
          ),
        ),
      );
    } else {
      dataGiaStampata = true;
      return SizedBox.shrink();
    }
  }
}
