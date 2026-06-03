// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'gpa_entry_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetGpaEntryModelCollection on Isar {
  IsarCollection<GpaEntryModel> get gpaEntryModels => this.collection();
}

const GpaEntryModelSchema = CollectionSchema(
  name: r'GpaEntryModel',
  id: 5356385913764185118,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'credits': PropertySchema(
      id: 1,
      name: r'credits',
      type: IsarType.long,
    ),
    r'examType': PropertySchema(
      id: 2,
      name: r'examType',
      type: IsarType.string,
    ),
    r'gradePoint': PropertySchema(
      id: 3,
      name: r'gradePoint',
      type: IsarType.double,
    ),
    r'isInternal': PropertySchema(
      id: 4,
      name: r'isInternal',
      type: IsarType.bool,
    ),
    r'letterGrade': PropertySchema(
      id: 5,
      name: r'letterGrade',
      type: IsarType.string,
    ),
    r'marksObtained': PropertySchema(
      id: 6,
      name: r'marksObtained',
      type: IsarType.double,
    ),
    r'maxMarks': PropertySchema(
      id: 7,
      name: r'maxMarks',
      type: IsarType.double,
    ),
    r'notes': PropertySchema(
      id: 8,
      name: r'notes',
      type: IsarType.string,
    ),
    r'percentage': PropertySchema(
      id: 9,
      name: r'percentage',
      type: IsarType.double,
    ),
    r'semesterLabel': PropertySchema(
      id: 10,
      name: r'semesterLabel',
      type: IsarType.string,
    ),
    r'subjectCode': PropertySchema(
      id: 11,
      name: r'subjectCode',
      type: IsarType.string,
    ),
    r'subjectName': PropertySchema(
      id: 12,
      name: r'subjectName',
      type: IsarType.string,
    ),
    r'subjectUuid': PropertySchema(
      id: 13,
      name: r'subjectUuid',
      type: IsarType.string,
    ),
    r'uuid': PropertySchema(
      id: 14,
      name: r'uuid',
      type: IsarType.string,
    ),
    r'weightedGradePoints': PropertySchema(
      id: 15,
      name: r'weightedGradePoints',
      type: IsarType.double,
    )
  },
  estimateSize: _gpaEntryModelEstimateSize,
  serialize: _gpaEntryModelSerialize,
  deserialize: _gpaEntryModelDeserialize,
  deserializeProp: _gpaEntryModelDeserializeProp,
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
    r'subjectName': IndexSchema(
      id: -2702852998942163311,
      name: r'subjectName',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'subjectName',
          type: IndexType.value,
          caseSensitive: true,
        )
      ],
    ),
    r'subjectUuid': IndexSchema(
      id: -630854241714589217,
      name: r'subjectUuid',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'subjectUuid',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'semesterLabel': IndexSchema(
      id: -539455878950126429,
      name: r'semesterLabel',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'semesterLabel',
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
  embeddedSchemas: {},
  getId: _gpaEntryModelGetId,
  getLinks: _gpaEntryModelGetLinks,
  attach: _gpaEntryModelAttach,
  version: '3.1.0+1',
);

int _gpaEntryModelEstimateSize(
  GpaEntryModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.examType.length * 3;
  bytesCount += 3 + object.letterGrade.length * 3;
  bytesCount += 3 + object.notes.length * 3;
  bytesCount += 3 + object.semesterLabel.length * 3;
  bytesCount += 3 + object.subjectCode.length * 3;
  bytesCount += 3 + object.subjectName.length * 3;
  bytesCount += 3 + object.subjectUuid.length * 3;
  bytesCount += 3 + object.uuid.length * 3;
  return bytesCount;
}

void _gpaEntryModelSerialize(
  GpaEntryModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeDateTime(offsets[0], object.createdAt);
  writer.writeLong(offsets[1], object.credits);
  writer.writeString(offsets[2], object.examType);
  writer.writeDouble(offsets[3], object.gradePoint);
  writer.writeBool(offsets[4], object.isInternal);
  writer.writeString(offsets[5], object.letterGrade);
  writer.writeDouble(offsets[6], object.marksObtained);
  writer.writeDouble(offsets[7], object.maxMarks);
  writer.writeString(offsets[8], object.notes);
  writer.writeDouble(offsets[9], object.percentage);
  writer.writeString(offsets[10], object.semesterLabel);
  writer.writeString(offsets[11], object.subjectCode);
  writer.writeString(offsets[12], object.subjectName);
  writer.writeString(offsets[13], object.subjectUuid);
  writer.writeString(offsets[14], object.uuid);
  writer.writeDouble(offsets[15], object.weightedGradePoints);
}

GpaEntryModel _gpaEntryModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = GpaEntryModel(
    createdAt: reader.readDateTimeOrNull(offsets[0]),
    credits: reader.readLongOrNull(offsets[1]) ?? 0,
    examType: reader.readStringOrNull(offsets[2]) ?? '',
    gradePoint: reader.readDoubleOrNull(offsets[3]) ?? 0.0,
    id: id,
    isInternal: reader.readBoolOrNull(offsets[4]) ?? false,
    letterGrade: reader.readStringOrNull(offsets[5]) ?? '',
    marksObtained: reader.readDoubleOrNull(offsets[6]) ?? 0.0,
    maxMarks: reader.readDoubleOrNull(offsets[7]) ?? 100.0,
    notes: reader.readStringOrNull(offsets[8]) ?? '',
    semesterLabel: reader.readStringOrNull(offsets[10]) ?? '',
    subjectCode: reader.readStringOrNull(offsets[11]) ?? '',
    subjectName: reader.readStringOrNull(offsets[12]) ?? '',
    subjectUuid: reader.readStringOrNull(offsets[13]) ?? '',
    uuid: reader.readStringOrNull(offsets[14]) ?? '',
  );
  return object;
}

P _gpaEntryModelDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 1:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 2:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 3:
      return (reader.readDoubleOrNull(offset) ?? 0.0) as P;
    case 4:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 5:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 6:
      return (reader.readDoubleOrNull(offset) ?? 0.0) as P;
    case 7:
      return (reader.readDoubleOrNull(offset) ?? 100.0) as P;
    case 8:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 9:
      return (reader.readDouble(offset)) as P;
    case 10:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 11:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 12:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 13:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 14:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 15:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _gpaEntryModelGetId(GpaEntryModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _gpaEntryModelGetLinks(GpaEntryModel object) {
  return [];
}

void _gpaEntryModelAttach(
    IsarCollection<dynamic> col, Id id, GpaEntryModel object) {
  object.id = id;
}

extension GpaEntryModelByIndex on IsarCollection<GpaEntryModel> {
  Future<GpaEntryModel?> getByUuid(String uuid) {
    return getByIndex(r'uuid', [uuid]);
  }

  GpaEntryModel? getByUuidSync(String uuid) {
    return getByIndexSync(r'uuid', [uuid]);
  }

  Future<bool> deleteByUuid(String uuid) {
    return deleteByIndex(r'uuid', [uuid]);
  }

  bool deleteByUuidSync(String uuid) {
    return deleteByIndexSync(r'uuid', [uuid]);
  }

  Future<List<GpaEntryModel?>> getAllByUuid(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndex(r'uuid', values);
  }

  List<GpaEntryModel?> getAllByUuidSync(List<String> uuidValues) {
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

  Future<Id> putByUuid(GpaEntryModel object) {
    return putByIndex(r'uuid', object);
  }

  Id putByUuidSync(GpaEntryModel object, {bool saveLinks = true}) {
    return putByIndexSync(r'uuid', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUuid(List<GpaEntryModel> objects) {
    return putAllByIndex(r'uuid', objects);
  }

  List<Id> putAllByUuidSync(List<GpaEntryModel> objects,
      {bool saveLinks = true}) {
    return putAllByIndexSync(r'uuid', objects, saveLinks: saveLinks);
  }
}

extension GpaEntryModelQueryWhereSort
    on QueryBuilder<GpaEntryModel, GpaEntryModel, QWhere> {
  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterWhere> anySubjectName() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'subjectName'),
      );
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterWhere> anyCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'createdAt'),
      );
    });
  }
}

extension GpaEntryModelQueryWhere
    on QueryBuilder<GpaEntryModel, GpaEntryModel, QWhereClause> {
  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterWhereClause> idEqualTo(
      Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterWhereClause> idNotEqualTo(
      Id id) {
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

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterWhereClause> idGreaterThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterWhereClause> idLessThan(
      Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterWhereClause> idBetween(
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

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterWhereClause> uuidEqualTo(
      String uuid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'uuid',
        value: [uuid],
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterWhereClause> uuidNotEqualTo(
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

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterWhereClause>
      subjectNameEqualTo(String subjectName) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'subjectName',
        value: [subjectName],
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterWhereClause>
      subjectNameNotEqualTo(String subjectName) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'subjectName',
              lower: [],
              upper: [subjectName],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'subjectName',
              lower: [subjectName],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'subjectName',
              lower: [subjectName],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'subjectName',
              lower: [],
              upper: [subjectName],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterWhereClause>
      subjectNameGreaterThan(
    String subjectName, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'subjectName',
        lower: [subjectName],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterWhereClause>
      subjectNameLessThan(
    String subjectName, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'subjectName',
        lower: [],
        upper: [subjectName],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterWhereClause>
      subjectNameBetween(
    String lowerSubjectName,
    String upperSubjectName, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'subjectName',
        lower: [lowerSubjectName],
        includeLower: includeLower,
        upper: [upperSubjectName],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterWhereClause>
      subjectNameStartsWith(String SubjectNamePrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'subjectName',
        lower: [SubjectNamePrefix],
        upper: ['$SubjectNamePrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterWhereClause>
      subjectNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'subjectName',
        value: [''],
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterWhereClause>
      subjectNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'subjectName',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'subjectName',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'subjectName',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'subjectName',
              upper: [''],
            ));
      }
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterWhereClause>
      subjectUuidEqualTo(String subjectUuid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'subjectUuid',
        value: [subjectUuid],
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterWhereClause>
      subjectUuidNotEqualTo(String subjectUuid) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'subjectUuid',
              lower: [],
              upper: [subjectUuid],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'subjectUuid',
              lower: [subjectUuid],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'subjectUuid',
              lower: [subjectUuid],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'subjectUuid',
              lower: [],
              upper: [subjectUuid],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterWhereClause>
      semesterLabelEqualTo(String semesterLabel) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'semesterLabel',
        value: [semesterLabel],
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterWhereClause>
      semesterLabelNotEqualTo(String semesterLabel) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'semesterLabel',
              lower: [],
              upper: [semesterLabel],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'semesterLabel',
              lower: [semesterLabel],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'semesterLabel',
              lower: [semesterLabel],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'semesterLabel',
              lower: [],
              upper: [semesterLabel],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterWhereClause>
      createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'createdAt',
        value: [null],
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterWhereClause>
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

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterWhereClause>
      createdAtEqualTo(DateTime? createdAt) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'createdAt',
        value: [createdAt],
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterWhereClause>
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

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterWhereClause>
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

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterWhereClause>
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

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterWhereClause>
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

extension GpaEntryModelQueryFilter
    on QueryBuilder<GpaEntryModel, GpaEntryModel, QFilterCondition> {
  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      createdAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      createdAtEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
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

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
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

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
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

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      creditsEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'credits',
        value: value,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      creditsGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'credits',
        value: value,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      creditsLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'credits',
        value: value,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      creditsBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'credits',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      examTypeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'examType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      examTypeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'examType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      examTypeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'examType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      examTypeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'examType',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      examTypeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'examType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      examTypeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'examType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      examTypeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'examType',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      examTypeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'examType',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      examTypeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'examType',
        value: '',
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      examTypeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'examType',
        value: '',
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      gradePointEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gradePoint',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      gradePointGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'gradePoint',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      gradePointLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'gradePoint',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      gradePointBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'gradePoint',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
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

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      isInternalEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isInternal',
        value: value,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      letterGradeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'letterGrade',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      letterGradeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'letterGrade',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      letterGradeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'letterGrade',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      letterGradeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'letterGrade',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      letterGradeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'letterGrade',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      letterGradeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'letterGrade',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      letterGradeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'letterGrade',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      letterGradeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'letterGrade',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      letterGradeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'letterGrade',
        value: '',
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      letterGradeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'letterGrade',
        value: '',
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      marksObtainedEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'marksObtained',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      marksObtainedGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'marksObtained',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      marksObtainedLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'marksObtained',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      marksObtainedBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'marksObtained',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      maxMarksEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'maxMarks',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      maxMarksGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'maxMarks',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      maxMarksLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'maxMarks',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      maxMarksBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'maxMarks',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      notesEqualTo(
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

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      notesGreaterThan(
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

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      notesLessThan(
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

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      notesBetween(
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

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      notesStartsWith(
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

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      notesEndsWith(
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

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      notesContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'notes',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      notesMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'notes',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      notesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      notesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'notes',
        value: '',
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      percentageEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'percentage',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      percentageGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'percentage',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      percentageLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'percentage',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      percentageBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'percentage',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      semesterLabelEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'semesterLabel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      semesterLabelGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'semesterLabel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      semesterLabelLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'semesterLabel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      semesterLabelBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'semesterLabel',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      semesterLabelStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'semesterLabel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      semesterLabelEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'semesterLabel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      semesterLabelContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'semesterLabel',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      semesterLabelMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'semesterLabel',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      semesterLabelIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'semesterLabel',
        value: '',
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      semesterLabelIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'semesterLabel',
        value: '',
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      subjectCodeEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subjectCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      subjectCodeGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'subjectCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      subjectCodeLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'subjectCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      subjectCodeBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'subjectCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      subjectCodeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'subjectCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      subjectCodeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'subjectCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      subjectCodeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'subjectCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      subjectCodeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'subjectCode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      subjectCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subjectCode',
        value: '',
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      subjectCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'subjectCode',
        value: '',
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      subjectNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subjectName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      subjectNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'subjectName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      subjectNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'subjectName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      subjectNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'subjectName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      subjectNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'subjectName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      subjectNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'subjectName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      subjectNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'subjectName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      subjectNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'subjectName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      subjectNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subjectName',
        value: '',
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      subjectNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'subjectName',
        value: '',
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      subjectUuidEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subjectUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      subjectUuidGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'subjectUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      subjectUuidLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'subjectUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      subjectUuidBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'subjectUuid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      subjectUuidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'subjectUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      subjectUuidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'subjectUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      subjectUuidContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'subjectUuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      subjectUuidMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'subjectUuid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      subjectUuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'subjectUuid',
        value: '',
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      subjectUuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'subjectUuid',
        value: '',
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition> uuidEqualTo(
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

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
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

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
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

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition> uuidBetween(
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

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
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

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
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

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      uuidContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uuid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition> uuidMatches(
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

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      weightedGradePointsEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weightedGradePoints',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      weightedGradePointsGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'weightedGradePoints',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      weightedGradePointsLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'weightedGradePoints',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterFilterCondition>
      weightedGradePointsBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'weightedGradePoints',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension GpaEntryModelQueryObject
    on QueryBuilder<GpaEntryModel, GpaEntryModel, QFilterCondition> {}

extension GpaEntryModelQueryLinks
    on QueryBuilder<GpaEntryModel, GpaEntryModel, QFilterCondition> {}

extension GpaEntryModelQuerySortBy
    on QueryBuilder<GpaEntryModel, GpaEntryModel, QSortBy> {
  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy>
      sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy> sortByCredits() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'credits', Sort.asc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy> sortByCreditsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'credits', Sort.desc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy> sortByExamType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'examType', Sort.asc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy>
      sortByExamTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'examType', Sort.desc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy> sortByGradePoint() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gradePoint', Sort.asc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy>
      sortByGradePointDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gradePoint', Sort.desc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy> sortByIsInternal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isInternal', Sort.asc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy>
      sortByIsInternalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isInternal', Sort.desc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy> sortByLetterGrade() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'letterGrade', Sort.asc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy>
      sortByLetterGradeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'letterGrade', Sort.desc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy>
      sortByMarksObtained() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'marksObtained', Sort.asc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy>
      sortByMarksObtainedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'marksObtained', Sort.desc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy> sortByMaxMarks() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxMarks', Sort.asc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy>
      sortByMaxMarksDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxMarks', Sort.desc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy> sortByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy> sortByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy> sortByPercentage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'percentage', Sort.asc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy>
      sortByPercentageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'percentage', Sort.desc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy>
      sortBySemesterLabel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'semesterLabel', Sort.asc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy>
      sortBySemesterLabelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'semesterLabel', Sort.desc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy> sortBySubjectCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subjectCode', Sort.asc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy>
      sortBySubjectCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subjectCode', Sort.desc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy> sortBySubjectName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subjectName', Sort.asc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy>
      sortBySubjectNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subjectName', Sort.desc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy> sortBySubjectUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subjectUuid', Sort.asc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy>
      sortBySubjectUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subjectUuid', Sort.desc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy> sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy> sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy>
      sortByWeightedGradePoints() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightedGradePoints', Sort.asc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy>
      sortByWeightedGradePointsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightedGradePoints', Sort.desc);
    });
  }
}

extension GpaEntryModelQuerySortThenBy
    on QueryBuilder<GpaEntryModel, GpaEntryModel, QSortThenBy> {
  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy>
      thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy> thenByCredits() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'credits', Sort.asc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy> thenByCreditsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'credits', Sort.desc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy> thenByExamType() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'examType', Sort.asc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy>
      thenByExamTypeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'examType', Sort.desc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy> thenByGradePoint() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gradePoint', Sort.asc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy>
      thenByGradePointDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gradePoint', Sort.desc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy> thenByIsInternal() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isInternal', Sort.asc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy>
      thenByIsInternalDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isInternal', Sort.desc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy> thenByLetterGrade() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'letterGrade', Sort.asc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy>
      thenByLetterGradeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'letterGrade', Sort.desc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy>
      thenByMarksObtained() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'marksObtained', Sort.asc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy>
      thenByMarksObtainedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'marksObtained', Sort.desc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy> thenByMaxMarks() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxMarks', Sort.asc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy>
      thenByMaxMarksDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'maxMarks', Sort.desc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy> thenByNotes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.asc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy> thenByNotesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'notes', Sort.desc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy> thenByPercentage() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'percentage', Sort.asc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy>
      thenByPercentageDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'percentage', Sort.desc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy>
      thenBySemesterLabel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'semesterLabel', Sort.asc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy>
      thenBySemesterLabelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'semesterLabel', Sort.desc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy> thenBySubjectCode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subjectCode', Sort.asc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy>
      thenBySubjectCodeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subjectCode', Sort.desc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy> thenBySubjectName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subjectName', Sort.asc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy>
      thenBySubjectNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subjectName', Sort.desc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy> thenBySubjectUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subjectUuid', Sort.asc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy>
      thenBySubjectUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'subjectUuid', Sort.desc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy> thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy> thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy>
      thenByWeightedGradePoints() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightedGradePoints', Sort.asc);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QAfterSortBy>
      thenByWeightedGradePointsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weightedGradePoints', Sort.desc);
    });
  }
}

extension GpaEntryModelQueryWhereDistinct
    on QueryBuilder<GpaEntryModel, GpaEntryModel, QDistinct> {
  QueryBuilder<GpaEntryModel, GpaEntryModel, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QDistinct> distinctByCredits() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'credits');
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QDistinct> distinctByExamType(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'examType', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QDistinct> distinctByGradePoint() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'gradePoint');
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QDistinct> distinctByIsInternal() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isInternal');
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QDistinct> distinctByLetterGrade(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'letterGrade', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QDistinct>
      distinctByMarksObtained() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'marksObtained');
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QDistinct> distinctByMaxMarks() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'maxMarks');
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QDistinct> distinctByNotes(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'notes', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QDistinct> distinctByPercentage() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'percentage');
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QDistinct> distinctBySemesterLabel(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'semesterLabel',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QDistinct> distinctBySubjectCode(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'subjectCode', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QDistinct> distinctBySubjectName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'subjectName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QDistinct> distinctBySubjectUuid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'subjectUuid', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QDistinct> distinctByUuid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<GpaEntryModel, GpaEntryModel, QDistinct>
      distinctByWeightedGradePoints() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weightedGradePoints');
    });
  }
}

extension GpaEntryModelQueryProperty
    on QueryBuilder<GpaEntryModel, GpaEntryModel, QQueryProperty> {
  QueryBuilder<GpaEntryModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<GpaEntryModel, DateTime?, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<GpaEntryModel, int, QQueryOperations> creditsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'credits');
    });
  }

  QueryBuilder<GpaEntryModel, String, QQueryOperations> examTypeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'examType');
    });
  }

  QueryBuilder<GpaEntryModel, double, QQueryOperations> gradePointProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'gradePoint');
    });
  }

  QueryBuilder<GpaEntryModel, bool, QQueryOperations> isInternalProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isInternal');
    });
  }

  QueryBuilder<GpaEntryModel, String, QQueryOperations> letterGradeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'letterGrade');
    });
  }

  QueryBuilder<GpaEntryModel, double, QQueryOperations>
      marksObtainedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'marksObtained');
    });
  }

  QueryBuilder<GpaEntryModel, double, QQueryOperations> maxMarksProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'maxMarks');
    });
  }

  QueryBuilder<GpaEntryModel, String, QQueryOperations> notesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'notes');
    });
  }

  QueryBuilder<GpaEntryModel, double, QQueryOperations> percentageProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'percentage');
    });
  }

  QueryBuilder<GpaEntryModel, String, QQueryOperations>
      semesterLabelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'semesterLabel');
    });
  }

  QueryBuilder<GpaEntryModel, String, QQueryOperations> subjectCodeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'subjectCode');
    });
  }

  QueryBuilder<GpaEntryModel, String, QQueryOperations> subjectNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'subjectName');
    });
  }

  QueryBuilder<GpaEntryModel, String, QQueryOperations> subjectUuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'subjectUuid');
    });
  }

  QueryBuilder<GpaEntryModel, String, QQueryOperations> uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }

  QueryBuilder<GpaEntryModel, double, QQueryOperations>
      weightedGradePointsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weightedGradePoints');
    });
  }
}
