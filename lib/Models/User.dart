import 'package:flutter_form_builder/flutter_form_builder.dart';

class User {
  int? id;
  String? email;
  String? nome;
  String? cognome;
  String? password;


  User({
    this.id,
    this.email,
    this.nome,
    this.cognome,
    this.password,

  });

  User.init(
      Map<String, FormBuilderFieldState<FormBuilderField<dynamic>, dynamic>>
      values) {
    values.forEach((key, value) {
      switch (key) {
        case 'email':
          {
            email = value.value;
          }
          break;
        case 'nome':
          {
            nome = value.value;
          }
          break;
        case 'cognome':
          {
            cognome = value.value;
          }
          break;
        case 'password':
          {
            password = value.value;
          }
          break;

      }
    });
  }

}
