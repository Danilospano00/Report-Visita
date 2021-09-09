import 'package:objectbox/objectbox.dart';

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

  Referente({this.id, this.nome,this.cognome,this.ruolo,this.telefono,this.email});
}