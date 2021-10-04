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
      id: const IdUid(1, 8460234860715438408),
      name: 'Azienda',
      lastPropertyId: const IdUid(10, 3574540353529118309),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 7808108765268025182),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 7974233072808858153),
            name: 'nome',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 7596696256123044276),
            name: 'indirizzo',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 5340825892269844003),
            name: 'cap',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 1790211398887102549),
            name: 'citta',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 3018968991148458212),
            name: 'partitaIva',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 6597458789409012988),
            name: 'codiceFiscale',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 6792923101365665855),
            name: 'lat',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(9, 5371245810450206642),
            name: 'lng',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(10, 3574540353529118309),
            name: 'renderKey',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[
        ModelRelation(
            id: const IdUid(1, 7816065985264809267),
            name: 'referenti',
            targetId: const IdUid(4, 8317230939662089217)),
        ModelRelation(
            id: const IdUid(2, 2683811393994220662),
            name: 'reports',
            targetId: const IdUid(5, 5482550158823569927)),
        ModelRelation(
            id: const IdUid(3, 3563601081454117575),
            name: 'events',
            targetId: const IdUid(2, 7897695579554558223))
      ],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(2, 7897695579554558223),
      name: 'Event',
      lastPropertyId: const IdUid(5, 6629519680951903219),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 7520895260367860385),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 924415528375980991),
            name: 'date',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 3372484252157164723),
            name: 'descrizione',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 9053317680352321450),
            name: 'aziendaId',
            type: 11,
            flags: 520,
            indexId: const IdUid(1, 965388715842789542),
            relationTarget: 'Azienda'),
        ModelProperty(
            id: const IdUid(5, 6629519680951903219),
            name: 'referenteId',
            type: 11,
            flags: 520,
            indexId: const IdUid(2, 6497295642343522316),
            relationTarget: 'Referente')
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(3, 164068517067656528),
      name: 'Nota',
      lastPropertyId: const IdUid(3, 5032708557379852664),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 1525777481681704206),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 6414245078746456117),
            name: 'titolo',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 5032708557379852664),
            name: 'testo',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(4, 8317230939662089217),
      name: 'Referente',
      lastPropertyId: const IdUid(7, 4031844865372382246),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 2800621579793915429),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 1041454870545477114),
            name: 'nome',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 3878008086786633539),
            name: 'cognome',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 8831013091349465548),
            name: 'ruolo',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 7858702449189039043),
            name: 'telefono',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 3207493360725824270),
            name: 'email',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 4031844865372382246),
            name: 'lng',
            type: 8,
            flags: 0)
      ],
      relations: <ModelRelation>[
        ModelRelation(
            id: const IdUid(4, 3776478613251764546),
            name: 'events',
            targetId: const IdUid(2, 7897695579554558223))
      ],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(5, 5482550158823569927),
      name: 'Report',
      lastPropertyId: const IdUid(6, 8119780012927646051),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 5345383412897643111),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 3504715279921915442),
            name: 'configurationJson',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 3718252479862676441),
            name: 'compilazione',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 8405597467589901663),
            name: 'prossimaVisita',
            type: 10,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 3759103972366318202),
            name: 'aziendaId',
            type: 11,
            flags: 520,
            indexId: const IdUid(3, 1875447252864094183),
            relationTarget: 'Azienda'),
        ModelProperty(
            id: const IdUid(6, 8119780012927646051),
            name: 'referenteId',
            type: 11,
            flags: 520,
            indexId: const IdUid(4, 159630822753411865),
            relationTarget: 'Referente')
      ],
      relations: <ModelRelation>[
        ModelRelation(
            id: const IdUid(5, 1990751358072285223),
            name: 'note',
            targetId: const IdUid(3, 164068517067656528))
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
      lastEntityId: const IdUid(5, 5482550158823569927),
      lastIndexId: const IdUid(4, 159630822753411865),
      lastRelationId: const IdUid(5, 1990751358072285223),
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
          fbb.startTable(7);
          fbb.addInt64(0, object.id ?? 0);
          fbb.addOffset(1, configurationJsonOffset);
          fbb.addInt64(2, object.compilazione?.millisecondsSinceEpoch);
          fbb.addInt64(3, object.prossimaVisita?.millisecondsSinceEpoch);
          fbb.addInt64(4, object.azienda.targetId);
          fbb.addInt64(5, object.referente.targetId);
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
          object.referente.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 14, 0);
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

  /// see [Azienda.renderKey]
  static final renderKey =
      QueryStringProperty<Azienda>(_entities[0].properties[9]);

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
      QueryRelationToOne<Report, Referente>(_entities[4].properties[5]);

  /// see [Report.note]
  static final note =
      QueryRelationToMany<Report, Nota>(_entities[4].relations[0]);
}
