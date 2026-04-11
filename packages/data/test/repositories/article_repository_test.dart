import 'package:data/data.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:domain/models/article.dart' as domain;

// テスト用のインメモリデータベースを作成するヘルパー関数
AppDatabase createTestDatabase() {
  return AppDatabase.forTest(LazyDatabase(() async => NativeDatabase.memory()));
}

class TestHelper {
  /// テスト用のアーティクルを作成(Idと作成日時を指定できる)
  static domain.Article createArticle({
    String id = 'article1',
    String url = 'https://example.com/1',
    DateTime? createdAt,
  }) {
    return domain.Article(
      id: id,
      urlString: url,
      createdAt: createdAt ?? DateTime(2025, 1, 1),
    );
  }

  /// 複数のArticleをデータベースに挿入
  static Future<void> insertArticles(
    AppDatabase db,
    List<domain.Article> articles,
  ) async {
    for (final article in articles) {
      await db.into(db.articles).insert(article.toDataModel());
    }
  }

  /// Articleとグループの関連付けを作成
  static Future<void> addArticleToGroup(
    AppDatabase db,
    String articleId,
    String groupId,
  ) async {
    await ArticleRepository.addArticleToGroups(db, articleId, groupId);
  }
}

void main() {
  late AppDatabase db;

  setUp(() {
    db = createTestDatabase();
  });

  tearDown(() async {
    await db.close();
  });

  group('ArticleRepositrory', () {
    group('getAllArticles', () {
      test('記事がない場合は空のリストが返される', () async {
        final articles = await ArticleRepository.getAllArticles(db);
        expect(articles, []);
      });

      test('全ての記事が取得でき，かつ日付の降順でソートされている', () async {
        final article1 = TestHelper.createArticle(
          createdAt: DateTime(2025, 1, 2),
        );

        final article2 = TestHelper.createArticle(
          id: 'article2',
          url: 'https://example.com/2',
          createdAt: DateTime(2025, 1, 1),
        );
        final article3 = TestHelper.createArticle(
          id: 'article3',
          url: 'https://example.com/3',
          createdAt: DateTime(2025, 1, 3),
        );

        await TestHelper.insertArticles(db, [article1, article2, article3]);

        final articles = await ArticleRepository.getAllArticles(db);

        expect(articles.length, 3);
        expect(articles[0].id, article3.id);
        expect(articles[1].id, article1.id);
        expect(articles[2].id, article2.id);
      });
    });

    group('getArticlesByGroupId', () {
      test('グループIDでフィルタリングした記事一覧を取得でき,かつ日付の降順でソートされている', () async {
        final article1 = TestHelper.createArticle(
          createdAt: DateTime(2025, 1, 2),
        );

        final article2 = TestHelper.createArticle(
          id: 'article2',
          url: 'https://example.com/2',
          createdAt: DateTime(2025, 1, 1),
        );
        final article3 = TestHelper.createArticle(
          id: 'article3',
          url: 'https://example.com/3',
          createdAt: DateTime(2025, 1, 3),
        );

        await TestHelper.insertArticles(db, [article1, article2, article3]);

        await TestHelper.addArticleToGroup(db, article1.id, 'groupA');
        await TestHelper.addArticleToGroup(db, article2.id, 'groupA');
        await TestHelper.addArticleToGroup(db, article3.id, 'groupB');

        final fetchArticles = await ArticleRepository.getArticlesByGroupId(
          db,
          'groupA',
        );

        expect(fetchArticles.length, 2);
        expect(fetchArticles[0].id, article1.id);
        expect(fetchArticles[1].id, article2.id);
      });
    });

    group('addArticleToGroups', () {
      test('同じ関連付けを複数回追加しても無視される', () async {
        final article = TestHelper.createArticle();

        await TestHelper.insertArticles(db, [article]);

        await ArticleRepository.addArticleToGroups(db, article.id, 'groupA');
        await ArticleRepository.addArticleToGroups(db, article.id, 'groupA');

        final fetchArticles = await ArticleRepository.getArticlesByGroupId(
          db,
          'groupA',
        );

        expect(fetchArticles.length, 1);
        expect(fetchArticles[0].id, article.id);
      });

      test('groupが存在しない場合は無視される', () async {
        final article = TestHelper.createArticle();

        await TestHelper.insertArticles(db, [article]);

        await TestHelper.addArticleToGroup(db, article.id, 'groupA');

        final fetchArticles = await ArticleRepository.getArticlesByGroupId(
          db,
          'groupB',
        );

        expect(fetchArticles.length, 0);
      });
    });

    group('getGroupIdsByArticleId', () {
      test('記事IDに紐づくグループIDのリストを取得できる(複数のグループに属する場合でも)', () async {
        final article = TestHelper.createArticle();

        await TestHelper.insertArticles(db, [article]);

        await TestHelper.addArticleToGroup(db, article.id, 'groupA');
        await TestHelper.addArticleToGroup(db, article.id, 'groupB');

        final groupIds = await ArticleRepository.getGroupIdsByArticleId(
          db,
          article.id,
        );

        expect(groupIds.length, 2);
        expect(groupIds, containsAll(['groupA', 'groupB']));
      });
    });

    group('getAllGroupArticleCounts', () {
      test('関連付けが0件のとき空のMapが返される', () async {
        final counts = await ArticleRepository.getAllGroupArticleCounts(db);
        expect(counts, isEmpty);
      });

      test('複数グループに分散した記事の件数が groupId ごとに集計される', () async {
        final article1 = TestHelper.createArticle();
        final article2 = TestHelper.createArticle(
          id: 'article2',
          url: 'https://example.com/2',
        );
        final article3 = TestHelper.createArticle(
          id: 'article3',
          url: 'https://example.com/3',
        );
        await TestHelper.insertArticles(db, [article1, article2, article3]);

        // groupA: 2件, groupB: 1件
        await TestHelper.addArticleToGroup(db, article1.id, 'groupA');
        await TestHelper.addArticleToGroup(db, article2.id, 'groupA');
        await TestHelper.addArticleToGroup(db, article3.id, 'groupB');

        final counts = await ArticleRepository.getAllGroupArticleCounts(db);

        expect(counts.length, 2);
        expect(counts['groupA'], 2);
        expect(counts['groupB'], 1);
      });

      test('同じ記事が複数グループに属していても各グループで個別にカウントされる', () async {
        final article = TestHelper.createArticle();
        await TestHelper.insertArticles(db, [article]);

        await TestHelper.addArticleToGroup(db, article.id, 'groupA');
        await TestHelper.addArticleToGroup(db, article.id, 'groupB');

        final counts = await ArticleRepository.getAllGroupArticleCounts(db);

        expect(counts['groupA'], 1);
        expect(counts['groupB'], 1);
      });

      test('関連付けを持たないグループは戻り値の Map にキーとして含まれない', () async {
        final article = TestHelper.createArticle();
        await TestHelper.insertArticles(db, [article]);

        await TestHelper.addArticleToGroup(db, article.id, 'groupA');

        final counts = await ArticleRepository.getAllGroupArticleCounts(db);

        expect(counts.containsKey('groupA'), isTrue);
        expect(counts.containsKey('groupB'), isFalse);
      });
    });
  });
}
