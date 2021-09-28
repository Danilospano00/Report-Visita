

import 'package:flutter/material.dart';
import 'package:objectbox/objectbox.dart';
import 'package:report_visita_danilo/Models/Event.dart';
import 'package:report_visita_danilo/Models/Referente.dart';

import 'Report.dart';


@Entity()
class Azienda{
  @Id()
  int? id;

  String? nome;
  String? indirizzo;
  String? cap;
  String? citta;
  String? partitaIva;
  String? codiceFiscale;
  double? lat;
  double? lng;
  String? renderKey;



  final referenti=ToMany<Referente>();
  final reports=ToMany<Report>();
  final events=ToMany<Event>();

  Azienda({this.id, this.nome,this.indirizzo,this.cap,this.citta,this.partitaIva,this.codiceFiscale,this.lat,this.lng});

  void setKey(Key _key) {
    renderKey = _key.toString();
  }

  String? getKey() {
    return renderKey;
  }


  Map<String, dynamic> toMap() {
    return {
      "id":this.id,
     'nome':this.nome,
    'indirizzo':this.indirizzo,
    'cap':this.cap,
    'citta':this.citta,
    'partitaIva':this.partitaIva,
    'codiceFiscale':this.codiceFiscale,
    'lat':this.lat,
    'lng':this.lng,

    };
  }

  Azienda fromMap(Map<String, dynamic> map) {


    return Azienda(
      id: map["id"],
      nome: map["nome"],
      indirizzo: map["indirizzo"],
      citta: map["citta"],
      codiceFiscale: map["codiceFiscale"],
      partitaIva: map["partitaIva"],
      cap: map["cap"],
      lat: map["lat"],
      lng: map["lng"]

    );

  }




}
