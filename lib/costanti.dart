


import 'dart:convert';

import 'objectbox.g.dart';

 Store? mainStore;
dynamic response;
dynamic formKeyBodyMain;
String emailAdress="sandrotroncone@gmail.com";
String subjectEmail="Feedback, suggerimenti, nuove funzioni";
String bodyEmail="Vuoi altre funzionalita'?\n Contattami ORA!\nL' applicazione e' attualmente in continua fase di Evoluzione e questo avverra' grazie alle tue segnalazioni.\n Non esitare a contattarmi per suggerimenti/modifiche.\n Ho a cuore il tuo business e il tuo feedback e' importantissimo.\n Ti ringrazio per la collaborazione.";



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
    "title": "file",
    "type": "file",
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

String configPerConfigurazioniUtente=json.encode([
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
    "title": "file",
    "type": "file",
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

String configurazioneAggiuntaEvento=json.encode([
  {
    "title": "azienda",
    "type": "autocomplete",
    "hint": "Nome Cliente",
    "entity": "Azienda",
    "field": [
      {"label": "indirizzo", "required": true},
    ],
    "empty": false,
    "validation": true
  },
  {
    "title": "prossimaVisita",
    "label": "prossima visita",
    "type": "date",
    "required": "yes"
  },
  {
    "title": "multiline",
    "type": "multiline",
  },
]);