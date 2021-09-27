import 'package:objectbox/objectbox.dart';
import 'package:report_visita_danilo/Models/Azienda.dart';
import 'package:report_visita_danilo/Models/Referente.dart';
import 'Nota.dart';

@Entity()
class Report{
  @Id()
  int? id;
  //configurazione presa da fire base da salvare per eventuali modifiche per retro compatibiltà
  String? configurationJson;
  DateTime? compilazione;
  DateTime? prossimaVisita;


   final azienda=ToOne<Azienda>();
   final referente=ToOne<Referente>();
   final note=ToMany<Nota>();
}