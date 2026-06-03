// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pomodoro_session_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPomodoroSessionModelCollection on Isar {
  IsarCollection<PomodoroSessionModel> get pomodoroSessionModels =>
      this.collection();
}

const PomodoroSessionModelSchema = CollectionSchema(
  name: r'PomodoroSessionModel',
  id: -4261804283330556400,
  properties: {
    r'actualDurationMinutes': PropertySchema(
      id: 0,
      name: r'actualDurationMinutes',
      type: IsarType.long,
    ),
    r'actualDurationSeconds': PropertySchema(
      id: 1,
      name: r'actualDurationSeconds',
      type: IsarType.long,
    ),
    r'completionRatio': PropertySchema(
      id: 2,
      name: r'completionRatio',
      type: IsarType.double,
    ),
    r'distractionCount': PropertySchema(
      id: 3,
      name: r'distractionCount',
      type: IsarType.long,
    ),
    r'endedAt': PropertySchema(
      id: 4,
      name: r'endedAt',
      type: IsarType.dateTime,
    ),
    r'isCompleted': PropertySchema(
      id: 5,
      name: r'isCompleted',
      type: IsarType.bool,
    ),
    r'localDateKey': PropertySchema(
      id: 6,
      name: r'localDateKey',
      type: IsarType.string,
    ),
    r'mode': PropertySchema(
      id: 7,
      name: r'mode',
      type: IsarType.byte,
      enumMap: _PomodoroSessionModelmodeEnumValueMap,
    ),
    r'notes': PropertySchema(
      id: 8,
      name: r'notes',
      type: IsarType.string,
    ),
    r'pauseCount': PropertySchema(
      id: 9,
      name: r'pauseCount',
      type: IsarType.long,
    ),
    r'plannedDurationSeconds': PropertySchema(
      id: 10,
      name: r'plannedDurationSeconds',
      type: IsarType.long,
    ),
    r'startedAt': PropertySchema(
      id: 11,
      name: r'startedAt',
      type: IsarType.dateTime,
    ),
    r'status': PropertySchema(
      id: 12,
      name: r'status',
      type: IsarType.byte,
      enumMap: _PomodoroSessionModelstatusEnumValueMap,
    ),
    r'subjectId': PropertySchema(
      id: 13,
      name: r'subjectId',
      type: IsarType.string,
    ),
    r'taskId': PropertySchema(
      id: 14,
      name: r'taskId',
      type: IsarType.string,
    ),
    r'totalPausedSeconds': PropertySchema(
      id: 15,
      name: r'totalPausedSeconds',
      type: IsarType.long,
    ),
    r'uuid': PropertySchema(
      id: 16,
      name: r'uuid',
      type: IsarType.string,
    )
  },
  estimateSize: _pomodoroSessionModelEstimateSize,
  serialize: _pomodoroSessionModelSerialize,
  deserialize: _pomodoroSessionModelDeserialize,
  deserializeProp: _pomodoroSessionModelDeserializeProp,
  idName: r'id',
  indexes: {
    r'uuid': IndexSchema(
      id: 2134397340427724972,
      name: r'uuid',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'uuid',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'subjectId': IndexSchema(
      id: 440306668014799972,
      name: r'subjectId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'subjectId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'taskId': IndexSchema(
      id: -6391211041487498726,
      name: r'taskId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'taskId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'startedAt': IndexSchema(
      id: 8114395319341636597,
      name: r'startedAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'startedAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'localDateKey': IndexSchema(
      id: -4285120956082274571,
      name: r'localDateKey',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'localDateKey',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _pomodoroSessionModelGetId,
  getLinks: _pomodoroSessionModelGetLinks,
  attach: _pomodoroSessionModelAttach,
  version: '3.1.0+1',
);

int _pomodoroSessionModelEstimateSize(
  PomodoroSessionModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.localDateKey.length * 3;
  bytesCount += 3 + object.notes.length * 3;
  bytesCount += 3 + object.subjectId.length * 3;
  bytesCount += 3 + object.taskId.length * 3;
  bytesCount += 3 + object.uuid.length * 3;
  return bytesCount;
}

void _pomodoroSessionModelSerialize(
  PomodoroSessionModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.actualDurationMinutes);
  writer.writeLong(offsets[1], object.actualDurationSeconds);
  writer.writeDouble(offsets[2], object.completionRatio);
  writer.writeLong(offsets[3], object.distractionCount);
  writer.writeDateTime(offsets[4], object.endedAt);
  writer.writeBool(offsets[5], object.isCompleted);
  writer.writeString(offsets[6], object.localDateKey);
  writer.writeByte(offsets[7], object.mode.index);
  writer.writeString(offsets[8], object.notes);
  writer.writeLong(offsets[9], object.pauseCount);
  writer.writeLong(offsets[10], object.plannedDurationSeconds);
  writer.writeDateTime(offsets[11], object.startedAt);
  writer.writeByte(offsets[12], object.status.index);
  writer.writeString(offsets[13], object.subjectId);
  writer.writeString(offsets[14], object.taskId);
  writer.writeLong(offsets[15], object.totalPausedSeconds);
  writer.writeString(offsets[16], object.uuid);
}

PomodoroSessionModel _pomodoroSessionModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = PomodoroSessionModel(
    actualDurationSeconds: reader.readLongOrNull(offsets[1]) ?? 0,
    distractionCount: reader.readLongOrNull(offsets[3]) ?? 0,
    endedAt: reader.readDateTimeOrNull(offsets[4]),
    id: id,
    localDateKey: reader.readStringOrNull(offsets[6]) ?? '',
    mode: _PomodoroSessionModelmodeValueEnumMap[
            reader.readByteOrNull(offsets[7])] ??
        PomodoroMode.pomodoro,
    notes: reader.readStringOrNull(offsets[8]) ?? '',
    pauseCount: reader.readLongOrNull(offsets[9]) ?? 0,
    plannedDurationSeconds: reader.readLongOrNull(offsets[10]) ?? 1500,
    startedAt: reader.readDateTimeOrNull(offsets[11]),
    status: _PomodoroSessionModelstatusValueEnumMap[
            reader.readByteOrNull(offsets[12])] ??
        SessionStatus.completed,
    subjectId: reader.readStringOrNull(offsets[13]) ?? '',
    taskId: reader.readStringOrNull(offsets[14]) ?? '',
    totalPausedSeconds: reader.readLongOrNull(offsets[15]) ?? 0,
    uuid: reader.readStringOrNull(offsets[16]) ?? '',
  );
  return object;
}

P _pomodoroSessionModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLong(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 2:
      return (reader.readDouble(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 4:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 5:
      return (reader.readBool(offset)) as P;
    case 6:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 7:
      return (_PomodoroSessionModelmodeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          PomodoroMode.pomodoro) as P;
    case 8:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 9:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 10:
      return (reader.readLongOrNull(offset) ?? 1500) as P;
    case 11:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 12:
      return (_PomodoroSessionModelstatusValueEnumMap[
              reader.readByteOrNull(offset)] ??
          SessionStatus.completed) as P;
    case 13:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 14:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 15:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 16:
      return (reader.readStringOrNull(offset) ?? '') as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _PomodoroSessionModelmodeEnumValueMap = {
  'pomodoro': 0,
  'shortBreak': 1,
  'longBreak': 2,
  'deepWork': 3,
};
const _PomodoroSessionModelmodeValueEnumMap = {
  0: PomodoroMode.pomodoro,
  1: PomodoroMode.shortBreak,
  2: PomodoroMode.longBreak,
  3: PomodoroMode.deepWork,
};
const _PomodoroSessionModelstatusEnumValueMap = {
  'completed': 0,
  'abandoned': 1,
  'paused': 2,
};
const _PomodoroSessionModelstatusValueEnumMap = {
  0: SessionStatus.completed,
  1: SessionStatus.abandoned,
  2: SessionStatus.paused,
};

Id _pomodoroSessionModelGetId(PomodoroSessionModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _pomodoroSessionModelGetLinks(
    PomodoroSessionModel object) {
  return [];
}

void _pomodoroSessionModelAttach(
    IsarCollection<dynamic> col, Id id, PomodoroSessionModel object) {
  object.id = id;
}

extension PomodoroSessionModelByIndex on IsarCollection<PomodoroSessionModel> {
  Future<PomodoroSessionModel?> getByUuid(String uuid) {
    return getByIndex(r'uuid', [uuid]);
  }

  PomodoroSessionModel? getByUuidSync(String uuid) {
    return getByIndexSync(r'uuid', [uuid]);
  }

  Future<bool> deleteByUuid(String uuid) {
    return deleteByIndex(r'uuid', [uuid]);
  }

  bool deleteByUuidSync(String uuid) {
    return deleteByIndexSync(r'uuid', [uuid]);
  }

  Future<List<PomodoroSessionModel?>> getAllByUuid(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndex(r'uuid', values);
  }

  List<PomodoroSessionModel?> getAllByUuidSync(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'uuid', values);
  }

  Future<int> deleteAllByUuid(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'uuid', values);
  }

  int deleteAllByUuidSync(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'uuid', values);
  }

  Future<Id> putByUuid(PomodoroSessionModel object) {
    return putByIndex(r'uuid', object);
  }

  Id putByUuidSync(PomodoroSessionModel object, {bool saveLinks = true}) {
    return putByIndexSync(r'uuid', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUuid(List<PomodoroSessionModel> objects) {
    return putAllByIndex(r'uuid', objects);
  }

  List<Id> putAllByUuidSync(List<PomodoroSessionModel> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'uuid', objects, saveLinks: saveLinks);
  }
}

extension PomodoroSessionModelQueryWhereSort
    on QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QWhere> {
  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterWhere>
      anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterWhere>
      anyStartedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'startedAt'),
      );
    });
  }
}

extension PomodoroSessionModelQueryWhere
    on QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QWhereClause> {
  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterWhereClause>
      idNotEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: id, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: id, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterWhereClause>
      idBetween(
    Id lowerId,
    Id upperId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerId,
        includeLower: includeLower,
        upper: upperId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterWhereClause>
      uuidEqualTo(String uuid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'uuid',
        value: [uuid],
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterWhereClause>
      uuidNotEqualTo(String uuid) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [],
              upper: [uuid],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [uuid],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [uuid],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'uuid',
              lower: [],
              upper: [uuid],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterWhereClause>
      subjectIdEqualTo(String subjectId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'subjectId',
        value: [subjectId],
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterWhereClause>
      subjectIdNotEqualTo(String subjectId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'subjectId',
              lower: [],
              upper: [subjectId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'subjectId',
              lower: [subjectId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'subjectId',
              lower: [subjectId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'subjectId',
              lower: [],
              upper: [subjectId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterWhereClause>
      taskIdEqualTo(String taskId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'taskId',
        value: [taskId],
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterWhereClause>
      taskIdNotEqualTo(String taskId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'taskId',
              lower: [],
              upper: [taskId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'taskId',
              lower: [taskId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'taskId',
              lower: [taskId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'taskId',
              lower: [],
              upper: [taskId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterWhereClause>
      startedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'startedAt',
        value: [null],
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterWhereClause>
      startedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'startedAt',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterWhereClause>
      startedAtEqualTo(DateTime? startedAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'startedAt',
        value: [startedAt],
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterWhereClause>
      startedAtNotEqualTo(DateTime? startedAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'startedAt',
              lower: [],
              upper: [startedAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'startedAt',
              lower: [startedAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'startedAt',
              lower: [startedAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'startedAt',
              lower: [],
              upper: [startedAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterWhereClause>
      startedAtGreaterThan(
    DateTime? startedAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'startedAt',
        lower: [startedAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterWhereClause>
      startedAtLessThan(
    DateTime? startedAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'startedAt',
        lower: [],
        upper: [startedAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterWhereClause>
      startedAtBetween(
    DateTime? lowerStartedAt,
    DateTime? upperStartedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'startedAt',
        lower: [lowerStartedAt],
        includeLower: includeLower,
        upper: [upperStartedAt],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterWhereClause>
      localDateKeyEqualTo(String localDateKey) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'localDateKey',
        value: [localDateKey],
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterWhereClause>
      localDateKeyNotEqualTo(String localDateKey) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'localDateKey',
              lower: [],
              upper: [localDateKey],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'localDateKey',
              lower: [localDateKey],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'localDateKey',
              lower: [localDateKey],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'localDateKey',
              lower: [],
              upper: [localDateKey],
              includeUpper: false,
            ));
      }
    });
  }
}

extension PomodoroSessionModelQueryFilter on QueryBuilder<PomodoroSessionModel,
    PomodoroSessionModel, QFilterCondition> {
  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> actualDurationMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'actualDurationMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> actualDurationMinutesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'actualDurationMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> actualDurationMinutesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'actualDurationMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> actualDurationMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'actualDurationMinutes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> actualDurationSecondsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'actualDurationSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> actualDurationSecondsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'actualDurationSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> actualDurationSecondsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'actualDurationSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> actualDurationSecondsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'actualDurationSeconds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> completionRatioEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'completionRatio',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> completionRatioGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'completionRatio',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> completionRatioLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'completionRatio',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> completionRatioBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'completionRatio',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> distractionCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'distractionCount',
        value: value,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> distractionCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'distractionCount',
        value: value,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> distractionCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'distractionCount',
        value: value,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> distractionCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'distractionCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> endedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'endedAt',
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> endedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'endedAt',
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> endedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'endedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> endedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'endedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> endedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'endedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> endedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'endedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> idGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> idLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> idBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> isCompletedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCompleted',
        value: value,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> localDateKeyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localDateKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> localDateKeyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'localDateKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> localDateKeyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'localDateKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> localDateKeyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'localDateKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> localDateKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'localDateKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> localDateKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'localDateKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
          QAfterFilterCondition>
      localDateKeyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'localDateKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
          QAfterFilterCondition>
      localDateKeyMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'localDateKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> localDateKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'localDateKey',
        value: '',
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> localDateKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'localDateKey',
        value: '',
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> modeEqualTo(PomodoroMode value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'mode',
        value: value,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> modeGreaterThan(
    PomodoroMode value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'mode',
        value: value,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> modeLessThan(
    PomodoroMode value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'mode',
        value: value,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> modeBetween(
    PomodoroMode lower,
    PomodoroMode upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'mode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> notesEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> notesGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> notesLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> notesBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> notesStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> notesEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
          QAfterFilterCondition>
      notesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
          QAfterFilterCondition>
      notesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> pauseCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pauseCount',
        value: value,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> pauseCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pauseCount',
        value: value,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> pauseCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pauseCount',
        value: value,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> pauseCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pauseCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> plannedDurationSecondsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'plannedDurationSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> plannedDurationSecondsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'plannedDurationSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> plannedDurationSecondsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'plannedDurationSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> plannedDurationSecondsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'plannedDurationSeconds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> startedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'startedAt',
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> startedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'startedAt',
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> startedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> startedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'startedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> startedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'startedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> startedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'startedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> statusEqualTo(SessionStatus value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> statusGreaterThan(
    SessionStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> statusLessThan(
    SessionStatus value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'status',
        value: value,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> statusBetween(
    SessionStatus lower,
    SessionStatus upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'status',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> subjectIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subjectId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> subjectIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'subjectId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> subjectIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'subjectId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> subjectIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'subjectId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> subjectIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'subjectId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> subjectIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'subjectId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
          QAfterFilterCondition>
      subjectIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'subjectId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
          QAfterFilterCondition>
      subjectIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'subjectId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> subjectIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subjectId',
        value: '',
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> subjectIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'subjectId',
        value: '',
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> taskIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'taskId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> taskIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'taskId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> taskIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'taskId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> taskIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'taskId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> taskIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'taskId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> taskIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'taskId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
          QAfterFilterCondition>
      taskIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'taskId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
          QAfterFilterCondition>
      taskIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'taskId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> taskIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'taskId',
        value: '',
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> taskIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'taskId',
        value: '',
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> totalPausedSecondsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalPausedSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> totalPausedSecondsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalPausedSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> totalPausedSecondsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalPausedSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> totalPausedSecondsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalPausedSeconds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> uuidEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> uuidGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> uuidLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> uuidBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'uuid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> uuidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> uuidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
          QAfterFilterCondition>
      uuidContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
          QAfterFilterCondition>
      uuidMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'uuid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel,
      QAfterFilterCondition> uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uuid',
        value: '',
      ));
    });
  }
}

extension PomodoroSessionModelQueryObject on QueryBuilder<PomodoroSessionModel,
    PomodoroSessionModel, QFilterCondition> {}

extension PomodoroSessionModelQueryLinks on QueryBuilder<PomodoroSessionModel,
    PomodoroSessionModel, QFilterCondition> {}

extension PomodoroSessionModelQuerySortBy
    on QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QSortBy> {
  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      sortByActualDurationMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actualDurationMinutes', Sort.asc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      sortByActualDurationMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actualDurationMinutes', Sort.desc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      sortByActualDurationSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actualDurationSeconds', Sort.asc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      sortByActualDurationSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actualDurationSeconds', Sort.desc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      sortByCompletionRatio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completionRatio', Sort.asc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      sortByCompletionRatioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completionRatio', Sort.desc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      sortByDistractionCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distractionCount', Sort.asc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      sortByDistractionCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distractionCount', Sort.desc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      sortByEndedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endedAt', Sort.asc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      sortByEndedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endedAt', Sort.desc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      sortByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.asc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      sortByIsCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.desc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      sortByLocalDateKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localDateKey', Sort.asc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      sortByLocalDateKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localDateKey', Sort.desc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      sortByMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mode', Sort.asc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      sortByModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mode', Sort.desc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      sortByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      sortByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      sortByPauseCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pauseCount', Sort.asc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      sortByPauseCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pauseCount', Sort.desc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      sortByPlannedDurationSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plannedDurationSeconds', Sort.asc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      sortByPlannedDurationSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plannedDurationSeconds', Sort.desc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      sortByStartedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startedAt', Sort.asc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      sortByStartedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startedAt', Sort.desc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      sortByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      sortByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      sortBySubjectId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subjectId', Sort.asc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      sortBySubjectIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subjectId', Sort.desc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      sortByTaskId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskId', Sort.asc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      sortByTaskIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskId', Sort.desc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      sortByTotalPausedSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalPausedSeconds', Sort.asc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      sortByTotalPausedSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalPausedSeconds', Sort.desc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension PomodoroSessionModelQuerySortThenBy
    on QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QSortThenBy> {
  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      thenByActualDurationMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actualDurationMinutes', Sort.asc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      thenByActualDurationMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actualDurationMinutes', Sort.desc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      thenByActualDurationSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actualDurationSeconds', Sort.asc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      thenByActualDurationSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'actualDurationSeconds', Sort.desc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      thenByCompletionRatio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completionRatio', Sort.asc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      thenByCompletionRatioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completionRatio', Sort.desc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      thenByDistractionCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distractionCount', Sort.asc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      thenByDistractionCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'distractionCount', Sort.desc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      thenByEndedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endedAt', Sort.asc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      thenByEndedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'endedAt', Sort.desc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      thenByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.asc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      thenByIsCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isCompleted', Sort.desc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      thenByLocalDateKey() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localDateKey', Sort.asc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      thenByLocalDateKeyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'localDateKey', Sort.desc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      thenByMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mode', Sort.asc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      thenByModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'mode', Sort.desc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      thenByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      thenByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      thenByPauseCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pauseCount', Sort.asc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      thenByPauseCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pauseCount', Sort.desc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      thenByPlannedDurationSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plannedDurationSeconds', Sort.asc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      thenByPlannedDurationSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'plannedDurationSeconds', Sort.desc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      thenByStartedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startedAt', Sort.asc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      thenByStartedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startedAt', Sort.desc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      thenByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.asc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      thenByStatusDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'status', Sort.desc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      thenBySubjectId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subjectId', Sort.asc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      thenBySubjectIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subjectId', Sort.desc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      thenByTaskId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskId', Sort.asc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      thenByTaskIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'taskId', Sort.desc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      thenByTotalPausedSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalPausedSeconds', Sort.asc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      thenByTotalPausedSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalPausedSeconds', Sort.desc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QAfterSortBy>
      thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension PomodoroSessionModelQueryWhereDistinct
    on QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QDistinct> {
  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QDistinct>
      distinctByActualDurationMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'actualDurationMinutes');
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QDistinct>
      distinctByActualDurationSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'actualDurationSeconds');
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QDistinct>
      distinctByCompletionRatio() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'completionRatio');
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QDistinct>
      distinctByDistractionCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'distractionCount');
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QDistinct>
      distinctByEndedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'endedAt');
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QDistinct>
      distinctByIsCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isCompleted');
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QDistinct>
      distinctByLocalDateKey({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'localDateKey', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QDistinct>
      distinctByMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'mode');
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QDistinct>
      distinctByNotes({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QDistinct>
      distinctByPauseCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pauseCount');
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QDistinct>
      distinctByPlannedDurationSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'plannedDurationSeconds');
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QDistinct>
      distinctByStartedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startedAt');
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QDistinct>
      distinctByStatus() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'status');
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QDistinct>
      distinctBySubjectId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'subjectId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QDistinct>
      distinctByTaskId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'taskId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QDistinct>
      distinctByTotalPausedSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalPausedSeconds');
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroSessionModel, QDistinct>
      distinctByUuid({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }
}

extension PomodoroSessionModelQueryProperty on QueryBuilder<
    PomodoroSessionModel, PomodoroSessionModel, QQueryProperty> {
  QueryBuilder<PomodoroSessionModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<PomodoroSessionModel, int, QQueryOperations>
      actualDurationMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'actualDurationMinutes');
    });
  }

  QueryBuilder<PomodoroSessionModel, int, QQueryOperations>
      actualDurationSecondsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'actualDurationSeconds');
    });
  }

  QueryBuilder<PomodoroSessionModel, double, QQueryOperations>
      completionRatioProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'completionRatio');
    });
  }

  QueryBuilder<PomodoroSessionModel, int, QQueryOperations>
      distractionCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'distractionCount');
    });
  }

  QueryBuilder<PomodoroSessionModel, DateTime?, QQueryOperations>
      endedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'endedAt');
    });
  }

  QueryBuilder<PomodoroSessionModel, bool, QQueryOperations>
      isCompletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isCompleted');
    });
  }

  QueryBuilder<PomodoroSessionModel, String, QQueryOperations>
      localDateKeyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'localDateKey');
    });
  }

  QueryBuilder<PomodoroSessionModel, PomodoroMode, QQueryOperations>
      modeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'mode');
    });
  }

  QueryBuilder<PomodoroSessionModel, String, QQueryOperations> notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notes');
    });
  }

  QueryBuilder<PomodoroSessionModel, int, QQueryOperations>
      pauseCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pauseCount');
    });
  }

  QueryBuilder<PomodoroSessionModel, int, QQueryOperations>
      plannedDurationSecondsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'plannedDurationSeconds');
    });
  }

  QueryBuilder<PomodoroSessionModel, DateTime?, QQueryOperations>
      startedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startedAt');
    });
  }

  QueryBuilder<PomodoroSessionModel, SessionStatus, QQueryOperations>
      statusProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'status');
    });
  }

  QueryBuilder<PomodoroSessionModel, String, QQueryOperations>
      subjectIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'subjectId');
    });
  }

  QueryBuilder<PomodoroSessionModel, String, QQueryOperations>
      taskIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'taskId');
    });
  }

  QueryBuilder<PomodoroSessionModel, int, QQueryOperations>
      totalPausedSecondsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalPausedSeconds');
    });
  }

  QueryBuilder<PomodoroSessionModel, String, QQueryOperations> uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }
}
