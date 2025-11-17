import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:drift/drift.dart';
import 'package:data/data.dart' as data;
import 'package:domain/models/article.dart' as domain;
import 'package:app/providers/database_provider.dart';
import 'package:app/utils/url_validator.dart';

final articleListProvider = FutureProvider<List<domain.Article>>((ref) async {
  final db = ref.watch(databaseProvider);

  // データベースから全記事を取得（作成日時の降順でソート）
  final dataArticles = await (db.select(
    db.articles,
  )..orderBy([(article) => OrderingTerm.desc(article.createdAt)])).get();

  // data層のモデルをdomain層のモデルに変換
  final domainArticles = dataArticles
      .map((dataArticle) => dataArticle.toDomainModel())
      .toList();

  return domainArticles;
});

final articleNotifierProvider = AsyncNotifierProvider<ArticleNotifier, void>(
  ArticleNotifier.new,
);

class ArticleNotifier extends AsyncNotifier<void> {
  @override
  Future<void> build() async {
    // 初期化処理は不要
  }

  Future<void> addArticle(String urlString) async {
    // 処理開始(ローディング)
    state = const AsyncValue.loading();

    try {
      // urlStringのバリデーション
      final errorMessage = validateUrl(urlString);
      if (errorMessage != null) {
        throw Exception(errorMessage);
      }

      final db = ref.read(databaseProvider);

      final domainArticle = domain.Article.create(urlString: urlString);

      final dataArticleCompanion = domainArticle.toDataModel();

      await db.into(db.articles).insert(dataArticleCompanion);

      state = const AsyncValue.data(null);

      ref.invalidate(articleListProvider);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
