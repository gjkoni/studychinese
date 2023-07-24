// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'db_manager.dart';

// ignore_for_file: type=lint
class LevelCharacter extends Table
    with TableInfo<LevelCharacter, LevelCharacterData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  LevelCharacter(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int> id = GeneratedColumn<int>(
      'id', aliasedName, false,
      hasAutoIncrement: true,
      type: DriftSqlType.int,
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  static const VerificationMeta _titleMeta = const VerificationMeta('title');
  late final GeneratedColumn<String> title = GeneratedColumn<String>(
      'title', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _characterMeta =
      const VerificationMeta('character');
  late final GeneratedColumn<String> character = GeneratedColumn<String>(
      'character', aliasedName, false,
      type: DriftSqlType.string,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _adminMeta = const VerificationMeta('admin');
  late final GeneratedColumn<int> admin = GeneratedColumn<int>(
      'admin', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  static const VerificationMeta _isdeleteMeta =
      const VerificationMeta('isdelete');
  late final GeneratedColumn<int> isdelete = GeneratedColumn<int>(
      'isdelete', aliasedName, false,
      type: DriftSqlType.int,
      requiredDuringInsert: true,
      $customConstraints: 'NOT NULL');
  @override
  List<GeneratedColumn> get $columns => [id, title, character, admin, isdelete];
  @override
  String get aliasedName => _alias ?? 'LevelCharacter';
  @override
  String get actualTableName => 'LevelCharacter';
  @override
  VerificationContext validateIntegrity(Insertable<LevelCharacterData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    } else if (isInserting) {
      context.missing(_titleMeta);
    }
    if (data.containsKey('character')) {
      context.handle(_characterMeta,
          character.isAcceptableOrUnknown(data['character']!, _characterMeta));
    } else if (isInserting) {
      context.missing(_characterMeta);
    }
    if (data.containsKey('admin')) {
      context.handle(
          _adminMeta, admin.isAcceptableOrUnknown(data['admin']!, _adminMeta));
    } else if (isInserting) {
      context.missing(_adminMeta);
    }
    if (data.containsKey('isdelete')) {
      context.handle(_isdeleteMeta,
          isdelete.isAcceptableOrUnknown(data['isdelete']!, _isdeleteMeta));
    } else if (isInserting) {
      context.missing(_isdeleteMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  LevelCharacterData map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return LevelCharacterData(
      id: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}id'])!,
      title: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}title'])!,
      character: attachedDatabase.typeMapping
          .read(DriftSqlType.string, data['${effectivePrefix}character'])!,
      admin: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}admin'])!,
      isdelete: attachedDatabase.typeMapping
          .read(DriftSqlType.int, data['${effectivePrefix}isdelete'])!,
    );
  }

  @override
  LevelCharacter createAlias(String alias) {
    return LevelCharacter(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class LevelCharacterData extends DataClass
    implements Insertable<LevelCharacterData> {
  final int id;
  final String title;
  final String character;
  final int admin;
  final int isdelete;
  const LevelCharacterData(
      {required this.id,
      required this.title,
      required this.character,
      required this.admin,
      required this.isdelete});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    map['title'] = Variable<String>(title);
    map['character'] = Variable<String>(character);
    map['admin'] = Variable<int>(admin);
    map['isdelete'] = Variable<int>(isdelete);
    return map;
  }

  LevelCharacterCompanion toCompanion(bool nullToAbsent) {
    return LevelCharacterCompanion(
      id: Value(id),
      title: Value(title),
      character: Value(character),
      admin: Value(admin),
      isdelete: Value(isdelete),
    );
  }

  factory LevelCharacterData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return LevelCharacterData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String>(json['title']),
      character: serializer.fromJson<String>(json['character']),
      admin: serializer.fromJson<int>(json['admin']),
      isdelete: serializer.fromJson<int>(json['isdelete']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String>(title),
      'character': serializer.toJson<String>(character),
      'admin': serializer.toJson<int>(admin),
      'isdelete': serializer.toJson<int>(isdelete),
    };
  }

  LevelCharacterData copyWith(
          {int? id,
          String? title,
          String? character,
          int? admin,
          int? isdelete}) =>
      LevelCharacterData(
        id: id ?? this.id,
        title: title ?? this.title,
        character: character ?? this.character,
        admin: admin ?? this.admin,
        isdelete: isdelete ?? this.isdelete,
      );
  @override
  String toString() {
    return (StringBuffer('LevelCharacterData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('character: $character, ')
          ..write('admin: $admin, ')
          ..write('isdelete: $isdelete')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, character, admin, isdelete);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is LevelCharacterData &&
          other.id == this.id &&
          other.title == this.title &&
          other.character == this.character &&
          other.admin == this.admin &&
          other.isdelete == this.isdelete);
}

class LevelCharacterCompanion extends UpdateCompanion<LevelCharacterData> {
  final Value<int> id;
  final Value<String> title;
  final Value<String> character;
  final Value<int> admin;
  final Value<int> isdelete;
  const LevelCharacterCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.character = const Value.absent(),
    this.admin = const Value.absent(),
    this.isdelete = const Value.absent(),
  });
  LevelCharacterCompanion.insert({
    this.id = const Value.absent(),
    required String title,
    required String character,
    required int admin,
    required int isdelete,
  })  : title = Value(title),
        character = Value(character),
        admin = Value(admin),
        isdelete = Value(isdelete);
  static Insertable<LevelCharacterData> custom({
    Expression<int>? id,
    Expression<String>? title,
    Expression<String>? character,
    Expression<int>? admin,
    Expression<int>? isdelete,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (character != null) 'character': character,
      if (admin != null) 'admin': admin,
      if (isdelete != null) 'isdelete': isdelete,
    });
  }

  LevelCharacterCompanion copyWith(
      {Value<int>? id,
      Value<String>? title,
      Value<String>? character,
      Value<int>? admin,
      Value<int>? isdelete}) {
    return LevelCharacterCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      character: character ?? this.character,
      admin: admin ?? this.admin,
      isdelete: isdelete ?? this.isdelete,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String>(title.value);
    }
    if (character.present) {
      map['character'] = Variable<String>(character.value);
    }
    if (admin.present) {
      map['admin'] = Variable<int>(admin.value);
    }
    if (isdelete.present) {
      map['isdelete'] = Variable<int>(isdelete.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('LevelCharacterCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('character: $character, ')
          ..write('admin: $admin, ')
          ..write('isdelete: $isdelete')
          ..write(')'))
        .toString();
  }
}

abstract class _$DBManager extends GeneratedDatabase {
  _$DBManager(QueryExecutor e) : super(e);
  late final LevelCharacter levelCharacter = LevelCharacter(this);
  late final Index levelCharacterName = Index('LevelCharacter_name',
      'CREATE INDEX LevelCharacter_name ON LevelCharacter (title)');
  Future<int> createEntry(String title, String character) {
    return customInsert(
      'INSERT INTO LevelCharacter (title, character, admin, isdelete) VALUES (?1, ?2, 0, 0)',
      variables: [Variable<String>(title), Variable<String>(character)],
      updates: {levelCharacter},
    );
  }

  Future<int> deleteById(int id) {
    return customUpdate(
      'UPDATE LevelCharacter SET isdelete = 1 WHERE id = ?1',
      variables: [Variable<int>(id)],
      updates: {levelCharacter},
      updateKind: UpdateKind.update,
    );
  }

  Selectable<LevelCharacterData> allLevelCharacter() {
    return customSelect('SELECT * FROM LevelCharacter WHERE isdelete = 0',
        variables: [],
        readsFrom: {
          levelCharacter,
        }).asyncMap(levelCharacter.mapFromRow);
  }

  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities =>
      [levelCharacter, levelCharacterName];
}
