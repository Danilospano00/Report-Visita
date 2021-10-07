import 'package:objectbox/objectbox.dart';
import 'package:report_visita_danilo/Models/Event.dart';

import 'Azienda.dart';

@Entity()
class Referente{
  @Id()
  int? id;

  String? nome;
  String? cognome;
  String? ruolo;
  String? telefono;
  String? email;

  double? lng;

  final azienda=ToOne<Azienda>();
  final events=ToMany<Event>();


  Referente({this.id, this.nome,this.cognome,this.ruolo,this.telefono,this.email});
}