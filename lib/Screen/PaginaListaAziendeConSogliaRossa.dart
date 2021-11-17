import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:report_visita_danilo/Models/Azienda.dart';
import 'package:report_visita_danilo/Utils/FormatDate.dart';
import 'package:report_visita_danilo/i18n/AppLocalizations.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:intl/intl.dart';

import 'DettaglioAzienda.dart';

class PaginaListaAziendeConSogliaRossa extends StatefulWidget {
  List<Azienda> listaAziendaConSogliaRossa;

  PaginaListaAziendeConSogliaRossa({required this.listaAziendaConSogliaRossa});

  @override
  State<StatefulWidget> createState() =>
      PaginaListaAziendeConSogliaRossaState();
}

class PaginaListaAziendeConSogliaRossaState
    extends State<PaginaListaAziendeConSogliaRossa> {
  bool dataGiaStampata = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        shadowColor: Colors.transparent,
        iconTheme: IconThemeData(color: Colors.grey[700]),
        title: Container(
          width: 500.w,
        ),
      ),
      body: Padding(
        padding: EdgeInsets.only(left: 16.w, right: 16.w),
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.only(
                  top: ScreenUtil().setHeight(20),
                  left: ScreenUtil().setWidth(16),
                  right: ScreenUtil().setWidth(16)),
              child: AutoSizeText(
                  AppLocalizations.of(context).translate('aziendeNonVisitateDaMoltoTempo'),
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
              physics: const NeverScrollableScrollPhysics(),
              itemCount: widget.listaAziendaConSogliaRossa.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => AziendaDettaglio(
                                azienda:
                                    widget.listaAziendaConSogliaRossa[index])));
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
                            padding: EdgeInsets.only(left: 16.w, right: 16.w),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Text(
                                  widget
                                      .listaAziendaConSogliaRossa[index].nome!,
                                  style: TextStyle(
                                      fontSize: 23.sp,
                                      fontWeight: FontWeight.w400,
                                      color: Colors.grey[700]),
                                ),
                                Icon(
                                  Icons.circle,
                                  color: Colors.red,
                                  size: 16,
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

  static Future<void> openMap(double latitude, double longitude) async {
    String googleUrl =
        'https://www.google.com/maps/search/?api=1&query=$latitude,$longitude';
    if (await canLaunch(googleUrl)) {
      await launch(googleUrl);
    } else {
      throw 'Could not open the map.';
    }
  }
}
