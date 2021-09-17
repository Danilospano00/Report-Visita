

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


  final referenti=ToMany<Referente>();
  final reports=ToMany<Report>();
  final events=ToMany<Event>();








  Azienda({this.id, this.nome,this.indirizzo,this.cap,this.citta,this.partitaIva,this.codiceFiscale,this.lat,this.lng});
}
