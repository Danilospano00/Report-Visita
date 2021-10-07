

import 'package:objectbox/objectbox.dart';

import 'Azienda.dart';
import 'Referente.dart';

@Entity()
class Event{
  @Id()
  int? id;
 // @NOT_NULL
  DateTime? date;
  String? descrizione;



  var azienda=ToOne<Azienda>();
  final referente=ToMany<Referente>();
}