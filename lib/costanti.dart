


import 'dart:convert';

import 'objectbox.g.dart';

 Store? mainStore;
dynamic response;
dynamic formKeyBodyMain;

String config=json.encode([
  {
    "title": "azienda",
    "type": "autocomplete",
    "hint": "inserisci la tua azienda",
    "entity": "Azienda",
    "field": [
      {"label": "indirizzo", "required": true},
      {"label": "partitaIva", "required": true},
    ],
    "empty": false,
    "validation": true
  },
  {
    "title": "dateCompilazione",
    "label": "compilazione",
    "type": "date",
    "required": "no"
  },
  {
    "title": "prossimaVisita",
    "label": "prossima visita",
    "type": "date",
    "required": "no"
  },
  {
    "title": "contatto",
    "type": "contact",
  },
  {
    "title": "note",
    "type": "note",
    "label": [
      "Scopo della visita/Argomenti discussi",
      "Richiste/Prospettive",
      "Punti forti concorrenza"
    ]
  }
]);

