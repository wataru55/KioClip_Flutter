import 'package:app/providers/article_provider.dart';
import 'package:app/providers/database_provider.dart';
import 'package:data/data.dart';
import 'package:domain/models/group.dart' as domain;
import 'package:domain/models/ogp.dart';
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

// OGP情報を正常に返すモック
class MockOgpRepository implements OgpRepository {
  @override
  Future<Ogp?> fetchOgp(String url) async {
    return Ogp(title: 'Test Title', imageUrl: 'https://example.com/image.jpg');
  }
}

// OGP情報をnullで返すモック
class MockOgpRepositoryReturnsNull implements OgpRepository {
  @override
  Future<Ogp?> fetchOgp(String url) async {
    return null;
  }
}

void main() {
  late AppDatabase db;
  late ProviderContainer container;

  // グループをDBに直接挿入するヘルパー関数
  Future<String> insertTestGroup(AppDatabase db, String name) async {
    final group = domain.Group.create(name: name);
    await db.into(db.groups).insert(group.toDataModel());
    return group.id;
  }

  setUp(() {
    db = AppDatabase.forTest(NativeDatabase.memory());
    container = ProviderContainer(
      overrides: [
        databaseProvider.overrideWithValue(db),
        ogpRepositoryProvider.overrideWithValue(MockOgpRepository()),
      ],
    );
  });

  tearDown(() async {
    container.dispose();
    await db.close();
  });

  group('ArticleNotifier', () {
    group('addArticle', () {
      test('正常なURLを追加すると記事が保存され、リストが更新される', () async {
        const urlString = 'https://example.com/article1';

        await container.read(articleNotifierProvider.notifier).addArticle(urlString);

        final state = container.read(articleNotifierProvider);
        expect(state, const AsyncValue<void>.data(null));

        final articles = await container.read(articleListProvider.future);
        expect(articles.length, 1);
        expect(articles.first.urlString, urlString);
        expect(articles.first.ogp?.title, 'Test Title');
      });

      test('無効なURLを追加すると記事が保存されない', () async {
        const invalidUrl = 'not-a-url';

        await container
            .read(articleNotifierProvider.notifier)
            .addArticle(invalidUrl);

        // Riverpod 2.x の AsyncNotifier はエラー後に build() を再実行するため
        // state は AsyncData(null) にリセットされるが、記事は保存されない
        final articles = await container.read(articleListProvider.future);
        expect(articles.isEmpty, true);
      });

      test('httpスキームでないURLを追加すると記事が保存されない', () async {
        const ftpUrl = 'ftp://example.com/article';

        await container
            .read(articleNotifierProvider.notifier)
            .addArticle(ftpUrl);

        final articles = await container.read(articleListProvider.future);
        expect(articles.isEmpty, true);
      });

      test('OGP取得がnullを返しても記事がogpなしで保存される', () async {
        final containerWithNullOgp = ProviderContainer(
          overrides: [
            databaseProvider.overrideWithValue(db),
            ogpRepositoryProvider.overrideWithValue(
              MockOgpRepositoryReturnsNull(),
            ),
          ],
        );
        addTearDown(containerWithNullOgp.dispose);

        const urlString = 'https://example.com/no-ogp';

        await containerWithNullOgp
            .read(articleNotifierProvider.notifier)
            .addArticle(urlString);

        final state = containerWithNullOgp.read(articleNotifierProvider);
        expect(state, const AsyncValue<void>.data(null));

        final articles = await containerWithNullOgp.read(
          articleListProvider.future,
        );
        expect(articles.length, 1);
        expect(articles.first.urlString, urlString);
        expect(articles.first.ogp, isNull);
      });
    });

    group('addArticleToGroups', () {
      test('記事をグループに追加するとgroupArticleListProviderに反映される', () async {
        const urlString = 'https://example.com/article1';
        await container
            .read(articleNotifierProvider.notifier)
            .addArticle(urlString);
        final articles = await container.read(articleListProvider.future);
        final articleId = articles.first.id;

        // グループをDBに直接挿入
        final groupId = await insertTestGroup(db, 'テストグループ');

        await container
            .read(articleNotifierProvider.notifier)
            .addArticleToGroups(articleId, [groupId]);

        final state = container.read(articleNotifierProvider);
        expect(state, const AsyncValue<void>.data(null));

        final groupArticles = await container.read(
          groupArticleListProvider(groupId).future,
        );
        expect(groupArticles.length, 1);
        expect(groupArticles.first.id, articleId);
      });

      test('複数グループに同時追加すると全グループに反映される', () async {
        const urlString = 'https://example.com/article1';
        await container
            .read(articleNotifierProvider.notifier)
            .addArticle(urlString);
        final articles = await container.read(articleListProvider.future);
        final articleId = articles.first.id;

        final groupId1 = await insertTestGroup(db, 'グループ1');
        final groupId2 = await insertTestGroup(db, 'グループ2');

        await container
            .read(articleNotifierProvider.notifier)
            .addArticleToGroups(articleId, [groupId1, groupId2]);

        final group1Articles = await container.read(
          groupArticleListProvider(groupId1).future,
        );
        final group2Articles = await container.read(
          groupArticleListProvider(groupId2).future,
        );
        expect(group1Articles.length, 1);
        expect(group2Articles.length, 1);
      });

      test('同じ記事を同じグループに重複追加してもエラーにならない', () async {
        const urlString = 'https://example.com/article1';
        await container
            .read(articleNotifierProvider.notifier)
            .addArticle(urlString);
        final articles = await container.read(articleListProvider.future);
        final articleId = articles.first.id;

        final groupId = await insertTestGroup(db, 'テストグループ');

        // 2回追加（insertOrIgnoreのため2件目は無視される）
        await container
            .read(articleNotifierProvider.notifier)
            .addArticleToGroups(articleId, [groupId]);
        await container
            .read(articleNotifierProvider.notifier)
            .addArticleToGroups(articleId, [groupId]);

        final groupArticles = await container.read(
          groupArticleListProvider(groupId).future,
        );
        expect(groupArticles.length, 1);
      });
    });

    group('removeArticleFromGroup', () {
      test('指定したグループとの関連付けのみ削除され、記事本体は残る', () async {
        const urlString = 'https://example.com/article1';
        await container
            .read(articleNotifierProvider.notifier)
            .addArticle(urlString);
        final articles = await container.read(articleListProvider.future);
        final articleId = articles.first.id;

        final groupId = await insertTestGroup(db, 'テストグループ');
        await container
            .read(articleNotifierProvider.notifier)
            .addArticleToGroups(articleId, [groupId]);

        await container
            .read(articleNotifierProvider.notifier)
            .removeArticleFromGroup(articleId, groupId);

        final state = container.read(articleNotifierProvider);
        expect(state, const AsyncValue<void>.data(null));

        // グループからは消える
        final groupArticles = await container.read(
          groupArticleListProvider(groupId).future,
        );
        expect(groupArticles.isEmpty, true);

        // 全体一覧には残る
        final allArticles = await container.read(articleListProvider.future);
        expect(allArticles.length, 1);
        expect(allArticles.first.id, articleId);
      });

      test('指定したグループ以外との関連付けは保持される', () async {
        const urlString = 'https://example.com/article1';
        await container
            .read(articleNotifierProvider.notifier)
            .addArticle(urlString);
        final articles = await container.read(articleListProvider.future);
        final articleId = articles.first.id;

        final groupId1 = await insertTestGroup(db, 'グループ1');
        final groupId2 = await insertTestGroup(db, 'グループ2');
        await container
            .read(articleNotifierProvider.notifier)
            .addArticleToGroups(articleId, [groupId1, groupId2]);

        // groupId1 との関連付けだけ削除
        await container
            .read(articleNotifierProvider.notifier)
            .removeArticleFromGroup(articleId, groupId1);

        final group1Articles = await container.read(
          groupArticleListProvider(groupId1).future,
        );
        final group2Articles = await container.read(
          groupArticleListProvider(groupId2).future,
        );
        expect(group1Articles.isEmpty, true);
        expect(group2Articles.length, 1);
        expect(group2Articles.first.id, articleId);
      });

      test('関連付けが存在しない状態で呼び出してもエラーにならない', () async {
        const urlString = 'https://example.com/article1';
        await container
            .read(articleNotifierProvider.notifier)
            .addArticle(urlString);
        final articles = await container.read(articleListProvider.future);
        final articleId = articles.first.id;

        final groupId = await insertTestGroup(db, 'テストグループ');

        // 関連付けを作らずに削除を実行
        await container
            .read(articleNotifierProvider.notifier)
            .removeArticleFromGroup(articleId, groupId);

        final state = container.read(articleNotifierProvider);
        expect(state, const AsyncValue<void>.data(null));
      });
    });

    group('deleteArticle', () {
      test('記事を削除するとarticleListProviderから消える', () async {
        const urlString = 'https://example.com/article1';
        await container
            .read(articleNotifierProvider.notifier)
            .addArticle(urlString);

        final articles = await container.read(articleListProvider.future);
        expect(articles.length, 1);
        final articleId = articles.first.id;

        await container
            .read(articleNotifierProvider.notifier)
            .deleteArticle(articleId);

        final state = container.read(articleNotifierProvider);
        expect(state, const AsyncValue<void>.data(null));

        final articlesAfterDelete = await container.read(
          articleListProvider.future,
        );
        expect(articlesAfterDelete.isEmpty, true);
      });

      test('複数記事のうち指定した1件だけ削除される', () async {
        final notifier = container.read(articleNotifierProvider.notifier);
        await notifier.addArticle('https://example.com/article1');
        await notifier.addArticle('https://example.com/article2');

        final articles = await container.read(articleListProvider.future);
        expect(articles.length, 2);
        final articleId = articles.first.id;

        await notifier.deleteArticle(articleId);

        final articlesAfterDelete = await container.read(
          articleListProvider.future,
        );
        expect(articlesAfterDelete.length, 1);
        expect(articlesAfterDelete.first.id, isNot(articleId));
      });
    });
  });

  group('articleListProvider', () {
    test('記事が存在しない場合は空リストを返す', () async {
      final articles = await container.read(articleListProvider.future);
      expect(articles.isEmpty, true);
    });

    test('複数の記事を追加すると全て取得できる', () async {
      final notifier = container.read(articleNotifierProvider.notifier);
      await notifier.addArticle('https://example.com/article1');
      await notifier.addArticle('https://example.com/article2');
      await notifier.addArticle('https://example.com/article3');

      final articles = await container.read(articleListProvider.future);
      expect(articles.length, 3);
    });
  });

  group('groupArticleListProvider', () {
    test('グループに属していない記事はフィルタリングされる', () async {
      final notifier = container.read(articleNotifierProvider.notifier);
      await notifier.addArticle('https://example.com/article1');
      await notifier.addArticle('https://example.com/article2');

      final articles = await container.read(articleListProvider.future);
      final articleId1 = articles[0].id;

      final groupId1 = await insertTestGroup(db, 'グループ1');
      final groupId2 = await insertTestGroup(db, 'グループ2');

      // article1のみグループ1に追加
      await container
          .read(articleNotifierProvider.notifier)
          .addArticleToGroups(articleId1, [groupId1]);

      final group1Articles = await container.read(
        groupArticleListProvider(groupId1).future,
      );
      final group2Articles = await container.read(
        groupArticleListProvider(groupId2).future,
      );
      expect(group1Articles.length, 1);
      expect(group1Articles.first.id, articleId1);
      expect(group2Articles.isEmpty, true);
    });
  });
}
