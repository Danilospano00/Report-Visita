import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:report_visita_danilo/Models/Event.dart';
import 'package:report_visita_danilo/Models/factory/filter.dart';
import 'package:report_visita_danilo/Utils/FormatDate.dart';
import 'package:report_visita_danilo/Utils/MyDrawer.dart';
import 'package:report_visita_danilo/i18n/AppLocalizations.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:intl/intl.dart';
import 'package:url_launcher/url_launcher.dart';

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
        stream = mainStore!
            .box<Event>()
            .query()
            .watch(triggerImmediately: true)
            .map((query) => query.find());

        loading = false;
      });
      print("Alta" + prefs.getString("prioritaAlta").toString());
      print("Media " + prefs.getString("prioritaMedia").toString());
      print("Bassa " + prefs.getString("prioritaBassa").toString());
    });

    /*  Query<Event> query = mainStore!
        .box<Event>()
        .query(Event_.date.between(DateTime.now().millisecond,
            DateTime.now().add(Duration(days: 365)).millisecond))
        .build();
    listaEventi = query.find();*/

    // listaEventi = mainStore!.box<Event>().getAll();
  }

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => FilterModel(),
      child: Scaffold(
        extendBodyBehindAppBar: true,
        key: _keyDrawer,
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        endDrawer: MyDrawer(),
        body: loading
            ? Center(
            child: CircularProgressIndicator(
              color: Colors.red,
            ))
            : StreamBuilder<List<Event>>(
            stream: stream,
            builder:
                (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
              if (snapshot.hasData) {
                var filter = context.watch<FilterModel>().map;
                List<Event> listaEvent = [];
                listaEvent = snapshot.data;
                listaEvent.sort((a, b) {
                  return a.date!.compareTo(b.date!);
                });
                listaEventi = calcoloSoglia(filter, listaEvent);
              }
              return Stack(
                children: [
                  SafeArea(
                    child: SingleChildScrollView(
                      child: Padding(
                        padding: EdgeInsets.only(right: 16.w, left: 16.w),
                        child: listaEventi.isEmpty
                            ? Center(child: Text( AppLocalizations.of(context).translate('eventiAssenti'),style: TextStyle(fontWeight: FontWeight.w700),))
                            : Column(
                          crossAxisAlignment:
                          CrossAxisAlignment.start,
                          children: [
                            ListView.builder(
                              shrinkWrap: true,
                              physics:
                              const NeverScrollableScrollPhysics(),
                              itemCount: listaEventi.length,
                              itemBuilder: (context, index) {
                                return Column(
                                  crossAxisAlignment:
                                  CrossAxisAlignment.start,
                                  children: [
                                    ritornaDataEvento(index),
                                    Column(
                                      crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                      children: [
                                        Row(
                                          children: [
                                            Text(
                                              FormatDate
                                                  .fromDateTimeToString(
                                                  listaEventi[
                                                  index]
                                                      .date!,
                                                  "orario"),
                                              textAlign:
                                              TextAlign.left,
                                              style: TextStyle(
                                                  fontSize:
                                                  12.075892.sp,
                                                  fontWeight:
                                                  FontWeight.w400,
                                                  letterSpacing: 2.w),
                                            ),
                                            Padding(
                                              padding:
                                              EdgeInsets.only(
                                                  left: 8.0),
                                              child:
                                              calcolaLivelloAllerta(
                                                  index),
                                            ),
                                          ],
                                        ),
                                        Padding(
                                          padding: EdgeInsets.only(
                                              top: 8.h),
                                          child: Text(
                                            listaEventi[index]
                                                .azienda
                                                .target!
                                                .nome
                                                .toString(),
                                            textAlign: TextAlign.left,
                                            style: TextStyle(
                                              fontSize: 20.126488.sp,
                                              fontWeight:
                                              FontWeight.w400,
                                              letterSpacing: 0.25,
                                              color: Colors.grey[700],
                                            ),
                                          ),
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                          MainAxisAlignment
                                              .spaceBetween,
                                          children: [
                                            Container(
                                              width: 250.w,
                                              child: AutoSizeText(
                                                "${listaEventi[index].azienda.target!.indirizzo}",
                                                textAlign:
                                                TextAlign.left,
                                                maxLines: 2,
                                                style: TextStyle(
                                                  fontSize:
                                                  12.075892.sp,
                                                  fontWeight:
                                                  FontWeight.w400,
                                                  letterSpacing: 0.4,
                                                  color: Colors
                                                      .grey[700],
                                                ),
                                              ),
                                            ),
                                            ElevatedButton(
                                              child: Text(
                                                AppLocalizations.of(context).translate('mappa'),
                                                style: TextStyle(
                                                    fontSize: 10.sp,
                                                    fontWeight:
                                                    FontWeight
                                                        .bold),
                                              ),
                                              onPressed: () {
                                                openMap(
                                                    listaEventi[index]
                                                        .azienda
                                                        .target!
                                                        .lat!,
                                                    listaEventi[index]
                                                        .azienda
                                                        .target!
                                                        .lng!);
                                              },
                                              style: ElevatedButton
                                                  .styleFrom(
                                                minimumSize:
                                                Size(18.w, 25.h),
                                                primary: Colors.red,
                                                shape:
                                                RoundedRectangleBorder(
                                                  borderRadius:
                                                  BorderRadius
                                                      .circular(
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
            }),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          actions: [
            Padding(
              //ho dovuto cambiare il padding a 12 perchè sennò diventava troppo piccolo il fab
              padding: EdgeInsets.only(right: 16.w, top: 2.h),
              child: ElevatedButton(
                onPressed: () {
                  print("aperto");
                  _keyDrawer.currentState!.openEndDrawer();
                },
                style: ElevatedButton.styleFrom(
                  shape: CircleBorder(),
                  primary: Colors.red,
                  minimumSize: Size(20, 10),
                  shadowColor: Colors.transparent,
                ),
                child: Icon(
                  Icons.filter_list_outlined,
                  size: 36,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget calcolaLivelloAllerta(int i) {
    Event e = listaEventi[i];
    List<Event> list = e.azienda.target!.events;

    if (list.length > 2) {
      list.sort((a, b) {
        return a.date!.compareTo(b.date!);
      });
      late int differenzaGiorni;
      for (int x = 0; x < list.length; x++) {
        if (list[x].id == e.id && list[x].date == e.date) {
          if (x != 0) {
            Event event = list[x - 1];
            differenzaGiorni = e.date!.difference(event.date!).inDays;
          } else
            differenzaGiorni = 0;
        }
      }

      if (differenzaGiorni >=
          int.parse(prefs.getString("prioritaAlta") ?? "60")) {
        return Icon(
          Icons.circle,
          color: Colors.redAccent,
        );
      } else if (differenzaGiorni >=
          int.parse(prefs.getString("prioritaMedia") ?? "30")) {
        return Icon(
          Icons.circle,
          color: Colors.yellowAccent,
        );
      } else
        return Icon(
          Icons.circle,
          color: Colors.greenAccent,
        );
    } else
      return Icon(
        Icons.circle,
        color: Colors.greenAccent,
      );
  }

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }

  Widget ritornaDataEvento(int i) {
    String dateTime = "${listaEventi[i].date!.day.toString()}" +
        "-" +
        listaEventi[i].date!.month.toString() +
        "-" +
        "${listaEventi[i].date!.year.toString()}";

    DateTime date = DateFormat('yyyy-MM-dd').parse(dateTime);
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
    } else if (!dataGiaStampata ||
        date !=
            DateFormat('dd-MM-yyyy')
                .parse(listaEventi[i - 1].date!.toString())) {
      String datee = listaEventi.length - 1 > 0
          ? DateFormat('dd-MM-yyyy')
          .parse(listaEventi[i - 1].date!.toString())
          .toString()
          : "1";
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

  List<Event> calcoloSoglia(Map<String, bool> filter, List<Event> listaEvent) {
    List<Event> listaEventiMetodo = [];

    for (int x = 0; x < listaEvent.length; x++) {
      if (listaEvent[x].date!.isAfter(DateTime.now()) ||
          listaEvent[x].date!.day == (DateTime.now().day) &&
              listaEvent[x].date!.month == (DateTime.now().month) &&
              listaEvent[x].date!.year == (DateTime.now().year)) {
        String? soglia;
        bool? bassa = filter["bassa"];
        bool? media = filter["media"];
        bool? alta = filter["alta"];

        Event e = listaEvent[x];
        List<Event> list = e.azienda.target!.events;

        list.sort((a, b) {
          return a.date!.compareTo(b.date!);
        });
        late int differenzaGiorni=0;
        for (int y = 0; y < list.length; y++) {
          if (list[y].id == e.id && list[y].date == e.date) {
            if (y != 0) {
              Event event = list[y - 1];
              differenzaGiorni = e.date!.difference(event.date!).inDays;
            }
            if (differenzaGiorni <=
                int.parse(prefs.getString("prioritaBassa") ?? "0")) {
              soglia="bassa";
            }else if(differenzaGiorni >=
                int.parse(prefs.getString("prioritaMedia") ?? "30")){
              soglia="media";
            }else if(differenzaGiorni >=  int.parse(prefs.getString("prioritaAlta") ?? "60")){
              soglia ="alta";
            }

            switch(soglia){
              case "bassa": if(bassa!) listaEventiMetodo.add(e);
              break;
              case "media": if(media!) listaEventiMetodo.add(e);
              break;
              case "alta": if(alta!) listaEventiMetodo.add(e);
              break;

            }

          }
        }
      }
    }
    return listaEventiMetodo;
  }
}
