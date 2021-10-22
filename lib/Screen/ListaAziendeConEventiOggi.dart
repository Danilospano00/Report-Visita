import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:report_visita_danilo/Models/Azienda.dart';
import 'package:report_visita_danilo/Models/Event.dart';
import 'package:report_visita_danilo/Utils/FormatDate.dart';

import 'AziendaDettaglio.dart';

class ListaAziendeConEventiOggi extends StatefulWidget {
  List<Event> listaEventiDiOggi;

  ListaAziendeConEventiOggi({required this.listaEventiDiOggi});

  @override
  State<StatefulWidget> createState() => ListaAziendeConEventiOggiState();
}

class ListaAziendeConEventiOggiState extends State<ListaAziendeConEventiOggi> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.grey[700]),
      ),
      body: widget.listaEventiDiOggi.isEmpty?Center(child: Text("Oggi non ci sono eventi")): SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  bottom: ScreenUtil().setHeight(10),
                  left: ScreenUtil().setWidth(16),
                  right: ScreenUtil().setWidth(16)),
              child: AutoSizeText(
                "Eventi in programma oggi",
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 24.sp,
                    fontWeight: FontWeight.w700,
                    letterSpacing: 0.9092158,
                    color: Colors.grey[700]),
              ),
            ),
            ListView.builder(
              shrinkWrap: true,
              itemCount: widget.listaEventiDiOggi.length,
              itemBuilder: (BuildContext context, int index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AziendaDettaglio(
                                azienda:
                                    widget.listaEventiDiOggi[index].azienda.target!)));
                  },
                  child: Column(
                    children: [
                      Padding(
                        padding: EdgeInsets.only(right: 16.w, left: 16.w),
                        child: Card(
                          elevation: 5,
                          shadowColor: Colors.grey,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15)),
                          margin: EdgeInsets.only(top: 8.h, bottom: 8.h),
                          child: Container(
                            height: 60.h,
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceAround,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(left: 12.w),
                                      child: Text(
                                        widget.listaEventiDiOggi[index].azienda.target!
                                            .nome!,
                                        style: TextStyle(
                                            fontSize: 15.712129.sp,
                                            fontWeight: FontWeight.w700,
                                            color: Colors.grey[700]),
                                      ),
                                    ),
                                    Text(
                                      FormatDate.fromDateTimeToString(
                                        widget.listaEventiDiOggi[index].date!,
                                      "data"),
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 13.748113.sp,
                                          fontWeight: FontWeight.w700),
                                    ),
                                    Padding(
                                      padding: EdgeInsets.only(right:12.w),
                                      child: Text(
                                        FormatDate.fromDateTimeToString(
                                            widget.listaEventiDiOggi[index].date!,
                                            "orario"),
                                        style: TextStyle(
                                            color: Colors.red,
                                            fontSize: 13.748113.sp,
                                            fontWeight: FontWeight.w700),
                                      ),
                                    ),
                                  ],
                                ),
                                widget.listaEventiDiOggi[index].azienda.target!.indirizzo != null?
                                Padding(
                                  padding: EdgeInsets.only(top:4.h),
                                  child: AutoSizeText(
                                    widget.listaEventiDiOggi[index].azienda.target!.indirizzo!,
                                    style: TextStyle(
                                      color: Colors.grey[700],
                                      fontWeight: FontWeight.w700,
                                    ),
                                  ),
                                ):
                                    Container(),
                                Padding(
                                  padding: EdgeInsets.only(
                                      right: 12.w, bottom: 4.h,),
                                  child: Align(
                                    alignment: Alignment.bottomRight,
                                    child: Icon(
                                      Icons.circle,
                                      color:  Colors.lightGreenAccent,
                                      size: 16,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
