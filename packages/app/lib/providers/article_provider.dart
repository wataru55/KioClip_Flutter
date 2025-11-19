import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:data/data.dart' as data;
import 'package:domain/models/article.dart' as domain;
import 'package:app/providers/database_provider.dart';
import 'package:app/utils/url_validator.dart';

final articleListProvider = FutureProvider<List<domain.Article>>((ref) async {
  final db = ref.watch(databaseProvider);

  return data.ArticleRepository.getAllArticles(db);
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

      // domain層のモデルを作成（OGPなしで一旦作成）
      final domainArticle = domain.Article.create(urlString: urlString);

      // OGPリポジトリからOGP情報を取得
      final ogp = await data.OgpRepository.fetchOgp(urlString);

      // OGP情報を含めてArticleを作成し直す
      final articleWithOgp = domainArticle.copyWith(ogp: ogp);

      final dataArticleCompanion = articleWithOgp.toDataModel();

      await db.into(db.articles).insert(dataArticleCompanion);

      state = const AsyncValue.data(null);

      ref.invalidate(articleListProvider);
    } catch (e, stack) {
      state = AsyncValue.error(e, stack);
    }
  }
}
