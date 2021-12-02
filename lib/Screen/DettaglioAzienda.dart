import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:report_visita_danilo/Models/Azienda.dart';
import 'package:report_visita_danilo/Models/Report.dart';
import 'package:report_visita_danilo/Utils/FormatDate.dart';
import 'package:report_visita_danilo/costanti.dart';
import 'package:report_visita_danilo/i18n/AppLocalizations.dart';

import 'DettaglioReport.dart';

class AziendaDettaglio extends StatefulWidget {
  Azienda azienda;

  AziendaDettaglio({required this.azienda});

  @override
  AziendaDettaglioPageState createState() => AziendaDettaglioPageState();
}

class AziendaDettaglioPageState extends State<AziendaDettaglio> {
  List<Report> report = [];

  @override
  initState() {
    super.initState();
    report = mainStore!.box<Report>().getAll();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          widget.azienda.nome!,
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(top:8.h),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Padding(
                    padding: EdgeInsets.only(left:16.w),
                    child: Image.asset(
                      "assets/palazzo.png",
                      height: 50.h,
                    ),
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: EdgeInsets.all(8.0.h),
                        child: Container(
                          width: MediaQuery.of(context).size.width*.70,
                          child: AutoSizeText(
                            AppLocalizations.of(context).translate('indirizzo') +
                                ": " +(
                              widget.azienda.indirizzo != null?
                                    widget.azienda.indirizzo! : "--"),
                            textAlign: TextAlign.left,
                            maxLines: 2,
                            style: TextStyle(
                                fontSize: 10.sp,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.4,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.all(8.0),
                        child: Container(
                          width: MediaQuery.of(context).size.width*.70,
                          child: AutoSizeText(
                            AppLocalizations.of(context).translate('partitaIVA') +
                                " ${widget.azienda.partitaIva ?? "--"} ",
                            textAlign: TextAlign.left,
                            style: TextStyle(
                              fontSize: 10.sp,
                              fontWeight: FontWeight.w400,
                              letterSpacing: 0.4,
                              color: Colors.grey[700],
                            ),
                          ),
                        ),
                      ),
                      Divider(
                        height: 1,
                        thickness: 2,
                      ),

                    ],
                  ),
                ],
              ),
            ),
            Divider(color: Colors.red, thickness: 1, indent: 16.w, endIndent: 16.w,),
            Padding(
              padding: EdgeInsets.all(8.0.h),
              child: AutoSizeText(
                "REPORT",
                textAlign: TextAlign.left,
                style: TextStyle(
                  fontSize: 20.sp,
                  fontWeight: FontWeight.w400,
                  letterSpacing: 0.4,
                  color: Colors.grey[700],
                ),
              ),
            ),
            Divider(color: Colors.red, thickness: 1, indent: 16.w, endIndent: 16.w,),
            Padding(
              padding: EdgeInsets.only(right: 16.w, left: 16.w),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: report.length,
                    itemBuilder: (context, index) {
                      if(report[index].azienda.target!.nome == widget.azienda.nome!) {
                        return GestureDetector(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => DettaglioReport(
                                          report: report[index],
                                        )));
                          },
                          child: Column(
                            children: [
                              Card(
                                elevation: 5,
                                shadowColor: Colors.grey,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15)),
                                margin: EdgeInsets.only(top: 8.h, bottom: 8.h),
                                child: Container(
                                  height: 60.h,
                                  child: Padding(
                                    padding: EdgeInsets.only(
                                        left: 16.w, right: 16.w),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceAround,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              AppLocalizations.of(context)
                                                      .translate(
                                                          'dataCreazioneEvento') +
                                                  ": " +
                                                  FormatDate
                                                      .fromDateTimeToString(
                                                    report[index].compilazione!,
                                                    "data",
                                                  ),
                                              style: TextStyle(
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.grey[700]),
                                            ),
                                            Text(
                                              AppLocalizations.of(context)
                                                      .translate('dataEvento') +
                                                  ": " +
                                                  (report[index]
                                                              .prossimaVisita !=
                                                          null
                                                      ? report[index]
                                                          .prossimaVisita
                                                          .toString()
                                                      : "--"),
                                              style: TextStyle(
                                                  fontSize: 15.sp,
                                                  fontWeight: FontWeight.w400,
                                                  color: Colors.grey[700]),
                                            ),
                                          ],
                                        ),
                                        CircleAvatar(
                                          backgroundColor: Colors.red,
                                          child: Icon(
                                            Icons.arrow_forward_outlined,
                                            color: Colors.white,
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
                      }
                      else return Container();
                    },
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
