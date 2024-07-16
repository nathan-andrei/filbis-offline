// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'collections.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetModuleCollection on Isar {
  IsarCollection<Module> get modules => this.collection();
}

const ModuleSchema = CollectionSchema(
  name: r'Module',
  id: -2335926089013615123,
  properties: {
    r'name': PropertySchema(
      id: 0,
      name: r'name',
      type: IsarType.string,
    ),
    r'order': PropertySchema(
      id: 1,
      name: r'order',
      type: IsarType.stringList,
    ),
    r'subModule': PropertySchema(
      id: 2,
      name: r'subModule',
      type: IsarType.objectList,
      target: r'SubModule',
    )
  },
  estimateSize: _moduleEstimateSize,
  serialize: _moduleSerialize,
  deserialize: _moduleDeserialize,
  deserializeProp: _moduleDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {
    r'SubModule': SubModuleSchema,
    r'QckReply': QckReplySchema,
    r'QuestionTranslation': QuestionTranslationSchema,
    r'Mobile': MobileSchema
  },
  getId: _moduleGetId,
  getLinks: _moduleGetLinks,
  attach: _moduleAttach,
  version: '3.1.7',
);

int _moduleEstimateSize(
  Module object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.name.length * 3;
  bytesCount += 3 + object.order.length * 3;
  {
    for (var i = 0; i < object.order.length; i++) {
      final value = object.order[i];
      bytesCount += value.length * 3;
    }
  }
  bytesCount += 3 + object.subModule.length * 3;
  {
    final offsets = allOffsets[SubModule]!;
    for (var i = 0; i < object.subModule.length; i++) {
      final value = object.subModule[i];
      bytesCount += SubModuleSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  return bytesCount;
}

void _moduleSerialize(
  Module object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.name);
  writer.writeStringList(offsets[1], object.order);
  writer.writeObjectList<SubModule>(
    offsets[2],
    allOffsets,
    SubModuleSchema.serialize,
    object.subModule,
  );
}

Module _moduleDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Module();
  object.id = id;
  object.name = reader.readString(offsets[0]);
  object.order = reader.readStringList(offsets[1]) ?? [];
  object.subModule = reader.readObjectList<SubModule>(
        offsets[2],
        SubModuleSchema.deserialize,
        allOffsets,
        SubModule(),
      ) ??
      [];
  return object;
}

P _moduleDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readStringList(offset) ?? []) as P;
    case 2:
      return (reader.readObjectList<SubModule>(
            offset,
            SubModuleSchema.deserialize,
            allOffsets,
            SubModule(),
          ) ??
          []) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _moduleGetId(Module object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _moduleGetLinks(Module object) {
  return [];
}

void _moduleAttach(IsarCollection<dynamic> col, Id id, Module object) {
  object.id = id;
}

extension ModuleQueryWhereSort on QueryBuilder<Module, Module, QWhere> {
  QueryBuilder<Module, Module, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ModuleQueryWhere on QueryBuilder<Module, Module, QWhereClause> {
  QueryBuilder<Module, Module, QAfterWhereClause> idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<Module, Module, QAfterWhereClause> idNotEqualTo(Id id) {
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

  QueryBuilder<Module, Module, QAfterWhereClause> idGreaterThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<Module, Module, QAfterWhereClause> idLessThan(Id id,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<Module, Module, QAfterWhereClause> idBetween(
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
}

extension ModuleQueryFilter on QueryBuilder<Module, Module, QFilterCondition> {
  QueryBuilder<Module, Module, QAfterFilterCondition> idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<Module, Module, QAfterFilterCondition> idGreaterThan(
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

  QueryBuilder<Module, Module, QAfterFilterCondition> idLessThan(
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

  QueryBuilder<Module, Module, QAfterFilterCondition> idBetween(
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

  QueryBuilder<Module, Module, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Module, Module, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Module, Module, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Module, Module, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Module, Module, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Module, Module, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Module, Module, QAfterFilterCondition> nameContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Module, Module, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Module, Module, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Module, Module, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<Module, Module, QAfterFilterCondition> orderElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'order',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Module, Module, QAfterFilterCondition> orderElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'order',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Module, Module, QAfterFilterCondition> orderElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'order',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Module, Module, QAfterFilterCondition> orderElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'order',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Module, Module, QAfterFilterCondition> orderElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'order',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Module, Module, QAfterFilterCondition> orderElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'order',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Module, Module, QAfterFilterCondition> orderElementContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'order',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Module, Module, QAfterFilterCondition> orderElementMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'order',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Module, Module, QAfterFilterCondition> orderElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'order',
        value: '',
      ));
    });
  }

  QueryBuilder<Module, Module, QAfterFilterCondition> orderElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'order',
        value: '',
      ));
    });
  }

  QueryBuilder<Module, Module, QAfterFilterCondition> orderLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'order',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Module, Module, QAfterFilterCondition> orderIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'order',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Module, Module, QAfterFilterCondition> orderIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'order',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Module, Module, QAfterFilterCondition> orderLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'order',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Module, Module, QAfterFilterCondition> orderLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'order',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Module, Module, QAfterFilterCondition> orderLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'order',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<Module, Module, QAfterFilterCondition> subModuleLengthEqualTo(
      int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'subModule',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<Module, Module, QAfterFilterCondition> subModuleIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'subModule',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<Module, Module, QAfterFilterCondition> subModuleIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'subModule',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Module, Module, QAfterFilterCondition> subModuleLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'subModule',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<Module, Module, QAfterFilterCondition>
      subModuleLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'subModule',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<Module, Module, QAfterFilterCondition> subModuleLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'subModule',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension ModuleQueryObject on QueryBuilder<Module, Module, QFilterCondition> {
  QueryBuilder<Module, Module, QAfterFilterCondition> subModuleElement(
      FilterQuery<SubModule> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'subModule');
    });
  }
}

extension ModuleQueryLinks on QueryBuilder<Module, Module, QFilterCondition> {}

extension ModuleQuerySortBy on QueryBuilder<Module, Module, QSortBy> {
  QueryBuilder<Module, Module, QAfterSortBy> sortByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Module, Module, QAfterSortBy> sortByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension ModuleQuerySortThenBy on QueryBuilder<Module, Module, QSortThenBy> {
  QueryBuilder<Module, Module, QAfterSortBy> thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<Module, Module, QAfterSortBy> thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<Module, Module, QAfterSortBy> thenByName() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.asc);
    });
  }

  QueryBuilder<Module, Module, QAfterSortBy> thenByNameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'name', Sort.desc);
    });
  }
}

extension ModuleQueryWhereDistinct on QueryBuilder<Module, Module, QDistinct> {
  QueryBuilder<Module, Module, QDistinct> distinctByName(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'name', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Module, Module, QDistinct> distinctByOrder() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'order');
    });
  }
}

extension ModuleQueryProperty on QueryBuilder<Module, Module, QQueryProperty> {
  QueryBuilder<Module, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<Module, String, QQueryOperations> nameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'name');
    });
  }

  QueryBuilder<Module, List<String>, QQueryOperations> orderProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'order');
    });
  }

  QueryBuilder<Module, List<SubModule>, QQueryOperations> subModuleProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'subModule');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetChildrenHealthDataCollection on Isar {
  IsarCollection<ChildrenHealthData> get childrenHealthDatas =>
      this.collection();
}

const ChildrenHealthDataSchema = CollectionSchema(
  name: r'ChildrenHealthData',
  id: -7281993883575927336,
  properties: {
    r'medicalHistory': PropertySchema(
      id: 0,
      name: r'medicalHistory',
      type: IsarType.object,
      target: r'MedicalHistory',
    ),
    r'uid': PropertySchema(
      id: 1,
      name: r'uid',
      type: IsarType.string,
    )
  },
  estimateSize: _childrenHealthDataEstimateSize,
  serialize: _childrenHealthDataSerialize,
  deserialize: _childrenHealthDataDeserialize,
  deserializeProp: _childrenHealthDataDeserializeProp,
  idName: r'id',
  indexes: {},
  links: {},
  embeddedSchemas: {
    r'MedicalHistory': MedicalHistorySchema,
    r'MedicalRecord': MedicalRecordSchema,
    r'KeyValuePair': KeyValuePairSchema
  },
  getId: _childrenHealthDataGetId,
  getLinks: _childrenHealthDataGetLinks,
  attach: _childrenHealthDataAttach,
  version: '3.1.7',
);

int _childrenHealthDataEstimateSize(
  ChildrenHealthData object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 +
      MedicalHistorySchema.estimateSize(
          object.medicalHistory, allOffsets[MedicalHistory]!, allOffsets);
  bytesCount += 3 + object.uid.length * 3;
  return bytesCount;
}

void _childrenHealthDataSerialize(
  ChildrenHealthData object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObject<MedicalHistory>(
    offsets[0],
    allOffsets,
    MedicalHistorySchema.serialize,
    object.medicalHistory,
  );
  writer.writeString(offsets[1], object.uid);
}

ChildrenHealthData _childrenHealthDataDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = ChildrenHealthData();
  object.id = id;
  object.medicalHistory = reader.readObjectOrNull<MedicalHistory>(
        offsets[0],
        MedicalHistorySchema.deserialize,
        allOffsets,
      ) ??
      MedicalHistory();
  object.uid = reader.readString(offsets[1]);
  return object;
}

P _childrenHealthDataDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectOrNull<MedicalHistory>(
            offset,
            MedicalHistorySchema.deserialize,
            allOffsets,
          ) ??
          MedicalHistory()) as P;
    case 1:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _childrenHealthDataGetId(ChildrenHealthData object) {
  return object.id;
}

List<IsarLinkBase<dynamic>> _childrenHealthDataGetLinks(
    ChildrenHealthData object) {
  return [];
}

void _childrenHealthDataAttach(
    IsarCollection<dynamic> col, Id id, ChildrenHealthData object) {
  object.id = id;
}

extension ChildrenHealthDataQueryWhereSort
    on QueryBuilder<ChildrenHealthData, ChildrenHealthData, QWhere> {
  QueryBuilder<ChildrenHealthData, ChildrenHealthData, QAfterWhere> anyId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }
}

extension ChildrenHealthDataQueryWhere
    on QueryBuilder<ChildrenHealthData, ChildrenHealthData, QWhereClause> {
  QueryBuilder<ChildrenHealthData, ChildrenHealthData, QAfterWhereClause>
      idEqualTo(Id id) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: id,
        upper: id,
      ));
    });
  }

  QueryBuilder<ChildrenHealthData, ChildrenHealthData, QAfterWhereClause>
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

  QueryBuilder<ChildrenHealthData, ChildrenHealthData, QAfterWhereClause>
      idGreaterThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: id, includeLower: include),
      );
    });
  }

  QueryBuilder<ChildrenHealthData, ChildrenHealthData, QAfterWhereClause>
      idLessThan(Id id, {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: id, includeUpper: include),
      );
    });
  }

  QueryBuilder<ChildrenHealthData, ChildrenHealthData, QAfterWhereClause>
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
}

extension ChildrenHealthDataQueryFilter
    on QueryBuilder<ChildrenHealthData, ChildrenHealthData, QFilterCondition> {
  QueryBuilder<ChildrenHealthData, ChildrenHealthData, QAfterFilterCondition>
      idEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'id',
        value: value,
      ));
    });
  }

  QueryBuilder<ChildrenHealthData, ChildrenHealthData, QAfterFilterCondition>
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

  QueryBuilder<ChildrenHealthData, ChildrenHealthData, QAfterFilterCondition>
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

  QueryBuilder<ChildrenHealthData, ChildrenHealthData, QAfterFilterCondition>
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

  QueryBuilder<ChildrenHealthData, ChildrenHealthData, QAfterFilterCondition>
      uidEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChildrenHealthData, ChildrenHealthData, QAfterFilterCondition>
      uidGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChildrenHealthData, ChildrenHealthData, QAfterFilterCondition>
      uidLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChildrenHealthData, ChildrenHealthData, QAfterFilterCondition>
      uidBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'uid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChildrenHealthData, ChildrenHealthData, QAfterFilterCondition>
      uidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChildrenHealthData, ChildrenHealthData, QAfterFilterCondition>
      uidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChildrenHealthData, ChildrenHealthData, QAfterFilterCondition>
      uidContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChildrenHealthData, ChildrenHealthData, QAfterFilterCondition>
      uidMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'uid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<ChildrenHealthData, ChildrenHealthData, QAfterFilterCondition>
      uidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uid',
        value: '',
      ));
    });
  }

  QueryBuilder<ChildrenHealthData, ChildrenHealthData, QAfterFilterCondition>
      uidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uid',
        value: '',
      ));
    });
  }
}

extension ChildrenHealthDataQueryObject
    on QueryBuilder<ChildrenHealthData, ChildrenHealthData, QFilterCondition> {
  QueryBuilder<ChildrenHealthData, ChildrenHealthData, QAfterFilterCondition>
      medicalHistory(FilterQuery<MedicalHistory> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'medicalHistory');
    });
  }
}

extension ChildrenHealthDataQueryLinks
    on QueryBuilder<ChildrenHealthData, ChildrenHealthData, QFilterCondition> {}

extension ChildrenHealthDataQuerySortBy
    on QueryBuilder<ChildrenHealthData, ChildrenHealthData, QSortBy> {
  QueryBuilder<ChildrenHealthData, ChildrenHealthData, QAfterSortBy>
      sortByUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.asc);
    });
  }

  QueryBuilder<ChildrenHealthData, ChildrenHealthData, QAfterSortBy>
      sortByUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.desc);
    });
  }
}

extension ChildrenHealthDataQuerySortThenBy
    on QueryBuilder<ChildrenHealthData, ChildrenHealthData, QSortThenBy> {
  QueryBuilder<ChildrenHealthData, ChildrenHealthData, QAfterSortBy>
      thenById() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.asc);
    });
  }

  QueryBuilder<ChildrenHealthData, ChildrenHealthData, QAfterSortBy>
      thenByIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'id', Sort.desc);
    });
  }

  QueryBuilder<ChildrenHealthData, ChildrenHealthData, QAfterSortBy>
      thenByUid() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.asc);
    });
  }

  QueryBuilder<ChildrenHealthData, ChildrenHealthData, QAfterSortBy>
      thenByUidDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'uid', Sort.desc);
    });
  }
}

extension ChildrenHealthDataQueryWhereDistinct
    on QueryBuilder<ChildrenHealthData, ChildrenHealthData, QDistinct> {
  QueryBuilder<ChildrenHealthData, ChildrenHealthData, QDistinct> distinctByUid(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'uid', caseSensitive: caseSensitive);
    });
  }
}

extension ChildrenHealthDataQueryProperty
    on QueryBuilder<ChildrenHealthData, ChildrenHealthData, QQueryProperty> {
  QueryBuilder<ChildrenHealthData, int, QQueryOperations> idProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'id');
    });
  }

  QueryBuilder<ChildrenHealthData, MedicalHistory, QQueryOperations>
      medicalHistoryProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'medicalHistory');
    });
  }

  QueryBuilder<ChildrenHealthData, String, QQueryOperations> uidProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'uid');
    });
  }
}

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const SubModuleSchema = Schema(
  name: r'SubModule',
  id: -8401262890041669663,
  properties: {
    r'mobile': PropertySchema(
      id: 0,
      name: r'mobile',
      type: IsarType.object,
      target: r'Mobile',
    ),
    r'name': PropertySchema(
      id: 1,
      name: r'name',
      type: IsarType.string,
    ),
    r'qckReply': PropertySchema(
      id: 2,
      name: r'qckReply',
      type: IsarType.object,
      target: r'QckReply',
    ),
    r'questionTranslation': PropertySchema(
      id: 3,
      name: r'questionTranslation',
      type: IsarType.object,
      target: r'QuestionTranslation',
    )
  },
  estimateSize: _subModuleEstimateSize,
  serialize: _subModuleSerialize,
  deserialize: _subModuleDeserialize,
  deserializeProp: _subModuleDeserializeProp,
);

int _subModuleEstimateSize(
  SubModule object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.mobile;
    if (value != null) {
      bytesCount +=
          3 + MobileSchema.estimateSize(value, allOffsets[Mobile]!, allOffsets);
    }
  }
  bytesCount += 3 + object.name.length * 3;
  {
    final value = object.qckReply;
    if (value != null) {
      bytesCount += 3 +
          QckReplySchema.estimateSize(value, allOffsets[QckReply]!, allOffsets);
    }
  }
  {
    final value = object.questionTranslation;
    if (value != null) {
      bytesCount += 3 +
          QuestionTranslationSchema.estimateSize(
              value, allOffsets[QuestionTranslation]!, allOffsets);
    }
  }
  return bytesCount;
}

void _subModuleSerialize(
  SubModule object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObject<Mobile>(
    offsets[0],
    allOffsets,
    MobileSchema.serialize,
    object.mobile,
  );
  writer.writeString(offsets[1], object.name);
  writer.writeObject<QckReply>(
    offsets[2],
    allOffsets,
    QckReplySchema.serialize,
    object.qckReply,
  );
  writer.writeObject<QuestionTranslation>(
    offsets[3],
    allOffsets,
    QuestionTranslationSchema.serialize,
    object.questionTranslation,
  );
}

SubModule _subModuleDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = SubModule();
  object.mobile = reader.readObjectOrNull<Mobile>(
    offsets[0],
    MobileSchema.deserialize,
    allOffsets,
  );
  object.name = reader.readString(offsets[1]);
  object.qckReply = reader.readObjectOrNull<QckReply>(
    offsets[2],
    QckReplySchema.deserialize,
    allOffsets,
  );
  object.questionTranslation = reader.readObjectOrNull<QuestionTranslation>(
    offsets[3],
    QuestionTranslationSchema.deserialize,
    allOffsets,
  );
  return object;
}

P _subModuleDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectOrNull<Mobile>(
        offset,
        MobileSchema.deserialize,
        allOffsets,
      )) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readObjectOrNull<QckReply>(
        offset,
        QckReplySchema.deserialize,
        allOffsets,
      )) as P;
    case 3:
      return (reader.readObjectOrNull<QuestionTranslation>(
        offset,
        QuestionTranslationSchema.deserialize,
        allOffsets,
      )) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension SubModuleQueryFilter
    on QueryBuilder<SubModule, SubModule, QFilterCondition> {
  QueryBuilder<SubModule, SubModule, QAfterFilterCondition> mobileIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'mobile',
      ));
    });
  }

  QueryBuilder<SubModule, SubModule, QAfterFilterCondition> mobileIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'mobile',
      ));
    });
  }

  QueryBuilder<SubModule, SubModule, QAfterFilterCondition> nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubModule, SubModule, QAfterFilterCondition> nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubModule, SubModule, QAfterFilterCondition> nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubModule, SubModule, QAfterFilterCondition> nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubModule, SubModule, QAfterFilterCondition> nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubModule, SubModule, QAfterFilterCondition> nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubModule, SubModule, QAfterFilterCondition> nameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubModule, SubModule, QAfterFilterCondition> nameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<SubModule, SubModule, QAfterFilterCondition> nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<SubModule, SubModule, QAfterFilterCondition> nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<SubModule, SubModule, QAfterFilterCondition> qckReplyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'qckReply',
      ));
    });
  }

  QueryBuilder<SubModule, SubModule, QAfterFilterCondition>
      qckReplyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'qckReply',
      ));
    });
  }

  QueryBuilder<SubModule, SubModule, QAfterFilterCondition>
      questionTranslationIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'questionTranslation',
      ));
    });
  }

  QueryBuilder<SubModule, SubModule, QAfterFilterCondition>
      questionTranslationIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'questionTranslation',
      ));
    });
  }
}

extension SubModuleQueryObject
    on QueryBuilder<SubModule, SubModule, QFilterCondition> {
  QueryBuilder<SubModule, SubModule, QAfterFilterCondition> mobile(
      FilterQuery<Mobile> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'mobile');
    });
  }

  QueryBuilder<SubModule, SubModule, QAfterFilterCondition> qckReply(
      FilterQuery<QckReply> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'qckReply');
    });
  }

  QueryBuilder<SubModule, SubModule, QAfterFilterCondition> questionTranslation(
      FilterQuery<QuestionTranslation> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'questionTranslation');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const QckReplySchema = Schema(
  name: r'QckReply',
  id: 207176715565757516,
  properties: {
    r'cebuanoReplies': PropertySchema(
      id: 0,
      name: r'cebuanoReplies',
      type: IsarType.stringList,
    ),
    r'englishReplies': PropertySchema(
      id: 1,
      name: r'englishReplies',
      type: IsarType.stringList,
    ),
    r'tagalogReplies': PropertySchema(
      id: 2,
      name: r'tagalogReplies',
      type: IsarType.stringList,
    )
  },
  estimateSize: _qckReplyEstimateSize,
  serialize: _qckReplySerialize,
  deserialize: _qckReplyDeserialize,
  deserializeProp: _qckReplyDeserializeProp,
);

int _qckReplyEstimateSize(
  QckReply object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final list = object.cebuanoReplies;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += value.length * 3;
        }
      }
    }
  }
  {
    final list = object.englishReplies;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += value.length * 3;
        }
      }
    }
  }
  {
    final list = object.tagalogReplies;
    if (list != null) {
      bytesCount += 3 + list.length * 3;
      {
        for (var i = 0; i < list.length; i++) {
          final value = list[i];
          bytesCount += value.length * 3;
        }
      }
    }
  }
  return bytesCount;
}

void _qckReplySerialize(
  QckReply object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeStringList(offsets[0], object.cebuanoReplies);
  writer.writeStringList(offsets[1], object.englishReplies);
  writer.writeStringList(offsets[2], object.tagalogReplies);
}

QckReply _qckReplyDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = QckReply();
  object.cebuanoReplies = reader.readStringList(offsets[0]);
  object.englishReplies = reader.readStringList(offsets[1]);
  object.tagalogReplies = reader.readStringList(offsets[2]);
  return object;
}

P _qckReplyDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringList(offset)) as P;
    case 1:
      return (reader.readStringList(offset)) as P;
    case 2:
      return (reader.readStringList(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension QckReplyQueryFilter
    on QueryBuilder<QckReply, QckReply, QFilterCondition> {
  QueryBuilder<QckReply, QckReply, QAfterFilterCondition>
      cebuanoRepliesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'cebuanoReplies',
      ));
    });
  }

  QueryBuilder<QckReply, QckReply, QAfterFilterCondition>
      cebuanoRepliesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'cebuanoReplies',
      ));
    });
  }

  QueryBuilder<QckReply, QckReply, QAfterFilterCondition>
      cebuanoRepliesElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cebuanoReplies',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QckReply, QckReply, QAfterFilterCondition>
      cebuanoRepliesElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cebuanoReplies',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QckReply, QckReply, QAfterFilterCondition>
      cebuanoRepliesElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cebuanoReplies',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QckReply, QckReply, QAfterFilterCondition>
      cebuanoRepliesElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cebuanoReplies',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QckReply, QckReply, QAfterFilterCondition>
      cebuanoRepliesElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'cebuanoReplies',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QckReply, QckReply, QAfterFilterCondition>
      cebuanoRepliesElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'cebuanoReplies',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QckReply, QckReply, QAfterFilterCondition>
      cebuanoRepliesElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cebuanoReplies',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QckReply, QckReply, QAfterFilterCondition>
      cebuanoRepliesElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cebuanoReplies',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QckReply, QckReply, QAfterFilterCondition>
      cebuanoRepliesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cebuanoReplies',
        value: '',
      ));
    });
  }

  QueryBuilder<QckReply, QckReply, QAfterFilterCondition>
      cebuanoRepliesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cebuanoReplies',
        value: '',
      ));
    });
  }

  QueryBuilder<QckReply, QckReply, QAfterFilterCondition>
      cebuanoRepliesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'cebuanoReplies',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<QckReply, QckReply, QAfterFilterCondition>
      cebuanoRepliesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'cebuanoReplies',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<QckReply, QckReply, QAfterFilterCondition>
      cebuanoRepliesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'cebuanoReplies',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<QckReply, QckReply, QAfterFilterCondition>
      cebuanoRepliesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'cebuanoReplies',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<QckReply, QckReply, QAfterFilterCondition>
      cebuanoRepliesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'cebuanoReplies',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<QckReply, QckReply, QAfterFilterCondition>
      cebuanoRepliesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'cebuanoReplies',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<QckReply, QckReply, QAfterFilterCondition>
      englishRepliesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'englishReplies',
      ));
    });
  }

  QueryBuilder<QckReply, QckReply, QAfterFilterCondition>
      englishRepliesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'englishReplies',
      ));
    });
  }

  QueryBuilder<QckReply, QckReply, QAfterFilterCondition>
      englishRepliesElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'englishReplies',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QckReply, QckReply, QAfterFilterCondition>
      englishRepliesElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'englishReplies',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QckReply, QckReply, QAfterFilterCondition>
      englishRepliesElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'englishReplies',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QckReply, QckReply, QAfterFilterCondition>
      englishRepliesElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'englishReplies',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QckReply, QckReply, QAfterFilterCondition>
      englishRepliesElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'englishReplies',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QckReply, QckReply, QAfterFilterCondition>
      englishRepliesElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'englishReplies',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QckReply, QckReply, QAfterFilterCondition>
      englishRepliesElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'englishReplies',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QckReply, QckReply, QAfterFilterCondition>
      englishRepliesElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'englishReplies',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QckReply, QckReply, QAfterFilterCondition>
      englishRepliesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'englishReplies',
        value: '',
      ));
    });
  }

  QueryBuilder<QckReply, QckReply, QAfterFilterCondition>
      englishRepliesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'englishReplies',
        value: '',
      ));
    });
  }

  QueryBuilder<QckReply, QckReply, QAfterFilterCondition>
      englishRepliesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'englishReplies',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<QckReply, QckReply, QAfterFilterCondition>
      englishRepliesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'englishReplies',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<QckReply, QckReply, QAfterFilterCondition>
      englishRepliesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'englishReplies',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<QckReply, QckReply, QAfterFilterCondition>
      englishRepliesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'englishReplies',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<QckReply, QckReply, QAfterFilterCondition>
      englishRepliesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'englishReplies',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<QckReply, QckReply, QAfterFilterCondition>
      englishRepliesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'englishReplies',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<QckReply, QckReply, QAfterFilterCondition>
      tagalogRepliesIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tagalogReplies',
      ));
    });
  }

  QueryBuilder<QckReply, QckReply, QAfterFilterCondition>
      tagalogRepliesIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tagalogReplies',
      ));
    });
  }

  QueryBuilder<QckReply, QckReply, QAfterFilterCondition>
      tagalogRepliesElementEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tagalogReplies',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QckReply, QckReply, QAfterFilterCondition>
      tagalogRepliesElementGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tagalogReplies',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QckReply, QckReply, QAfterFilterCondition>
      tagalogRepliesElementLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tagalogReplies',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QckReply, QckReply, QAfterFilterCondition>
      tagalogRepliesElementBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tagalogReplies',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QckReply, QckReply, QAfterFilterCondition>
      tagalogRepliesElementStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tagalogReplies',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QckReply, QckReply, QAfterFilterCondition>
      tagalogRepliesElementEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tagalogReplies',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QckReply, QckReply, QAfterFilterCondition>
      tagalogRepliesElementContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tagalogReplies',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QckReply, QckReply, QAfterFilterCondition>
      tagalogRepliesElementMatches(String pattern,
          {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tagalogReplies',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QckReply, QckReply, QAfterFilterCondition>
      tagalogRepliesElementIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tagalogReplies',
        value: '',
      ));
    });
  }

  QueryBuilder<QckReply, QckReply, QAfterFilterCondition>
      tagalogRepliesElementIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tagalogReplies',
        value: '',
      ));
    });
  }

  QueryBuilder<QckReply, QckReply, QAfterFilterCondition>
      tagalogRepliesLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tagalogReplies',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<QckReply, QckReply, QAfterFilterCondition>
      tagalogRepliesIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tagalogReplies',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<QckReply, QckReply, QAfterFilterCondition>
      tagalogRepliesIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tagalogReplies',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<QckReply, QckReply, QAfterFilterCondition>
      tagalogRepliesLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tagalogReplies',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<QckReply, QckReply, QAfterFilterCondition>
      tagalogRepliesLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tagalogReplies',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<QckReply, QckReply, QAfterFilterCondition>
      tagalogRepliesLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'tagalogReplies',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }
}

extension QckReplyQueryObject
    on QueryBuilder<QckReply, QckReply, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const QuestionTranslationSchema = Schema(
  name: r'QuestionTranslation',
  id: 3017805896090420689,
  properties: {
    r'cebuanoResponse': PropertySchema(
      id: 0,
      name: r'cebuanoResponse',
      type: IsarType.string,
    ),
    r'englishResponse': PropertySchema(
      id: 1,
      name: r'englishResponse',
      type: IsarType.string,
    ),
    r'tagalogResponse': PropertySchema(
      id: 2,
      name: r'tagalogResponse',
      type: IsarType.string,
    )
  },
  estimateSize: _questionTranslationEstimateSize,
  serialize: _questionTranslationSerialize,
  deserialize: _questionTranslationDeserialize,
  deserializeProp: _questionTranslationDeserializeProp,
);

int _questionTranslationEstimateSize(
  QuestionTranslation object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.cebuanoResponse;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.englishResponse;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.tagalogResponse;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _questionTranslationSerialize(
  QuestionTranslation object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.cebuanoResponse);
  writer.writeString(offsets[1], object.englishResponse);
  writer.writeString(offsets[2], object.tagalogResponse);
}

QuestionTranslation _questionTranslationDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = QuestionTranslation();
  object.cebuanoResponse = reader.readStringOrNull(offsets[0]);
  object.englishResponse = reader.readStringOrNull(offsets[1]);
  object.tagalogResponse = reader.readStringOrNull(offsets[2]);
  return object;
}

P _questionTranslationDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension QuestionTranslationQueryFilter on QueryBuilder<QuestionTranslation,
    QuestionTranslation, QFilterCondition> {
  QueryBuilder<QuestionTranslation, QuestionTranslation, QAfterFilterCondition>
      cebuanoResponseIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'cebuanoResponse',
      ));
    });
  }

  QueryBuilder<QuestionTranslation, QuestionTranslation, QAfterFilterCondition>
      cebuanoResponseIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'cebuanoResponse',
      ));
    });
  }

  QueryBuilder<QuestionTranslation, QuestionTranslation, QAfterFilterCondition>
      cebuanoResponseEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cebuanoResponse',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionTranslation, QuestionTranslation, QAfterFilterCondition>
      cebuanoResponseGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'cebuanoResponse',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionTranslation, QuestionTranslation, QAfterFilterCondition>
      cebuanoResponseLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'cebuanoResponse',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionTranslation, QuestionTranslation, QAfterFilterCondition>
      cebuanoResponseBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'cebuanoResponse',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionTranslation, QuestionTranslation, QAfterFilterCondition>
      cebuanoResponseStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'cebuanoResponse',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionTranslation, QuestionTranslation, QAfterFilterCondition>
      cebuanoResponseEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'cebuanoResponse',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionTranslation, QuestionTranslation, QAfterFilterCondition>
      cebuanoResponseContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'cebuanoResponse',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionTranslation, QuestionTranslation, QAfterFilterCondition>
      cebuanoResponseMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'cebuanoResponse',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionTranslation, QuestionTranslation, QAfterFilterCondition>
      cebuanoResponseIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'cebuanoResponse',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionTranslation, QuestionTranslation, QAfterFilterCondition>
      cebuanoResponseIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'cebuanoResponse',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionTranslation, QuestionTranslation, QAfterFilterCondition>
      englishResponseIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'englishResponse',
      ));
    });
  }

  QueryBuilder<QuestionTranslation, QuestionTranslation, QAfterFilterCondition>
      englishResponseIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'englishResponse',
      ));
    });
  }

  QueryBuilder<QuestionTranslation, QuestionTranslation, QAfterFilterCondition>
      englishResponseEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'englishResponse',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionTranslation, QuestionTranslation, QAfterFilterCondition>
      englishResponseGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'englishResponse',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionTranslation, QuestionTranslation, QAfterFilterCondition>
      englishResponseLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'englishResponse',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionTranslation, QuestionTranslation, QAfterFilterCondition>
      englishResponseBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'englishResponse',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionTranslation, QuestionTranslation, QAfterFilterCondition>
      englishResponseStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'englishResponse',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionTranslation, QuestionTranslation, QAfterFilterCondition>
      englishResponseEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'englishResponse',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionTranslation, QuestionTranslation, QAfterFilterCondition>
      englishResponseContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'englishResponse',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionTranslation, QuestionTranslation, QAfterFilterCondition>
      englishResponseMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'englishResponse',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionTranslation, QuestionTranslation, QAfterFilterCondition>
      englishResponseIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'englishResponse',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionTranslation, QuestionTranslation, QAfterFilterCondition>
      englishResponseIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'englishResponse',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionTranslation, QuestionTranslation, QAfterFilterCondition>
      tagalogResponseIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'tagalogResponse',
      ));
    });
  }

  QueryBuilder<QuestionTranslation, QuestionTranslation, QAfterFilterCondition>
      tagalogResponseIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'tagalogResponse',
      ));
    });
  }

  QueryBuilder<QuestionTranslation, QuestionTranslation, QAfterFilterCondition>
      tagalogResponseEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tagalogResponse',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionTranslation, QuestionTranslation, QAfterFilterCondition>
      tagalogResponseGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'tagalogResponse',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionTranslation, QuestionTranslation, QAfterFilterCondition>
      tagalogResponseLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'tagalogResponse',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionTranslation, QuestionTranslation, QAfterFilterCondition>
      tagalogResponseBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'tagalogResponse',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionTranslation, QuestionTranslation, QAfterFilterCondition>
      tagalogResponseStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'tagalogResponse',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionTranslation, QuestionTranslation, QAfterFilterCondition>
      tagalogResponseEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'tagalogResponse',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionTranslation, QuestionTranslation, QAfterFilterCondition>
      tagalogResponseContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'tagalogResponse',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionTranslation, QuestionTranslation, QAfterFilterCondition>
      tagalogResponseMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'tagalogResponse',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<QuestionTranslation, QuestionTranslation, QAfterFilterCondition>
      tagalogResponseIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'tagalogResponse',
        value: '',
      ));
    });
  }

  QueryBuilder<QuestionTranslation, QuestionTranslation, QAfterFilterCondition>
      tagalogResponseIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'tagalogResponse',
        value: '',
      ));
    });
  }
}

extension QuestionTranslationQueryObject on QueryBuilder<QuestionTranslation,
    QuestionTranslation, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const MobileSchema = Schema(
  name: r'Mobile',
  id: 6947612774435727190,
  properties: {
    r'dataKey': PropertySchema(
      id: 0,
      name: r'dataKey',
      type: IsarType.string,
    ),
    r'next': PropertySchema(
      id: 1,
      name: r'next',
      type: IsarType.string,
    ),
    r'yesNext': PropertySchema(
      id: 2,
      name: r'yesNext',
      type: IsarType.string,
    )
  },
  estimateSize: _mobileEstimateSize,
  serialize: _mobileSerialize,
  deserialize: _mobileDeserialize,
  deserializeProp: _mobileDeserializeProp,
);

int _mobileEstimateSize(
  Mobile object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.dataKey;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.next;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.yesNext;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _mobileSerialize(
  Mobile object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.dataKey);
  writer.writeString(offsets[1], object.next);
  writer.writeString(offsets[2], object.yesNext);
}

Mobile _mobileDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Mobile();
  object.dataKey = reader.readStringOrNull(offsets[0]);
  object.next = reader.readStringOrNull(offsets[1]);
  object.yesNext = reader.readStringOrNull(offsets[2]);
  return object;
}

P _mobileDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    case 2:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension MobileQueryFilter on QueryBuilder<Mobile, Mobile, QFilterCondition> {
  QueryBuilder<Mobile, Mobile, QAfterFilterCondition> dataKeyIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'dataKey',
      ));
    });
  }

  QueryBuilder<Mobile, Mobile, QAfterFilterCondition> dataKeyIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'dataKey',
      ));
    });
  }

  QueryBuilder<Mobile, Mobile, QAfterFilterCondition> dataKeyEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dataKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mobile, Mobile, QAfterFilterCondition> dataKeyGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'dataKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mobile, Mobile, QAfterFilterCondition> dataKeyLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'dataKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mobile, Mobile, QAfterFilterCondition> dataKeyBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'dataKey',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mobile, Mobile, QAfterFilterCondition> dataKeyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'dataKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mobile, Mobile, QAfterFilterCondition> dataKeyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'dataKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mobile, Mobile, QAfterFilterCondition> dataKeyContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'dataKey',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mobile, Mobile, QAfterFilterCondition> dataKeyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'dataKey',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mobile, Mobile, QAfterFilterCondition> dataKeyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'dataKey',
        value: '',
      ));
    });
  }

  QueryBuilder<Mobile, Mobile, QAfterFilterCondition> dataKeyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'dataKey',
        value: '',
      ));
    });
  }

  QueryBuilder<Mobile, Mobile, QAfterFilterCondition> nextIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'next',
      ));
    });
  }

  QueryBuilder<Mobile, Mobile, QAfterFilterCondition> nextIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'next',
      ));
    });
  }

  QueryBuilder<Mobile, Mobile, QAfterFilterCondition> nextEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'next',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mobile, Mobile, QAfterFilterCondition> nextGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'next',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mobile, Mobile, QAfterFilterCondition> nextLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'next',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mobile, Mobile, QAfterFilterCondition> nextBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'next',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mobile, Mobile, QAfterFilterCondition> nextStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'next',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mobile, Mobile, QAfterFilterCondition> nextEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'next',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mobile, Mobile, QAfterFilterCondition> nextContains(String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'next',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mobile, Mobile, QAfterFilterCondition> nextMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'next',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mobile, Mobile, QAfterFilterCondition> nextIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'next',
        value: '',
      ));
    });
  }

  QueryBuilder<Mobile, Mobile, QAfterFilterCondition> nextIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'next',
        value: '',
      ));
    });
  }

  QueryBuilder<Mobile, Mobile, QAfterFilterCondition> yesNextIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'yesNext',
      ));
    });
  }

  QueryBuilder<Mobile, Mobile, QAfterFilterCondition> yesNextIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'yesNext',
      ));
    });
  }

  QueryBuilder<Mobile, Mobile, QAfterFilterCondition> yesNextEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'yesNext',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mobile, Mobile, QAfterFilterCondition> yesNextGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'yesNext',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mobile, Mobile, QAfterFilterCondition> yesNextLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'yesNext',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mobile, Mobile, QAfterFilterCondition> yesNextBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'yesNext',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mobile, Mobile, QAfterFilterCondition> yesNextStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'yesNext',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mobile, Mobile, QAfterFilterCondition> yesNextEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'yesNext',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mobile, Mobile, QAfterFilterCondition> yesNextContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'yesNext',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mobile, Mobile, QAfterFilterCondition> yesNextMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'yesNext',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Mobile, Mobile, QAfterFilterCondition> yesNextIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'yesNext',
        value: '',
      ));
    });
  }

  QueryBuilder<Mobile, Mobile, QAfterFilterCondition> yesNextIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'yesNext',
        value: '',
      ));
    });
  }
}

extension MobileQueryObject on QueryBuilder<Mobile, Mobile, QFilterCondition> {}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const MedicalHistorySchema = Schema(
  name: r'MedicalHistory',
  id: 3417794035235762164,
  properties: {
    r'medicalRecords': PropertySchema(
      id: 0,
      name: r'medicalRecords',
      type: IsarType.objectList,
      target: r'MedicalRecord',
    ),
    r'name': PropertySchema(
      id: 1,
      name: r'name',
      type: IsarType.string,
    )
  },
  estimateSize: _medicalHistoryEstimateSize,
  serialize: _medicalHistorySerialize,
  deserialize: _medicalHistoryDeserialize,
  deserializeProp: _medicalHistoryDeserializeProp,
);

int _medicalHistoryEstimateSize(
  MedicalHistory object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.medicalRecords.length * 3;
  {
    final offsets = allOffsets[MedicalRecord]!;
    for (var i = 0; i < object.medicalRecords.length; i++) {
      final value = object.medicalRecords[i];
      bytesCount +=
          MedicalRecordSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.name.length * 3;
  return bytesCount;
}

void _medicalHistorySerialize(
  MedicalHistory object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeObjectList<MedicalRecord>(
    offsets[0],
    allOffsets,
    MedicalRecordSchema.serialize,
    object.medicalRecords,
  );
  writer.writeString(offsets[1], object.name);
}

MedicalHistory _medicalHistoryDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MedicalHistory();
  object.medicalRecords = reader.readObjectList<MedicalRecord>(
        offsets[0],
        MedicalRecordSchema.deserialize,
        allOffsets,
        MedicalRecord(),
      ) ??
      [];
  object.name = reader.readString(offsets[1]);
  return object;
}

P _medicalHistoryDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readObjectList<MedicalRecord>(
            offset,
            MedicalRecordSchema.deserialize,
            allOffsets,
            MedicalRecord(),
          ) ??
          []) as P;
    case 1:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension MedicalHistoryQueryFilter
    on QueryBuilder<MedicalHistory, MedicalHistory, QFilterCondition> {
  QueryBuilder<MedicalHistory, MedicalHistory, QAfterFilterCondition>
      medicalRecordsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'medicalRecords',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<MedicalHistory, MedicalHistory, QAfterFilterCondition>
      medicalRecordsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'medicalRecords',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<MedicalHistory, MedicalHistory, QAfterFilterCondition>
      medicalRecordsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'medicalRecords',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<MedicalHistory, MedicalHistory, QAfterFilterCondition>
      medicalRecordsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'medicalRecords',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<MedicalHistory, MedicalHistory, QAfterFilterCondition>
      medicalRecordsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'medicalRecords',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<MedicalHistory, MedicalHistory, QAfterFilterCondition>
      medicalRecordsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'medicalRecords',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<MedicalHistory, MedicalHistory, QAfterFilterCondition>
      nameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicalHistory, MedicalHistory, QAfterFilterCondition>
      nameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicalHistory, MedicalHistory, QAfterFilterCondition>
      nameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicalHistory, MedicalHistory, QAfterFilterCondition>
      nameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'name',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicalHistory, MedicalHistory, QAfterFilterCondition>
      nameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicalHistory, MedicalHistory, QAfterFilterCondition>
      nameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicalHistory, MedicalHistory, QAfterFilterCondition>
      nameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'name',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicalHistory, MedicalHistory, QAfterFilterCondition>
      nameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'name',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicalHistory, MedicalHistory, QAfterFilterCondition>
      nameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'name',
        value: '',
      ));
    });
  }

  QueryBuilder<MedicalHistory, MedicalHistory, QAfterFilterCondition>
      nameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'name',
        value: '',
      ));
    });
  }
}

extension MedicalHistoryQueryObject
    on QueryBuilder<MedicalHistory, MedicalHistory, QFilterCondition> {
  QueryBuilder<MedicalHistory, MedicalHistory, QAfterFilterCondition>
      medicalRecordsElement(FilterQuery<MedicalRecord> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'medicalRecords');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const MedicalRecordSchema = Schema(
  name: r'MedicalRecord',
  id: 5109892404991089297,
  properties: {
    r'createdAt': PropertySchema(
      id: 0,
      name: r'createdAt',
      type: IsarType.string,
    ),
    r'records': PropertySchema(
      id: 1,
      name: r'records',
      type: IsarType.objectList,
      target: r'KeyValuePair',
    ),
    r'sessionName': PropertySchema(
      id: 2,
      name: r'sessionName',
      type: IsarType.string,
    ),
    r'uid': PropertySchema(
      id: 3,
      name: r'uid',
      type: IsarType.string,
    ),
    r'updatedAt': PropertySchema(
      id: 4,
      name: r'updatedAt',
      type: IsarType.string,
    )
  },
  estimateSize: _medicalRecordEstimateSize,
  serialize: _medicalRecordSerialize,
  deserialize: _medicalRecordDeserialize,
  deserializeProp: _medicalRecordDeserializeProp,
);

int _medicalRecordEstimateSize(
  MedicalRecord object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.createdAt.length * 3;
  bytesCount += 3 + object.records.length * 3;
  {
    final offsets = allOffsets[KeyValuePair]!;
    for (var i = 0; i < object.records.length; i++) {
      final value = object.records[i];
      bytesCount += KeyValuePairSchema.estimateSize(value, offsets, allOffsets);
    }
  }
  bytesCount += 3 + object.sessionName.length * 3;
  bytesCount += 3 + object.uid.length * 3;
  bytesCount += 3 + object.updatedAt.length * 3;
  return bytesCount;
}

void _medicalRecordSerialize(
  MedicalRecord object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.createdAt);
  writer.writeObjectList<KeyValuePair>(
    offsets[1],
    allOffsets,
    KeyValuePairSchema.serialize,
    object.records,
  );
  writer.writeString(offsets[2], object.sessionName);
  writer.writeString(offsets[3], object.uid);
  writer.writeString(offsets[4], object.updatedAt);
}

MedicalRecord _medicalRecordDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = MedicalRecord();
  object.createdAt = reader.readString(offsets[0]);
  object.records = reader.readObjectList<KeyValuePair>(
        offsets[1],
        KeyValuePairSchema.deserialize,
        allOffsets,
        KeyValuePair(),
      ) ??
      [];
  object.sessionName = reader.readString(offsets[2]);
  object.uid = reader.readString(offsets[3]);
  object.updatedAt = reader.readString(offsets[4]);
  return object;
}

P _medicalRecordDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readObjectList<KeyValuePair>(
            offset,
            KeyValuePairSchema.deserialize,
            allOffsets,
            KeyValuePair(),
          ) ??
          []) as P;
    case 2:
      return (reader.readString(offset)) as P;
    case 3:
      return (reader.readString(offset)) as P;
    case 4:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension MedicalRecordQueryFilter
    on QueryBuilder<MedicalRecord, MedicalRecord, QFilterCondition> {
  QueryBuilder<MedicalRecord, MedicalRecord, QAfterFilterCondition>
      createdAtEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicalRecord, MedicalRecord, QAfterFilterCondition>
      createdAtGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'createdAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicalRecord, MedicalRecord, QAfterFilterCondition>
      createdAtLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'createdAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicalRecord, MedicalRecord, QAfterFilterCondition>
      createdAtBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'createdAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicalRecord, MedicalRecord, QAfterFilterCondition>
      createdAtStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'createdAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicalRecord, MedicalRecord, QAfterFilterCondition>
      createdAtEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'createdAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicalRecord, MedicalRecord, QAfterFilterCondition>
      createdAtContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'createdAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicalRecord, MedicalRecord, QAfterFilterCondition>
      createdAtMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'createdAt',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicalRecord, MedicalRecord, QAfterFilterCondition>
      createdAtIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'createdAt',
        value: '',
      ));
    });
  }

  QueryBuilder<MedicalRecord, MedicalRecord, QAfterFilterCondition>
      createdAtIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'createdAt',
        value: '',
      ));
    });
  }

  QueryBuilder<MedicalRecord, MedicalRecord, QAfterFilterCondition>
      recordsLengthEqualTo(int length) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'records',
        length,
        true,
        length,
        true,
      );
    });
  }

  QueryBuilder<MedicalRecord, MedicalRecord, QAfterFilterCondition>
      recordsIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'records',
        0,
        true,
        0,
        true,
      );
    });
  }

  QueryBuilder<MedicalRecord, MedicalRecord, QAfterFilterCondition>
      recordsIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'records',
        0,
        false,
        999999,
        true,
      );
    });
  }

  QueryBuilder<MedicalRecord, MedicalRecord, QAfterFilterCondition>
      recordsLengthLessThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'records',
        0,
        true,
        length,
        include,
      );
    });
  }

  QueryBuilder<MedicalRecord, MedicalRecord, QAfterFilterCondition>
      recordsLengthGreaterThan(
    int length, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'records',
        length,
        include,
        999999,
        true,
      );
    });
  }

  QueryBuilder<MedicalRecord, MedicalRecord, QAfterFilterCondition>
      recordsLengthBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.listLength(
        r'records',
        lower,
        includeLower,
        upper,
        includeUpper,
      );
    });
  }

  QueryBuilder<MedicalRecord, MedicalRecord, QAfterFilterCondition>
      sessionNameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sessionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicalRecord, MedicalRecord, QAfterFilterCondition>
      sessionNameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'sessionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicalRecord, MedicalRecord, QAfterFilterCondition>
      sessionNameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'sessionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicalRecord, MedicalRecord, QAfterFilterCondition>
      sessionNameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'sessionName',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicalRecord, MedicalRecord, QAfterFilterCondition>
      sessionNameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'sessionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicalRecord, MedicalRecord, QAfterFilterCondition>
      sessionNameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'sessionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicalRecord, MedicalRecord, QAfterFilterCondition>
      sessionNameContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'sessionName',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicalRecord, MedicalRecord, QAfterFilterCondition>
      sessionNameMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'sessionName',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicalRecord, MedicalRecord, QAfterFilterCondition>
      sessionNameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'sessionName',
        value: '',
      ));
    });
  }

  QueryBuilder<MedicalRecord, MedicalRecord, QAfterFilterCondition>
      sessionNameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'sessionName',
        value: '',
      ));
    });
  }

  QueryBuilder<MedicalRecord, MedicalRecord, QAfterFilterCondition> uidEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicalRecord, MedicalRecord, QAfterFilterCondition>
      uidGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicalRecord, MedicalRecord, QAfterFilterCondition> uidLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicalRecord, MedicalRecord, QAfterFilterCondition> uidBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'uid',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicalRecord, MedicalRecord, QAfterFilterCondition>
      uidStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicalRecord, MedicalRecord, QAfterFilterCondition> uidEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicalRecord, MedicalRecord, QAfterFilterCondition> uidContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'uid',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicalRecord, MedicalRecord, QAfterFilterCondition> uidMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'uid',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicalRecord, MedicalRecord, QAfterFilterCondition>
      uidIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'uid',
        value: '',
      ));
    });
  }

  QueryBuilder<MedicalRecord, MedicalRecord, QAfterFilterCondition>
      uidIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'uid',
        value: '',
      ));
    });
  }

  QueryBuilder<MedicalRecord, MedicalRecord, QAfterFilterCondition>
      updatedAtEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicalRecord, MedicalRecord, QAfterFilterCondition>
      updatedAtGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'updatedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicalRecord, MedicalRecord, QAfterFilterCondition>
      updatedAtLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'updatedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicalRecord, MedicalRecord, QAfterFilterCondition>
      updatedAtBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'updatedAt',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicalRecord, MedicalRecord, QAfterFilterCondition>
      updatedAtStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'updatedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicalRecord, MedicalRecord, QAfterFilterCondition>
      updatedAtEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'updatedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicalRecord, MedicalRecord, QAfterFilterCondition>
      updatedAtContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'updatedAt',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicalRecord, MedicalRecord, QAfterFilterCondition>
      updatedAtMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'updatedAt',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<MedicalRecord, MedicalRecord, QAfterFilterCondition>
      updatedAtIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'updatedAt',
        value: '',
      ));
    });
  }

  QueryBuilder<MedicalRecord, MedicalRecord, QAfterFilterCondition>
      updatedAtIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'updatedAt',
        value: '',
      ));
    });
  }
}

extension MedicalRecordQueryObject
    on QueryBuilder<MedicalRecord, MedicalRecord, QFilterCondition> {
  QueryBuilder<MedicalRecord, MedicalRecord, QAfterFilterCondition>
      recordsElement(FilterQuery<KeyValuePair> q) {
    return QueryBuilder.apply(this, (query) {
      return query.object(q, r'records');
    });
  }
}

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const KeyValuePairSchema = Schema(
  name: r'KeyValuePair',
  id: 7710330437554445552,
  properties: {
    r'key': PropertySchema(
      id: 0,
      name: r'key',
      type: IsarType.string,
    ),
    r'value': PropertySchema(
      id: 1,
      name: r'value',
      type: IsarType.string,
    )
  },
  estimateSize: _keyValuePairEstimateSize,
  serialize: _keyValuePairSerialize,
  deserialize: _keyValuePairDeserialize,
  deserializeProp: _keyValuePairDeserializeProp,
);

int _keyValuePairEstimateSize(
  KeyValuePair object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.key.length * 3;
  bytesCount += 3 + object.value.length * 3;
  return bytesCount;
}

void _keyValuePairSerialize(
  KeyValuePair object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.key);
  writer.writeString(offsets[1], object.value);
}

KeyValuePair _keyValuePairDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = KeyValuePair();
  object.key = reader.readString(offsets[0]);
  object.value = reader.readString(offsets[1]);
  return object;
}

P _keyValuePairDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readString(offset)) as P;
    case 1:
      return (reader.readString(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension KeyValuePairQueryFilter
    on QueryBuilder<KeyValuePair, KeyValuePair, QFilterCondition> {
  QueryBuilder<KeyValuePair, KeyValuePair, QAfterFilterCondition> keyEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KeyValuePair, KeyValuePair, QAfterFilterCondition>
      keyGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KeyValuePair, KeyValuePair, QAfterFilterCondition> keyLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KeyValuePair, KeyValuePair, QAfterFilterCondition> keyBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'key',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KeyValuePair, KeyValuePair, QAfterFilterCondition> keyStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KeyValuePair, KeyValuePair, QAfterFilterCondition> keyEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KeyValuePair, KeyValuePair, QAfterFilterCondition> keyContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'key',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KeyValuePair, KeyValuePair, QAfterFilterCondition> keyMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'key',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KeyValuePair, KeyValuePair, QAfterFilterCondition> keyIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'key',
        value: '',
      ));
    });
  }

  QueryBuilder<KeyValuePair, KeyValuePair, QAfterFilterCondition>
      keyIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'key',
        value: '',
      ));
    });
  }

  QueryBuilder<KeyValuePair, KeyValuePair, QAfterFilterCondition> valueEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KeyValuePair, KeyValuePair, QAfterFilterCondition>
      valueGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KeyValuePair, KeyValuePair, QAfterFilterCondition> valueLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KeyValuePair, KeyValuePair, QAfterFilterCondition> valueBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'value',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KeyValuePair, KeyValuePair, QAfterFilterCondition>
      valueStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KeyValuePair, KeyValuePair, QAfterFilterCondition> valueEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KeyValuePair, KeyValuePair, QAfterFilterCondition> valueContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'value',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KeyValuePair, KeyValuePair, QAfterFilterCondition> valueMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'value',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<KeyValuePair, KeyValuePair, QAfterFilterCondition>
      valueIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'value',
        value: '',
      ));
    });
  }

  QueryBuilder<KeyValuePair, KeyValuePair, QAfterFilterCondition>
      valueIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'value',
        value: '',
      ));
    });
  }
}

extension KeyValuePairQueryObject
    on QueryBuilder<KeyValuePair, KeyValuePair, QFilterCondition> {}
