// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'app_database.dart';

// ignore_for_file: type=lint
class $ArticlesTable extends Articles with TableInfo<$ArticlesTable, Article> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ArticlesTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _urlStringMeta = const VerificationMeta(
    'urlString',
  );
  @override
  late final GeneratedColumn<String> urlString = GeneratedColumn<String>(
    'url_string',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _createdAtMeta = const VerificationMeta(
    'createdAt',
  );
  @override
  late final GeneratedColumn<DateTime> createdAt = GeneratedColumn<DateTime>(
    'created_at',
    aliasedName,
    false,
    type: DriftSqlType.dateTime,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _ogpTitleMeta = const VerificationMeta(
    'ogpTitle',
  );
  @override
  late final GeneratedColumn<String> ogpTitle = GeneratedColumn<String>(
    'ogp_title',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  static const VerificationMeta _ogpImageUrlMeta = const VerificationMeta(
    'ogpImageUrl',
  );
  @override
  late final GeneratedColumn<String> ogpImageUrl = GeneratedColumn<String>(
    'ogp_image_url',
    aliasedName,
    true,
    type: DriftSqlType.string,
    requiredDuringInsert: false,
  );
  @override
  List<GeneratedColumn> get $columns => [
    id,
    urlString,
    createdAt,
    ogpTitle,
    ogpImageUrl,
  ];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'articles';
  @override
  VerificationContext validateIntegrity(
    Insertable<Article> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('url_string')) {
      context.handle(
        _urlStringMeta,
        urlString.isAcceptableOrUnknown(data['url_string']!, _urlStringMeta),
      );
    } else if (isInserting) {
      context.missing(_urlStringMeta);
    }
    if (data.containsKey('created_at')) {
      context.handle(
        _createdAtMeta,
        createdAt.isAcceptableOrUnknown(data['created_at']!, _createdAtMeta),
      );
    } else if (isInserting) {
      context.missing(_createdAtMeta);
    }
    if (data.containsKey('ogp_title')) {
      context.handle(
        _ogpTitleMeta,
        ogpTitle.isAcceptableOrUnknown(data['ogp_title']!, _ogpTitleMeta),
      );
    }
    if (data.containsKey('ogp_image_url')) {
      context.handle(
        _ogpImageUrlMeta,
        ogpImageUrl.isAcceptableOrUnknown(
          data['ogp_image_url']!,
          _ogpImageUrlMeta,
        ),
      );
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Article map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Article(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      urlString: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}url_string'],
      )!,
      createdAt: attachedDatabase.typeMapping.read(
        DriftSqlType.dateTime,
        data['${effectivePrefix}created_at'],
      )!,
      ogpTitle: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ogp_title'],
      ),
      ogpImageUrl: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}ogp_image_url'],
      ),
    );
  }

  @override
  $ArticlesTable createAlias(String alias) {
    return $ArticlesTable(attachedDatabase, alias);
  }
}

class Article extends DataClass implements Insertable<Article> {
  final String id;
  final String urlString;
  final DateTime createdAt;
  final String? ogpTitle;
  final String? ogpImageUrl;
  const Article({
    required this.id,
    required this.urlString,
    required this.createdAt,
    this.ogpTitle,
    this.ogpImageUrl,
  });
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['url_string'] = Variable<String>(urlString);
    map['created_at'] = Variable<DateTime>(createdAt);
    if (!nullToAbsent || ogpTitle != null) {
      map['ogp_title'] = Variable<String>(ogpTitle);
    }
    if (!nullToAbsent || ogpImageUrl != null) {
      map['ogp_image_url'] = Variable<String>(ogpImageUrl);
    }
    return map;
  }

  ArticlesCompanion toCompanion(bool nullToAbsent) {
    return ArticlesCompanion(
      id: Value(id),
      urlString: Value(urlString),
      createdAt: Value(createdAt),
      ogpTitle: ogpTitle == null && nullToAbsent
          ? const Value.absent()
          : Value(ogpTitle),
      ogpImageUrl: ogpImageUrl == null && nullToAbsent
          ? const Value.absent()
          : Value(ogpImageUrl),
    );
  }

  factory Article.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Article(
      id: serializer.fromJson<String>(json['id']),
      urlString: serializer.fromJson<String>(json['urlString']),
      createdAt: serializer.fromJson<DateTime>(json['createdAt']),
      ogpTitle: serializer.fromJson<String?>(json['ogpTitle']),
      ogpImageUrl: serializer.fromJson<String?>(json['ogpImageUrl']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'urlString': serializer.toJson<String>(urlString),
      'createdAt': serializer.toJson<DateTime>(createdAt),
      'ogpTitle': serializer.toJson<String?>(ogpTitle),
      'ogpImageUrl': serializer.toJson<String?>(ogpImageUrl),
    };
  }

  Article copyWith({
    String? id,
    String? urlString,
    DateTime? createdAt,
    Value<String?> ogpTitle = const Value.absent(),
    Value<String?> ogpImageUrl = const Value.absent(),
  }) => Article(
    id: id ?? this.id,
    urlString: urlString ?? this.urlString,
    createdAt: createdAt ?? this.createdAt,
    ogpTitle: ogpTitle.present ? ogpTitle.value : this.ogpTitle,
    ogpImageUrl: ogpImageUrl.present ? ogpImageUrl.value : this.ogpImageUrl,
  );
  Article copyWithCompanion(ArticlesCompanion data) {
    return Article(
      id: data.id.present ? data.id.value : this.id,
      urlString: data.urlString.present ? data.urlString.value : this.urlString,
      createdAt: data.createdAt.present ? data.createdAt.value : this.createdAt,
      ogpTitle: data.ogpTitle.present ? data.ogpTitle.value : this.ogpTitle,
      ogpImageUrl: data.ogpImageUrl.present
          ? data.ogpImageUrl.value
          : this.ogpImageUrl,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Article(')
          ..write('id: $id, ')
          ..write('urlString: $urlString, ')
          ..write('createdAt: $createdAt, ')
          ..write('ogpTitle: $ogpTitle, ')
          ..write('ogpImageUrl: $ogpImageUrl')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode =>
      Object.hash(id, urlString, createdAt, ogpTitle, ogpImageUrl);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Article &&
          other.id == this.id &&
          other.urlString == this.urlString &&
          other.createdAt == this.createdAt &&
          other.ogpTitle == this.ogpTitle &&
          other.ogpImageUrl == this.ogpImageUrl);
}

class ArticlesCompanion extends UpdateCompanion<Article> {
  final Value<String> id;
  final Value<String> urlString;
  final Value<DateTime> createdAt;
  final Value<String?> ogpTitle;
  final Value<String?> ogpImageUrl;
  final Value<int> rowid;
  const ArticlesCompanion({
    this.id = const Value.absent(),
    this.urlString = const Value.absent(),
    this.createdAt = const Value.absent(),
    this.ogpTitle = const Value.absent(),
    this.ogpImageUrl = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ArticlesCompanion.insert({
    required String id,
    required String urlString,
    required DateTime createdAt,
    this.ogpTitle = const Value.absent(),
    this.ogpImageUrl = const Value.absent(),
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       urlString = Value(urlString),
       createdAt = Value(createdAt);
  static Insertable<Article> custom({
    Expression<String>? id,
    Expression<String>? urlString,
    Expression<DateTime>? createdAt,
    Expression<String>? ogpTitle,
    Expression<String>? ogpImageUrl,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (urlString != null) 'url_string': urlString,
      if (createdAt != null) 'created_at': createdAt,
      if (ogpTitle != null) 'ogp_title': ogpTitle,
      if (ogpImageUrl != null) 'ogp_image_url': ogpImageUrl,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ArticlesCompanion copyWith({
    Value<String>? id,
    Value<String>? urlString,
    Value<DateTime>? createdAt,
    Value<String?>? ogpTitle,
    Value<String?>? ogpImageUrl,
    Value<int>? rowid,
  }) {
    return ArticlesCompanion(
      id: id ?? this.id,
      urlString: urlString ?? this.urlString,
      createdAt: createdAt ?? this.createdAt,
      ogpTitle: ogpTitle ?? this.ogpTitle,
      ogpImageUrl: ogpImageUrl ?? this.ogpImageUrl,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (urlString.present) {
      map['url_string'] = Variable<String>(urlString.value);
    }
    if (createdAt.present) {
      map['created_at'] = Variable<DateTime>(createdAt.value);
    }
    if (ogpTitle.present) {
      map['ogp_title'] = Variable<String>(ogpTitle.value);
    }
    if (ogpImageUrl.present) {
      map['ogp_image_url'] = Variable<String>(ogpImageUrl.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ArticlesCompanion(')
          ..write('id: $id, ')
          ..write('urlString: $urlString, ')
          ..write('createdAt: $createdAt, ')
          ..write('ogpTitle: $ogpTitle, ')
          ..write('ogpImageUrl: $ogpImageUrl, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $GroupsTable extends Groups with TableInfo<$GroupsTable, Group> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $GroupsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _idMeta = const VerificationMeta('id');
  @override
  late final GeneratedColumn<String> id = GeneratedColumn<String>(
    'id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  static const VerificationMeta _nameMeta = const VerificationMeta('name');
  @override
  late final GeneratedColumn<String> name = GeneratedColumn<String>(
    'name',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
  );
  @override
  List<GeneratedColumn> get $columns => [id, name];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'groups';
  @override
  VerificationContext validateIntegrity(
    Insertable<Group> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    } else if (isInserting) {
      context.missing(_idMeta);
    }
    if (data.containsKey('name')) {
      context.handle(
        _nameMeta,
        name.isAcceptableOrUnknown(data['name']!, _nameMeta),
      );
    } else if (isInserting) {
      context.missing(_nameMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  Group map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return Group(
      id: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}id'],
      )!,
      name: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}name'],
      )!,
    );
  }

  @override
  $GroupsTable createAlias(String alias) {
    return $GroupsTable(attachedDatabase, alias);
  }
}

class Group extends DataClass implements Insertable<Group> {
  final String id;
  final String name;
  const Group({required this.id, required this.name});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<String>(id);
    map['name'] = Variable<String>(name);
    return map;
  }

  GroupsCompanion toCompanion(bool nullToAbsent) {
    return GroupsCompanion(id: Value(id), name: Value(name));
  }

  factory Group.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return Group(
      id: serializer.fromJson<String>(json['id']),
      name: serializer.fromJson<String>(json['name']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<String>(id),
      'name': serializer.toJson<String>(name),
    };
  }

  Group copyWith({String? id, String? name}) =>
      Group(id: id ?? this.id, name: name ?? this.name);
  Group copyWithCompanion(GroupsCompanion data) {
    return Group(
      id: data.id.present ? data.id.value : this.id,
      name: data.name.present ? data.name.value : this.name,
    );
  }

  @override
  String toString() {
    return (StringBuffer('Group(')
          ..write('id: $id, ')
          ..write('name: $name')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, name);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Group && other.id == this.id && other.name == this.name);
}

class GroupsCompanion extends UpdateCompanion<Group> {
  final Value<String> id;
  final Value<String> name;
  final Value<int> rowid;
  const GroupsCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  GroupsCompanion.insert({
    required String id,
    required String name,
    this.rowid = const Value.absent(),
  }) : id = Value(id),
       name = Value(name);
  static Insertable<Group> custom({
    Expression<String>? id,
    Expression<String>? name,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (name != null) 'name': name,
      if (rowid != null) 'rowid': rowid,
    });
  }

  GroupsCompanion copyWith({
    Value<String>? id,
    Value<String>? name,
    Value<int>? rowid,
  }) {
    return GroupsCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<String>(id.value);
    }
    if (name.present) {
      map['name'] = Variable<String>(name.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('GroupsCompanion(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

class $ArticleGroupRelationsTable extends ArticleGroupRelations
    with TableInfo<$ArticleGroupRelationsTable, ArticleGroupRelation> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  $ArticleGroupRelationsTable(this.attachedDatabase, [this._alias]);
  static const VerificationMeta _articleIdMeta = const VerificationMeta(
    'articleId',
  );
  @override
  late final GeneratedColumn<String> articleId = GeneratedColumn<String>(
    'article_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES articles (id)',
    ),
  );
  static const VerificationMeta _groupIdMeta = const VerificationMeta(
    'groupId',
  );
  @override
  late final GeneratedColumn<String> groupId = GeneratedColumn<String>(
    'group_id',
    aliasedName,
    false,
    type: DriftSqlType.string,
    requiredDuringInsert: true,
    defaultConstraints: GeneratedColumn.constraintIsAlways(
      'REFERENCES "groups" (id)',
    ),
  );
  @override
  List<GeneratedColumn> get $columns => [articleId, groupId];
  @override
  String get aliasedName => _alias ?? actualTableName;
  @override
  String get actualTableName => $name;
  static const String $name = 'article_group_relations';
  @override
  VerificationContext validateIntegrity(
    Insertable<ArticleGroupRelation> instance, {
    bool isInserting = false,
  }) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('article_id')) {
      context.handle(
        _articleIdMeta,
        articleId.isAcceptableOrUnknown(data['article_id']!, _articleIdMeta),
      );
    } else if (isInserting) {
      context.missing(_articleIdMeta);
    }
    if (data.containsKey('group_id')) {
      context.handle(
        _groupIdMeta,
        groupId.isAcceptableOrUnknown(data['group_id']!, _groupIdMeta),
      );
    } else if (isInserting) {
      context.missing(_groupIdMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {articleId, groupId};
  @override
  ArticleGroupRelation map(Map<String, dynamic> data, {String? tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : '';
    return ArticleGroupRelation(
      articleId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}article_id'],
      )!,
      groupId: attachedDatabase.typeMapping.read(
        DriftSqlType.string,
        data['${effectivePrefix}group_id'],
      )!,
    );
  }

  @override
  $ArticleGroupRelationsTable createAlias(String alias) {
    return $ArticleGroupRelationsTable(attachedDatabase, alias);
  }
}

class ArticleGroupRelation extends DataClass
    implements Insertable<ArticleGroupRelation> {
  final String articleId;
  final String groupId;
  const ArticleGroupRelation({required this.articleId, required this.groupId});
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['article_id'] = Variable<String>(articleId);
    map['group_id'] = Variable<String>(groupId);
    return map;
  }

  ArticleGroupRelationsCompanion toCompanion(bool nullToAbsent) {
    return ArticleGroupRelationsCompanion(
      articleId: Value(articleId),
      groupId: Value(groupId),
    );
  }

  factory ArticleGroupRelation.fromJson(
    Map<String, dynamic> json, {
    ValueSerializer? serializer,
  }) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return ArticleGroupRelation(
      articleId: serializer.fromJson<String>(json['articleId']),
      groupId: serializer.fromJson<String>(json['groupId']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'articleId': serializer.toJson<String>(articleId),
      'groupId': serializer.toJson<String>(groupId),
    };
  }

  ArticleGroupRelation copyWith({String? articleId, String? groupId}) =>
      ArticleGroupRelation(
        articleId: articleId ?? this.articleId,
        groupId: groupId ?? this.groupId,
      );
  ArticleGroupRelation copyWithCompanion(ArticleGroupRelationsCompanion data) {
    return ArticleGroupRelation(
      articleId: data.articleId.present ? data.articleId.value : this.articleId,
      groupId: data.groupId.present ? data.groupId.value : this.groupId,
    );
  }

  @override
  String toString() {
    return (StringBuffer('ArticleGroupRelation(')
          ..write('articleId: $articleId, ')
          ..write('groupId: $groupId')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(articleId, groupId);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is ArticleGroupRelation &&
          other.articleId == this.articleId &&
          other.groupId == this.groupId);
}

class ArticleGroupRelationsCompanion
    extends UpdateCompanion<ArticleGroupRelation> {
  final Value<String> articleId;
  final Value<String> groupId;
  final Value<int> rowid;
  const ArticleGroupRelationsCompanion({
    this.articleId = const Value.absent(),
    this.groupId = const Value.absent(),
    this.rowid = const Value.absent(),
  });
  ArticleGroupRelationsCompanion.insert({
    required String articleId,
    required String groupId,
    this.rowid = const Value.absent(),
  }) : articleId = Value(articleId),
       groupId = Value(groupId);
  static Insertable<ArticleGroupRelation> custom({
    Expression<String>? articleId,
    Expression<String>? groupId,
    Expression<int>? rowid,
  }) {
    return RawValuesInsertable({
      if (articleId != null) 'article_id': articleId,
      if (groupId != null) 'group_id': groupId,
      if (rowid != null) 'rowid': rowid,
    });
  }

  ArticleGroupRelationsCompanion copyWith({
    Value<String>? articleId,
    Value<String>? groupId,
    Value<int>? rowid,
  }) {
    return ArticleGroupRelationsCompanion(
      articleId: articleId ?? this.articleId,
      groupId: groupId ?? this.groupId,
      rowid: rowid ?? this.rowid,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (articleId.present) {
      map['article_id'] = Variable<String>(articleId.value);
    }
    if (groupId.present) {
      map['group_id'] = Variable<String>(groupId.value);
    }
    if (rowid.present) {
      map['rowid'] = Variable<int>(rowid.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('ArticleGroupRelationsCompanion(')
          ..write('articleId: $articleId, ')
          ..write('groupId: $groupId, ')
          ..write('rowid: $rowid')
          ..write(')'))
        .toString();
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(e);
  $AppDatabaseManager get managers => $AppDatabaseManager(this);
  late final $ArticlesTable articles = $ArticlesTable(this);
  late final $GroupsTable groups = $GroupsTable(this);
  late final $ArticleGroupRelationsTable articleGroupRelations =
      $ArticleGroupRelationsTable(this);
  @override
  Iterable<TableInfo<Table, Object?>> get allTables =>
      allSchemaEntities.whereType<TableInfo<Table, Object?>>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [
    articles,
    groups,
    articleGroupRelations,
  ];
}

typedef $$ArticlesTableCreateCompanionBuilder =
    ArticlesCompanion Function({
      required String id,
      required String urlString,
      required DateTime createdAt,
      Value<String?> ogpTitle,
      Value<String?> ogpImageUrl,
      Value<int> rowid,
    });
typedef $$ArticlesTableUpdateCompanionBuilder =
    ArticlesCompanion Function({
      Value<String> id,
      Value<String> urlString,
      Value<DateTime> createdAt,
      Value<String?> ogpTitle,
      Value<String?> ogpImageUrl,
      Value<int> rowid,
    });

final class $$ArticlesTableReferences
    extends BaseReferences<_$AppDatabase, $ArticlesTable, Article> {
  $$ArticlesTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<
    $ArticleGroupRelationsTable,
    List<ArticleGroupRelation>
  >
  _articleGroupRelationsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.articleGroupRelations,
        aliasName: $_aliasNameGenerator(
          db.articles.id,
          db.articleGroupRelations.articleId,
        ),
      );

  $$ArticleGroupRelationsTableProcessedTableManager
  get articleGroupRelationsRefs {
    final manager = $$ArticleGroupRelationsTableTableManager(
      $_db,
      $_db.articleGroupRelations,
    ).filter((f) => f.articleId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _articleGroupRelationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$ArticlesTableFilterComposer
    extends Composer<_$AppDatabase, $ArticlesTable> {
  $$ArticlesTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get urlString => $composableBuilder(
    column: $table.urlString,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ogpTitle => $composableBuilder(
    column: $table.ogpTitle,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get ogpImageUrl => $composableBuilder(
    column: $table.ogpImageUrl,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> articleGroupRelationsRefs(
    Expression<bool> Function($$ArticleGroupRelationsTableFilterComposer f) f,
  ) {
    final $$ArticleGroupRelationsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.articleGroupRelations,
          getReferencedColumn: (t) => t.articleId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ArticleGroupRelationsTableFilterComposer(
                $db: $db,
                $table: $db.articleGroupRelations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ArticlesTableOrderingComposer
    extends Composer<_$AppDatabase, $ArticlesTable> {
  $$ArticlesTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get urlString => $composableBuilder(
    column: $table.urlString,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<DateTime> get createdAt => $composableBuilder(
    column: $table.createdAt,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ogpTitle => $composableBuilder(
    column: $table.ogpTitle,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get ogpImageUrl => $composableBuilder(
    column: $table.ogpImageUrl,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$ArticlesTableAnnotationComposer
    extends Composer<_$AppDatabase, $ArticlesTable> {
  $$ArticlesTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get urlString =>
      $composableBuilder(column: $table.urlString, builder: (column) => column);

  GeneratedColumn<DateTime> get createdAt =>
      $composableBuilder(column: $table.createdAt, builder: (column) => column);

  GeneratedColumn<String> get ogpTitle =>
      $composableBuilder(column: $table.ogpTitle, builder: (column) => column);

  GeneratedColumn<String> get ogpImageUrl => $composableBuilder(
    column: $table.ogpImageUrl,
    builder: (column) => column,
  );

  Expression<T> articleGroupRelationsRefs<T extends Object>(
    Expression<T> Function($$ArticleGroupRelationsTableAnnotationComposer a) f,
  ) {
    final $$ArticleGroupRelationsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.articleGroupRelations,
          getReferencedColumn: (t) => t.articleId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ArticleGroupRelationsTableAnnotationComposer(
                $db: $db,
                $table: $db.articleGroupRelations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$ArticlesTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ArticlesTable,
          Article,
          $$ArticlesTableFilterComposer,
          $$ArticlesTableOrderingComposer,
          $$ArticlesTableAnnotationComposer,
          $$ArticlesTableCreateCompanionBuilder,
          $$ArticlesTableUpdateCompanionBuilder,
          (Article, $$ArticlesTableReferences),
          Article,
          PrefetchHooks Function({bool articleGroupRelationsRefs})
        > {
  $$ArticlesTableTableManager(_$AppDatabase db, $ArticlesTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ArticlesTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$ArticlesTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$ArticlesTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> urlString = const Value.absent(),
                Value<DateTime> createdAt = const Value.absent(),
                Value<String?> ogpTitle = const Value.absent(),
                Value<String?> ogpImageUrl = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ArticlesCompanion(
                id: id,
                urlString: urlString,
                createdAt: createdAt,
                ogpTitle: ogpTitle,
                ogpImageUrl: ogpImageUrl,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String id,
                required String urlString,
                required DateTime createdAt,
                Value<String?> ogpTitle = const Value.absent(),
                Value<String?> ogpImageUrl = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ArticlesCompanion.insert(
                id: id,
                urlString: urlString,
                createdAt: createdAt,
                ogpTitle: ogpTitle,
                ogpImageUrl: ogpImageUrl,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ArticlesTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({articleGroupRelationsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (articleGroupRelationsRefs) db.articleGroupRelations,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (articleGroupRelationsRefs)
                    await $_getPrefetchedData<
                      Article,
                      $ArticlesTable,
                      ArticleGroupRelation
                    >(
                      currentTable: table,
                      referencedTable: $$ArticlesTableReferences
                          ._articleGroupRelationsRefsTable(db),
                      managerFromTypedResult: (p0) => $$ArticlesTableReferences(
                        db,
                        table,
                        p0,
                      ).articleGroupRelationsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.articleId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$ArticlesTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ArticlesTable,
      Article,
      $$ArticlesTableFilterComposer,
      $$ArticlesTableOrderingComposer,
      $$ArticlesTableAnnotationComposer,
      $$ArticlesTableCreateCompanionBuilder,
      $$ArticlesTableUpdateCompanionBuilder,
      (Article, $$ArticlesTableReferences),
      Article,
      PrefetchHooks Function({bool articleGroupRelationsRefs})
    >;
typedef $$GroupsTableCreateCompanionBuilder =
    GroupsCompanion Function({
      required String id,
      required String name,
      Value<int> rowid,
    });
typedef $$GroupsTableUpdateCompanionBuilder =
    GroupsCompanion Function({
      Value<String> id,
      Value<String> name,
      Value<int> rowid,
    });

final class $$GroupsTableReferences
    extends BaseReferences<_$AppDatabase, $GroupsTable, Group> {
  $$GroupsTableReferences(super.$_db, super.$_table, super.$_typedResult);

  static MultiTypedResultKey<
    $ArticleGroupRelationsTable,
    List<ArticleGroupRelation>
  >
  _articleGroupRelationsRefsTable(_$AppDatabase db) =>
      MultiTypedResultKey.fromTable(
        db.articleGroupRelations,
        aliasName: $_aliasNameGenerator(
          db.groups.id,
          db.articleGroupRelations.groupId,
        ),
      );

  $$ArticleGroupRelationsTableProcessedTableManager
  get articleGroupRelationsRefs {
    final manager = $$ArticleGroupRelationsTableTableManager(
      $_db,
      $_db.articleGroupRelations,
    ).filter((f) => f.groupId.id.sqlEquals($_itemColumn<String>('id')!));

    final cache = $_typedResult.readTableOrNull(
      _articleGroupRelationsRefsTable($_db),
    );
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: cache),
    );
  }
}

class $$GroupsTableFilterComposer
    extends Composer<_$AppDatabase, $GroupsTable> {
  $$GroupsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnFilters<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnFilters(column),
  );

  ColumnFilters<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnFilters(column),
  );

  Expression<bool> articleGroupRelationsRefs(
    Expression<bool> Function($$ArticleGroupRelationsTableFilterComposer f) f,
  ) {
    final $$ArticleGroupRelationsTableFilterComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.articleGroupRelations,
          getReferencedColumn: (t) => t.groupId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ArticleGroupRelationsTableFilterComposer(
                $db: $db,
                $table: $db.articleGroupRelations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$GroupsTableOrderingComposer
    extends Composer<_$AppDatabase, $GroupsTable> {
  $$GroupsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  ColumnOrderings<String> get id => $composableBuilder(
    column: $table.id,
    builder: (column) => ColumnOrderings(column),
  );

  ColumnOrderings<String> get name => $composableBuilder(
    column: $table.name,
    builder: (column) => ColumnOrderings(column),
  );
}

class $$GroupsTableAnnotationComposer
    extends Composer<_$AppDatabase, $GroupsTable> {
  $$GroupsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  GeneratedColumn<String> get id =>
      $composableBuilder(column: $table.id, builder: (column) => column);

  GeneratedColumn<String> get name =>
      $composableBuilder(column: $table.name, builder: (column) => column);

  Expression<T> articleGroupRelationsRefs<T extends Object>(
    Expression<T> Function($$ArticleGroupRelationsTableAnnotationComposer a) f,
  ) {
    final $$ArticleGroupRelationsTableAnnotationComposer composer =
        $composerBuilder(
          composer: this,
          getCurrentColumn: (t) => t.id,
          referencedTable: $db.articleGroupRelations,
          getReferencedColumn: (t) => t.groupId,
          builder:
              (
                joinBuilder, {
                $addJoinBuilderToRootComposer,
                $removeJoinBuilderFromRootComposer,
              }) => $$ArticleGroupRelationsTableAnnotationComposer(
                $db: $db,
                $table: $db.articleGroupRelations,
                $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
                joinBuilder: joinBuilder,
                $removeJoinBuilderFromRootComposer:
                    $removeJoinBuilderFromRootComposer,
              ),
        );
    return f(composer);
  }
}

class $$GroupsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $GroupsTable,
          Group,
          $$GroupsTableFilterComposer,
          $$GroupsTableOrderingComposer,
          $$GroupsTableAnnotationComposer,
          $$GroupsTableCreateCompanionBuilder,
          $$GroupsTableUpdateCompanionBuilder,
          (Group, $$GroupsTableReferences),
          Group,
          PrefetchHooks Function({bool articleGroupRelationsRefs})
        > {
  $$GroupsTableTableManager(_$AppDatabase db, $GroupsTable table)
    : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$GroupsTableFilterComposer($db: db, $table: table),
          createOrderingComposer: () =>
              $$GroupsTableOrderingComposer($db: db, $table: table),
          createComputedFieldComposer: () =>
              $$GroupsTableAnnotationComposer($db: db, $table: table),
          updateCompanionCallback:
              ({
                Value<String> id = const Value.absent(),
                Value<String> name = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => GroupsCompanion(id: id, name: name, rowid: rowid),
          createCompanionCallback:
              ({
                required String id,
                required String name,
                Value<int> rowid = const Value.absent(),
              }) => GroupsCompanion.insert(id: id, name: name, rowid: rowid),
          withReferenceMapper: (p0) => p0
              .map(
                (e) =>
                    (e.readTable(table), $$GroupsTableReferences(db, table, e)),
              )
              .toList(),
          prefetchHooksCallback: ({articleGroupRelationsRefs = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [
                if (articleGroupRelationsRefs) db.articleGroupRelations,
              ],
              addJoins: null,
              getPrefetchedDataCallback: (items) async {
                return [
                  if (articleGroupRelationsRefs)
                    await $_getPrefetchedData<
                      Group,
                      $GroupsTable,
                      ArticleGroupRelation
                    >(
                      currentTable: table,
                      referencedTable: $$GroupsTableReferences
                          ._articleGroupRelationsRefsTable(db),
                      managerFromTypedResult: (p0) => $$GroupsTableReferences(
                        db,
                        table,
                        p0,
                      ).articleGroupRelationsRefs,
                      referencedItemsForCurrentItem: (item, referencedItems) =>
                          referencedItems.where((e) => e.groupId == item.id),
                      typedResults: items,
                    ),
                ];
              },
            );
          },
        ),
      );
}

typedef $$GroupsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $GroupsTable,
      Group,
      $$GroupsTableFilterComposer,
      $$GroupsTableOrderingComposer,
      $$GroupsTableAnnotationComposer,
      $$GroupsTableCreateCompanionBuilder,
      $$GroupsTableUpdateCompanionBuilder,
      (Group, $$GroupsTableReferences),
      Group,
      PrefetchHooks Function({bool articleGroupRelationsRefs})
    >;
typedef $$ArticleGroupRelationsTableCreateCompanionBuilder =
    ArticleGroupRelationsCompanion Function({
      required String articleId,
      required String groupId,
      Value<int> rowid,
    });
typedef $$ArticleGroupRelationsTableUpdateCompanionBuilder =
    ArticleGroupRelationsCompanion Function({
      Value<String> articleId,
      Value<String> groupId,
      Value<int> rowid,
    });

final class $$ArticleGroupRelationsTableReferences
    extends
        BaseReferences<
          _$AppDatabase,
          $ArticleGroupRelationsTable,
          ArticleGroupRelation
        > {
  $$ArticleGroupRelationsTableReferences(
    super.$_db,
    super.$_table,
    super.$_typedResult,
  );

  static $ArticlesTable _articleIdTable(_$AppDatabase db) =>
      db.articles.createAlias(
        $_aliasNameGenerator(
          db.articleGroupRelations.articleId,
          db.articles.id,
        ),
      );

  $$ArticlesTableProcessedTableManager get articleId {
    final $_column = $_itemColumn<String>('article_id')!;

    final manager = $$ArticlesTableTableManager(
      $_db,
      $_db.articles,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_articleIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }

  static $GroupsTable _groupIdTable(_$AppDatabase db) => db.groups.createAlias(
    $_aliasNameGenerator(db.articleGroupRelations.groupId, db.groups.id),
  );

  $$GroupsTableProcessedTableManager get groupId {
    final $_column = $_itemColumn<String>('group_id')!;

    final manager = $$GroupsTableTableManager(
      $_db,
      $_db.groups,
    ).filter((f) => f.id.sqlEquals($_column));
    final item = $_typedResult.readTableOrNull(_groupIdTable($_db));
    if (item == null) return manager;
    return ProcessedTableManager(
      manager.$state.copyWith(prefetchedData: [item]),
    );
  }
}

class $$ArticleGroupRelationsTableFilterComposer
    extends Composer<_$AppDatabase, $ArticleGroupRelationsTable> {
  $$ArticleGroupRelationsTableFilterComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$ArticlesTableFilterComposer get articleId {
    final $$ArticlesTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.articleId,
      referencedTable: $db.articles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ArticlesTableFilterComposer(
            $db: $db,
            $table: $db.articles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GroupsTableFilterComposer get groupId {
    final $$GroupsTableFilterComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.groups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupsTableFilterComposer(
            $db: $db,
            $table: $db.groups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ArticleGroupRelationsTableOrderingComposer
    extends Composer<_$AppDatabase, $ArticleGroupRelationsTable> {
  $$ArticleGroupRelationsTableOrderingComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$ArticlesTableOrderingComposer get articleId {
    final $$ArticlesTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.articleId,
      referencedTable: $db.articles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ArticlesTableOrderingComposer(
            $db: $db,
            $table: $db.articles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GroupsTableOrderingComposer get groupId {
    final $$GroupsTableOrderingComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.groups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupsTableOrderingComposer(
            $db: $db,
            $table: $db.groups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ArticleGroupRelationsTableAnnotationComposer
    extends Composer<_$AppDatabase, $ArticleGroupRelationsTable> {
  $$ArticleGroupRelationsTableAnnotationComposer({
    required super.$db,
    required super.$table,
    super.joinBuilder,
    super.$addJoinBuilderToRootComposer,
    super.$removeJoinBuilderFromRootComposer,
  });
  $$ArticlesTableAnnotationComposer get articleId {
    final $$ArticlesTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.articleId,
      referencedTable: $db.articles,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$ArticlesTableAnnotationComposer(
            $db: $db,
            $table: $db.articles,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }

  $$GroupsTableAnnotationComposer get groupId {
    final $$GroupsTableAnnotationComposer composer = $composerBuilder(
      composer: this,
      getCurrentColumn: (t) => t.groupId,
      referencedTable: $db.groups,
      getReferencedColumn: (t) => t.id,
      builder:
          (
            joinBuilder, {
            $addJoinBuilderToRootComposer,
            $removeJoinBuilderFromRootComposer,
          }) => $$GroupsTableAnnotationComposer(
            $db: $db,
            $table: $db.groups,
            $addJoinBuilderToRootComposer: $addJoinBuilderToRootComposer,
            joinBuilder: joinBuilder,
            $removeJoinBuilderFromRootComposer:
                $removeJoinBuilderFromRootComposer,
          ),
    );
    return composer;
  }
}

class $$ArticleGroupRelationsTableTableManager
    extends
        RootTableManager<
          _$AppDatabase,
          $ArticleGroupRelationsTable,
          ArticleGroupRelation,
          $$ArticleGroupRelationsTableFilterComposer,
          $$ArticleGroupRelationsTableOrderingComposer,
          $$ArticleGroupRelationsTableAnnotationComposer,
          $$ArticleGroupRelationsTableCreateCompanionBuilder,
          $$ArticleGroupRelationsTableUpdateCompanionBuilder,
          (ArticleGroupRelation, $$ArticleGroupRelationsTableReferences),
          ArticleGroupRelation,
          PrefetchHooks Function({bool articleId, bool groupId})
        > {
  $$ArticleGroupRelationsTableTableManager(
    _$AppDatabase db,
    $ArticleGroupRelationsTable table,
  ) : super(
        TableManagerState(
          db: db,
          table: table,
          createFilteringComposer: () =>
              $$ArticleGroupRelationsTableFilterComposer(
                $db: db,
                $table: table,
              ),
          createOrderingComposer: () =>
              $$ArticleGroupRelationsTableOrderingComposer(
                $db: db,
                $table: table,
              ),
          createComputedFieldComposer: () =>
              $$ArticleGroupRelationsTableAnnotationComposer(
                $db: db,
                $table: table,
              ),
          updateCompanionCallback:
              ({
                Value<String> articleId = const Value.absent(),
                Value<String> groupId = const Value.absent(),
                Value<int> rowid = const Value.absent(),
              }) => ArticleGroupRelationsCompanion(
                articleId: articleId,
                groupId: groupId,
                rowid: rowid,
              ),
          createCompanionCallback:
              ({
                required String articleId,
                required String groupId,
                Value<int> rowid = const Value.absent(),
              }) => ArticleGroupRelationsCompanion.insert(
                articleId: articleId,
                groupId: groupId,
                rowid: rowid,
              ),
          withReferenceMapper: (p0) => p0
              .map(
                (e) => (
                  e.readTable(table),
                  $$ArticleGroupRelationsTableReferences(db, table, e),
                ),
              )
              .toList(),
          prefetchHooksCallback: ({articleId = false, groupId = false}) {
            return PrefetchHooks(
              db: db,
              explicitlyWatchedTables: [],
              addJoins:
                  <
                    T extends TableManagerState<
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic,
                      dynamic
                    >
                  >(state) {
                    if (articleId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.articleId,
                                referencedTable:
                                    $$ArticleGroupRelationsTableReferences
                                        ._articleIdTable(db),
                                referencedColumn:
                                    $$ArticleGroupRelationsTableReferences
                                        ._articleIdTable(db)
                                        .id,
                              )
                              as T;
                    }
                    if (groupId) {
                      state =
                          state.withJoin(
                                currentTable: table,
                                currentColumn: table.groupId,
                                referencedTable:
                                    $$ArticleGroupRelationsTableReferences
                                        ._groupIdTable(db),
                                referencedColumn:
                                    $$ArticleGroupRelationsTableReferences
                                        ._groupIdTable(db)
                                        .id,
                              )
                              as T;
                    }

                    return state;
                  },
              getPrefetchedDataCallback: (items) async {
                return [];
              },
            );
          },
        ),
      );
}

typedef $$ArticleGroupRelationsTableProcessedTableManager =
    ProcessedTableManager<
      _$AppDatabase,
      $ArticleGroupRelationsTable,
      ArticleGroupRelation,
      $$ArticleGroupRelationsTableFilterComposer,
      $$ArticleGroupRelationsTableOrderingComposer,
      $$ArticleGroupRelationsTableAnnotationComposer,
      $$ArticleGroupRelationsTableCreateCompanionBuilder,
      $$ArticleGroupRelationsTableUpdateCompanionBuilder,
      (ArticleGroupRelation, $$ArticleGroupRelationsTableReferences),
      ArticleGroupRelation,
      PrefetchHooks Function({bool articleId, bool groupId})
    >;

class $AppDatabaseManager {
  final _$AppDatabase _db;
  $AppDatabaseManager(this._db);
  $$ArticlesTableTableManager get articles =>
      $$ArticlesTableTableManager(_db, _db.articles);
  $$GroupsTableTableManager get groups =>
      $$GroupsTableTableManager(_db, _db.groups);
  $$ArticleGroupRelationsTableTableManager get articleGroupRelations =>
      $$ArticleGroupRelationsTableTableManager(_db, _db.articleGroupRelations);
}
