


import 'dart:convert';

import 'objectbox.g.dart';

 Store? mainStore;
dynamic response;
dynamic formKeyBodyMain;

String config=json.encode([
  {
    "title": "azienda",
    "type": "autocomplete",
    "hint": "Nome Cliente",
    "entity": "Azienda",
    "field": [
      {"label": "indirizzo", "required": true},
      {"label": "partitaIva", "required": true},
    ],
    "empty": false,
    "validation": true
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
      "Scopo della visita/Argomenti discussi/Problemi riscontrati/Opportunita/Dubbi e domande",
      "Richieste/Prospettive/Potenzialita/ Future Opportunita e rischi",
      "Criteri cliente importanti e secondari",
      "Punti forti concorrenza",
      "Punti deboli concorrenza",
      "Prossime azioni/Chi fa cosa/Tempi/Proposte alla direzione",
      "Prossimi Step",
      "Note"
    ]
  }
]);

