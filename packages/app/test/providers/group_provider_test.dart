import 'package:app/providers/article_provider.dart';
import 'package:app/providers/database_provider.dart';
import 'package:app/providers/group_provider.dart';
import 'package:data/data.dart';
import 'package:domain/models/article.dart' as domain_article;
import 'package:domain/models/group.dart' as domain_group;
import 'package:drift/native.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

void main() {
  late AppDatabase db;
  late ProviderContainer container;

  Future<domain_group.Group> insertGroup(String name) async {
    final group = domain_group.Group.create(name: name);
    await db.into(db.groups).insert(group.toDataModel());
    return group;
  }

  Future<domain_article.Article> insertArticle(String urlString) async {
    final article = domain_article.Article.create(urlString: urlString);
    await db.into(db.articles).insert(article.toDataModel());
    return article;
  }

  Future<void> addRelation(String articleId, String groupId) async {
    await db
        .into(db.articleGroupRelations)
        .insert(
          ArticleGroupRelationsCompanion.insert(
            articleId: articleId,
            groupId: groupId,
          ),
        );
  }

  setUp(() {
    db = AppDatabase.forTest(NativeDatabase.memory());
    container = ProviderContainer(
      overrides: [databaseProvider.overrideWithValue(db)],
    );
  });

  tearDown(() async {
    container.dispose();
    await db.close();
  });

  group('GroupNotifier', () {
    test('addGroupを実行するとgroupListProviderに反映される', () async {
      await container.read(groupNotifierProvider.notifier).addGroup('テストグループ');

      final groups = await container.read(groupListProvider.future);
      expect(groups.length, 1);
      expect(groups.first.name, 'テストグループ');
    });

    test('deleteGroupを実行すると対象グループだけ削除され記事本体は残る', () async {
      final groupA = await insertGroup('グループA');
      final groupB = await insertGroup('グループB');
      final article = await insertArticle('https://example.com/article1');
      await addRelation(article.id, groupA.id);

      await container
          .read(groupNotifierProvider.notifier)
          .deleteGroup(groupA.id);

      final state = container.read(groupNotifierProvider);
      expect(state, const AsyncValue<void>.data(null));

      final groupsAfterDelete = await container.read(groupListProvider.future);
      final groupIds = groupsAfterDelete.map((g) => g.id).toList();
      expect(groupIds, isNot(contains(groupA.id)));
      expect(groupIds, contains(groupB.id));

      final allArticles = await container.read(articleListProvider.future);
      expect(allArticles.length, 1);
      expect(allArticles.first.id, article.id);

      final relationsAfterDelete = await (db.select(
        db.articleGroupRelations,
      )..where((relation) => relation.groupId.equals(groupA.id))).get();
      expect(relationsAfterDelete, isEmpty);
    });

    test('deleteGroupを実行すると関連付けが削除され記事数マップが更新される', () async {
      final groupA = await insertGroup('グループA');
      final groupB = await insertGroup('グループB');
      final articleA = await insertArticle('https://example.com/articleA');
      final articleB = await insertArticle('https://example.com/articleB');
      await addRelation(articleA.id, groupA.id);
      await addRelation(articleB.id, groupB.id);

      final beforeCountMap = await container.read(
        groupArticleCountMapProvider.future,
      );
      expect(beforeCountMap[groupA.id], 1);
      expect(beforeCountMap[groupB.id], 1);

      await container
          .read(groupNotifierProvider.notifier)
          .deleteGroup(groupA.id);

      final afterCountMap = await container.read(
        groupArticleCountMapProvider.future,
      );
      expect(afterCountMap.containsKey(groupA.id), isFalse);
      expect(afterCountMap[groupB.id], 1);

      final groupAArticles = await container.read(
        groupArticleListProvider(groupA.id).future,
      );
      expect(groupAArticles, isEmpty);
    });
  });
}
