// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetQuizQuestionModelCollection on Isar {
  IsarCollection<QuizQuestionModel> get quizQuestionModels => this.collection();
}

const QuizQuestionModelSchema = CollectionSchema(
  name: r'QuizQuestionModel',
  id: -100663082932377212,
  properties: {
    r'correctAnswer': PropertySchema(
      id: 0,
      name: r'correctAnswer',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 1,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'difficultyScore': PropertySchema(
      id: 2,
      name: r'difficultyScore',
      type: IsarType.long,
    ),
    r'explanation': PropertySchema(
      id: 3,
      name: r'explanation',
      type: IsarType.string,
    ),
    r'imagePathQuestion': PropertySchema(
      id: 4,
      name: r'imagePathQuestion',
      type: IsarType.string,
    ),
    r'options': PropertySchema(
      id: 5,
      name: r'options',
      type: IsarType.objectList,
      target: r'QuizOptionModel',
    ),
    r'position': PropertySchema(
      id: 6,
      name: r'position',
      type: IsarType.long,
    ),
    r'questionText': PropertySchema(
      id: 7,
      name: r'questionText',
      type: IsarType.string,
    ),
    r'questionType': PropertySchema(
      id: 8,
      name: r'questionType',
      type: IsarType.byte,
      enumMap: _QuizQuestionModelquestionTypeEnumValueMap,
    ),
    r'quizId': PropertySchema(
      id: 9,
      name: r'quizId',
      type: IsarType.string,
    ),
    r'sourceNoteId': PropertySchema(
      id: 10,
      name: r'sourceNoteId',
      type: IsarType.string,
    ),
    r'subjectId': PropertySchema(
      id: 11,
      name: r'subjectId',
      type: IsarType.string,
    ),
    r'tags': PropertySchema(
      id: 12,
      name: r'tags',
      type: IsarType.stringList,
    ),
    r'timeLimitSeconds': PropertySchema(
      id: 13,
      name: r'timeLimitSeconds',
      type: IsarType.long,
    ),
    r'uuid': PropertySchema(
      id: 14,
      name: r'uuid',
      type: IsarType.string,
    )
  },
  estimateSize: _quizQuestionModelEstimateSize,
  serialize: _quizQuestionModelSerialize,
  deserialize: _quizQuestionModelDeserialize,
  deserializeProp: _quizQuestionModelDeserializeProp,
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
    r'quizId': IndexSchema(
      id: -3109243004246223161,
      name: r'quizId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'quizId',
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
    r'questionText': IndexSchema(
      id: -7975357143895391099,
      name: r'questionText',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'questionText',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'sourceNoteId': IndexSchema(
      id: 8470138718509712414,
      name: r'sourceNoteId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'sourceNoteId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'createdAt': IndexSchema(
      id: -3433535483987302584,
      name: r'createdAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'createdAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {r'QuizOptionModel': QuizOptionModelSchema},
  getId: _quizQuestionModelGetId,
  getLinks: _quizQuestionModelGetLinks,
  attach: _quizQuestionModelAttach,
  version: '3.1.0+1',
);

int _quizQuestionModelEstimateSize(
  QuizQuestionModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.correctAnswer.length * 3;
  bytesCount += 3 + object.explanation.length * 3;
  bytesCount += 3 + object.imagePathQuestion.length * 3;
  bytesCount += 3 + object.options.length * 3;
  {
    final offsets = allOffsets[QuizOptionModel]!;
    for (var i = 0; i < object.options.length; i++) {
      final value = object.options[i];
      bytesCount +=
          QuizOptionModelSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.questionText.length * 3;
  bytesCount += 3 + object.quizId.length * 3;
  bytesCount += 3 + object.sourceNoteId.length * 3;
  bytesCount += 3 + object.subjectId.length * 3;
  bytesCount += 3 + object.tags.length * 3;
  {
    for (var i = 0; i < object.tags.length; i++) {
      final value = object.tags[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.uuid.length * 3;
  return bytesCount;
}

void _quizQuestionModelSerialize(
  QuizQuestionModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.correctAnswer);
  writer.writeDateTime(offsets[1], object.createdAt);
  writer.writeLong(offsets[2], object.difficultyScore);
  writer.writeString(offsets[3], object.explanation);
  writer.writeString(offsets[4], object.imagePathQuestion);
  writer.writeObjectList<QuizOptionModel>(
    offsets[5],
    allOffsets,
    QuizOptionModelSchema.serialize,
    object.options,
  );
  writer.writeLong(offsets[6], object.position);
  writer.writeString(offsets[7], object.questionText);
  writer.writeByte(offsets[8], object.questionType.index);
  writer.writeString(offsets[9], object.quizId);
  writer.writeString(offsets[10], object.sourceNoteId);
  writer.writeString(offsets[11], object.subjectId);
  writer.writeStringList(offsets[12], object.tags);
  writer.writeLong(offsets[13], object.timeLimitSeconds);
  writer.writeString(offsets[14], object.uuid);
}

QuizQuestionModel _quizQuestionModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = QuizQuestionModel(
    correctAnswer: reader.readStringOrNull(offsets[0]) ?? '',
    createdAt: reader.readDateTimeOrNull(offsets[1]),
    difficultyScore: reader.readLongOrNull(offsets[2]) ?? 1,
    explanation: reader.readStringOrNull(offsets[3]) ?? '',
    id: id,
    imagePathQuestion: reader.readStringOrNull(offsets[4]) ?? '',
    options: reader.readObjectList<QuizOptionModel>(
          offsets[5],
          QuizOptionModelSchema.deserialize,
          allOffsets,
          QuizOptionModel(),
        ) ??
        const [],
    position: reader.readLongOrNull(offsets[6]) ?? 0,
    questionText: reader.readStringOrNull(offsets[7]) ?? '',
    questionType: _QuizQuestionModelquestionTypeValueEnumMap[
            reader.readByteOrNull(offsets[8])] ??
        QuizQuestionType.multipleChoice,
    quizId: reader.readStringOrNull(offsets[9]) ?? '',
    sourceNoteId: reader.readStringOrNull(offsets[10]) ?? '',
    subjectId: reader.readStringOrNull(offsets[11]) ?? '',
    tags: reader.readStringList(offsets[12]) ?? const [],
    timeLimitSeconds: reader.readLongOrNull(offsets[13]) ?? 0,
    uuid: reader.readStringOrNull(offsets[14]) ?? '',
  );
  return object;
}

P _quizQuestionModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset) ?? 1) as P;
    case 3:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 4:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 5:
      return (reader.readObjectList<QuizOptionModel>(
            offset,
            QuizOptionModelSchema.deserialize,
            allOffsets,
            QuizOptionModel(),
          ) ??
          const []) as P;
    case 6:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 7:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 8:
      return (_QuizQuestionModelquestionTypeValueEnumMap[
              reader.readByteOrNull(offset)] ??
          QuizQuestionType.multipleChoice) as P;
    case 9:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 10:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 11:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 12:
      return (reader.readStringList(offset) ?? const []) as P;
    case 13:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 14:
      return (reader.readStringOrNull(offset) ?? '') as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

const _QuizQuestionModelquestionTypeEnumValueMap = {
  'multipleChoice': 0,
  'trueFalse': 1,
  'shortAnswer': 2,
  'fillInBlank': 3,
};
const _QuizQuestionModelquestionTypeValueEnumMap = {
  0: QuizQuestionType.multipleChoice,
  1: QuizQuestionType.trueFalse,
  2: QuizQuestionType.shortAnswer,
  3: QuizQuestionType.fillInBlank,
};

Id _quizQuestionModelGetId(QuizQuestionModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _quizQuestionModelGetLinks(
    QuizQuestionModel object) {
  return [];
}

void _quizQuestionModelAttach(
    IsarCollection<dynamic> col, Id id, QuizQuestionModel object) {
  object.id = id;
}

extension QuizQuestionModelByIndex on IsarCollection<QuizQuestionModel> {
  Future<QuizQuestionModel?> getByUuid(String uuid) {
    return getByIndex(r'uuid', [uuid]);
  }

  QuizQuestionModel? getByUuidSync(String uuid) {
    return getByIndexSync(r'uuid', [uuid]);
  }

  Future<bool> deleteByUuid(String uuid) {
    return deleteByIndex(r'uuid', [uuid]);
  }

  bool deleteByUuidSync(String uuid) {
    return deleteByIndexSync(r'uuid', [uuid]);
  }

  Future<List<QuizQuestionModel?>> getAllByUuid(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndex(r'uuid', values);
  }

  List<QuizQuestionModel?> getAllByUuidSync(List<String> uuidValues) {
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

  Future<Id> putByUuid(QuizQuestionModel object) {
    return putByIndex(r'uuid', object);
  }

  Id putByUuidSync(QuizQuestionModel object, {bool saveLinks = true}) {
    return putByIndexSync(r'uuid', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUuid(List<QuizQuestionModel> objects) {
    return putAllByIndex(r'uuid', objects);
  }

  List<Id> putAllByUuidSync(List<QuizQuestionModel> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'uuid', objects, saveLinks: saveLinks);
  }
}

extension QuizQuestionModelQueryWhereSort
    on QueryBuilder<QuizQuestionModel, QuizQuestionModel, QWhere> {
  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterWhere>
      anyCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'createdAt'),
      );
    });
  }
}

extension QuizQuestionModelQueryWhere
    on QueryBuilder<QuizQuestionModel, QuizQuestionModel, QWhereClause> {
  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterWhereClause>
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

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterWhereClause>
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

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterWhereClause>
      uuidEqualTo(String uuid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'uuid',
        value: [uuid],
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterWhereClause>
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

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterWhereClause>
      quizIdEqualTo(String quizId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'quizId',
        value: [quizId],
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterWhereClause>
      quizIdNotEqualTo(String quizId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'quizId',
              lower: [],
              upper: [quizId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'quizId',
              lower: [quizId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'quizId',
              lower: [quizId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'quizId',
              lower: [],
              upper: [quizId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterWhereClause>
      subjectIdEqualTo(String subjectId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'subjectId',
        value: [subjectId],
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterWhereClause>
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

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterWhereClause>
      questionTextEqualTo(String questionText) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'questionText',
        value: [questionText],
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterWhereClause>
      questionTextNotEqualTo(String questionText) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'questionText',
              lower: [],
              upper: [questionText],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'questionText',
              lower: [questionText],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'questionText',
              lower: [questionText],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'questionText',
              lower: [],
              upper: [questionText],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterWhereClause>
      sourceNoteIdEqualTo(String sourceNoteId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'sourceNoteId',
        value: [sourceNoteId],
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterWhereClause>
      sourceNoteIdNotEqualTo(String sourceNoteId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'sourceNoteId',
              lower: [],
              upper: [sourceNoteId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'sourceNoteId',
              lower: [sourceNoteId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'sourceNoteId',
              lower: [sourceNoteId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'sourceNoteId',
              lower: [],
              upper: [sourceNoteId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterWhereClause>
      createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'createdAt',
        value: [null],
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterWhereClause>
      createdAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterWhereClause>
      createdAtEqualTo(DateTime? createdAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'createdAt',
        value: [createdAt],
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterWhereClause>
      createdAtNotEqualTo(DateTime? createdAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [],
              upper: [createdAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [createdAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [createdAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [],
              upper: [createdAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterWhereClause>
      createdAtGreaterThan(
    DateTime? createdAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [createdAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterWhereClause>
      createdAtLessThan(
    DateTime? createdAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [],
        upper: [createdAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterWhereClause>
      createdAtBetween(
    DateTime? lowerCreatedAt,
    DateTime? upperCreatedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [lowerCreatedAt],
        includeLower: includeLower,
        upper: [upperCreatedAt],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension QuizQuestionModelQueryFilter
    on QueryBuilder<QuizQuestionModel, QuizQuestionModel, QFilterCondition> {
  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      correctAnswerEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'correctAnswer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      correctAnswerGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'correctAnswer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      correctAnswerLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'correctAnswer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      correctAnswerBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'correctAnswer',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      correctAnswerStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'correctAnswer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      correctAnswerEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'correctAnswer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      correctAnswerContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'correctAnswer',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      correctAnswerMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'correctAnswer',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      correctAnswerIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'correctAnswer',
        value: '',
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      correctAnswerIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'correctAnswer',
        value: '',
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      createdAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      createdAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      createdAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      createdAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      difficultyScoreEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'difficultyScore',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      difficultyScoreGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'difficultyScore',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      difficultyScoreLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'difficultyScore',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      difficultyScoreBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'difficultyScore',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      explanationEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'explanation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      explanationGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'explanation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      explanationLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'explanation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      explanationBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'explanation',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      explanationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'explanation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      explanationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'explanation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      explanationContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'explanation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      explanationMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'explanation',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      explanationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'explanation',
        value: '',
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      explanationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'explanation',
        value: '',
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      imagePathQuestionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imagePathQuestion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      imagePathQuestionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'imagePathQuestion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      imagePathQuestionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'imagePathQuestion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      imagePathQuestionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'imagePathQuestion',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      imagePathQuestionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'imagePathQuestion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      imagePathQuestionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'imagePathQuestion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      imagePathQuestionContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'imagePathQuestion',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      imagePathQuestionMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'imagePathQuestion',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      imagePathQuestionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'imagePathQuestion',
        value: '',
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      imagePathQuestionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'imagePathQuestion',
        value: '',
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      optionsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'options',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      optionsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'options',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      optionsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'options',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      optionsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'options',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      optionsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'options',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      optionsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'options',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      positionEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'position',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      positionGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'position',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      positionLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'position',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      positionBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'position',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      questionTextEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'questionText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      questionTextGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'questionText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      questionTextLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'questionText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      questionTextBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'questionText',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      questionTextStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'questionText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      questionTextEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'questionText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      questionTextContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'questionText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      questionTextMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'questionText',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      questionTextIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'questionText',
        value: '',
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      questionTextIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'questionText',
        value: '',
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      questionTypeEqualTo(QuizQuestionType value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'questionType',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      questionTypeGreaterThan(
    QuizQuestionType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'questionType',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      questionTypeLessThan(
    QuizQuestionType value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'questionType',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      questionTypeBetween(
    QuizQuestionType lower,
    QuizQuestionType upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'questionType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      quizIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quizId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      quizIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quizId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      quizIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quizId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      quizIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quizId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      quizIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'quizId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      quizIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'quizId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      quizIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'quizId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      quizIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'quizId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      quizIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quizId',
        value: '',
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      quizIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'quizId',
        value: '',
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      sourceNoteIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sourceNoteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      sourceNoteIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sourceNoteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      sourceNoteIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sourceNoteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      sourceNoteIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sourceNoteId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      sourceNoteIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sourceNoteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      sourceNoteIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sourceNoteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      sourceNoteIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sourceNoteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      sourceNoteIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sourceNoteId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      sourceNoteIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sourceNoteId',
        value: '',
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      sourceNoteIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sourceNoteId',
        value: '',
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      subjectIdEqualTo(
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

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      subjectIdGreaterThan(
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

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      subjectIdLessThan(
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

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      subjectIdBetween(
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

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      subjectIdStartsWith(
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

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      subjectIdEndsWith(
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

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      subjectIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'subjectId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      subjectIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'subjectId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      subjectIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subjectId',
        value: '',
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      subjectIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'subjectId',
        value: '',
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      tagsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      tagsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      tagsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      tagsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tags',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      tagsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      tagsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      tagsElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      tagsElementMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tags',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      tagsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tags',
        value: '',
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      tagsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tags',
        value: '',
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      tagsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      tagsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      tagsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      tagsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      tagsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      tagsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      timeLimitSecondsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timeLimitSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      timeLimitSecondsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timeLimitSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      timeLimitSecondsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timeLimitSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      timeLimitSecondsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timeLimitSeconds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      uuidEqualTo(
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

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      uuidGreaterThan(
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

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      uuidLessThan(
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

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      uuidBetween(
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

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      uuidStartsWith(
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

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      uuidEndsWith(
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

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      uuidContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      uuidMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'uuid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uuid',
        value: '',
      ));
    });
  }
}

extension QuizQuestionModelQueryObject
    on QueryBuilder<QuizQuestionModel, QuizQuestionModel, QFilterCondition> {
  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterFilterCondition>
      optionsElement(FilterQuery<QuizOptionModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'options');
    });
  }
}

extension QuizQuestionModelQueryLinks
    on QueryBuilder<QuizQuestionModel, QuizQuestionModel, QFilterCondition> {}

extension QuizQuestionModelQuerySortBy
    on QueryBuilder<QuizQuestionModel, QuizQuestionModel, QSortBy> {
  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterSortBy>
      sortByCorrectAnswer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'correctAnswer', Sort.asc);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterSortBy>
      sortByCorrectAnswerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'correctAnswer', Sort.desc);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterSortBy>
      sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterSortBy>
      sortByDifficultyScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'difficultyScore', Sort.asc);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterSortBy>
      sortByDifficultyScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'difficultyScore', Sort.desc);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterSortBy>
      sortByExplanation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explanation', Sort.asc);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterSortBy>
      sortByExplanationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explanation', Sort.desc);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterSortBy>
      sortByImagePathQuestion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagePathQuestion', Sort.asc);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterSortBy>
      sortByImagePathQuestionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagePathQuestion', Sort.desc);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterSortBy>
      sortByPosition() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'position', Sort.asc);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterSortBy>
      sortByPositionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'position', Sort.desc);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterSortBy>
      sortByQuestionText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questionText', Sort.asc);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterSortBy>
      sortByQuestionTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questionText', Sort.desc);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterSortBy>
      sortByQuestionType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questionType', Sort.asc);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterSortBy>
      sortByQuestionTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questionType', Sort.desc);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterSortBy>
      sortByQuizId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quizId', Sort.asc);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterSortBy>
      sortByQuizIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quizId', Sort.desc);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterSortBy>
      sortBySourceNoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceNoteId', Sort.asc);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterSortBy>
      sortBySourceNoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceNoteId', Sort.desc);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterSortBy>
      sortBySubjectId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subjectId', Sort.asc);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterSortBy>
      sortBySubjectIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subjectId', Sort.desc);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterSortBy>
      sortByTimeLimitSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeLimitSeconds', Sort.asc);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterSortBy>
      sortByTimeLimitSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeLimitSeconds', Sort.desc);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterSortBy>
      sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterSortBy>
      sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension QuizQuestionModelQuerySortThenBy
    on QueryBuilder<QuizQuestionModel, QuizQuestionModel, QSortThenBy> {
  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterSortBy>
      thenByCorrectAnswer() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'correctAnswer', Sort.asc);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterSortBy>
      thenByCorrectAnswerDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'correctAnswer', Sort.desc);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterSortBy>
      thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterSortBy>
      thenByDifficultyScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'difficultyScore', Sort.asc);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterSortBy>
      thenByDifficultyScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'difficultyScore', Sort.desc);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterSortBy>
      thenByExplanation() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explanation', Sort.asc);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterSortBy>
      thenByExplanationDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'explanation', Sort.desc);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterSortBy>
      thenByImagePathQuestion() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagePathQuestion', Sort.asc);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterSortBy>
      thenByImagePathQuestionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'imagePathQuestion', Sort.desc);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterSortBy>
      thenByPosition() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'position', Sort.asc);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterSortBy>
      thenByPositionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'position', Sort.desc);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterSortBy>
      thenByQuestionText() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questionText', Sort.asc);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterSortBy>
      thenByQuestionTextDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questionText', Sort.desc);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterSortBy>
      thenByQuestionType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questionType', Sort.asc);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterSortBy>
      thenByQuestionTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questionType', Sort.desc);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterSortBy>
      thenByQuizId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quizId', Sort.asc);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterSortBy>
      thenByQuizIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quizId', Sort.desc);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterSortBy>
      thenBySourceNoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceNoteId', Sort.asc);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterSortBy>
      thenBySourceNoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceNoteId', Sort.desc);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterSortBy>
      thenBySubjectId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subjectId', Sort.asc);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterSortBy>
      thenBySubjectIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subjectId', Sort.desc);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterSortBy>
      thenByTimeLimitSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeLimitSeconds', Sort.asc);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterSortBy>
      thenByTimeLimitSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'timeLimitSeconds', Sort.desc);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterSortBy>
      thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QAfterSortBy>
      thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension QuizQuestionModelQueryWhereDistinct
    on QueryBuilder<QuizQuestionModel, QuizQuestionModel, QDistinct> {
  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QDistinct>
      distinctByCorrectAnswer({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'correctAnswer',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QDistinct>
      distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QDistinct>
      distinctByDifficultyScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'difficultyScore');
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QDistinct>
      distinctByExplanation({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'explanation', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QDistinct>
      distinctByImagePathQuestion({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'imagePathQuestion',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QDistinct>
      distinctByPosition() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'position');
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QDistinct>
      distinctByQuestionText({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'questionText', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QDistinct>
      distinctByQuestionType() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'questionType');
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QDistinct>
      distinctByQuizId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quizId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QDistinct>
      distinctBySourceNoteId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sourceNoteId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QDistinct>
      distinctBySubjectId({bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'subjectId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QDistinct>
      distinctByTags() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tags');
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QDistinct>
      distinctByTimeLimitSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'timeLimitSeconds');
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionModel, QDistinct> distinctByUuid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }
}

extension QuizQuestionModelQueryProperty
    on QueryBuilder<QuizQuestionModel, QuizQuestionModel, QQueryProperty> {
  QueryBuilder<QuizQuestionModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<QuizQuestionModel, String, QQueryOperations>
      correctAnswerProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'correctAnswer');
    });
  }

  QueryBuilder<QuizQuestionModel, DateTime?, QQueryOperations>
      createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<QuizQuestionModel, int, QQueryOperations>
      difficultyScoreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'difficultyScore');
    });
  }

  QueryBuilder<QuizQuestionModel, String, QQueryOperations>
      explanationProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'explanation');
    });
  }

  QueryBuilder<QuizQuestionModel, String, QQueryOperations>
      imagePathQuestionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'imagePathQuestion');
    });
  }

  QueryBuilder<QuizQuestionModel, List<QuizOptionModel>, QQueryOperations>
      optionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'options');
    });
  }

  QueryBuilder<QuizQuestionModel, int, QQueryOperations> positionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'position');
    });
  }

  QueryBuilder<QuizQuestionModel, String, QQueryOperations>
      questionTextProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'questionText');
    });
  }

  QueryBuilder<QuizQuestionModel, QuizQuestionType, QQueryOperations>
      questionTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'questionType');
    });
  }

  QueryBuilder<QuizQuestionModel, String, QQueryOperations> quizIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quizId');
    });
  }

  QueryBuilder<QuizQuestionModel, String, QQueryOperations>
      sourceNoteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sourceNoteId');
    });
  }

  QueryBuilder<QuizQuestionModel, String, QQueryOperations>
      subjectIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'subjectId');
    });
  }

  QueryBuilder<QuizQuestionModel, List<String>, QQueryOperations>
      tagsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tags');
    });
  }

  QueryBuilder<QuizQuestionModel, int, QQueryOperations>
      timeLimitSecondsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'timeLimitSeconds');
    });
  }

  QueryBuilder<QuizQuestionModel, String, QQueryOperations> uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetQuizAttemptModelCollection on Isar {
  IsarCollection<QuizAttemptModel> get quizAttemptModels => this.collection();
}

const QuizAttemptModelSchema = CollectionSchema(
  name: r'QuizAttemptModel',
  id: -4063829834006677212,
  properties: {
    r'answers': PropertySchema(
      id: 0,
      name: r'answers',
      type: IsarType.objectList,
      target: r'QuizAttemptAnswerModel',
    ),
    r'completedAt': PropertySchema(
      id: 1,
      name: r'completedAt',
      type: IsarType.dateTime,
    ),
    r'durationSeconds': PropertySchema(
      id: 2,
      name: r'durationSeconds',
      type: IsarType.long,
    ),
    r'isPassed': PropertySchema(
      id: 3,
      name: r'isPassed',
      type: IsarType.bool,
    ),
    r'quizId': PropertySchema(
      id: 4,
      name: r'quizId',
      type: IsarType.string,
    ),
    r'score': PropertySchema(
      id: 5,
      name: r'score',
      type: IsarType.long,
    ),
    r'scorePercent': PropertySchema(
      id: 6,
      name: r'scorePercent',
      type: IsarType.double,
    ),
    r'startedAt': PropertySchema(
      id: 7,
      name: r'startedAt',
      type: IsarType.dateTime,
    ),
    r'totalQuestions': PropertySchema(
      id: 8,
      name: r'totalQuestions',
      type: IsarType.long,
    ),
    r'uuid': PropertySchema(
      id: 9,
      name: r'uuid',
      type: IsarType.string,
    )
  },
  estimateSize: _quizAttemptModelEstimateSize,
  serialize: _quizAttemptModelSerialize,
  deserialize: _quizAttemptModelDeserialize,
  deserializeProp: _quizAttemptModelDeserializeProp,
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
    r'quizId': IndexSchema(
      id: -3109243004246223161,
      name: r'quizId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'quizId',
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
    r'completedAt': IndexSchema(
      id: -3156591011457686752,
      name: r'completedAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'completedAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {r'QuizAttemptAnswerModel': QuizAttemptAnswerModelSchema},
  getId: _quizAttemptModelGetId,
  getLinks: _quizAttemptModelGetLinks,
  attach: _quizAttemptModelAttach,
  version: '3.1.0+1',
);

int _quizAttemptModelEstimateSize(
  QuizAttemptModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.answers.length * 3;
  {
    final offsets = allOffsets[QuizAttemptAnswerModel]!;
    for (var i = 0; i < object.answers.length; i++) {
      final value = object.answers[i];
      bytesCount +=
          QuizAttemptAnswerModelSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.quizId.length * 3;
  bytesCount += 3 + object.uuid.length * 3;
  return bytesCount;
}

void _quizAttemptModelSerialize(
  QuizAttemptModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<QuizAttemptAnswerModel>(
    offsets[0],
    allOffsets,
    QuizAttemptAnswerModelSchema.serialize,
    object.answers,
  );
  writer.writeDateTime(offsets[1], object.completedAt);
  writer.writeLong(offsets[2], object.durationSeconds);
  writer.writeBool(offsets[3], object.isPassed);
  writer.writeString(offsets[4], object.quizId);
  writer.writeLong(offsets[5], object.score);
  writer.writeDouble(offsets[6], object.scorePercent);
  writer.writeDateTime(offsets[7], object.startedAt);
  writer.writeLong(offsets[8], object.totalQuestions);
  writer.writeString(offsets[9], object.uuid);
}

QuizAttemptModel _quizAttemptModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = QuizAttemptModel(
    answers: reader.readObjectList<QuizAttemptAnswerModel>(
          offsets[0],
          QuizAttemptAnswerModelSchema.deserialize,
          allOffsets,
          QuizAttemptAnswerModel(),
        ) ??
        const [],
    completedAt: reader.readDateTimeOrNull(offsets[1]),
    durationSeconds: reader.readLongOrNull(offsets[2]) ?? 0,
    id: id,
    quizId: reader.readStringOrNull(offsets[4]) ?? '',
    score: reader.readLongOrNull(offsets[5]) ?? 0,
    startedAt: reader.readDateTimeOrNull(offsets[7]),
    totalQuestions: reader.readLongOrNull(offsets[8]) ?? 0,
    uuid: reader.readStringOrNull(offsets[9]) ?? '',
  );
  return object;
}

P _quizAttemptModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<QuizAttemptAnswerModel>(
            offset,
            QuizAttemptAnswerModelSchema.deserialize,
            allOffsets,
            QuizAttemptAnswerModel(),
          ) ??
          const []) as P;
    case 1:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 3:
      return (reader.readBool(offset)) as P;
    case 4:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 5:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 6:
      return (reader.readDouble(offset)) as P;
    case 7:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 8:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 9:
      return (reader.readStringOrNull(offset) ?? '') as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _quizAttemptModelGetId(QuizAttemptModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _quizAttemptModelGetLinks(QuizAttemptModel object) {
  return [];
}

void _quizAttemptModelAttach(
    IsarCollection<dynamic> col, Id id, QuizAttemptModel object) {
  object.id = id;
}

extension QuizAttemptModelByIndex on IsarCollection<QuizAttemptModel> {
  Future<QuizAttemptModel?> getByUuid(String uuid) {
    return getByIndex(r'uuid', [uuid]);
  }

  QuizAttemptModel? getByUuidSync(String uuid) {
    return getByIndexSync(r'uuid', [uuid]);
  }

  Future<bool> deleteByUuid(String uuid) {
    return deleteByIndex(r'uuid', [uuid]);
  }

  bool deleteByUuidSync(String uuid) {
    return deleteByIndexSync(r'uuid', [uuid]);
  }

  Future<List<QuizAttemptModel?>> getAllByUuid(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndex(r'uuid', values);
  }

  List<QuizAttemptModel?> getAllByUuidSync(List<String> uuidValues) {
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

  Future<Id> putByUuid(QuizAttemptModel object) {
    return putByIndex(r'uuid', object);
  }

  Id putByUuidSync(QuizAttemptModel object, {bool saveLinks = true}) {
    return putByIndexSync(r'uuid', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUuid(List<QuizAttemptModel> objects) {
    return putAllByIndex(r'uuid', objects);
  }

  List<Id> putAllByUuidSync(List<QuizAttemptModel> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'uuid', objects, saveLinks: saveLinks);
  }
}

extension QuizAttemptModelQueryWhereSort
    on QueryBuilder<QuizAttemptModel, QuizAttemptModel, QWhere> {
  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterWhere> anyStartedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'startedAt'),
      );
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterWhere>
      anyCompletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'completedAt'),
      );
    });
  }
}

extension QuizAttemptModelQueryWhere
    on QueryBuilder<QuizAttemptModel, QuizAttemptModel, QWhereClause> {
  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterWhereClause>
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

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterWhereClause> idBetween(
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

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterWhereClause>
      uuidEqualTo(String uuid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'uuid',
        value: [uuid],
      ));
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterWhereClause>
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

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterWhereClause>
      quizIdEqualTo(String quizId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'quizId',
        value: [quizId],
      ));
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterWhereClause>
      quizIdNotEqualTo(String quizId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'quizId',
              lower: [],
              upper: [quizId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'quizId',
              lower: [quizId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'quizId',
              lower: [quizId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'quizId',
              lower: [],
              upper: [quizId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterWhereClause>
      startedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'startedAt',
        value: [null],
      ));
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterWhereClause>
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

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterWhereClause>
      startedAtEqualTo(DateTime? startedAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'startedAt',
        value: [startedAt],
      ));
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterWhereClause>
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

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterWhereClause>
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

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterWhereClause>
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

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterWhereClause>
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

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterWhereClause>
      completedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'completedAt',
        value: [null],
      ));
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterWhereClause>
      completedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'completedAt',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterWhereClause>
      completedAtEqualTo(DateTime? completedAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'completedAt',
        value: [completedAt],
      ));
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterWhereClause>
      completedAtNotEqualTo(DateTime? completedAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'completedAt',
              lower: [],
              upper: [completedAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'completedAt',
              lower: [completedAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'completedAt',
              lower: [completedAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'completedAt',
              lower: [],
              upper: [completedAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterWhereClause>
      completedAtGreaterThan(
    DateTime? completedAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'completedAt',
        lower: [completedAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterWhereClause>
      completedAtLessThan(
    DateTime? completedAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'completedAt',
        lower: [],
        upper: [completedAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterWhereClause>
      completedAtBetween(
    DateTime? lowerCompletedAt,
    DateTime? upperCompletedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'completedAt',
        lower: [lowerCompletedAt],
        includeLower: includeLower,
        upper: [upperCompletedAt],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension QuizAttemptModelQueryFilter
    on QueryBuilder<QuizAttemptModel, QuizAttemptModel, QFilterCondition> {
  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      answersLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'answers',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      answersIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'answers',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      answersIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'answers',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      answersLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'answers',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      answersLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'answers',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      answersLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'answers',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      completedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'completedAt',
      ));
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      completedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'completedAt',
      ));
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      completedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'completedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      completedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'completedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      completedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'completedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      completedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'completedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      durationSecondsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'durationSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      durationSecondsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'durationSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      durationSecondsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'durationSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      durationSecondsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'durationSeconds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      idGreaterThan(
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

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      idLessThan(
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

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      idBetween(
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

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      isPassedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isPassed',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      quizIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quizId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      quizIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'quizId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      quizIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'quizId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      quizIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'quizId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      quizIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'quizId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      quizIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'quizId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      quizIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'quizId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      quizIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'quizId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      quizIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'quizId',
        value: '',
      ));
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      quizIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'quizId',
        value: '',
      ));
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      scoreEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'score',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      scoreGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'score',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      scoreLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'score',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      scoreBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'score',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      scorePercentEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'scorePercent',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      scorePercentGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'scorePercent',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      scorePercentLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'scorePercent',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      scorePercentBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'scorePercent',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      startedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'startedAt',
      ));
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      startedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'startedAt',
      ));
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      startedAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'startedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      startedAtGreaterThan(
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

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      startedAtLessThan(
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

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      startedAtBetween(
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

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      totalQuestionsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalQuestions',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      totalQuestionsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalQuestions',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      totalQuestionsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalQuestions',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      totalQuestionsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalQuestions',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      uuidEqualTo(
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

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      uuidGreaterThan(
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

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      uuidLessThan(
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

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      uuidBetween(
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

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      uuidStartsWith(
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

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      uuidEndsWith(
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

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      uuidContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      uuidMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'uuid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uuid',
        value: '',
      ));
    });
  }
}

extension QuizAttemptModelQueryObject
    on QueryBuilder<QuizAttemptModel, QuizAttemptModel, QFilterCondition> {
  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterFilterCondition>
      answersElement(FilterQuery<QuizAttemptAnswerModel> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'answers');
    });
  }
}

extension QuizAttemptModelQueryLinks
    on QueryBuilder<QuizAttemptModel, QuizAttemptModel, QFilterCondition> {}

extension QuizAttemptModelQuerySortBy
    on QueryBuilder<QuizAttemptModel, QuizAttemptModel, QSortBy> {
  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterSortBy>
      sortByCompletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedAt', Sort.asc);
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterSortBy>
      sortByCompletedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedAt', Sort.desc);
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterSortBy>
      sortByDurationSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationSeconds', Sort.asc);
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterSortBy>
      sortByDurationSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationSeconds', Sort.desc);
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterSortBy>
      sortByIsPassed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPassed', Sort.asc);
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterSortBy>
      sortByIsPassedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPassed', Sort.desc);
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterSortBy>
      sortByQuizId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quizId', Sort.asc);
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterSortBy>
      sortByQuizIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quizId', Sort.desc);
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterSortBy> sortByScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'score', Sort.asc);
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterSortBy>
      sortByScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'score', Sort.desc);
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterSortBy>
      sortByScorePercent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scorePercent', Sort.asc);
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterSortBy>
      sortByScorePercentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scorePercent', Sort.desc);
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterSortBy>
      sortByStartedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startedAt', Sort.asc);
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterSortBy>
      sortByStartedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startedAt', Sort.desc);
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterSortBy>
      sortByTotalQuestions() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalQuestions', Sort.asc);
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterSortBy>
      sortByTotalQuestionsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalQuestions', Sort.desc);
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterSortBy> sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterSortBy>
      sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension QuizAttemptModelQuerySortThenBy
    on QueryBuilder<QuizAttemptModel, QuizAttemptModel, QSortThenBy> {
  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterSortBy>
      thenByCompletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedAt', Sort.asc);
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterSortBy>
      thenByCompletedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'completedAt', Sort.desc);
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterSortBy>
      thenByDurationSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationSeconds', Sort.asc);
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterSortBy>
      thenByDurationSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'durationSeconds', Sort.desc);
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterSortBy>
      thenByIsPassed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPassed', Sort.asc);
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterSortBy>
      thenByIsPassedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPassed', Sort.desc);
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterSortBy>
      thenByQuizId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quizId', Sort.asc);
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterSortBy>
      thenByQuizIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'quizId', Sort.desc);
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterSortBy> thenByScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'score', Sort.asc);
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterSortBy>
      thenByScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'score', Sort.desc);
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterSortBy>
      thenByScorePercent() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scorePercent', Sort.asc);
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterSortBy>
      thenByScorePercentDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'scorePercent', Sort.desc);
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterSortBy>
      thenByStartedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startedAt', Sort.asc);
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterSortBy>
      thenByStartedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'startedAt', Sort.desc);
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterSortBy>
      thenByTotalQuestions() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalQuestions', Sort.asc);
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterSortBy>
      thenByTotalQuestionsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalQuestions', Sort.desc);
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterSortBy> thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QAfterSortBy>
      thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension QuizAttemptModelQueryWhereDistinct
    on QueryBuilder<QuizAttemptModel, QuizAttemptModel, QDistinct> {
  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QDistinct>
      distinctByCompletedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'completedAt');
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QDistinct>
      distinctByDurationSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'durationSeconds');
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QDistinct>
      distinctByIsPassed() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isPassed');
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QDistinct> distinctByQuizId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'quizId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QDistinct>
      distinctByScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'score');
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QDistinct>
      distinctByScorePercent() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'scorePercent');
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QDistinct>
      distinctByStartedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'startedAt');
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QDistinct>
      distinctByTotalQuestions() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalQuestions');
    });
  }

  QueryBuilder<QuizAttemptModel, QuizAttemptModel, QDistinct> distinctByUuid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }
}

extension QuizAttemptModelQueryProperty
    on QueryBuilder<QuizAttemptModel, QuizAttemptModel, QQueryProperty> {
  QueryBuilder<QuizAttemptModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<QuizAttemptModel, List<QuizAttemptAnswerModel>, QQueryOperations>
      answersProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'answers');
    });
  }

  QueryBuilder<QuizAttemptModel, DateTime?, QQueryOperations>
      completedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'completedAt');
    });
  }

  QueryBuilder<QuizAttemptModel, int, QQueryOperations>
      durationSecondsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'durationSeconds');
    });
  }

  QueryBuilder<QuizAttemptModel, bool, QQueryOperations> isPassedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isPassed');
    });
  }

  QueryBuilder<QuizAttemptModel, String, QQueryOperations> quizIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'quizId');
    });
  }

  QueryBuilder<QuizAttemptModel, int, QQueryOperations> scoreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'score');
    });
  }

  QueryBuilder<QuizAttemptModel, double, QQueryOperations>
      scorePercentProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'scorePercent');
    });
  }

  QueryBuilder<QuizAttemptModel, DateTime?, QQueryOperations>
      startedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'startedAt');
    });
  }

  QueryBuilder<QuizAttemptModel, int, QQueryOperations>
      totalQuestionsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalQuestions');
    });
  }

  QueryBuilder<QuizAttemptModel, String, QQueryOperations> uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetQuizModelCollection on Isar {
  IsarCollection<QuizModel> get quizModels => this.collection();
}

const QuizModelSchema = CollectionSchema(
  name: r'QuizModel',
  id: 6530402973248277489,
  properties: {
    r'attemptCount': PropertySchema(
      id: 0,
      name: r'attemptCount',
      type: IsarType.long,
    ),
    r'bestScore': PropertySchema(
      id: 1,
      name: r'bestScore',
      type: IsarType.long,
    ),
    r'createdAt': PropertySchema(
      id: 2,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'defaultTimeLimitSeconds': PropertySchema(
      id: 3,
      name: r'defaultTimeLimitSeconds',
      type: IsarType.long,
    ),
    r'description': PropertySchema(
      id: 4,
      name: r'description',
      type: IsarType.string,
    ),
    r'isAiGenerated': PropertySchema(
      id: 5,
      name: r'isAiGenerated',
      type: IsarType.bool,
    ),
    r'isPublished': PropertySchema(
      id: 6,
      name: r'isPublished',
      type: IsarType.bool,
    ),
    r'lastAttemptAt': PropertySchema(
      id: 7,
      name: r'lastAttemptAt',
      type: IsarType.dateTime,
    ),
    r'questionCount': PropertySchema(
      id: 8,
      name: r'questionCount',
      type: IsarType.long,
    ),
    r'sourceNoteId': PropertySchema(
      id: 9,
      name: r'sourceNoteId',
      type: IsarType.string,
    ),
    r'subjectId': PropertySchema(
      id: 10,
      name: r'subjectId',
      type: IsarType.string,
    ),
    r'tags': PropertySchema(
      id: 11,
      name: r'tags',
      type: IsarType.stringList,
    ),
    r'title': PropertySchema(
      id: 12,
      name: r'title',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 13,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'uuid': PropertySchema(
      id: 14,
      name: r'uuid',
      type: IsarType.string,
    )
  },
  estimateSize: _quizModelEstimateSize,
  serialize: _quizModelSerialize,
  deserialize: _quizModelDeserialize,
  deserializeProp: _quizModelDeserializeProp,
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
    r'title': IndexSchema(
      id: -7636685945352118059,
      name: r'title',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'title',
          type: IndexType.value,
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
    r'sourceNoteId': IndexSchema(
      id: 8470138718509712414,
      name: r'sourceNoteId',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'sourceNoteId',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'isPublished': IndexSchema(
      id: -798099639650777246,
      name: r'isPublished',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isPublished',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    ),
    r'createdAt': IndexSchema(
      id: -3433535483987302584,
      name: r'createdAt',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'createdAt',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _quizModelGetId,
  getLinks: _quizModelGetLinks,
  attach: _quizModelAttach,
  version: '3.1.0+1',
);

int _quizModelEstimateSize(
  QuizModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.description.length * 3;
  bytesCount += 3 + object.sourceNoteId.length * 3;
  bytesCount += 3 + object.subjectId.length * 3;
  bytesCount += 3 + object.tags.length * 3;
  {
    for (var i = 0; i < object.tags.length; i++) {
      final value = object.tags[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.title.length * 3;
  bytesCount += 3 + object.uuid.length * 3;
  return bytesCount;
}

void _quizModelSerialize(
  QuizModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.attemptCount);
  writer.writeLong(offsets[1], object.bestScore);
  writer.writeDateTime(offsets[2], object.createdAt);
  writer.writeLong(offsets[3], object.defaultTimeLimitSeconds);
  writer.writeString(offsets[4], object.description);
  writer.writeBool(offsets[5], object.isAiGenerated);
  writer.writeBool(offsets[6], object.isPublished);
  writer.writeDateTime(offsets[7], object.lastAttemptAt);
  writer.writeLong(offsets[8], object.questionCount);
  writer.writeString(offsets[9], object.sourceNoteId);
  writer.writeString(offsets[10], object.subjectId);
  writer.writeStringList(offsets[11], object.tags);
  writer.writeString(offsets[12], object.title);
  writer.writeDateTime(offsets[13], object.updatedAt);
  writer.writeString(offsets[14], object.uuid);
}

QuizModel _quizModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = QuizModel(
    attemptCount: reader.readLongOrNull(offsets[0]) ?? 0,
    bestScore: reader.readLongOrNull(offsets[1]) ?? 0,
    createdAt: reader.readDateTimeOrNull(offsets[2]),
    defaultTimeLimitSeconds: reader.readLongOrNull(offsets[3]) ?? 30,
    description: reader.readStringOrNull(offsets[4]) ?? '',
    id: id,
    isAiGenerated: reader.readBoolOrNull(offsets[5]) ?? false,
    isPublished: reader.readBoolOrNull(offsets[6]) ?? false,
    lastAttemptAt: reader.readDateTimeOrNull(offsets[7]),
    questionCount: reader.readLongOrNull(offsets[8]) ?? 0,
    sourceNoteId: reader.readStringOrNull(offsets[9]) ?? '',
    subjectId: reader.readStringOrNull(offsets[10]) ?? '',
    tags: reader.readStringList(offsets[11]) ?? const [],
    title: reader.readStringOrNull(offsets[12]) ?? '',
    updatedAt: reader.readDateTimeOrNull(offsets[13]),
    uuid: reader.readStringOrNull(offsets[14]) ?? '',
  );
  return object;
}

P _quizModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 1:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 2:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset) ?? 30) as P;
    case 4:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 5:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 6:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 7:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 8:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 9:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 10:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 11:
      return (reader.readStringList(offset) ?? const []) as P;
    case 12:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 13:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 14:
      return (reader.readStringOrNull(offset) ?? '') as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _quizModelGetId(QuizModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _quizModelGetLinks(QuizModel object) {
  return [];
}

void _quizModelAttach(IsarCollection<dynamic> col, Id id, QuizModel object) {
  object.id = id;
}

extension QuizModelByIndex on IsarCollection<QuizModel> {
  Future<QuizModel?> getByUuid(String uuid) {
    return getByIndex(r'uuid', [uuid]);
  }

  QuizModel? getByUuidSync(String uuid) {
    return getByIndexSync(r'uuid', [uuid]);
  }

  Future<bool> deleteByUuid(String uuid) {
    return deleteByIndex(r'uuid', [uuid]);
  }

  bool deleteByUuidSync(String uuid) {
    return deleteByIndexSync(r'uuid', [uuid]);
  }

  Future<List<QuizModel?>> getAllByUuid(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndex(r'uuid', values);
  }

  List<QuizModel?> getAllByUuidSync(List<String> uuidValues) {
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

  Future<Id> putByUuid(QuizModel object) {
    return putByIndex(r'uuid', object);
  }

  Id putByUuidSync(QuizModel object, {bool saveLinks = true}) {
    return putByIndexSync(r'uuid', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUuid(List<QuizModel> objects) {
    return putAllByIndex(r'uuid', objects);
  }

  List<Id> putAllByUuidSync(List<QuizModel> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'uuid', objects, saveLinks: saveLinks);
  }
}

extension QuizModelQueryWhereSort
    on QueryBuilder<QuizModel, QuizModel, QWhere> {
  QueryBuilder<QuizModel, QuizModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterWhere> anyTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'title'),
      );
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterWhere> anyIsPublished() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isPublished'),
      );
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterWhere> anyCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'createdAt'),
      );
    });
  }
}

extension QuizModelQueryWhere
    on QueryBuilder<QuizModel, QuizModel, QWhereClause> {
  QueryBuilder<QuizModel, QuizModel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<QuizModel, QuizModel, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterWhereClause> idBetween(
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

  QueryBuilder<QuizModel, QuizModel, QAfterWhereClause> uuidEqualTo(
      String uuid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'uuid',
        value: [uuid],
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterWhereClause> uuidNotEqualTo(
      String uuid) {
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

  QueryBuilder<QuizModel, QuizModel, QAfterWhereClause> titleEqualTo(
      String title) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'title',
        value: [title],
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterWhereClause> titleNotEqualTo(
      String title) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'title',
              lower: [],
              upper: [title],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'title',
              lower: [title],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'title',
              lower: [title],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'title',
              lower: [],
              upper: [title],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterWhereClause> titleGreaterThan(
    String title, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'title',
        lower: [title],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterWhereClause> titleLessThan(
    String title, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'title',
        lower: [],
        upper: [title],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterWhereClause> titleBetween(
    String lowerTitle,
    String upperTitle, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'title',
        lower: [lowerTitle],
        includeLower: includeLower,
        upper: [upperTitle],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterWhereClause> titleStartsWith(
      String TitlePrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'title',
        lower: [TitlePrefix],
        upper: ['$TitlePrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterWhereClause> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'title',
        value: [''],
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterWhereClause> titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'title',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'title',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'title',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'title',
              upper: [''],
            ));
      }
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterWhereClause> subjectIdEqualTo(
      String subjectId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'subjectId',
        value: [subjectId],
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterWhereClause> subjectIdNotEqualTo(
      String subjectId) {
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

  QueryBuilder<QuizModel, QuizModel, QAfterWhereClause> sourceNoteIdEqualTo(
      String sourceNoteId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'sourceNoteId',
        value: [sourceNoteId],
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterWhereClause> sourceNoteIdNotEqualTo(
      String sourceNoteId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'sourceNoteId',
              lower: [],
              upper: [sourceNoteId],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'sourceNoteId',
              lower: [sourceNoteId],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'sourceNoteId',
              lower: [sourceNoteId],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'sourceNoteId',
              lower: [],
              upper: [sourceNoteId],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterWhereClause> isPublishedEqualTo(
      bool isPublished) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isPublished',
        value: [isPublished],
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterWhereClause> isPublishedNotEqualTo(
      bool isPublished) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isPublished',
              lower: [],
              upper: [isPublished],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isPublished',
              lower: [isPublished],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isPublished',
              lower: [isPublished],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isPublished',
              lower: [],
              upper: [isPublished],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterWhereClause> createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'createdAt',
        value: [null],
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterWhereClause> createdAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterWhereClause> createdAtEqualTo(
      DateTime? createdAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'createdAt',
        value: [createdAt],
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterWhereClause> createdAtNotEqualTo(
      DateTime? createdAt) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [],
              upper: [createdAt],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [createdAt],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [createdAt],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'createdAt',
              lower: [],
              upper: [createdAt],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterWhereClause> createdAtGreaterThan(
    DateTime? createdAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [createdAt],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterWhereClause> createdAtLessThan(
    DateTime? createdAt, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [],
        upper: [createdAt],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterWhereClause> createdAtBetween(
    DateTime? lowerCreatedAt,
    DateTime? upperCreatedAt, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'createdAt',
        lower: [lowerCreatedAt],
        includeLower: includeLower,
        upper: [upperCreatedAt],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension QuizModelQueryFilter
    on QueryBuilder<QuizModel, QuizModel, QFilterCondition> {
  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> attemptCountEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'attemptCount',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition>
      attemptCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'attemptCount',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition>
      attemptCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'attemptCount',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> attemptCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'attemptCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> bestScoreEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bestScore',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition>
      bestScoreGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bestScore',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> bestScoreLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bestScore',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> bestScoreBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bestScore',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition>
      createdAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> createdAtEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition>
      createdAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> createdAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> createdAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition>
      defaultTimeLimitSecondsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'defaultTimeLimitSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition>
      defaultTimeLimitSecondsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'defaultTimeLimitSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition>
      defaultTimeLimitSecondsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'defaultTimeLimitSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition>
      defaultTimeLimitSecondsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'defaultTimeLimitSeconds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> descriptionEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition>
      descriptionGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> descriptionLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> descriptionBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'description',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition>
      descriptionStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> descriptionEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> descriptionContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'description',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> descriptionMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'description',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition>
      descriptionIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition>
      descriptionIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'description',
        value: '',
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition>
      isAiGeneratedEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isAiGenerated',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> isPublishedEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isPublished',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition>
      lastAttemptAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastAttemptAt',
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition>
      lastAttemptAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastAttemptAt',
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition>
      lastAttemptAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastAttemptAt',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition>
      lastAttemptAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastAttemptAt',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition>
      lastAttemptAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastAttemptAt',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition>
      lastAttemptAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastAttemptAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition>
      questionCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'questionCount',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition>
      questionCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'questionCount',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition>
      questionCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'questionCount',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition>
      questionCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'questionCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> sourceNoteIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sourceNoteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition>
      sourceNoteIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sourceNoteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition>
      sourceNoteIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sourceNoteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> sourceNoteIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sourceNoteId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition>
      sourceNoteIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sourceNoteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition>
      sourceNoteIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sourceNoteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition>
      sourceNoteIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sourceNoteId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> sourceNoteIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sourceNoteId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition>
      sourceNoteIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sourceNoteId',
        value: '',
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition>
      sourceNoteIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sourceNoteId',
        value: '',
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> subjectIdEqualTo(
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

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition>
      subjectIdGreaterThan(
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

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> subjectIdLessThan(
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

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> subjectIdBetween(
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

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> subjectIdStartsWith(
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

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> subjectIdEndsWith(
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

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> subjectIdContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'subjectId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> subjectIdMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'subjectId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> subjectIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subjectId',
        value: '',
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition>
      subjectIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'subjectId',
        value: '',
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> tagsElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition>
      tagsElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> tagsElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> tagsElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tags',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition>
      tagsElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> tagsElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> tagsElementContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tags',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> tagsElementMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tags',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition>
      tagsElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tags',
        value: '',
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition>
      tagsElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tags',
        value: '',
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> tagsLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> tagsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> tagsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> tagsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition>
      tagsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> tagsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tags',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> titleEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> titleGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> titleLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> titleBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'title',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> titleStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> titleEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> titleContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'title',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> titleMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'title',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> titleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> titleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'title',
        value: '',
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> updatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition>
      updatedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> updatedAtEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition>
      updatedAtGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> updatedAtLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> updatedAtBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> uuidEqualTo(
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

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> uuidGreaterThan(
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

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> uuidLessThan(
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

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> uuidBetween(
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

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> uuidStartsWith(
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

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> uuidEndsWith(
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

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> uuidContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> uuidMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'uuid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterFilterCondition> uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uuid',
        value: '',
      ));
    });
  }
}

extension QuizModelQueryObject
    on QueryBuilder<QuizModel, QuizModel, QFilterCondition> {}

extension QuizModelQueryLinks
    on QueryBuilder<QuizModel, QuizModel, QFilterCondition> {}

extension QuizModelQuerySortBy on QueryBuilder<QuizModel, QuizModel, QSortBy> {
  QueryBuilder<QuizModel, QuizModel, QAfterSortBy> sortByAttemptCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'attemptCount', Sort.asc);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterSortBy> sortByAttemptCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'attemptCount', Sort.desc);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterSortBy> sortByBestScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bestScore', Sort.asc);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterSortBy> sortByBestScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bestScore', Sort.desc);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterSortBy>
      sortByDefaultTimeLimitSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultTimeLimitSeconds', Sort.asc);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterSortBy>
      sortByDefaultTimeLimitSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultTimeLimitSeconds', Sort.desc);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterSortBy> sortByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterSortBy> sortByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterSortBy> sortByIsAiGenerated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAiGenerated', Sort.asc);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterSortBy> sortByIsAiGeneratedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAiGenerated', Sort.desc);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterSortBy> sortByIsPublished() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPublished', Sort.asc);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterSortBy> sortByIsPublishedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPublished', Sort.desc);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterSortBy> sortByLastAttemptAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastAttemptAt', Sort.asc);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterSortBy> sortByLastAttemptAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastAttemptAt', Sort.desc);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterSortBy> sortByQuestionCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questionCount', Sort.asc);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterSortBy> sortByQuestionCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questionCount', Sort.desc);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterSortBy> sortBySourceNoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceNoteId', Sort.asc);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterSortBy> sortBySourceNoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceNoteId', Sort.desc);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterSortBy> sortBySubjectId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subjectId', Sort.asc);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterSortBy> sortBySubjectIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subjectId', Sort.desc);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterSortBy> sortByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterSortBy> sortByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterSortBy> sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterSortBy> sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension QuizModelQuerySortThenBy
    on QueryBuilder<QuizModel, QuizModel, QSortThenBy> {
  QueryBuilder<QuizModel, QuizModel, QAfterSortBy> thenByAttemptCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'attemptCount', Sort.asc);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterSortBy> thenByAttemptCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'attemptCount', Sort.desc);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterSortBy> thenByBestScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bestScore', Sort.asc);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterSortBy> thenByBestScoreDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bestScore', Sort.desc);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterSortBy>
      thenByDefaultTimeLimitSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultTimeLimitSeconds', Sort.asc);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterSortBy>
      thenByDefaultTimeLimitSecondsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'defaultTimeLimitSeconds', Sort.desc);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterSortBy> thenByDescription() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.asc);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterSortBy> thenByDescriptionDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'description', Sort.desc);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterSortBy> thenByIsAiGenerated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAiGenerated', Sort.asc);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterSortBy> thenByIsAiGeneratedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isAiGenerated', Sort.desc);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterSortBy> thenByIsPublished() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPublished', Sort.asc);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterSortBy> thenByIsPublishedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isPublished', Sort.desc);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterSortBy> thenByLastAttemptAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastAttemptAt', Sort.asc);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterSortBy> thenByLastAttemptAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastAttemptAt', Sort.desc);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterSortBy> thenByQuestionCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questionCount', Sort.asc);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterSortBy> thenByQuestionCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'questionCount', Sort.desc);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterSortBy> thenBySourceNoteId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceNoteId', Sort.asc);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterSortBy> thenBySourceNoteIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'sourceNoteId', Sort.desc);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterSortBy> thenBySubjectId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subjectId', Sort.asc);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterSortBy> thenBySubjectIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subjectId', Sort.desc);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterSortBy> thenByTitle() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.asc);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterSortBy> thenByTitleDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'title', Sort.desc);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterSortBy> thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QAfterSortBy> thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }
}

extension QuizModelQueryWhereDistinct
    on QueryBuilder<QuizModel, QuizModel, QDistinct> {
  QueryBuilder<QuizModel, QuizModel, QDistinct> distinctByAttemptCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'attemptCount');
    });
  }

  QueryBuilder<QuizModel, QuizModel, QDistinct> distinctByBestScore() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bestScore');
    });
  }

  QueryBuilder<QuizModel, QuizModel, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<QuizModel, QuizModel, QDistinct>
      distinctByDefaultTimeLimitSeconds() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'defaultTimeLimitSeconds');
    });
  }

  QueryBuilder<QuizModel, QuizModel, QDistinct> distinctByDescription(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'description', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QDistinct> distinctByIsAiGenerated() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isAiGenerated');
    });
  }

  QueryBuilder<QuizModel, QuizModel, QDistinct> distinctByIsPublished() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isPublished');
    });
  }

  QueryBuilder<QuizModel, QuizModel, QDistinct> distinctByLastAttemptAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastAttemptAt');
    });
  }

  QueryBuilder<QuizModel, QuizModel, QDistinct> distinctByQuestionCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'questionCount');
    });
  }

  QueryBuilder<QuizModel, QuizModel, QDistinct> distinctBySourceNoteId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'sourceNoteId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QDistinct> distinctBySubjectId(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'subjectId', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QDistinct> distinctByTags() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'tags');
    });
  }

  QueryBuilder<QuizModel, QuizModel, QDistinct> distinctByTitle(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'title', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<QuizModel, QuizModel, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<QuizModel, QuizModel, QDistinct> distinctByUuid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }
}

extension QuizModelQueryProperty
    on QueryBuilder<QuizModel, QuizModel, QQueryProperty> {
  QueryBuilder<QuizModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<QuizModel, int, QQueryOperations> attemptCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'attemptCount');
    });
  }

  QueryBuilder<QuizModel, int, QQueryOperations> bestScoreProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bestScore');
    });
  }

  QueryBuilder<QuizModel, DateTime?, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<QuizModel, int, QQueryOperations>
      defaultTimeLimitSecondsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'defaultTimeLimitSeconds');
    });
  }

  QueryBuilder<QuizModel, String, QQueryOperations> descriptionProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'description');
    });
  }

  QueryBuilder<QuizModel, bool, QQueryOperations> isAiGeneratedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isAiGenerated');
    });
  }

  QueryBuilder<QuizModel, bool, QQueryOperations> isPublishedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isPublished');
    });
  }

  QueryBuilder<QuizModel, DateTime?, QQueryOperations> lastAttemptAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastAttemptAt');
    });
  }

  QueryBuilder<QuizModel, int, QQueryOperations> questionCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'questionCount');
    });
  }

  QueryBuilder<QuizModel, String, QQueryOperations> sourceNoteIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'sourceNoteId');
    });
  }

  QueryBuilder<QuizModel, String, QQueryOperations> subjectIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'subjectId');
    });
  }

  QueryBuilder<QuizModel, List<String>, QQueryOperations> tagsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'tags');
    });
  }

  QueryBuilder<QuizModel, String, QQueryOperations> titleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'title');
    });
  }

  QueryBuilder<QuizModel, DateTime?, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<QuizModel, String, QQueryOperations> uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const QuizOptionModelSchema = Schema(
  name: r'QuizOptionModel',
  id: -102837985575811359,
  properties: {
    r'explanation': PropertySchema(
      id: 0,
      name: r'explanation',
      type: IsarType.string,
    ),
    r'id': PropertySchema(
      id: 1,
      name: r'id',
      type: IsarType.string,
    ),
    r'isCorrect': PropertySchema(
      id: 2,
      name: r'isCorrect',
      type: IsarType.bool,
    ),
    r'text': PropertySchema(
      id: 3,
      name: r'text',
      type: IsarType.string,
    )
  },
  estimateSize: _quizOptionModelEstimateSize,
  serialize: _quizOptionModelSerialize,
  deserialize: _quizOptionModelDeserialize,
  deserializeProp: _quizOptionModelDeserializeProp,
);

int _quizOptionModelEstimateSize(
  QuizOptionModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.explanation.length * 3;
  bytesCount += 3 + object.id.length * 3;
  bytesCount += 3 + object.text.length * 3;
  return bytesCount;
}

void _quizOptionModelSerialize(
  QuizOptionModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.explanation);
  writer.writeString(offsets[1], object.id);
  writer.writeBool(offsets[2], object.isCorrect);
  writer.writeString(offsets[3], object.text);
}

QuizOptionModel _quizOptionModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = QuizOptionModel(
    explanation: reader.readStringOrNull(offsets[0]) ?? '',
    id: reader.readStringOrNull(offsets[1]) ?? '',
    isCorrect: reader.readBoolOrNull(offsets[2]) ?? false,
    text: reader.readStringOrNull(offsets[3]) ?? '',
  );
  return object;
}

P _quizOptionModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 1:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 2:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 3:
      return (reader.readStringOrNull(offset) ?? '') as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension QuizOptionModelQueryFilter
    on QueryBuilder<QuizOptionModel, QuizOptionModel, QFilterCondition> {
  QueryBuilder<QuizOptionModel, QuizOptionModel, QAfterFilterCondition>
      explanationEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'explanation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizOptionModel, QuizOptionModel, QAfterFilterCondition>
      explanationGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'explanation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizOptionModel, QuizOptionModel, QAfterFilterCondition>
      explanationLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'explanation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizOptionModel, QuizOptionModel, QAfterFilterCondition>
      explanationBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'explanation',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizOptionModel, QuizOptionModel, QAfterFilterCondition>
      explanationStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'explanation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizOptionModel, QuizOptionModel, QAfterFilterCondition>
      explanationEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'explanation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizOptionModel, QuizOptionModel, QAfterFilterCondition>
      explanationContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'explanation',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizOptionModel, QuizOptionModel, QAfterFilterCondition>
      explanationMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'explanation',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizOptionModel, QuizOptionModel, QAfterFilterCondition>
      explanationIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'explanation',
        value: '',
      ));
    });
  }

  QueryBuilder<QuizOptionModel, QuizOptionModel, QAfterFilterCondition>
      explanationIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'explanation',
        value: '',
      ));
    });
  }

  QueryBuilder<QuizOptionModel, QuizOptionModel, QAfterFilterCondition>
      idEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizOptionModel, QuizOptionModel, QAfterFilterCondition>
      idGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizOptionModel, QuizOptionModel, QAfterFilterCondition>
      idLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizOptionModel, QuizOptionModel, QAfterFilterCondition>
      idBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'id',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizOptionModel, QuizOptionModel, QAfterFilterCondition>
      idStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizOptionModel, QuizOptionModel, QAfterFilterCondition>
      idEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizOptionModel, QuizOptionModel, QAfterFilterCondition>
      idContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'id',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizOptionModel, QuizOptionModel, QAfterFilterCondition>
      idMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'id',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizOptionModel, QuizOptionModel, QAfterFilterCondition>
      idIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<QuizOptionModel, QuizOptionModel, QAfterFilterCondition>
      idIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'id',
        value: '',
      ));
    });
  }

  QueryBuilder<QuizOptionModel, QuizOptionModel, QAfterFilterCondition>
      isCorrectEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCorrect',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizOptionModel, QuizOptionModel, QAfterFilterCondition>
      textEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizOptionModel, QuizOptionModel, QAfterFilterCondition>
      textGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizOptionModel, QuizOptionModel, QAfterFilterCondition>
      textLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizOptionModel, QuizOptionModel, QAfterFilterCondition>
      textBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'text',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizOptionModel, QuizOptionModel, QAfterFilterCondition>
      textStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizOptionModel, QuizOptionModel, QAfterFilterCondition>
      textEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizOptionModel, QuizOptionModel, QAfterFilterCondition>
      textContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizOptionModel, QuizOptionModel, QAfterFilterCondition>
      textMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'text',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizOptionModel, QuizOptionModel, QAfterFilterCondition>
      textIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'text',
        value: '',
      ));
    });
  }

  QueryBuilder<QuizOptionModel, QuizOptionModel, QAfterFilterCondition>
      textIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'text',
        value: '',
      ));
    });
  }
}

extension QuizOptionModelQueryObject
    on QueryBuilder<QuizOptionModel, QuizOptionModel, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const QuizAttemptAnswerModelSchema = Schema(
  name: r'QuizAttemptAnswerModel',
  id: -4488915156417365663,
  properties: {
    r'chosenOptionId': PropertySchema(
      id: 0,
      name: r'chosenOptionId',
      type: IsarType.string,
    ),
    r'chosenText': PropertySchema(
      id: 1,
      name: r'chosenText',
      type: IsarType.string,
    ),
    r'isCorrect': PropertySchema(
      id: 2,
      name: r'isCorrect',
      type: IsarType.bool,
    ),
    r'questionUuid': PropertySchema(
      id: 3,
      name: r'questionUuid',
      type: IsarType.string,
    ),
    r'timeTakenSeconds': PropertySchema(
      id: 4,
      name: r'timeTakenSeconds',
      type: IsarType.long,
    )
  },
  estimateSize: _quizAttemptAnswerModelEstimateSize,
  serialize: _quizAttemptAnswerModelSerialize,
  deserialize: _quizAttemptAnswerModelDeserialize,
  deserializeProp: _quizAttemptAnswerModelDeserializeProp,
);

int _quizAttemptAnswerModelEstimateSize(
  QuizAttemptAnswerModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.chosenOptionId.length * 3;
  bytesCount += 3 + object.chosenText.length * 3;
  bytesCount += 3 + object.questionUuid.length * 3;
  return bytesCount;
}

void _quizAttemptAnswerModelSerialize(
  QuizAttemptAnswerModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.chosenOptionId);
  writer.writeString(offsets[1], object.chosenText);
  writer.writeBool(offsets[2], object.isCorrect);
  writer.writeString(offsets[3], object.questionUuid);
  writer.writeLong(offsets[4], object.timeTakenSeconds);
}

QuizAttemptAnswerModel _quizAttemptAnswerModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = QuizAttemptAnswerModel(
    chosenOptionId: reader.readStringOrNull(offsets[0]) ?? '',
    chosenText: reader.readStringOrNull(offsets[1]) ?? '',
    isCorrect: reader.readBoolOrNull(offsets[2]) ?? false,
    questionUuid: reader.readStringOrNull(offsets[3]) ?? '',
    timeTakenSeconds: reader.readLongOrNull(offsets[4]) ?? 0,
  );
  return object;
}

P _quizAttemptAnswerModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 1:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 2:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 3:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 4:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension QuizAttemptAnswerModelQueryFilter on QueryBuilder<
    QuizAttemptAnswerModel, QuizAttemptAnswerModel, QFilterCondition> {
  QueryBuilder<QuizAttemptAnswerModel, QuizAttemptAnswerModel,
      QAfterFilterCondition> chosenOptionIdEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chosenOptionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizAttemptAnswerModel, QuizAttemptAnswerModel,
      QAfterFilterCondition> chosenOptionIdGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'chosenOptionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizAttemptAnswerModel, QuizAttemptAnswerModel,
      QAfterFilterCondition> chosenOptionIdLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'chosenOptionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizAttemptAnswerModel, QuizAttemptAnswerModel,
      QAfterFilterCondition> chosenOptionIdBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'chosenOptionId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizAttemptAnswerModel, QuizAttemptAnswerModel,
      QAfterFilterCondition> chosenOptionIdStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'chosenOptionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizAttemptAnswerModel, QuizAttemptAnswerModel,
      QAfterFilterCondition> chosenOptionIdEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'chosenOptionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizAttemptAnswerModel, QuizAttemptAnswerModel,
          QAfterFilterCondition>
      chosenOptionIdContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'chosenOptionId',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizAttemptAnswerModel, QuizAttemptAnswerModel,
          QAfterFilterCondition>
      chosenOptionIdMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'chosenOptionId',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizAttemptAnswerModel, QuizAttemptAnswerModel,
      QAfterFilterCondition> chosenOptionIdIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chosenOptionId',
        value: '',
      ));
    });
  }

  QueryBuilder<QuizAttemptAnswerModel, QuizAttemptAnswerModel,
      QAfterFilterCondition> chosenOptionIdIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'chosenOptionId',
        value: '',
      ));
    });
  }

  QueryBuilder<QuizAttemptAnswerModel, QuizAttemptAnswerModel,
      QAfterFilterCondition> chosenTextEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chosenText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizAttemptAnswerModel, QuizAttemptAnswerModel,
      QAfterFilterCondition> chosenTextGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'chosenText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizAttemptAnswerModel, QuizAttemptAnswerModel,
      QAfterFilterCondition> chosenTextLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'chosenText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizAttemptAnswerModel, QuizAttemptAnswerModel,
      QAfterFilterCondition> chosenTextBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'chosenText',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizAttemptAnswerModel, QuizAttemptAnswerModel,
      QAfterFilterCondition> chosenTextStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'chosenText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizAttemptAnswerModel, QuizAttemptAnswerModel,
      QAfterFilterCondition> chosenTextEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'chosenText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizAttemptAnswerModel, QuizAttemptAnswerModel,
          QAfterFilterCondition>
      chosenTextContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'chosenText',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizAttemptAnswerModel, QuizAttemptAnswerModel,
          QAfterFilterCondition>
      chosenTextMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'chosenText',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizAttemptAnswerModel, QuizAttemptAnswerModel,
      QAfterFilterCondition> chosenTextIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'chosenText',
        value: '',
      ));
    });
  }

  QueryBuilder<QuizAttemptAnswerModel, QuizAttemptAnswerModel,
      QAfterFilterCondition> chosenTextIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'chosenText',
        value: '',
      ));
    });
  }

  QueryBuilder<QuizAttemptAnswerModel, QuizAttemptAnswerModel,
      QAfterFilterCondition> isCorrectEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isCorrect',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizAttemptAnswerModel, QuizAttemptAnswerModel,
      QAfterFilterCondition> questionUuidEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'questionUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizAttemptAnswerModel, QuizAttemptAnswerModel,
      QAfterFilterCondition> questionUuidGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'questionUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizAttemptAnswerModel, QuizAttemptAnswerModel,
      QAfterFilterCondition> questionUuidLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'questionUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizAttemptAnswerModel, QuizAttemptAnswerModel,
      QAfterFilterCondition> questionUuidBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'questionUuid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizAttemptAnswerModel, QuizAttemptAnswerModel,
      QAfterFilterCondition> questionUuidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'questionUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizAttemptAnswerModel, QuizAttemptAnswerModel,
      QAfterFilterCondition> questionUuidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'questionUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizAttemptAnswerModel, QuizAttemptAnswerModel,
          QAfterFilterCondition>
      questionUuidContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'questionUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizAttemptAnswerModel, QuizAttemptAnswerModel,
          QAfterFilterCondition>
      questionUuidMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'questionUuid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuizAttemptAnswerModel, QuizAttemptAnswerModel,
      QAfterFilterCondition> questionUuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'questionUuid',
        value: '',
      ));
    });
  }

  QueryBuilder<QuizAttemptAnswerModel, QuizAttemptAnswerModel,
      QAfterFilterCondition> questionUuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'questionUuid',
        value: '',
      ));
    });
  }

  QueryBuilder<QuizAttemptAnswerModel, QuizAttemptAnswerModel,
      QAfterFilterCondition> timeTakenSecondsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'timeTakenSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizAttemptAnswerModel, QuizAttemptAnswerModel,
      QAfterFilterCondition> timeTakenSecondsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'timeTakenSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizAttemptAnswerModel, QuizAttemptAnswerModel,
      QAfterFilterCondition> timeTakenSecondsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'timeTakenSeconds',
        value: value,
      ));
    });
  }

  QueryBuilder<QuizAttemptAnswerModel, QuizAttemptAnswerModel,
      QAfterFilterCondition> timeTakenSecondsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'timeTakenSeconds',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension QuizAttemptAnswerModelQueryObject on QueryBuilder<
    QuizAttemptAnswerModel, QuizAttemptAnswerModel, QFilterCondition> {}
