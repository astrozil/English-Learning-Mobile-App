// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'dictionary_database.dart';

// ignore_for_file: type=lint
class $DictionaryTableTable extends DictionaryTable
    with TableInfo<$DictionaryTableTable, DictionaryTableData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $DictionaryTableTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _wordMeta = const VerificationMeta('word');
  @override
  late final GeneratedColumn<String> word = GeneratedColumn<String>(
      'word', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _typeMeta = const VerificationMeta('type');
  @override
  late final GeneratedColumn<String> type = GeneratedColumn<String>(
      'type', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  static const VerificationMeta _defnMeta = const VerificationMeta('defn');
  @override
  late final GeneratedColumn<String> defn = GeneratedColumn<String>(
      'defn', aliasedName, false,
      type: DriftSqlType.string, requiredDuringInsert: true);
  @override
  List<GeneratedColumn> get $columns => [word, type, defn];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'words';
  @override
  VerificationContext validateIntegrity(
      Insertable<DictionaryTableData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('word')) {
      context.handle(
          _wordMeta, word.isAcceptableOrUnknown(data['word']!, _wordMeta));
    } else if (isInserting) {
      context.missing(_wordMeta);
    }
    if (data.containsKey('type')) {
      context.handle(
          _typeMeta, type.isAcceptableOrUnknown(data['type']!, _typeMeta));
    } else if (isInserting) {
      context.missing(_typeMeta);
    }
    if (data.containsKey('defn')) {
      context.handle(
          _defnMeta, defn.isAcceptableOrUnknown(data['defn']!, _defnMeta));
    } else if (isInserting) {
      context.missing(_defnMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => const {};
  @override
  DictionaryTableData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return DictionaryTableData(
      word: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}word'])!,
      type: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}type'])!,
      defn: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}defn'])!,
    );
  }

  @override
  $DictionaryTableTable createAlias(String alias) {
    return $DictionaryTableTable(attachedDatabase, alias);
  }
}

class DictionaryTableData extends DataClass
    implements Insertable<DictionaryTableData> {
  final String word;
  final String type;
  final String defn;
  const DictionaryTableData(
      {required this.word, required this.type, required this.defn});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['word'] = Variable<String>(word);
    map['type'] = Variable<String>(type);
    map['defn'] = Variable<String>(defn);
    return map;
  }

  DictionaryTableCompanion toCompanion(bool nullToAbsent) {
    return DictionaryTableCompanion(
      word: Value(word),
      type: Value(type),
      defn: Value(defn),
    );
  }

  factory DictionaryTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return DictionaryTableData(
      word: serializer.fromJson<String>(json['word']),
      type: serializer.fromJson<String>(json['type']),
      defn: serializer.fromJson<String>(json['defn']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'word': serializer.toJson<String>(word),
      'type': serializer.toJson<String>(type),
      'defn': serializer.toJson<String>(defn),
    };
  }

  DictionaryTableData copyWith({String? word, String? type, String? defn}) =>
      DictionaryTableData(
        word: word ?? this.word,
        type: type ?? this.type,
        defn: defn ?? this.defn,
      );
  @override
  String toString() {
    return (StringBuffer('DictionaryTableData(')
          ..write('word: $word, ')
          ..write('type: $type, ')
          ..write('defn: $defn')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(word, type, defn);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is DictionaryTableData &&
          other.word == this.word &&
          other.type == this.type &&
          other.defn == this.defn);
}

class DictionaryTableCompanion extends UpdateCompanion<DictionaryTableData> {
  final Value<String> word;
  final Value<String> type;
  final Value<String> defn;
  final Value<int> rowid;
  const DictionaryTableCompanion({
    this.word = const Value.absent(),
    this.type = const Value.absent(),
    this.defn = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  DictionaryTableCompanion.insert({
    required String word,
    required String type,
    required String defn,
    this.rowid = const Value.absent(),
  })  : word = Value(word),
        type = Value(type),
        defn = Value(defn);
  static Insertable<DictionaryTableData> custom({
    Expression<String>? word,
    Expression<String>? type,
    Expression<String>? defn,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (word != null) 'word': word,
      if (type != null) 'type': type,
      if (defn != null) 'defn': defn,
      if (rowid != null) 'rowid': rowid,
    });
  }

  DictionaryTableCompanion copyWith(
      {Value<String>? word,
      Value<String>? type,
      Value<String>? defn,
      Value<int>? rowid}) {
    return DictionaryTableCompanion(
      word: word ?? this.word,
      type: type ?? this.type,
      defn: defn ?? this.defn,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (word.present) {
      map['word'] = Variable<String>(word.value);
    }
    if (type.present) {
      map['type'] = Variable<String>(type.value);
    }
    if (defn.present) {
      map['defn'] = Variable<String>(defn.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('DictionaryTableCompanion(')
          ..write('word: $word, ')
          ..write('type: $type, ')
          ..write('defn: $defn, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$DictionaryDatabase extends GeneratedDatabase {
  _$DictionaryDatabase(QueryExecutor e) : super(e);
  late final $DictionaryTableTable dictionaryTable =
      $DictionaryTableTable(this);
  late final DictionaryDao dictionaryDao =
      DictionaryDao(this as DictionaryDatabase);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [dictionaryTable];
}
