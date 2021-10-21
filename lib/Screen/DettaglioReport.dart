import 'package:flutter/material.dart';
import 'package:report_visita_danilo/Models/Report.dart';
import 'package:report_visita_danilo/generateFromtoJson/genetareFormtoJson.dart';

import '../costanti.dart';

class DettaglioReport extends StatefulWidget{
  final Report report;

  DettaglioReport({required this.report});

  @override
  State<StatefulWidget> createState() => DettaglioReportState();
}

class DettaglioReportState extends State<DettaglioReport>{
  @override
  Widget build(BuildContext context) {
   return Scaffold(
     body: GeneratorFormToJson(
       store: mainStore!,
       form: widget.report.configurationJson!,
       active: false,
       initialReport: widget.report,
       onChanged: (dynamic value) {
         print(value);
       },
     ),
   );
  }

}