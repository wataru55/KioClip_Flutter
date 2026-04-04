import 'package:drift/drift.dart';

class Articles extends Table {
  // id (文字列、主キー)
  TextColumn get id => text()();
  // urlString (文字列) ← Articleモデルに合わせて名前を変更
  TextColumn get urlString => text()();
  // createdAt (日時)
  DateTimeColumn get createdAt => dateTime()();

  // --- OGP情報を格納するための列を追加 ---
  // OGPのtitle (文字列、Ogpが存在しない場合もあるのでnull許容)
  TextColumn get ogpTitle => text().nullable()();
  // OGPのimageUrl (文字列、null許容)
  TextColumn get ogpImageUrl => text().nullable()();

  @override
  Set<Column> get primaryKey => {id};
}

// Groupを格納するためのテーブル
class Groups extends Table {
  // id (文字列、主キー)
  TextColumn get id => text()();
  // name (文字列)
  TextColumn get name => text()();

  @override
  Set<Column> get primaryKey => {id};
}

// ArticlesとGroupsの多対多関係を表す中間テーブル
// 各行は1つの記事(article)と1つのグループ(group)の関連付けを表す
class ArticleGroupRelations extends Table {
  TextColumn get articleId => text().references(Articles, #id)();
  TextColumn get groupId => text().references(Groups, #id)();

  @override
  Set<Column> get primaryKey => {articleId, groupId};
}
