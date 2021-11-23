import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:report_visita_danilo/Models/Event.dart';
import 'package:report_visita_danilo/Models/Report.dart';
import 'package:report_visita_danilo/generateFromtoJson/genetareFormtoJson.dart';

import '../costanti.dart';

class DettaglioReport extends StatefulWidget {
  final Report report;

  DettaglioReport({required this.report});

  @override
  State<StatefulWidget> createState() => DettaglioReportState();
}

class DettaglioReportState extends State<DettaglioReport> {
  bool export = false;

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
                  child: GeneratorFormToJson(
                    store: mainStore!,
                    form:  widget.report.configurationJson!,
                    active: false,
                    initialReport: widget.report,
                    onChanged: (dynamic value) {
                      print(value);
                    },
                    export: export,
                  ),
                ),
              ),
            )
    );
  }


}
