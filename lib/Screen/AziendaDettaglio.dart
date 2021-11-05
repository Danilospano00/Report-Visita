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
          AppLocalizations.of(context).translate('dettaglioAzienda'),
        ),
        centerTitle: true,
        backgroundColor: Colors.red,
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: EdgeInsets.all(8.h),
                  child: AutoSizeText(
                    widget.azienda.nome.toString(),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 20.126488.sp,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.25,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0.h),
                  child: AutoSizeText(
                    AppLocalizations.of(context).translate('indirizzo')+":" +widget.azienda.indirizzo!,
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 12.075892.sp,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.4,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(8.0.h),
                  child: AutoSizeText(
                    AppLocalizations.of(context).translate('partitaIVA')+widget.azienda.partitaIva.toString(),
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 12.075892.sp,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.4,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
                Divider(
                  height: 1,
                  thickness: 2,
                ),
                Padding(
                  padding: EdgeInsets.all(8.0.h),
                  child: AutoSizeText(
                    "REPORT",
                    textAlign: TextAlign.left,
                    style: TextStyle(
                      fontSize: 12.075892.sp,
                      fontWeight: FontWeight.w400,
                      letterSpacing: 0.4,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ],
            ),
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
                      if (report[index].azienda.target!.partitaIva ==
                          widget.azienda.partitaIva) {
                        return Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Padding(
                                      padding: EdgeInsets.only(top: 8.h),
                                      child: AutoSizeText(
                                        AppLocalizations.of(context).translate('dataCreazioneEvento') +" :"+
                                            FormatDate.fromDateTimeToString(
                                                report[index].compilazione!,
                                                "data"),
                                        textAlign: TextAlign.left,
                                        style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w400,
                                          letterSpacing: 0.25,
                                          color: Colors.grey[700],
                                        ),
                                      ),
                                    ),
                                    ElevatedButton(
                                      child: Text(
                                        AppLocalizations.of(context).translate('vedi'),
                                        style: TextStyle(
                                            fontSize: 10.sp,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      onPressed: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    DettaglioReport(
                                                      report: report[index],
                                                    )));
                                      },
                                      style: ElevatedButton.styleFrom(
                                        minimumSize: Size(18.w, 25.h),
                                        primary: Colors.red,
                                        shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(32.0),
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
                      } else
                        return Container();
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
