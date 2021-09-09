import 'package:objectbox/objectbox.dart';

@Entity()
class Nota {
  @Id()
  int? id;

  String? titolo;
  String? testo;

  Nota({this.id, this.titolo, this.testo});
}
