import 'package:drift/drift.dart';
import 'package:data/src/database/app_database.dart' as data_db;
import 'package:domain/models/article.dart' as domain;
import 'package:data/src/mappers/article_mapper.dart';

class ArticleRepository {
  /// データベースから全記事を取得（作成日時の降順でソート）
  static Future<List<domain.Article>> getAllArticles(
    data_db.AppDatabase db,
  ) async {
    final dataArticles = await (db.select(
      db.articles,
    )..orderBy([(article) => OrderingTerm.desc(article.createdAt)])).get();

    return dataArticles
        .map((dataArticle) => dataArticle.toDomainModel())
        .toList();
  }

  /// グループIDでフィルタリングした記事一覧を取得
  static Future<List<domain.Article>> getArticlesByGroupId(
    data_db.AppDatabase db,
    String groupId,
  ) async {
    // JOINクエリでグループに属する記事を取得
    final query =
        db.select(db.articles).join([
            innerJoin(
              db.articleGroupRelations,
              db.articleGroupRelations.articleId.equalsExp(db.articles.id),
            ),
          ])
          ..where(db.articleGroupRelations.groupId.equals(groupId))
          ..orderBy([OrderingTerm.desc(db.articles.createdAt)]);

    final rows = await query.get();

    // Articleテーブルのデータを取得してドメインモデルに変換
    return rows
        .map((row) => row.readTable(db.articles).toDomainModel())
        .toList();
  }

  static Future<void> addArticleToGroups(
    data_db.AppDatabase db,
    String articleId,
    String groupId,
  ) async {
    await db
        .into(db.articleGroupRelations)
        .insert(
          data_db.ArticleGroupRelationsCompanion.insert(
            articleId: articleId,
            groupId: groupId,
          ),
          mode: InsertMode.insertOrIgnore,
        );
  }

  /// 全グループの記事数を一括取得する（GROUP BY を使った単一クエリ）
  /// 戻り値: groupId → 記事数 のMap（記事なしのグループはキーなし）
  static Future<Map<String, int>> getAllGroupArticleCounts(
    data_db.AppDatabase db,
  ) async {
    final groupIdCol = db.articleGroupRelations.groupId;
    final countExp = db.articleGroupRelations.articleId.count();
    final query = db.selectOnly(db.articleGroupRelations)
      ..addColumns([groupIdCol, countExp])
      ..groupBy([groupIdCol]);
    final results = await query.get();
    return {
      for (final row in results)
        row.read(groupIdCol)!: row.read(countExp) ?? 0,
    };
  }

  /// 記事IDからその記事が属しているグループIDのリストを取得
  static Future<List<String>> getGroupIdsByArticleId(
    data_db.AppDatabase db,
    String articleId,
  ) async {
    final relations = await (db.select(
      db.articleGroupRelations,
    )..where((relation) => relation.articleId.equals(articleId))).get();

    return relations.map((relation) => relation.groupId).toList();
  }
}
