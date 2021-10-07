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
      id: const IdUid(1, 7680391318172929617),
      name: 'Azienda',
      lastPropertyId: const IdUid(10, 8916914568439692031),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 4251973141094445378),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 9113671131925970057),
            name: 'nome',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 1605146872390469641),
            name: 'indirizzo',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 233115652319760780),
            name: 'cap',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 7019725277862164034),
            name: 'citta',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 8467371171069459758),
            name: 'partitaIva',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 6840011190013759796),
            name: 'codiceFiscale',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 146442061210388558),
            name: 'lat',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(9, 7059998843745818455),
            name: 'lng',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(10, 8916914568439692031),
            name: 'renderKey',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[
        ModelBacklink(name: 'referenti', srcEntity: 'Referente', srcField: ''),
        ModelBacklink(name: 'reports', srcEntity: 'Report', srcField: ''),
        ModelBacklink(name: 'events', srcEntity: 'Event', srcField: '')
      ]),
  ModelEntity(
      id: const IdUid(2, 5953336626248704928),
      name: 'Event',
      lastPropertyId: const IdUid(4, 6171730511282965482),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 4007721547883438717),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 4690951266521953618),
            name: 'date',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 4937564314507903129),
            name: 'descrizione',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 6171730511282965482),
            name: 'aziendaId',
            type: 11,
            flags: 520,
            indexId: const IdUid(1, 6239286463158365392),
            relationTarget: 'Azienda')
      ],
      relations: <ModelRelation>[
        ModelRelation(
            id: const IdUid(1, 7404641149566312458),
            name: 'referente',
            targetId: const IdUid(4, 7151926937552982657))
      ],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(3, 4311911329912121033),
      name: 'Nota',
      lastPropertyId: const IdUid(3, 7448987757746992852),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 3205647782247511021),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 4210989929080814206),
            name: 'titolo',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 7448987757746992852),
            name: 'testo',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(4, 7151926937552982657),
      name: 'Referente',
      lastPropertyId: const IdUid(8, 715802498592503400),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 2956486295006565917),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 7984525061348748492),
            name: 'nome',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 5063340341344372883),
            name: 'cognome',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 5248427982577134333),
            name: 'ruolo',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 2231873890095241133),
            name: 'telefono',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 6915798299052527530),
            name: 'email',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 8045678100845258381),
            name: 'lng',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 715802498592503400),
            name: 'aziendaId',
            type: 11,
            flags: 520,
            indexId: const IdUid(2, 4349831053801725827),
            relationTarget: 'Azienda')
      ],
      relations: <ModelRelation>[
        ModelRelation(
            id: const IdUid(2, 1127125399291987263),
            name: 'events',
            targetId: const IdUid(2, 5953336626248704928))
      ],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(5, 3340527064996842485),
      name: 'Report',
      lastPropertyId: const IdUid(5, 999915125360666004),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 3222029855715634254),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 1085152779943139338),
            name: 'configurationJson',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 5268945991684943812),
            name: 'compilazione',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 7491829105962668215),
            name: 'prossimaVisita',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 999915125360666004),
            name: 'aziendaId',
            type: 11,
            flags: 520,
            indexId: const IdUid(3, 3200128813239925040),
            relationTarget: 'Azienda')
      ],
      relations: <ModelRelation>[
        ModelRelation(
            id: const IdUid(3, 2002548762732762643),
            name: 'referente',
            targetId: const IdUid(4, 7151926937552982657)),
        ModelRelation(
            id: const IdUid(4, 462586827835209344),
            name: 'note',
            targetId: const IdUid(3, 4311911329912121033))
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
      lastEntityId: const IdUid(5, 3340527064996842485),
      lastIndexId: const IdUid(3, 3200128813239925040),
      lastRelationId: const IdUid(4, 462586827835209344),
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
              RelInfo<Referente>.toOneBacklink(8, object.id!,
                  (Referente srcObject) => srcObject.azienda): object.referenti,
              RelInfo<Report>.toOneBacklink(
                      5, object.id!, (Report srcObject) => srcObject.azienda):
                  object.reports,
              RelInfo<Event>.toOneBacklink(
                      4, object.id!, (Event srcObject) => srcObject.azienda):
                  object.events
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
          final renderKeyOffset = object.renderKey == null
              ? null
              : fbb.writeString(object.renderKey!);
          fbb.startTable(11);
          fbb.addInt64(0, object.id ?? 0);
          fbb.addOffset(1, nomeOffset);
          fbb.addOffset(2, indirizzoOffset);
          fbb.addOffset(3, capOffset);
          fbb.addOffset(4, cittaOffset);
          fbb.addOffset(5, partitaIvaOffset);
          fbb.addOffset(6, codiceFiscaleOffset);
          fbb.addFloat64(7, object.lat);
          fbb.addFloat64(8, object.lng);
          fbb.addOffset(9, renderKeyOffset);
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
                  .vTableGetNullable(buffer, rootOffset, 20))
            ..renderKey = const fb.StringReader()
                .vTableGetNullable(buffer, rootOffset, 22);
          InternalToManyAccess.setRelInfo(
              object.referenti,
              store,
              RelInfo<Referente>.toOneBacklink(
                  8, object.id!, (Referente srcObject) => srcObject.azienda),
              store.box<Azienda>());
          InternalToManyAccess.setRelInfo(
              object.reports,
              store,
              RelInfo<Report>.toOneBacklink(
                  5, object.id!, (Report srcObject) => srcObject.azienda),
              store.box<Azienda>());
          InternalToManyAccess.setRelInfo(
              object.events,
              store,
              RelInfo<Event>.toOneBacklink(
                  4, object.id!, (Event srcObject) => srcObject.azienda),
              store.box<Azienda>());
          return object;
        }),
    Event: EntityDefinition<Event>(
        model: _entities[1],
        toOneRelations: (Event object) => [object.azienda],
        toManyRelations: (Event object) =>
            {RelInfo<Event>.toMany(1, object.id!): object.referente},
        getId: (Event object) => object.id,
        setId: (Event object, int id) {
          object.id = id;
        },
        objectToFB: (Event object, fb.Builder fbb) {
          final descrizioneOffset = object.descrizione == null
              ? null
              : fbb.writeString(object.descrizione!);
          fbb.startTable(5);
          fbb.addInt64(0, object.id ?? 0);
          fbb.addInt64(1, object.date?.millisecondsSinceEpoch);
          fbb.addOffset(2, descrizioneOffset);
          fbb.addInt64(3, object.azienda.targetId);
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
          InternalToManyAccess.setRelInfo(object.referente, store,
              RelInfo<Event>.toMany(1, object.id!), store.box<Event>());
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
        toOneRelations: (Referente object) => [object.azienda],
        toManyRelations: (Referente object) =>
            {RelInfo<Referente>.toMany(2, object.id!): object.events},
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
          fbb.startTable(9);
          fbb.addInt64(0, object.id ?? 0);
          fbb.addOffset(1, nomeOffset);
          fbb.addOffset(2, cognomeOffset);
          fbb.addOffset(3, ruoloOffset);
          fbb.addOffset(4, telefonoOffset);
          fbb.addOffset(5, emailOffset);
          fbb.addFloat64(6, object.lng);
          fbb.addInt64(7, object.azienda.targetId);
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
          object.azienda.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 18, 0);
          object.azienda.attach(store);
          InternalToManyAccess.setRelInfo(object.events, store,
              RelInfo<Referente>.toMany(2, object.id!), store.box<Referente>());
          return object;
        }),
    Report: EntityDefinition<Report>(
        model: _entities[4],
        toOneRelations: (Report object) => [object.azienda],
        toManyRelations: (Report object) => {
              RelInfo<Report>.toMany(3, object.id!): object.referente,
              RelInfo<Report>.toMany(4, object.id!): object.note
            },
        getId: (Report object) => object.id,
        setId: (Report object, int id) {
          object.id = id;
        },
        objectToFB: (Report object, fb.Builder fbb) {
          final configurationJsonOffset = object.configurationJson == null
              ? null
              : fbb.writeString(object.configurationJson!);
          fbb.startTable(6);
          fbb.addInt64(0, object.id ?? 0);
          fbb.addOffset(1, configurationJsonOffset);
          fbb.addInt64(2, object.compilazione?.millisecondsSinceEpoch);
          fbb.addInt64(3, object.prossimaVisita?.millisecondsSinceEpoch);
          fbb.addInt64(4, object.azienda.targetId);
          fbb.finish(fbb.endTable());
          return object.id ?? 0;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);
          final compilazioneValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 8);
          final prossimaVisitaValue =
              const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 10);
          final object = Report()
            ..id =
                const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 4)
            ..configurationJson =
                const fb.StringReader().vTableGetNullable(buffer, rootOffset, 6)
            ..compilazione = compilazioneValue == null
                ? null
                : DateTime.fromMillisecondsSinceEpoch(compilazioneValue)
            ..prossimaVisita = prossimaVisitaValue == null
                ? null
                : DateTime.fromMillisecondsSinceEpoch(prossimaVisitaValue);
          object.azienda.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 12, 0);
          object.azienda.attach(store);
          InternalToManyAccess.setRelInfo(object.referente, store,
              RelInfo<Report>.toMany(3, object.id!), store.box<Report>());
          InternalToManyAccess.setRelInfo(object.note, store,
              RelInfo<Report>.toMany(4, object.id!), store.box<Report>());
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

  /// see [Azienda.renderKey]
  static final renderKey =
      QueryStringProperty<Azienda>(_entities[0].properties[9]);
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
      QueryRelationToMany<Event, Referente>(_entities[1].relations[0]);
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

  /// see [Referente.azienda]
  static final azienda =
      QueryRelationToOne<Referente, Azienda>(_entities[3].properties[7]);

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

  /// see [Report.compilazione]
  static final compilazione =
      QueryIntegerProperty<Report>(_entities[4].properties[2]);

  /// see [Report.prossimaVisita]
  static final prossimaVisita =
      QueryIntegerProperty<Report>(_entities[4].properties[3]);

  /// see [Report.azienda]
  static final azienda =
      QueryRelationToOne<Report, Azienda>(_entities[4].properties[4]);

  /// see [Report.referente]
  static final referente =
      QueryRelationToMany<Report, Referente>(_entities[4].relations[0]);

  /// see [Report.note]
  static final note =
      QueryRelationToMany<Report, Nota>(_entities[4].relations[1]);
}
