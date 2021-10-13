import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:report_visita_danilo/generateFromtoJson/genetareFormtoJson.dart';

import '../costanti.dart';

class MostraConfigurazioni extends StatefulWidget {
  late String _nomeConfigurazione;
  static late String text;

  @override
  State<StatefulWidget> createState() => MostraConfigurazioniState();

  MostraConfigurazioni(this._nomeConfigurazione);

  @override
  initState(){
    text = _nomeConfigurazione;
  }
}

class MostraConfigurazioniState extends State<MostraConfigurazioni> {
  late String configurazione;

  @override
  initState() {
    super.initState();
    setState(() {
      configurazione = configPerConfigurazioniUtente;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.grey[700]),
        title: AutoSizeText(MostraConfigurazioni.text,
          textAlign: TextAlign.left,
          style: TextStyle(
              fontSize: 21.sp,
              fontWeight: FontWeight.w400,
              color: Colors.grey[700]),
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(right: 16.w, left: 16.w),
        child: SingleChildScrollView(
          child: Stack(
            children: [
              GeneratorFormToJson(
                form: configurazione,
                store: mainStore!,
                onChanged: (dynamic value) {
                  print(value);
                  setState(() {
                    response = value;
                  });
                  print(response.toString());
                },
              ),
              Align(
                alignment: Alignment.bottomRight,
                child: ElevatedButton(
                  onPressed: () {},
                  child: Text(
                    "ACCETTA",
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
            ],
          ),
        ),
      ),
    );
  }
}
