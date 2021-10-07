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
  @Property(type: PropertyType.byteVector)
  List<int>? byteListFile;


   final azienda=ToOne<Azienda>();
   final referente=ToMany<Referente>();
   final note=ToMany<Nota>();
}