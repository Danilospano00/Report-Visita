import 'package:objectbox/objectbox.dart';
import 'package:report_visita_danilo/Models/Azienda.dart';
import 'package:report_visita_danilo/Models/Referente.dart';
import 'Nota.dart';

@Entity()
class Report {
  @Id()
  int? id;

  //configurazione presa da fire base da salvare per eventuali modifiche per retro compatibiltà
  String? configurationJson;
  DateTime? compilazione;
  DateTime? prossimaVisita;
  @Property(type: PropertyType.byteVector)
  List<int>? byteListFile;

  final azienda = ToOne<Azienda>();
  final referente = ToMany<Referente>();
  final note = ToMany<Nota>();

  Map<String, dynamic> toMap() {
    return {
      "id": this.id,
      'Azienda': this.azienda.target!.nome,
      'indirizzo': this.azienda.target!.indirizzo,
      "partitaIva": this.azienda.target!.partitaIva,
      'cap': this.azienda.target!.cap,
      'citta': this.azienda.target!.citta,
      'codiceFiscale': this.azienda.target!.codiceFiscale,
      'lat': this.azienda.target!.lat,
      'lng': this.azienda.target!.lng,
      "note": this.note
    };
  }
}
