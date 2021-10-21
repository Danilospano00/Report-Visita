import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:report_visita_danilo/Models/Azienda.dart';
import 'package:report_visita_danilo/Utils/FormatDate.dart';

import 'AziendaDettaglio.dart';

class ListaAziendeConEventiOggi extends StatefulWidget {
  List<Azienda> listaAziendaConEventiOggi;

  ListaAziendeConEventiOggi({required this.listaAziendaConEventiOggi});

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
      body: Column(
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
            itemCount: widget.listaAziendaConEventiOggi.length,
            itemBuilder: (BuildContext context, int index) {
              return GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => AziendaDettaglio(
                              azienda:
                                  widget.listaAziendaConEventiOggi[index])));
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
                                      widget.listaAziendaConEventiOggi[index]
                                          .nome!,
                                      style: TextStyle(
                                          fontSize: 15.712129.sp,
                                          fontWeight: FontWeight.w700,
                                          color: Colors.grey[700]),
                                    ),
                                  ),
                                  Text(
                                    widget.listaAziendaConEventiOggi[index]
                                            .events.isNotEmpty
                                        ? widget
                                                .listaAziendaConEventiOggi[
                                                    index]
                                                .events
                                                .elementAt(0)
                                                .date!
                                                .day
                                                .toString() +
                                            "/" +
                                            widget
                                                .listaAziendaConEventiOggi[
                                                    index]
                                                .events
                                                .elementAt(0)
                                                .date!
                                                .month
                                                .toString() +
                                            "/" +
                                            widget
                                                .listaAziendaConEventiOggi[
                                                    index]
                                                .events
                                                .elementAt(0)
                                                .date!
                                                .year
                                                .toString()
                                        : "",
                                    style: TextStyle(
                                        color: Colors.red,
                                        fontSize: 13.748113.sp,
                                        fontWeight: FontWeight.w700),
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(right:12.w),
                                    child: Text(
                                      FormatDate.fromDateTimeToString(
                                          widget.listaAziendaConEventiOggi[index]
                                              .events
                                              .elementAt(0)
                                              .date!,
                                          "orario"),
                                      style: TextStyle(
                                          color: Colors.red,
                                          fontSize: 13.748113.sp,
                                          fontWeight: FontWeight.w700),
                                    ),
                                  ),
                                ],
                              ),
                              widget.listaAziendaConEventiOggi[index].indirizzo != null?
                              Padding(
                                padding: EdgeInsets.only(top:4.h),
                                child: AutoSizeText(
                                  widget.listaAziendaConEventiOggi[index].indirizzo!,
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
                                    color: widget
                                        .listaAziendaConEventiOggi[index]
                                        .events
                                        .isNotEmpty
                                        ? Colors.lightGreenAccent
                                        : Colors.blue,
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
    );
  }
}
