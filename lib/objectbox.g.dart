// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: camel_case_types

import 'dart:typed_data';

import 'package:objectbox/flatbuffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'Models/Azienda.dart';
import 'Models/Event.dart';
import 'Models/Nota.dart';
import 'Models/Referente.dart';
import 'Models/Report.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 6699721163340380006),
      name: 'Azienda',
      lastPropertyId: const IdUid(9, 7763242583025491130),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 889486232859355408),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 2163537920210606187),
            name: 'nome',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 585111996702982996),
            name: 'indirizzo',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 5646883500398924192),
            name: 'cap',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 8193278155310535672),
            name: 'citta',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 3301996090157655906),
            name: 'partitaIva',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 1456508788078607),
            name: 'codiceFiscale',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 8129124514944070115),
            name: 'lat',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(9, 7763242583025491130),
            name: 'lng',
            type: 8,
            flags: 0)
      ],
      relations: <ModelRelation>[
        ModelRelation(
            id: const IdUid(1, 5716422256582063063),
            name: 'referenti',
            targetId: const IdUid(4, 8947773901463855486)),
        ModelRelation(
            id: const IdUid(2, 163474457223025267),
            name: 'reports',
            targetId: const IdUid(5, 8602950264123820003)),
        ModelRelation(
            id: const IdUid(3, 2389066898047290087),
            name: 'events',
            targetId: const IdUid(2, 2552819608927518688))
      ],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(2, 2552819608927518688),
      name: 'Event',
      lastPropertyId: const IdUid(5, 7341862949847124080),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 6916513378018649333),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 2693273868096212302),
            name: 'date',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 1985119465410250632),
            name: 'descrizione',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 7015651020845249374),
            name: 'aziendaId',
            type: 11,
            flags: 520,
            indexId: const IdUid(1, 8696375249037025975),
            relationTarget: 'Azienda'),
        ModelProperty(
            id: const IdUid(5, 7341862949847124080),
            name: 'referenteId',
            type: 11,
            flags: 520,
            indexId: const IdUid(2, 4488707589057652025),
            relationTarget: 'Referente')
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(3, 1173462549094797954),
      name: 'Nota',
      lastPropertyId: const IdUid(3, 8065523008156345813),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 8929789468711488672),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 1775260327657327707),
            name: 'titolo',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 8065523008156345813),
            name: 'testo',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(4, 8947773901463855486),
      name: 'Referente',
      lastPropertyId: const IdUid(7, 5963342834668548175),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 5077991129764406274),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 9075779107153716383),
            name: 'nome',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 5597478610342204745),
            name: 'cognome',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 7890546103322153713),
            name: 'ruolo',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 4043144854624402565),
            name: 'telefono',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 2906446119383018850),
            name: 'email',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 5963342834668548175),
            name: 'lng',
            type: 8,
            flags: 0)
      ],
      relations: <ModelRelation>[
        ModelRelation(
            id: const IdUid(4, 1102411262598963011),
            name: 'events',
            targetId: const IdUid(2, 2552819608927518688))
      ],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(5, 8602950264123820003),
      name: 'Report',
      lastPropertyId: const IdUid(4, 1276631803658986642),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 6132108408124088977),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 732325322840181720),
            name: 'configurationJson',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 3150946864205750518),
            name: 'aziendaId',
            type: 11,
            flags: 520,
            indexId: const IdUid(3, 6145414908728092047),
            relationTarget: 'Azienda'),
        ModelProperty(
            id: const IdUid(4, 1276631803658986642),
            name: 'referenteId',
            type: 11,
            flags: 520,
            indexId: const IdUid(4, 7821083838526575426),
            relationTarget: 'Referente')
      ],
      relations: <ModelRelation>[
        ModelRelation(
            id: const IdUid(5, 8105831970410159531),
            name: 'note',
            targetId: const IdUid(3, 1173462549094797954))
      ],
      backlinks: <ModelBacklink>[])
];

/// Open an ObjectBox store with the model declared in this file.
Future<Store> openStore(
        {String? directory,
        int? maxDBSizeInKB,
        int? fileMode,
        int? maxReaders,
        bool queriesCaseSensitiveDefault = true,
        String? macosApplicationGroup}) async =>
    Store(getObjectBoxModel(),
        directory: directory ?? (await defaultStoreDirectory()).path,
        maxDBSizeInKB: maxDBSizeInKB,
        fileMode: fileMode,
        maxReaders: maxReaders,
        queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
        macosApplicationGroup: macosApplicationGroup);

/// ObjectBox model definition, pass it to [Store] - Store(getObjectBoxModel())
ModelDefinition getObjectBoxModel() {
  final model = ModelInfo(
      entities: _entities,
      lastEntityId: const IdUid(5, 8602950264123820003),
      lastIndexId: const IdUid(4, 7821083838526575426),
      lastRelationId: const IdUid(5, 8105831970410159531),
      lastSequenceId: const IdUid(0, 0),
      retiredEntityUids: const [],
      retiredIndexUids: const [],
      retiredPropertyUids: const [],
      retiredRelationUids: const [],
      modelVersion: 5,
      modelVersionParserMinimum: 5,
      version: 1);

  final bindings = <Type, EntityDefinition>{
    Azienda: EntityDefinition<Azienda>(
        model: _entities[0],
        toOneRelations: (Azienda object) => [],
        toManyRelations: (Azienda object) => {
              RelInfo<Azienda>.toMany(1, object.id!): object.referenti,
              RelInfo<Azienda>.toMany(2, object.id!): object.reports,
              RelInfo<Azienda>.toMany(3, object.id!): object.events
            },
        getId: (Azienda object) => object.id,
        setId: (Azienda object, int id) {
          object.id = id;
        },
        objectToFB: (Azienda object, fb.Builder fbb) {
          final nomeOffset =
              object.nome == null ? null : fbb.writeString(object.nome!);
          final indirizzoOffset = object.indirizzo == null
              ? null
              : fbb.writeString(object.indirizzo!);
          final capOffset =
              object.cap == null ? null : fbb.writeString(object.cap!);
          final cittaOffset =
              object.citta == null ? null : fbb.writeString(object.citta!);
          final partitaIvaOffset = object.partitaIva == null
              ? null
              : fbb.writeString(object.partitaIva!);
          final codiceFiscaleOffset = object.codiceFiscale == null
              ? null
              : fbb.writeString(object.codiceFiscale!);
          fbb.startTable(10);
          fbb.addInt64(0, object.id ?? 0);
          fbb.addOffset(1, nomeOffset);
          fbb.addOffset(2, indirizzoOffset);
          fbb.addOffset(3, capOffset);
          fbb.addOffset(4, cittaOffset);
          fbb.addOffset(5, partitaIvaOffset);
          fbb.addOffset(6, codiceFiscaleOffset);
          fbb.addFloat64(7, object.lat);
          fbb.addFloat64(8, object.lng);
          fbb.finish(fbb.endTable());
          return object.id ?? 0;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Azienda(
              id: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 4),
              nome: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 6),
              indirizzo: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 8),
              cap: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 10),
              citta: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 12),
              partitaIva: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 14),
              codiceFiscale: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 16),
              lat: const fb.Float64Reader()
                  .vTableGetNullable(buffer, rootOffset, 18),
              lng: const fb.Float64Reader()
                  .vTableGetNullable(buffer, rootOffset, 20));
          InternalToManyAccess.setRelInfo(object.referenti, store,
              RelInfo<Azienda>.toMany(1, object.id!), store.box<Azienda>());
          InternalToManyAccess.setRelInfo(object.reports, store,
              RelInfo<Azienda>.toMany(2, object.id!), store.box<Azienda>());
          InternalToManyAccess.setRelInfo(object.events, store,
              RelInfo<Azienda>.toMany(3, object.id!), store.box<Azienda>());
          return object;
        }),
    Event: EntityDefinition<Event>(
        model: _entities[1],
        toOneRelations: (Event object) => [object.azienda, object.referente],
        toManyRelations: (Event object) => {},
        getId: (Event object) => object.id,
        setId: (Event object, int id) {
          object.id = id;
        },
        objectToFB: (Event object, fb.Builder fbb) {
          final descrizioneOffset = object.descrizione == null
              ? null
              : fbb.writeString(object.descrizione!);
          fbb.startTable(6);
          fbb.addInt64(0, object.id ?? 0);
          fbb.addInt64(1, object.date?.millisecondsSinceEpoch);
          fbb.addOffset(2, descrizioneOffset);
          fbb.addInt64(3, object.azienda.targetId);
          fbb.addInt64(4, object.referente.targetId);
          fbb.finish(fbb.endTable());
          return object.id ?? 0;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final dateValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 6);
          final object = Event()
            ..id =
                const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 4)
            ..date = dateValue == null
                ? null
                : DateTime.fromMillisecondsSinceEpoch(dateValue)
            ..descrizione = const fb.StringReader()
                .vTableGetNullable(buffer, rootOffset, 8);
          object.azienda.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 10, 0);
          object.azienda.attach(store);
          object.referente.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 12, 0);
          object.referente.attach(store);
          return object;
        }),
    Nota: EntityDefinition<Nota>(
        model: _entities[2],
        toOneRelations: (Nota object) => [],
        toManyRelations: (Nota object) => {},
        getId: (Nota object) => object.id,
        setId: (Nota object, int id) {
          object.id = id;
        },
        objectToFB: (Nota object, fb.Builder fbb) {
          final titoloOffset =
              object.titolo == null ? null : fbb.writeString(object.titolo!);
          final testoOffset =
              object.testo == null ? null : fbb.writeString(object.testo!);
          fbb.startTable(4);
          fbb.addInt64(0, object.id ?? 0);
          fbb.addOffset(1, titoloOffset);
          fbb.addOffset(2, testoOffset);
          fbb.finish(fbb.endTable());
          return object.id ?? 0;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Nota(
              id: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 4),
              titolo: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 6),
              testo: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 8));

          return object;
        }),
    Referente: EntityDefinition<Referente>(
        model: _entities[3],
        toOneRelations: (Referente object) => [],
        toManyRelations: (Referente object) =>
            {RelInfo<Referente>.toMany(4, object.id!): object.events},
        getId: (Referente object) => object.id,
        setId: (Referente object, int id) {
          object.id = id;
        },
        objectToFB: (Referente object, fb.Builder fbb) {
          final nomeOffset =
              object.nome == null ? null : fbb.writeString(object.nome!);
          final cognomeOffset =
              object.cognome == null ? null : fbb.writeString(object.cognome!);
          final ruoloOffset =
              object.ruolo == null ? null : fbb.writeString(object.ruolo!);
          final telefonoOffset = object.telefono == null
              ? null
              : fbb.writeString(object.telefono!);
          final emailOffset =
              object.email == null ? null : fbb.writeString(object.email!);
          fbb.startTable(8);
          fbb.addInt64(0, object.id ?? 0);
          fbb.addOffset(1, nomeOffset);
          fbb.addOffset(2, cognomeOffset);
          fbb.addOffset(3, ruoloOffset);
          fbb.addOffset(4, telefonoOffset);
          fbb.addOffset(5, emailOffset);
          fbb.addFloat64(6, object.lng);
          fbb.finish(fbb.endTable());
          return object.id ?? 0;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Referente(
              id: const fb.Int64Reader()
                  .vTableGetNullable(buffer, rootOffset, 4),
              nome: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 6),
              cognome: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 8),
              ruolo: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 10),
              telefono: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 12),
              email: const fb.StringReader()
                  .vTableGetNullable(buffer, rootOffset, 14))
            ..lng = const fb.Float64Reader()
                .vTableGetNullable(buffer, rootOffset, 16);
          InternalToManyAccess.setRelInfo(object.events, store,
              RelInfo<Referente>.toMany(4, object.id!), store.box<Referente>());
          return object;
        }),
    Report: EntityDefinition<Report>(
        model: _entities[4],
        toOneRelations: (Report object) => [object.azienda, object.referente],
        toManyRelations: (Report object) =>
            {RelInfo<Report>.toMany(5, object.id!): object.note},
        getId: (Report object) => object.id,
        setId: (Report object, int id) {
          object.id = id;
        },
        objectToFB: (Report object, fb.Builder fbb) {
          final configurationJsonOffset = object.configurationJson == null
              ? null
              : fbb.writeString(object.configurationJson!);
          fbb.startTable(5);
          fbb.addInt64(0, object.id ?? 0);
          fbb.addOffset(1, configurationJsonOffset);
          fbb.addInt64(2, object.azienda.targetId);
          fbb.addInt64(3, object.referente.targetId);
          fbb.finish(fbb.endTable());
          return object.id ?? 0;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Report()
            ..id =
                const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 4)
            ..configurationJson = const fb.StringReader()
                .vTableGetNullable(buffer, rootOffset, 6);
          object.azienda.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 8, 0);
          object.azienda.attach(store);
          object.referente.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 10, 0);
          object.referente.attach(store);
          InternalToManyAccess.setRelInfo(object.note, store,
              RelInfo<Report>.toMany(5, object.id!), store.box<Report>());
          return object;
        })
  };

  return ModelDefinition(model, bindings);
}

/// [Azienda] entity fields to define ObjectBox queries.
class Azienda_ {
  /// see [Azienda.id]
  static final id = QueryIntegerProperty<Azienda>(_entities[0].properties[0]);

  /// see [Azienda.nome]
  static final nome = QueryStringProperty<Azienda>(_entities[0].properties[1]);

  /// see [Azienda.indirizzo]
  static final indirizzo =
      QueryStringProperty<Azienda>(_entities[0].properties[2]);

  /// see [Azienda.cap]
  static final cap = QueryStringProperty<Azienda>(_entities[0].properties[3]);

  /// see [Azienda.citta]
  static final citta = QueryStringProperty<Azienda>(_entities[0].properties[4]);

  /// see [Azienda.partitaIva]
  static final partitaIva =
      QueryStringProperty<Azienda>(_entities[0].properties[5]);

  /// see [Azienda.codiceFiscale]
  static final codiceFiscale =
      QueryStringProperty<Azienda>(_entities[0].properties[6]);

  /// see [Azienda.lat]
  static final lat = QueryDoubleProperty<Azienda>(_entities[0].properties[7]);

  /// see [Azienda.lng]
  static final lng = QueryDoubleProperty<Azienda>(_entities[0].properties[8]);

  /// see [Azienda.referenti]
  static final referenti =
      QueryRelationToMany<Azienda, Referente>(_entities[0].relations[0]);

  /// see [Azienda.reports]
  static final reports =
      QueryRelationToMany<Azienda, Report>(_entities[0].relations[1]);

  /// see [Azienda.events]
  static final events =
      QueryRelationToMany<Azienda, Event>(_entities[0].relations[2]);
}

/// [Event] entity fields to define ObjectBox queries.
class Event_ {
  /// see [Event.id]
  static final id = QueryIntegerProperty<Event>(_entities[1].properties[0]);

  /// see [Event.date]
  static final date = QueryIntegerProperty<Event>(_entities[1].properties[1]);

  /// see [Event.descrizione]
  static final descrizione =
      QueryStringProperty<Event>(_entities[1].properties[2]);

  /// see [Event.azienda]
  static final azienda =
      QueryRelationToOne<Event, Azienda>(_entities[1].properties[3]);

  /// see [Event.referente]
  static final referente =
      QueryRelationToOne<Event, Referente>(_entities[1].properties[4]);
}

/// [Nota] entity fields to define ObjectBox queries.
class Nota_ {
  /// see [Nota.id]
  static final id = QueryIntegerProperty<Nota>(_entities[2].properties[0]);

  /// see [Nota.titolo]
  static final titolo = QueryStringProperty<Nota>(_entities[2].properties[1]);

  /// see [Nota.testo]
  static final testo = QueryStringProperty<Nota>(_entities[2].properties[2]);
}

/// [Referente] entity fields to define ObjectBox queries.
class Referente_ {
  /// see [Referente.id]
  static final id = QueryIntegerProperty<Referente>(_entities[3].properties[0]);

  /// see [Referente.nome]
  static final nome =
      QueryStringProperty<Referente>(_entities[3].properties[1]);

  /// see [Referente.cognome]
  static final cognome =
      QueryStringProperty<Referente>(_entities[3].properties[2]);

  /// see [Referente.ruolo]
  static final ruolo =
      QueryStringProperty<Referente>(_entities[3].properties[3]);

  /// see [Referente.telefono]
  static final telefono =
      QueryStringProperty<Referente>(_entities[3].properties[4]);

  /// see [Referente.email]
  static final email =
      QueryStringProperty<Referente>(_entities[3].properties[5]);

  /// see [Referente.lng]
  static final lng = QueryDoubleProperty<Referente>(_entities[3].properties[6]);

  /// see [Referente.events]
  static final events =
      QueryRelationToMany<Referente, Event>(_entities[3].relations[0]);
}

/// [Report] entity fields to define ObjectBox queries.
class Report_ {
  /// see [Report.id]
  static final id = QueryIntegerProperty<Report>(_entities[4].properties[0]);

  /// see [Report.configurationJson]
  static final configurationJson =
      QueryStringProperty<Report>(_entities[4].properties[1]);

  /// see [Report.azienda]
  static final azienda =
      QueryRelationToOne<Report, Azienda>(_entities[4].properties[2]);

  /// see [Report.referente]
  static final referente =
      QueryRelationToOne<Report, Referente>(_entities[4].properties[3]);

  /// see [Report.note]
  static final note =
      QueryRelationToMany<Report, Nota>(_entities[4].relations[0]);
}
