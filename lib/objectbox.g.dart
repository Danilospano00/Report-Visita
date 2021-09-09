// GENERATED CODE - DO NOT MODIFY BY HAND

// ignore_for_file: camel_case_types

import 'dart:typed_data';

import 'package:objectbox/flatbuffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart';
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'Models/Azienda.dart';
import 'Models/Nota.dart';
import 'Models/Referente.dart';
import 'Models/Report.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <ModelEntity>[
  ModelEntity(
      id: const IdUid(1, 3138899131742898812),
      name: 'Azienda',
      lastPropertyId: const IdUid(9, 5279237058025492374),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 5551351502668826253),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 2889104212203136962),
            name: 'nome',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 2613881134958763434),
            name: 'indirizzo',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 7327450284482912913),
            name: 'cap',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 7494618641111035513),
            name: 'citta',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 8275051880509170183),
            name: 'partitaIva',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 6830332390664123324),
            name: 'codiceFiscale',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(8, 5392407183097939609),
            name: 'lat',
            type: 8,
            flags: 0),
        ModelProperty(
            id: const IdUid(9, 5279237058025492374),
            name: 'lng',
            type: 8,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(2, 9010118104071840998),
      name: 'Nota',
      lastPropertyId: const IdUid(3, 1275198843792946196),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 6771886556609393582),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 4977382038095430839),
            name: 'titolo',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 1275198843792946196),
            name: 'testo',
            type: 9,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(3, 1724050477393436024),
      name: 'Referente',
      lastPropertyId: const IdUid(7, 2380123224548529367),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 2749362504261456340),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 614674080790275592),
            name: 'nome',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(3, 4744237264499700664),
            name: 'cognome',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(4, 2939920344380470164),
            name: 'ruolo',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(5, 1465063992318852548),
            name: 'telefono',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(6, 3943749822707307598),
            name: 'email',
            type: 9,
            flags: 0),
        ModelProperty(
            id: const IdUid(7, 2380123224548529367),
            name: 'lng',
            type: 8,
            flags: 0)
      ],
      relations: <ModelRelation>[],
      backlinks: <ModelBacklink>[]),
  ModelEntity(
      id: const IdUid(4, 6399944043336873268),
      name: 'Report',
      lastPropertyId: const IdUid(3, 7371815368849573335),
      flags: 0,
      properties: <ModelProperty>[
        ModelProperty(
            id: const IdUid(1, 2695679673933592744),
            name: 'id',
            type: 6,
            flags: 1),
        ModelProperty(
            id: const IdUid(2, 2167568013007333385),
            name: 'aziendaId',
            type: 11,
            flags: 520,
            indexId: const IdUid(1, 7175251592518024657),
            relationTarget: 'Azienda'),
        ModelProperty(
            id: const IdUid(3, 7371815368849573335),
            name: 'referenteId',
            type: 11,
            flags: 520,
            indexId: const IdUid(2, 1194400844658538239),
            relationTarget: 'Referente')
      ],
      relations: <ModelRelation>[
        ModelRelation(
            id: const IdUid(1, 1145918004155875744),
            name: 'note',
            targetId: const IdUid(2, 9010118104071840998))
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
      lastEntityId: const IdUid(4, 6399944043336873268),
      lastIndexId: const IdUid(2, 1194400844658538239),
      lastRelationId: const IdUid(1, 1145918004155875744),
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
        toManyRelations: (Azienda object) => {},
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

          return object;
        }),
    Nota: EntityDefinition<Nota>(
        model: _entities[1],
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
        model: _entities[2],
        toOneRelations: (Referente object) => [],
        toManyRelations: (Referente object) => {},
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

          return object;
        }),
    Report: EntityDefinition<Report>(
        model: _entities[3],
        toOneRelations: (Report object) => [object.azienda, object.referente],
        toManyRelations: (Report object) =>
            {RelInfo<Report>.toMany(1, object.id!): object.note},
        getId: (Report object) => object.id,
        setId: (Report object, int id) {
          object.id = id;
        },
        objectToFB: (Report object, fb.Builder fbb) {
          fbb.startTable(4);
          fbb.addInt64(0, object.id ?? 0);
          fbb.addInt64(1, object.azienda.targetId);
          fbb.addInt64(2, object.referente.targetId);
          fbb.finish(fbb.endTable());
          return object.id ?? 0;
        },
        objectFromFB: (Store store, ByteData fbData) {
          final buffer = fb.BufferContext(fbData);
          final rootOffset = buffer.derefObject(0);

          final object = Report()
            ..id =
                const fb.Int64Reader().vTableGetNullable(buffer, rootOffset, 4);
          object.azienda.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 6, 0);
          object.azienda.attach(store);
          object.referente.targetId =
              const fb.Int64Reader().vTableGet(buffer, rootOffset, 8, 0);
          object.referente.attach(store);
          InternalToManyAccess.setRelInfo(object.note, store,
              RelInfo<Report>.toMany(1, object.id!), store.box<Report>());
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
}

/// [Nota] entity fields to define ObjectBox queries.
class Nota_ {
  /// see [Nota.id]
  static final id = QueryIntegerProperty<Nota>(_entities[1].properties[0]);

  /// see [Nota.titolo]
  static final titolo = QueryStringProperty<Nota>(_entities[1].properties[1]);

  /// see [Nota.testo]
  static final testo = QueryStringProperty<Nota>(_entities[1].properties[2]);
}

/// [Referente] entity fields to define ObjectBox queries.
class Referente_ {
  /// see [Referente.id]
  static final id = QueryIntegerProperty<Referente>(_entities[2].properties[0]);

  /// see [Referente.nome]
  static final nome =
      QueryStringProperty<Referente>(_entities[2].properties[1]);

  /// see [Referente.cognome]
  static final cognome =
      QueryStringProperty<Referente>(_entities[2].properties[2]);

  /// see [Referente.ruolo]
  static final ruolo =
      QueryStringProperty<Referente>(_entities[2].properties[3]);

  /// see [Referente.telefono]
  static final telefono =
      QueryStringProperty<Referente>(_entities[2].properties[4]);

  /// see [Referente.email]
  static final email =
      QueryStringProperty<Referente>(_entities[2].properties[5]);

  /// see [Referente.lng]
  static final lng = QueryDoubleProperty<Referente>(_entities[2].properties[6]);
}

/// [Report] entity fields to define ObjectBox queries.
class Report_ {
  /// see [Report.id]
  static final id = QueryIntegerProperty<Report>(_entities[3].properties[0]);

  /// see [Report.azienda]
  static final azienda =
      QueryRelationToOne<Report, Azienda>(_entities[3].properties[1]);

  /// see [Report.referente]
  static final referente =
      QueryRelationToOne<Report, Referente>(_entities[3].properties[2]);

  /// see [Report.note]
  static final note =
      QueryRelationToMany<Report, Nota>(_entities[3].relations[0]);
}
