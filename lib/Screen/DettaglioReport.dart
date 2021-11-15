import 'dart:io';

import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:path_provider/path_provider.dart';
import 'package:report_visita_danilo/Models/Report.dart';
import 'package:report_visita_danilo/Utils/PdfApi.dart';
import 'package:report_visita_danilo/Utils/theme.dart';
import 'package:report_visita_danilo/generateFromtoJson/genetareFormtoJson.dart';
import 'package:report_visita_danilo/i18n/AppLocalizations.dart';
import 'package:share/share.dart';

import '../costanti.dart';

class DettaglioReport extends StatefulWidget {
  final Report report;

  DettaglioReport({required this.report});

  @override
  State<StatefulWidget> createState() => DettaglioReportState();
}

class DettaglioReportState extends State<DettaglioReport> {
  bool export = false;
  static GlobalKey<ScaffoldState> _scaffoldKeyDettaglioReport =
  GlobalKey<ScaffoldState>();
  @override
  initState() {
    super.initState();
    widget.report.configurationJson=configPreferences;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [
          FlatButton.icon(
              onPressed: () {
                setState(() {
                  export = !export;
                });
              },
              icon: Icon(
                Icons.share_outlined,
              ),
              label: Text("")),
        ],
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.grey[700]),
        title: Text(
          "Report ${widget.report.azienda.target!.nome}",
          textAlign: TextAlign.left,
          style: TextStyle(
              fontSize: 24.151785.sp,
              fontWeight: FontWeight.w400,
              color: Colors.grey[700]),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w, top: 4.h),
        child: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              children: [
                GeneratorFormToJson(
                  store: mainStore!,
                  export: export,
                  form: config,
                  active: false,
                  initialReport: widget.report,
                  onChanged: (dynamic value) {
                    print(value);
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
  static void showSnackBar(String text) {
    final snackBar = SnackBar(
      duration: Duration(seconds: 8),
      content: Text(text),
      backgroundColor: Colors.black,
      padding: EdgeInsets.all(15.0),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(10))),
      behavior: SnackBarBehavior.floating,
    );
    ScaffoldMessenger.of(_scaffoldKeyDettaglioReport.currentContext!).showSnackBar(snackBar);
  }


}
