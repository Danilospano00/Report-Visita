import 'package:objectbox/objectbox.dart';
import 'package:report_visita_danilo/Models/Azienda.dart';
import 'package:report_visita_danilo/Models/Referente.dart';
import 'Nota.dart';

@Entity()
class Report{
  @Id()
  int? id;

   final azienda=ToOne<Azienda>();
   final referente=ToOne<Referente>();
   final note=ToMany<Nota>();


}