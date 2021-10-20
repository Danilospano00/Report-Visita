import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:report_visita_danilo/Models/Azienda.dart';
import 'package:report_visita_danilo/Models/Event.dart';
import 'package:report_visita_danilo/Utils/authService.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../costanti.dart';

class AccountEmpty extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => AccountEmptyState();
}

class AccountEmptyState extends State<AccountEmpty> {
  Random rnd = new Random();
  Azienda aziendaRandom = Azienda();
  int differenzaGiorni = 0;
  List<Azienda> listaAziende = [];

  List<Azienda> listaEventDaCiclare = [];


  SharedPreferences? prefs;

  @override
  initState() {
    super.initState();

    listaEventDaCiclare  = mainStore!.box<Azienda>().getAll();
    SharedPreferences.getInstance().then((value) {
      prefs = value;
      for (int x = 0; x < listaEventDaCiclare.length; x++) {
        Azienda a = listaEventDaCiclare[x];
        List<Event> list = a.events;
        list.sort((a, b) {
          return a.date!.compareTo(b.date!);
        });
        print(prefs!.getString("prioritaAlta").toString());

        if (list.length >= 2) {
          differenzaGiorni =
              list[list.length - 1].date!.difference(DateTime.now()).inDays;
          print(list[list.length - 1].date!);
          print(differenzaGiorni);
        }
        if (differenzaGiorni >=
            int.parse(prefs!.getString("prioritaAlta").toString())) {
          listaAziende.add(a);
          print("evento aggiunto");
        }
        print(listaAziende.length.toString());
      }
      setState(() {
        if (listaAziende.length >= 1) {
          aziendaRandom = listaAziende[rnd.nextInt(listaAziende.length)];
          print(aziendaRandom.nome);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          iconTheme: IconThemeData(color: Colors.grey[700]),
          title: Text(
            "Account",
            textAlign: TextAlign.left,
            style: TextStyle(
                fontSize: 24.151785.sp,
                fontWeight: FontWeight.w400,
                color: Colors.grey[700]),
          ),
        ),
        body: AuthService()
                .handleAuth(listaAziende, listaEventDaCiclare, aziendaRandom));
  }
}
