// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_model.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetUserModelCollection on Isar {
  IsarCollection<UserModel> get userModels => this.collection();
}

const UserModelSchema = CollectionSchema(
  name: r'UserModel',
  id: 7195426469378571114,
  properties: {
    r'avatarPath': PropertySchema(
      id: 0,
      name: r'avatarPath',
      type: IsarType.string,
    ),
    r'bio': PropertySchema(
      id: 1,
      name: r'bio',
      type: IsarType.string,
    ),
    r'createdAt': PropertySchema(
      id: 2,
      name: r'createdAt',
      type: IsarType.dateTime,
    ),
    r'currentStreakDays': PropertySchema(
      id: 3,
      name: r'currentStreakDays',
      type: IsarType.long,
    ),
    r'dailyFocusGoalMinutes': PropertySchema(
      id: 4,
      name: r'dailyFocusGoalMinutes',
      type: IsarType.long,
    ),
    r'dailyTaskGoalCount': PropertySchema(
      id: 5,
      name: r'dailyTaskGoalCount',
      type: IsarType.long,
    ),
    r'displayName': PropertySchema(
      id: 6,
      name: r'displayName',
      type: IsarType.string,
    ),
    r'earnedBadgeKeys': PropertySchema(
      id: 7,
      name: r'earnedBadgeKeys',
      type: IsarType.stringList,
    ),
    r'email': PropertySchema(
      id: 8,
      name: r'email',
      type: IsarType.string,
    ),
    r'fieldOfStudy': PropertySchema(
      id: 9,
      name: r'fieldOfStudy',
      type: IsarType.string,
    ),
    r'gradeOrYear': PropertySchema(
      id: 10,
      name: r'gradeOrYear',
      type: IsarType.string,
    ),
    r'hasAvatar': PropertySchema(
      id: 11,
      name: r'hasAvatar',
      type: IsarType.bool,
    ),
    r'hasCompletedOnboarding': PropertySchema(
      id: 12,
      name: r'hasCompletedOnboarding',
      type: IsarType.bool,
    ),
    r'initials': PropertySchema(
      id: 13,
      name: r'initials',
      type: IsarType.string,
    ),
    r'institutionName': PropertySchema(
      id: 14,
      name: r'institutionName',
      type: IsarType.string,
    ),
    r'lastActiveDate': PropertySchema(
      id: 15,
      name: r'lastActiveDate',
      type: IsarType.dateTime,
    ),
    r'level': PropertySchema(
      id: 16,
      name: r'level',
      type: IsarType.long,
    ),
    r'longestStreakDays': PropertySchema(
      id: 17,
      name: r'longestStreakDays',
      type: IsarType.long,
    ),
    r'pomodoroLongBreakMinutes': PropertySchema(
      id: 18,
      name: r'pomodoroLongBreakMinutes',
      type: IsarType.long,
    ),
    r'pomodoroShortBreakMinutes': PropertySchema(
      id: 19,
      name: r'pomodoroShortBreakMinutes',
      type: IsarType.long,
    ),
    r'pomodoroWorkMinutes': PropertySchema(
      id: 20,
      name: r'pomodoroWorkMinutes',
      type: IsarType.long,
    ),
    r'pomodorosBeforeLongBreak': PropertySchema(
      id: 21,
      name: r'pomodorosBeforeLongBreak',
      type: IsarType.long,
    ),
    r'prefersDarkMode': PropertySchema(
      id: 22,
      name: r'prefersDarkMode',
      type: IsarType.bool,
    ),
    r'studyReminder': PropertySchema(
      id: 23,
      name: r'studyReminder',
      type: IsarType.object,
      target: r'StudyReminderConfig',
    ),
    r'totalFlashcardsReviewed': PropertySchema(
      id: 24,
      name: r'totalFlashcardsReviewed',
      type: IsarType.long,
    ),
    r'totalFocusMinutes': PropertySchema(
      id: 25,
      name: r'totalFocusMinutes',
      type: IsarType.long,
    ),
    r'totalNotesCreated': PropertySchema(
      id: 26,
      name: r'totalNotesCreated',
      type: IsarType.long,
    ),
    r'totalQuizzesTaken': PropertySchema(
      id: 27,
      name: r'totalQuizzesTaken',
      type: IsarType.long,
    ),
    r'totalTasksCompleted': PropertySchema(
      id: 28,
      name: r'totalTasksCompleted',
      type: IsarType.long,
    ),
    r'updatedAt': PropertySchema(
      id: 29,
      name: r'updatedAt',
      type: IsarType.dateTime,
    ),
    r'uuid': PropertySchema(
      id: 30,
      name: r'uuid',
      type: IsarType.string,
    ),
    r'weeklyFocusGoalMinutes': PropertySchema(
      id: 31,
      name: r'weeklyFocusGoalMinutes',
      type: IsarType.long,
    ),
    r'xp': PropertySchema(
      id: 32,
      name: r'xp',
      type: IsarType.long,
    ),
    r'xpForNextLevel': PropertySchema(
      id: 33,
      name: r'xpForNextLevel',
      type: IsarType.long,
    ),
    r'xpProgressToNextLevel': PropertySchema(
      id: 34,
      name: r'xpProgressToNextLevel',
      type: IsarType.double,
    )
  },
  estimateSize: _userModelEstimateSize,
  serialize: _userModelSerialize,
  deserialize: _userModelDeserialize,
  deserializeProp: _userModelDeserializeProp,
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
    r'displayName': IndexSchema(
      id: -825365117524145674,
      name: r'displayName',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'displayName',
          type: IndexType.value,
          caseSensitive: true,
        )
      ],
    ),
    r'email': IndexSchema(
      id: -26095440403582047,
      name: r'email',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'email',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'lastActiveDate': IndexSchema(
      id: -3740889078868266563,
      name: r'lastActiveDate',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'lastActiveDate',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {r'StudyReminderConfig': StudyReminderConfigSchema},
  getId: _userModelGetId,
  getLinks: _userModelGetLinks,
  attach: _userModelAttach,
  version: '3.1.0+1',
);

int _userModelEstimateSize(
  UserModel object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.avatarPath.length * 3;
  bytesCount += 3 + object.bio.length * 3;
  bytesCount += 3 + object.displayName.length * 3;
  bytesCount += 3 + object.earnedBadgeKeys.length * 3;
  {
    for (var i = 0; i < object.earnedBadgeKeys.length; i++) {
      final value = object.earnedBadgeKeys[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.email.length * 3;
  bytesCount += 3 + object.fieldOfStudy.length * 3;
  bytesCount += 3 + object.gradeOrYear.length * 3;
  bytesCount += 3 + object.initials.length * 3;
  bytesCount += 3 + object.institutionName.length * 3;
  {
    final value = object.studyReminder;
    if (value != null) {
      bytesCount += 3 +
          StudyReminderConfigSchema.estimateSize(
              value, allOffsets[StudyReminderConfig]!, allOffsets);
    }
  }
  bytesCount += 3 + object.uuid.length * 3;
  return bytesCount;
}

void _userModelSerialize(
  UserModel object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.avatarPath);
  writer.writeString(offsets[1], object.bio);
  writer.writeDateTime(offsets[2], object.createdAt);
  writer.writeLong(offsets[3], object.currentStreakDays);
  writer.writeLong(offsets[4], object.dailyFocusGoalMinutes);
  writer.writeLong(offsets[5], object.dailyTaskGoalCount);
  writer.writeString(offsets[6], object.displayName);
  writer.writeStringList(offsets[7], object.earnedBadgeKeys);
  writer.writeString(offsets[8], object.email);
  writer.writeString(offsets[9], object.fieldOfStudy);
  writer.writeString(offsets[10], object.gradeOrYear);
  writer.writeBool(offsets[11], object.hasAvatar);
  writer.writeBool(offsets[12], object.hasCompletedOnboarding);
  writer.writeString(offsets[13], object.initials);
  writer.writeString(offsets[14], object.institutionName);
  writer.writeDateTime(offsets[15], object.lastActiveDate);
  writer.writeLong(offsets[16], object.level);
  writer.writeLong(offsets[17], object.longestStreakDays);
  writer.writeLong(offsets[18], object.pomodoroLongBreakMinutes);
  writer.writeLong(offsets[19], object.pomodoroShortBreakMinutes);
  writer.writeLong(offsets[20], object.pomodoroWorkMinutes);
  writer.writeLong(offsets[21], object.pomodorosBeforeLongBreak);
  writer.writeBool(offsets[22], object.prefersDarkMode);
  writer.writeObject<StudyReminderConfig>(
    offsets[23],
    allOffsets,
    StudyReminderConfigSchema.serialize,
    object.studyReminder,
  );
  writer.writeLong(offsets[24], object.totalFlashcardsReviewed);
  writer.writeLong(offsets[25], object.totalFocusMinutes);
  writer.writeLong(offsets[26], object.totalNotesCreated);
  writer.writeLong(offsets[27], object.totalQuizzesTaken);
  writer.writeLong(offsets[28], object.totalTasksCompleted);
  writer.writeDateTime(offsets[29], object.updatedAt);
  writer.writeString(offsets[30], object.uuid);
  writer.writeLong(offsets[31], object.weeklyFocusGoalMinutes);
  writer.writeLong(offsets[32], object.xp);
  writer.writeLong(offsets[33], object.xpForNextLevel);
  writer.writeDouble(offsets[34], object.xpProgressToNextLevel);
}

UserModel _userModelDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = UserModel(
    avatarPath: reader.readStringOrNull(offsets[0]) ?? '',
    bio: reader.readStringOrNull(offsets[1]) ?? '',
    createdAt: reader.readDateTimeOrNull(offsets[2]),
    currentStreakDays: reader.readLongOrNull(offsets[3]) ?? 0,
    dailyFocusGoalMinutes: reader.readLongOrNull(offsets[4]) ?? 120,
    dailyTaskGoalCount: reader.readLongOrNull(offsets[5]) ?? 5,
    displayName: reader.readStringOrNull(offsets[6]) ?? '',
    earnedBadgeKeys: reader.readStringList(offsets[7]) ?? const [],
    email: reader.readStringOrNull(offsets[8]) ?? '',
    fieldOfStudy: reader.readStringOrNull(offsets[9]) ?? '',
    gradeOrYear: reader.readStringOrNull(offsets[10]) ?? '',
    hasCompletedOnboarding: reader.readBoolOrNull(offsets[12]) ?? false,
    id: id,
    institutionName: reader.readStringOrNull(offsets[14]) ?? '',
    lastActiveDate: reader.readDateTimeOrNull(offsets[15]),
    level: reader.readLongOrNull(offsets[16]) ?? 1,
    longestStreakDays: reader.readLongOrNull(offsets[17]) ?? 0,
    pomodoroLongBreakMinutes: reader.readLongOrNull(offsets[18]) ?? 15,
    pomodoroShortBreakMinutes: reader.readLongOrNull(offsets[19]) ?? 5,
    pomodoroWorkMinutes: reader.readLongOrNull(offsets[20]) ?? 25,
    pomodorosBeforeLongBreak: reader.readLongOrNull(offsets[21]) ?? 4,
    prefersDarkMode: reader.readBoolOrNull(offsets[22]) ?? false,
    studyReminder: reader.readObjectOrNull<StudyReminderConfig>(
      offsets[23],
      StudyReminderConfigSchema.deserialize,
      allOffsets,
    ),
    totalFlashcardsReviewed: reader.readLongOrNull(offsets[24]) ?? 0,
    totalFocusMinutes: reader.readLongOrNull(offsets[25]) ?? 0,
    totalNotesCreated: reader.readLongOrNull(offsets[26]) ?? 0,
    totalQuizzesTaken: reader.readLongOrNull(offsets[27]) ?? 0,
    totalTasksCompleted: reader.readLongOrNull(offsets[28]) ?? 0,
    updatedAt: reader.readDateTimeOrNull(offsets[29]),
    uuid: reader.readStringOrNull(offsets[30]) ?? '',
    weeklyFocusGoalMinutes: reader.readLongOrNull(offsets[31]) ?? 600,
    xp: reader.readLongOrNull(offsets[32]) ?? 0,
  );
  return object;
}

P _userModelDeserializeProp<P>(
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
      return (reader.readDateTimeOrNull(offset)) as P;
    case 3:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 4:
      return (reader.readLongOrNull(offset) ?? 120) as P;
    case 5:
      return (reader.readLongOrNull(offset) ?? 5) as P;
    case 6:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 7:
      return (reader.readStringList(offset) ?? const []) as P;
    case 8:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 9:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 10:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 11:
      return (reader.readBool(offset)) as P;
    case 12:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 13:
      return (reader.readString(offset)) as P;
    case 14:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 15:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 16:
      return (reader.readLongOrNull(offset) ?? 1) as P;
    case 17:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 18:
      return (reader.readLongOrNull(offset) ?? 15) as P;
    case 19:
      return (reader.readLongOrNull(offset) ?? 5) as P;
    case 20:
      return (reader.readLongOrNull(offset) ?? 25) as P;
    case 21:
      return (reader.readLongOrNull(offset) ?? 4) as P;
    case 22:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 23:
      return (reader.readObjectOrNull<StudyReminderConfig>(
        offset,
        StudyReminderConfigSchema.deserialize,
        allOffsets,
      )) as P;
    case 24:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 25:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 26:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 27:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 28:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 29:
      return (reader.readDateTimeOrNull(offset)) as P;
    case 30:
      return (reader.readStringOrNull(offset) ?? '') as P;
    case 31:
      return (reader.readLongOrNull(offset) ?? 600) as P;
    case 32:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 33:
      return (reader.readLong(offset)) as P;
    case 34:
      return (reader.readDouble(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _userModelGetId(UserModel object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _userModelGetLinks(UserModel object) {
  return [];
}

void _userModelAttach(IsarCollection<dynamic> col, Id id, UserModel object) {
  object.id = id;
}

extension UserModelByIndex on IsarCollection<UserModel> {
  Future<UserModel?> getByUuid(String uuid) {
    return getByIndex(r'uuid', [uuid]);
  }

  UserModel? getByUuidSync(String uuid) {
    return getByIndexSync(r'uuid', [uuid]);
  }

  Future<bool> deleteByUuid(String uuid) {
    return deleteByIndex(r'uuid', [uuid]);
  }

  bool deleteByUuidSync(String uuid) {
    return deleteByIndexSync(r'uuid', [uuid]);
  }

  Future<List<UserModel?>> getAllByUuid(List<String> uuidValues) {
    final values = uuidValues.map((e) => [e]).toList();
    return getAllByIndex(r'uuid', values);
  }

  List<UserModel?> getAllByUuidSync(List<String> uuidValues) {
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

  Future<Id> putByUuid(UserModel object) {
    return putByIndex(r'uuid', object);
  }

  Id putByUuidSync(UserModel object, {bool saveLinks = true}) {
    return putByIndexSync(r'uuid', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByUuid(List<UserModel> objects) {
    return putAllByIndex(r'uuid', objects);
  }

  List<Id> putAllByUuidSync(List<UserModel> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'uuid', objects, saveLinks: saveLinks);
  }
}

extension UserModelQueryWhereSort
    on QueryBuilder<UserModel, UserModel, QWhere> {
  QueryBuilder<UserModel, UserModel, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterWhere> anyDisplayName() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'displayName'),
      );
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterWhere> anyLastActiveDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'lastActiveDate'),
      );
    });
  }
}

extension UserModelQueryWhere
    on QueryBuilder<UserModel, UserModel, QWhereClause> {
  QueryBuilder<UserModel, UserModel, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<UserModel, UserModel, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterWhereClause> idBetween(
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

  QueryBuilder<UserModel, UserModel, QAfterWhereClause> uuidEqualTo(
      String uuid) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'uuid',
        value: [uuid],
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterWhereClause> uuidNotEqualTo(
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

  QueryBuilder<UserModel, UserModel, QAfterWhereClause> displayNameEqualTo(
      String displayName) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'displayName',
        value: [displayName],
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterWhereClause> displayNameNotEqualTo(
      String displayName) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'displayName',
              lower: [],
              upper: [displayName],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'displayName',
              lower: [displayName],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'displayName',
              lower: [displayName],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'displayName',
              lower: [],
              upper: [displayName],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterWhereClause> displayNameGreaterThan(
    String displayName, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'displayName',
        lower: [displayName],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterWhereClause> displayNameLessThan(
    String displayName, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'displayName',
        lower: [],
        upper: [displayName],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterWhereClause> displayNameBetween(
    String lowerDisplayName,
    String upperDisplayName, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'displayName',
        lower: [lowerDisplayName],
        includeLower: includeLower,
        upper: [upperDisplayName],
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterWhereClause> displayNameStartsWith(
      String DisplayNamePrefix) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'displayName',
        lower: [DisplayNamePrefix],
        upper: ['$DisplayNamePrefix\u{FFFFF}'],
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterWhereClause> displayNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'displayName',
        value: [''],
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterWhereClause>
      displayNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'displayName',
              upper: [''],
            ))
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'displayName',
              lower: [''],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.greaterThan(
              indexName: r'displayName',
              lower: [''],
            ))
            .addWhereClause(IndexWhereClause.lessThan(
              indexName: r'displayName',
              upper: [''],
            ));
      }
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterWhereClause> emailEqualTo(
      String email) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'email',
        value: [email],
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterWhereClause> emailNotEqualTo(
      String email) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'email',
              lower: [],
              upper: [email],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'email',
              lower: [email],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'email',
              lower: [email],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'email',
              lower: [],
              upper: [email],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterWhereClause> lastActiveDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'lastActiveDate',
        value: [null],
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterWhereClause>
      lastActiveDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'lastActiveDate',
        lower: [null],
        includeLower: false,
        upper: [],
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterWhereClause> lastActiveDateEqualTo(
      DateTime? lastActiveDate) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'lastActiveDate',
        value: [lastActiveDate],
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterWhereClause>
      lastActiveDateNotEqualTo(DateTime? lastActiveDate) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'lastActiveDate',
              lower: [],
              upper: [lastActiveDate],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'lastActiveDate',
              lower: [lastActiveDate],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'lastActiveDate',
              lower: [lastActiveDate],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'lastActiveDate',
              lower: [],
              upper: [lastActiveDate],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterWhereClause>
      lastActiveDateGreaterThan(
    DateTime? lastActiveDate, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'lastActiveDate',
        lower: [lastActiveDate],
        includeLower: include,
        upper: [],
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterWhereClause> lastActiveDateLessThan(
    DateTime? lastActiveDate, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'lastActiveDate',
        lower: [],
        upper: [lastActiveDate],
        includeUpper: include,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterWhereClause> lastActiveDateBetween(
    DateTime? lowerLastActiveDate,
    DateTime? upperLastActiveDate, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.between(
        indexName: r'lastActiveDate',
        lower: [lowerLastActiveDate],
        includeLower: includeLower,
        upper: [upperLastActiveDate],
        includeUpper: includeUpper,
      ));
    });
  }
}

extension UserModelQueryFilter
    on QueryBuilder<UserModel, UserModel, QFilterCondition> {
  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> avatarPathEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'avatarPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      avatarPathGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'avatarPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> avatarPathLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'avatarPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> avatarPathBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'avatarPath',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      avatarPathStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'avatarPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> avatarPathEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'avatarPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> avatarPathContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'avatarPath',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> avatarPathMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'avatarPath',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      avatarPathIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'avatarPath',
        value: '',
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      avatarPathIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'avatarPath',
        value: '',
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> bioEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> bioGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'bio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> bioLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'bio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> bioBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'bio',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> bioStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'bio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> bioEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'bio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> bioContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'bio',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> bioMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'bio',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> bioIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'bio',
        value: '',
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> bioIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'bio',
        value: '',
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> createdAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      createdAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'createdAt',
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> createdAtEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
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

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> createdAtLessThan(
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

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> createdAtBetween(
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

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      currentStreakDaysEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'currentStreakDays',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      currentStreakDaysGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'currentStreakDays',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      currentStreakDaysLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'currentStreakDays',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      currentStreakDaysBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'currentStreakDays',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      dailyFocusGoalMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dailyFocusGoalMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      dailyFocusGoalMinutesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dailyFocusGoalMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      dailyFocusGoalMinutesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dailyFocusGoalMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      dailyFocusGoalMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dailyFocusGoalMinutes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      dailyTaskGoalCountEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dailyTaskGoalCount',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      dailyTaskGoalCountGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dailyTaskGoalCount',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      dailyTaskGoalCountLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dailyTaskGoalCount',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      dailyTaskGoalCountBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dailyTaskGoalCount',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> displayNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      displayNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> displayNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> displayNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'displayName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      displayNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> displayNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> displayNameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'displayName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> displayNameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'displayName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      displayNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'displayName',
        value: '',
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      displayNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'displayName',
        value: '',
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      earnedBadgeKeysElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'earnedBadgeKeys',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      earnedBadgeKeysElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'earnedBadgeKeys',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      earnedBadgeKeysElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'earnedBadgeKeys',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      earnedBadgeKeysElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'earnedBadgeKeys',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      earnedBadgeKeysElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'earnedBadgeKeys',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      earnedBadgeKeysElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'earnedBadgeKeys',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      earnedBadgeKeysElementContains(String value,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'earnedBadgeKeys',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      earnedBadgeKeysElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'earnedBadgeKeys',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      earnedBadgeKeysElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'earnedBadgeKeys',
        value: '',
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      earnedBadgeKeysElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'earnedBadgeKeys',
        value: '',
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      earnedBadgeKeysLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'earnedBadgeKeys',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      earnedBadgeKeysIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'earnedBadgeKeys',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      earnedBadgeKeysIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'earnedBadgeKeys',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      earnedBadgeKeysLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'earnedBadgeKeys',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      earnedBadgeKeysLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'earnedBadgeKeys',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      earnedBadgeKeysLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'earnedBadgeKeys',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> emailEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> emailGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> emailLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> emailBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'email',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> emailStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> emailEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> emailContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'email',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> emailMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'email',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> emailIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'email',
        value: '',
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> emailIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'email',
        value: '',
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> fieldOfStudyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fieldOfStudy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      fieldOfStudyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'fieldOfStudy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      fieldOfStudyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'fieldOfStudy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> fieldOfStudyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'fieldOfStudy',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      fieldOfStudyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'fieldOfStudy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      fieldOfStudyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'fieldOfStudy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      fieldOfStudyContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'fieldOfStudy',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> fieldOfStudyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'fieldOfStudy',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      fieldOfStudyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'fieldOfStudy',
        value: '',
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      fieldOfStudyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'fieldOfStudy',
        value: '',
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> gradeOrYearEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gradeOrYear',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      gradeOrYearGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'gradeOrYear',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> gradeOrYearLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'gradeOrYear',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> gradeOrYearBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'gradeOrYear',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      gradeOrYearStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'gradeOrYear',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> gradeOrYearEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'gradeOrYear',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> gradeOrYearContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'gradeOrYear',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> gradeOrYearMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'gradeOrYear',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      gradeOrYearIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'gradeOrYear',
        value: '',
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      gradeOrYearIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'gradeOrYear',
        value: '',
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> hasAvatarEqualTo(
      bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hasAvatar',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      hasCompletedOnboardingEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hasCompletedOnboarding',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> idEqualTo(
      Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> idBetween(
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

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> initialsEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'initials',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> initialsGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'initials',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> initialsLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'initials',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> initialsBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'initials',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> initialsStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'initials',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> initialsEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'initials',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> initialsContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'initials',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> initialsMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'initials',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> initialsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'initials',
        value: '',
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      initialsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'initials',
        value: '',
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      institutionNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'institutionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      institutionNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'institutionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      institutionNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'institutionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      institutionNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'institutionName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      institutionNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'institutionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      institutionNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'institutionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      institutionNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'institutionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      institutionNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'institutionName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      institutionNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'institutionName',
        value: '',
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      institutionNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'institutionName',
        value: '',
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      lastActiveDateIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'lastActiveDate',
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      lastActiveDateIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'lastActiveDate',
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      lastActiveDateEqualTo(DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'lastActiveDate',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      lastActiveDateGreaterThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'lastActiveDate',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      lastActiveDateLessThan(
    DateTime? value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'lastActiveDate',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      lastActiveDateBetween(
    DateTime? lower,
    DateTime? upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'lastActiveDate',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> levelEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'level',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> levelGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'level',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> levelLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'level',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> levelBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'level',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      longestStreakDaysEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'longestStreakDays',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      longestStreakDaysGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'longestStreakDays',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      longestStreakDaysLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'longestStreakDays',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      longestStreakDaysBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'longestStreakDays',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      pomodoroLongBreakMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pomodoroLongBreakMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      pomodoroLongBreakMinutesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pomodoroLongBreakMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      pomodoroLongBreakMinutesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pomodoroLongBreakMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      pomodoroLongBreakMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pomodoroLongBreakMinutes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      pomodoroShortBreakMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pomodoroShortBreakMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      pomodoroShortBreakMinutesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pomodoroShortBreakMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      pomodoroShortBreakMinutesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pomodoroShortBreakMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      pomodoroShortBreakMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pomodoroShortBreakMinutes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      pomodoroWorkMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pomodoroWorkMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      pomodoroWorkMinutesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pomodoroWorkMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      pomodoroWorkMinutesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pomodoroWorkMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      pomodoroWorkMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pomodoroWorkMinutes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      pomodorosBeforeLongBreakEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'pomodorosBeforeLongBreak',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      pomodorosBeforeLongBreakGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'pomodorosBeforeLongBreak',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      pomodorosBeforeLongBreakLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'pomodorosBeforeLongBreak',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      pomodorosBeforeLongBreakBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'pomodorosBeforeLongBreak',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      prefersDarkModeEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'prefersDarkMode',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      studyReminderIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'studyReminder',
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      studyReminderIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'studyReminder',
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      totalFlashcardsReviewedEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalFlashcardsReviewed',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      totalFlashcardsReviewedGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalFlashcardsReviewed',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      totalFlashcardsReviewedLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalFlashcardsReviewed',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      totalFlashcardsReviewedBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalFlashcardsReviewed',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      totalFocusMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalFocusMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      totalFocusMinutesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalFocusMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      totalFocusMinutesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalFocusMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      totalFocusMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalFocusMinutes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      totalNotesCreatedEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalNotesCreated',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      totalNotesCreatedGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalNotesCreated',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      totalNotesCreatedLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalNotesCreated',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      totalNotesCreatedBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalNotesCreated',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      totalQuizzesTakenEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalQuizzesTaken',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      totalQuizzesTakenGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalQuizzesTaken',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      totalQuizzesTakenLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalQuizzesTaken',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      totalQuizzesTakenBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalQuizzesTaken',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      totalTasksCompletedEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'totalTasksCompleted',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      totalTasksCompletedGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'totalTasksCompleted',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      totalTasksCompletedLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'totalTasksCompleted',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      totalTasksCompletedBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'totalTasksCompleted',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> updatedAtIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      updatedAtIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'updatedAt',
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> updatedAtEqualTo(
      DateTime? value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
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

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> updatedAtLessThan(
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

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> updatedAtBetween(
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

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> uuidEqualTo(
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

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> uuidGreaterThan(
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

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> uuidLessThan(
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

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> uuidBetween(
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

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> uuidStartsWith(
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

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> uuidEndsWith(
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

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> uuidContains(
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

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> uuidMatches(
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

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> uuidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> uuidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uuid',
        value: '',
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      weeklyFocusGoalMinutesEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'weeklyFocusGoalMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      weeklyFocusGoalMinutesGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'weeklyFocusGoalMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      weeklyFocusGoalMinutesLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'weeklyFocusGoalMinutes',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      weeklyFocusGoalMinutesBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'weeklyFocusGoalMinutes',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> xpEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'xp',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> xpGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'xp',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> xpLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'xp',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> xpBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'xp',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      xpForNextLevelEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'xpForNextLevel',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      xpForNextLevelGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'xpForNextLevel',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      xpForNextLevelLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'xpForNextLevel',
        value: value,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      xpForNextLevelBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'xpForNextLevel',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      xpProgressToNextLevelEqualTo(
    double value, {
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'xpProgressToNextLevel',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      xpProgressToNextLevelGreaterThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'xpProgressToNextLevel',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      xpProgressToNextLevelLessThan(
    double value, {
    bool include = false,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'xpProgressToNextLevel',
        value: value,
        epsilon: epsilon,
      ));
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterFilterCondition>
      xpProgressToNextLevelBetween(
    double lower,
    double upper, {
    bool includeLower = true,
    bool includeUpper = true,
    double epsilon = Query.epsilon,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'xpProgressToNextLevel',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        epsilon: epsilon,
      ));
    });
  }
}

extension UserModelQueryObject
    on QueryBuilder<UserModel, UserModel, QFilterCondition> {
  QueryBuilder<UserModel, UserModel, QAfterFilterCondition> studyReminder(
      FilterQuery<StudyReminderConfig> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'studyReminder');
    });
  }
}

extension UserModelQueryLinks
    on QueryBuilder<UserModel, UserModel, QFilterCondition> {}

extension UserModelQuerySortBy on QueryBuilder<UserModel, UserModel, QSortBy> {
  QueryBuilder<UserModel, UserModel, QAfterSortBy> sortByAvatarPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarPath', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> sortByAvatarPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarPath', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> sortByBio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bio', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> sortByBioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bio', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> sortByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> sortByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> sortByCurrentStreakDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentStreakDays', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy>
      sortByCurrentStreakDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentStreakDays', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy>
      sortByDailyFocusGoalMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dailyFocusGoalMinutes', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy>
      sortByDailyFocusGoalMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dailyFocusGoalMinutes', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> sortByDailyTaskGoalCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dailyTaskGoalCount', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy>
      sortByDailyTaskGoalCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dailyTaskGoalCount', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> sortByDisplayName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> sortByDisplayNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> sortByEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> sortByEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> sortByFieldOfStudy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fieldOfStudy', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> sortByFieldOfStudyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fieldOfStudy', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> sortByGradeOrYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gradeOrYear', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> sortByGradeOrYearDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gradeOrYear', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> sortByHasAvatar() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasAvatar', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> sortByHasAvatarDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasAvatar', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy>
      sortByHasCompletedOnboarding() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasCompletedOnboarding', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy>
      sortByHasCompletedOnboardingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasCompletedOnboarding', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> sortByInitials() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'initials', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> sortByInitialsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'initials', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> sortByInstitutionName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'institutionName', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> sortByInstitutionNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'institutionName', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> sortByLastActiveDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastActiveDate', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> sortByLastActiveDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastActiveDate', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> sortByLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'level', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> sortByLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'level', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> sortByLongestStreakDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longestStreakDays', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy>
      sortByLongestStreakDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longestStreakDays', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy>
      sortByPomodoroLongBreakMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pomodoroLongBreakMinutes', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy>
      sortByPomodoroLongBreakMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pomodoroLongBreakMinutes', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy>
      sortByPomodoroShortBreakMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pomodoroShortBreakMinutes', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy>
      sortByPomodoroShortBreakMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pomodoroShortBreakMinutes', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> sortByPomodoroWorkMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pomodoroWorkMinutes', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy>
      sortByPomodoroWorkMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pomodoroWorkMinutes', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy>
      sortByPomodorosBeforeLongBreak() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pomodorosBeforeLongBreak', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy>
      sortByPomodorosBeforeLongBreakDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pomodorosBeforeLongBreak', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> sortByPrefersDarkMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prefersDarkMode', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> sortByPrefersDarkModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prefersDarkMode', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy>
      sortByTotalFlashcardsReviewed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalFlashcardsReviewed', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy>
      sortByTotalFlashcardsReviewedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalFlashcardsReviewed', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> sortByTotalFocusMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalFocusMinutes', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy>
      sortByTotalFocusMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalFocusMinutes', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> sortByTotalNotesCreated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalNotesCreated', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy>
      sortByTotalNotesCreatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalNotesCreated', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> sortByTotalQuizzesTaken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalQuizzesTaken', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy>
      sortByTotalQuizzesTakenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalQuizzesTaken', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> sortByTotalTasksCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalTasksCompleted', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy>
      sortByTotalTasksCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalTasksCompleted', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> sortByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> sortByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> sortByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> sortByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy>
      sortByWeeklyFocusGoalMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weeklyFocusGoalMinutes', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy>
      sortByWeeklyFocusGoalMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weeklyFocusGoalMinutes', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> sortByXp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'xp', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> sortByXpDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'xp', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> sortByXpForNextLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'xpForNextLevel', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> sortByXpForNextLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'xpForNextLevel', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy>
      sortByXpProgressToNextLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'xpProgressToNextLevel', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy>
      sortByXpProgressToNextLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'xpProgressToNextLevel', Sort.desc);
    });
  }
}

extension UserModelQuerySortThenBy
    on QueryBuilder<UserModel, UserModel, QSortThenBy> {
  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenByAvatarPath() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarPath', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenByAvatarPathDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'avatarPath', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenByBio() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bio', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenByBioDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'bio', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenByCreatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'createdAt', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenByCurrentStreakDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentStreakDays', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy>
      thenByCurrentStreakDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'currentStreakDays', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy>
      thenByDailyFocusGoalMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dailyFocusGoalMinutes', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy>
      thenByDailyFocusGoalMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dailyFocusGoalMinutes', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenByDailyTaskGoalCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dailyTaskGoalCount', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy>
      thenByDailyTaskGoalCountDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'dailyTaskGoalCount', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenByDisplayName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenByDisplayNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'displayName', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenByEmail() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenByEmailDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'email', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenByFieldOfStudy() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fieldOfStudy', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenByFieldOfStudyDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'fieldOfStudy', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenByGradeOrYear() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gradeOrYear', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenByGradeOrYearDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'gradeOrYear', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenByHasAvatar() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasAvatar', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenByHasAvatarDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasAvatar', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy>
      thenByHasCompletedOnboarding() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasCompletedOnboarding', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy>
      thenByHasCompletedOnboardingDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'hasCompletedOnboarding', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenByInitials() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'initials', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenByInitialsDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'initials', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenByInstitutionName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'institutionName', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenByInstitutionNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'institutionName', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenByLastActiveDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastActiveDate', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenByLastActiveDateDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'lastActiveDate', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenByLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'level', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenByLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'level', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenByLongestStreakDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longestStreakDays', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy>
      thenByLongestStreakDaysDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'longestStreakDays', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy>
      thenByPomodoroLongBreakMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pomodoroLongBreakMinutes', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy>
      thenByPomodoroLongBreakMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pomodoroLongBreakMinutes', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy>
      thenByPomodoroShortBreakMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pomodoroShortBreakMinutes', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy>
      thenByPomodoroShortBreakMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pomodoroShortBreakMinutes', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenByPomodoroWorkMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pomodoroWorkMinutes', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy>
      thenByPomodoroWorkMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pomodoroWorkMinutes', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy>
      thenByPomodorosBeforeLongBreak() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pomodorosBeforeLongBreak', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy>
      thenByPomodorosBeforeLongBreakDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'pomodorosBeforeLongBreak', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenByPrefersDarkMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prefersDarkMode', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenByPrefersDarkModeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'prefersDarkMode', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy>
      thenByTotalFlashcardsReviewed() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalFlashcardsReviewed', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy>
      thenByTotalFlashcardsReviewedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalFlashcardsReviewed', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenByTotalFocusMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalFocusMinutes', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy>
      thenByTotalFocusMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalFocusMinutes', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenByTotalNotesCreated() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalNotesCreated', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy>
      thenByTotalNotesCreatedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalNotesCreated', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenByTotalQuizzesTaken() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalQuizzesTaken', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy>
      thenByTotalQuizzesTakenDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalQuizzesTaken', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenByTotalTasksCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalTasksCompleted', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy>
      thenByTotalTasksCompletedDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'totalTasksCompleted', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenByUpdatedAtDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'updatedAt', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenByUuid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenByUuidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uuid', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy>
      thenByWeeklyFocusGoalMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weeklyFocusGoalMinutes', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy>
      thenByWeeklyFocusGoalMinutesDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'weeklyFocusGoalMinutes', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenByXp() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'xp', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenByXpDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'xp', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenByXpForNextLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'xpForNextLevel', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy> thenByXpForNextLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'xpForNextLevel', Sort.desc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy>
      thenByXpProgressToNextLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'xpProgressToNextLevel', Sort.asc);
    });
  }

  QueryBuilder<UserModel, UserModel, QAfterSortBy>
      thenByXpProgressToNextLevelDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'xpProgressToNextLevel', Sort.desc);
    });
  }
}

extension UserModelQueryWhereDistinct
    on QueryBuilder<UserModel, UserModel, QDistinct> {
  QueryBuilder<UserModel, UserModel, QDistinct> distinctByAvatarPath(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'avatarPath', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserModel, UserModel, QDistinct> distinctByBio(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'bio', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserModel, UserModel, QDistinct> distinctByCreatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'createdAt');
    });
  }

  QueryBuilder<UserModel, UserModel, QDistinct> distinctByCurrentStreakDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'currentStreakDays');
    });
  }

  QueryBuilder<UserModel, UserModel, QDistinct>
      distinctByDailyFocusGoalMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dailyFocusGoalMinutes');
    });
  }

  QueryBuilder<UserModel, UserModel, QDistinct> distinctByDailyTaskGoalCount() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'dailyTaskGoalCount');
    });
  }

  QueryBuilder<UserModel, UserModel, QDistinct> distinctByDisplayName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'displayName', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserModel, UserModel, QDistinct> distinctByEarnedBadgeKeys() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'earnedBadgeKeys');
    });
  }

  QueryBuilder<UserModel, UserModel, QDistinct> distinctByEmail(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'email', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserModel, UserModel, QDistinct> distinctByFieldOfStudy(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'fieldOfStudy', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserModel, UserModel, QDistinct> distinctByGradeOrYear(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'gradeOrYear', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserModel, UserModel, QDistinct> distinctByHasAvatar() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasAvatar');
    });
  }

  QueryBuilder<UserModel, UserModel, QDistinct>
      distinctByHasCompletedOnboarding() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'hasCompletedOnboarding');
    });
  }

  QueryBuilder<UserModel, UserModel, QDistinct> distinctByInitials(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'initials', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserModel, UserModel, QDistinct> distinctByInstitutionName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'institutionName',
          caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserModel, UserModel, QDistinct> distinctByLastActiveDate() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'lastActiveDate');
    });
  }

  QueryBuilder<UserModel, UserModel, QDistinct> distinctByLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'level');
    });
  }

  QueryBuilder<UserModel, UserModel, QDistinct> distinctByLongestStreakDays() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'longestStreakDays');
    });
  }

  QueryBuilder<UserModel, UserModel, QDistinct>
      distinctByPomodoroLongBreakMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pomodoroLongBreakMinutes');
    });
  }

  QueryBuilder<UserModel, UserModel, QDistinct>
      distinctByPomodoroShortBreakMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pomodoroShortBreakMinutes');
    });
  }

  QueryBuilder<UserModel, UserModel, QDistinct>
      distinctByPomodoroWorkMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pomodoroWorkMinutes');
    });
  }

  QueryBuilder<UserModel, UserModel, QDistinct>
      distinctByPomodorosBeforeLongBreak() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'pomodorosBeforeLongBreak');
    });
  }

  QueryBuilder<UserModel, UserModel, QDistinct> distinctByPrefersDarkMode() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'prefersDarkMode');
    });
  }

  QueryBuilder<UserModel, UserModel, QDistinct>
      distinctByTotalFlashcardsReviewed() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalFlashcardsReviewed');
    });
  }

  QueryBuilder<UserModel, UserModel, QDistinct> distinctByTotalFocusMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalFocusMinutes');
    });
  }

  QueryBuilder<UserModel, UserModel, QDistinct> distinctByTotalNotesCreated() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalNotesCreated');
    });
  }

  QueryBuilder<UserModel, UserModel, QDistinct> distinctByTotalQuizzesTaken() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalQuizzesTaken');
    });
  }

  QueryBuilder<UserModel, UserModel, QDistinct>
      distinctByTotalTasksCompleted() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'totalTasksCompleted');
    });
  }

  QueryBuilder<UserModel, UserModel, QDistinct> distinctByUpdatedAt() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'updatedAt');
    });
  }

  QueryBuilder<UserModel, UserModel, QDistinct> distinctByUuid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uuid', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<UserModel, UserModel, QDistinct>
      distinctByWeeklyFocusGoalMinutes() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'weeklyFocusGoalMinutes');
    });
  }

  QueryBuilder<UserModel, UserModel, QDistinct> distinctByXp() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'xp');
    });
  }

  QueryBuilder<UserModel, UserModel, QDistinct> distinctByXpForNextLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'xpForNextLevel');
    });
  }

  QueryBuilder<UserModel, UserModel, QDistinct>
      distinctByXpProgressToNextLevel() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'xpProgressToNextLevel');
    });
  }
}

extension UserModelQueryProperty
    on QueryBuilder<UserModel, UserModel, QQueryProperty> {
  QueryBuilder<UserModel, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<UserModel, String, QQueryOperations> avatarPathProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'avatarPath');
    });
  }

  QueryBuilder<UserModel, String, QQueryOperations> bioProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'bio');
    });
  }

  QueryBuilder<UserModel, DateTime?, QQueryOperations> createdAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'createdAt');
    });
  }

  QueryBuilder<UserModel, int, QQueryOperations> currentStreakDaysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'currentStreakDays');
    });
  }

  QueryBuilder<UserModel, int, QQueryOperations>
      dailyFocusGoalMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dailyFocusGoalMinutes');
    });
  }

  QueryBuilder<UserModel, int, QQueryOperations> dailyTaskGoalCountProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'dailyTaskGoalCount');
    });
  }

  QueryBuilder<UserModel, String, QQueryOperations> displayNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'displayName');
    });
  }

  QueryBuilder<UserModel, List<String>, QQueryOperations>
      earnedBadgeKeysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'earnedBadgeKeys');
    });
  }

  QueryBuilder<UserModel, String, QQueryOperations> emailProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'email');
    });
  }

  QueryBuilder<UserModel, String, QQueryOperations> fieldOfStudyProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'fieldOfStudy');
    });
  }

  QueryBuilder<UserModel, String, QQueryOperations> gradeOrYearProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'gradeOrYear');
    });
  }

  QueryBuilder<UserModel, bool, QQueryOperations> hasAvatarProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasAvatar');
    });
  }

  QueryBuilder<UserModel, bool, QQueryOperations>
      hasCompletedOnboardingProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'hasCompletedOnboarding');
    });
  }

  QueryBuilder<UserModel, String, QQueryOperations> initialsProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'initials');
    });
  }

  QueryBuilder<UserModel, String, QQueryOperations> institutionNameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'institutionName');
    });
  }

  QueryBuilder<UserModel, DateTime?, QQueryOperations>
      lastActiveDateProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'lastActiveDate');
    });
  }

  QueryBuilder<UserModel, int, QQueryOperations> levelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'level');
    });
  }

  QueryBuilder<UserModel, int, QQueryOperations> longestStreakDaysProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'longestStreakDays');
    });
  }

  QueryBuilder<UserModel, int, QQueryOperations>
      pomodoroLongBreakMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pomodoroLongBreakMinutes');
    });
  }

  QueryBuilder<UserModel, int, QQueryOperations>
      pomodoroShortBreakMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pomodoroShortBreakMinutes');
    });
  }

  QueryBuilder<UserModel, int, QQueryOperations> pomodoroWorkMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pomodoroWorkMinutes');
    });
  }

  QueryBuilder<UserModel, int, QQueryOperations>
      pomodorosBeforeLongBreakProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'pomodorosBeforeLongBreak');
    });
  }

  QueryBuilder<UserModel, bool, QQueryOperations> prefersDarkModeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'prefersDarkMode');
    });
  }

  QueryBuilder<UserModel, StudyReminderConfig?, QQueryOperations>
      studyReminderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'studyReminder');
    });
  }

  QueryBuilder<UserModel, int, QQueryOperations>
      totalFlashcardsReviewedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalFlashcardsReviewed');
    });
  }

  QueryBuilder<UserModel, int, QQueryOperations> totalFocusMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalFocusMinutes');
    });
  }

  QueryBuilder<UserModel, int, QQueryOperations> totalNotesCreatedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalNotesCreated');
    });
  }

  QueryBuilder<UserModel, int, QQueryOperations> totalQuizzesTakenProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalQuizzesTaken');
    });
  }

  QueryBuilder<UserModel, int, QQueryOperations> totalTasksCompletedProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'totalTasksCompleted');
    });
  }

  QueryBuilder<UserModel, DateTime?, QQueryOperations> updatedAtProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'updatedAt');
    });
  }

  QueryBuilder<UserModel, String, QQueryOperations> uuidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uuid');
    });
  }

  QueryBuilder<UserModel, int, QQueryOperations>
      weeklyFocusGoalMinutesProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'weeklyFocusGoalMinutes');
    });
  }

  QueryBuilder<UserModel, int, QQueryOperations> xpProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'xp');
    });
  }

  QueryBuilder<UserModel, int, QQueryOperations> xpForNextLevelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'xpForNextLevel');
    });
  }

  QueryBuilder<UserModel, double, QQueryOperations>
      xpProgressToNextLevelProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'xpProgressToNextLevel');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const StudyReminderConfigSchema = Schema(
  name: r'StudyReminderConfig',
  id: 6803471858213199865,
  properties: {
    r'hour': PropertySchema(
      id: 0,
      name: r'hour',
      type: IsarType.long,
    ),
    r'isEnabled': PropertySchema(
      id: 1,
      name: r'isEnabled',
      type: IsarType.bool,
    ),
    r'minute': PropertySchema(
      id: 2,
      name: r'minute',
      type: IsarType.long,
    ),
    r'notificationId': PropertySchema(
      id: 3,
      name: r'notificationId',
      type: IsarType.long,
    )
  },
  estimateSize: _studyReminderConfigEstimateSize,
  serialize: _studyReminderConfigSerialize,
  deserialize: _studyReminderConfigDeserialize,
  deserializeProp: _studyReminderConfigDeserializeProp,
);

int _studyReminderConfigEstimateSize(
  StudyReminderConfig object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  return bytesCount;
}

void _studyReminderConfigSerialize(
  StudyReminderConfig object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeLong(offsets[0], object.hour);
  writer.writeBool(offsets[1], object.isEnabled);
  writer.writeLong(offsets[2], object.minute);
  writer.writeLong(offsets[3], object.notificationId);
}

StudyReminderConfig _studyReminderConfigDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = StudyReminderConfig(
    hour: reader.readLongOrNull(offsets[0]) ?? 20,
    isEnabled: reader.readBoolOrNull(offsets[1]) ?? true,
    minute: reader.readLongOrNull(offsets[2]) ?? 0,
    notificationId: reader.readLongOrNull(offsets[3]) ?? 9999,
  );
  return object;
}

P _studyReminderConfigDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readLongOrNull(offset) ?? 20) as P;
    case 1:
      return (reader.readBoolOrNull(offset) ?? true) as P;
    case 2:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    case 3:
      return (reader.readLongOrNull(offset) ?? 9999) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension StudyReminderConfigQueryFilter on QueryBuilder<StudyReminderConfig,
    StudyReminderConfig, QFilterCondition> {
  QueryBuilder<StudyReminderConfig, StudyReminderConfig, QAfterFilterCondition>
      hourEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'hour',
        value: value,
      ));
    });
  }

  QueryBuilder<StudyReminderConfig, StudyReminderConfig, QAfterFilterCondition>
      hourGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'hour',
        value: value,
      ));
    });
  }

  QueryBuilder<StudyReminderConfig, StudyReminderConfig, QAfterFilterCondition>
      hourLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'hour',
        value: value,
      ));
    });
  }

  QueryBuilder<StudyReminderConfig, StudyReminderConfig, QAfterFilterCondition>
      hourBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'hour',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<StudyReminderConfig, StudyReminderConfig, QAfterFilterCondition>
      isEnabledEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isEnabled',
        value: value,
      ));
    });
  }

  QueryBuilder<StudyReminderConfig, StudyReminderConfig, QAfterFilterCondition>
      minuteEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'minute',
        value: value,
      ));
    });
  }

  QueryBuilder<StudyReminderConfig, StudyReminderConfig, QAfterFilterCondition>
      minuteGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'minute',
        value: value,
      ));
    });
  }

  QueryBuilder<StudyReminderConfig, StudyReminderConfig, QAfterFilterCondition>
      minuteLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'minute',
        value: value,
      ));
    });
  }

  QueryBuilder<StudyReminderConfig, StudyReminderConfig, QAfterFilterCondition>
      minuteBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'minute',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<StudyReminderConfig, StudyReminderConfig, QAfterFilterCondition>
      notificationIdEqualTo(int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'notificationId',
        value: value,
      ));
    });
  }

  QueryBuilder<StudyReminderConfig, StudyReminderConfig, QAfterFilterCondition>
      notificationIdGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'notificationId',
        value: value,
      ));
    });
  }

  QueryBuilder<StudyReminderConfig, StudyReminderConfig, QAfterFilterCondition>
      notificationIdLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'notificationId',
        value: value,
      ));
    });
  }

  QueryBuilder<StudyReminderConfig, StudyReminderConfig, QAfterFilterCondition>
      notificationIdBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'notificationId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension StudyReminderConfigQueryObject on QueryBuilder<StudyReminderConfig,
    StudyReminderConfig, QFilterCondition> {}
