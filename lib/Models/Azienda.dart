
import 'package:objectbox/objectbox.dart';

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





  Azienda({this.id, this.nome,this.indirizzo,this.cap,this.citta,this.partitaIva,this.codiceFiscale,this.lat,this.lng});
}