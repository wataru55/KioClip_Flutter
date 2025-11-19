import 'package:drift/drift.dart';
import 'package:data/src/database/app_database.dart' as data_db;
import 'package:domain/models/article.dart' as domain;
import 'package:data/src/mappers/article_mapper.dart';

/// 記事一覧を取得するためのリポジトリクラス
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
}
