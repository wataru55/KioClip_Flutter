import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:app/providers/article_provider.dart';
import 'package:domain/models/article.dart' as domain;
import 'package:app/styles/app_styles.dart';

class ArticleListScreen extends ConsumerWidget {
  const ArticleListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articleListAsyncValue = ref.watch(articleListProvider);

    return articleListAsyncValue.when(
      data: (articles) {
        if (articles.isEmpty) {
          return const Center(child: Text('記事がありません'));
        }

        return ListView.builder(
          padding: const EdgeInsets.all(AppStyles.edgeAllPadding),
          itemCount: articles.length,
          itemBuilder: (context, index) {
            final article = articles[index];
            return _ArticleCard(article: article);
          },
        );
      },
      error: (error, stack) {
        return Center(child: Text('エラーが発生しました: $error'));
      },
      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}

// ==========================================================
// この画面専用の、プライベートなカードウィジェット
// ==========================================================

class _ArticleCard extends StatelessWidget {
  const _ArticleCard({required this.article});

  final domain.Article article;

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: AppStyles.edgeAllPadding),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(AppStyles.cornerRadius),
        side: const BorderSide(
          color: Colors.black,
          width: AppStyles.borderWidth,
        ),
      ),
      child: ListTile(
        // TODO: OGP画像を表示する
        leading: const Icon(Icons.link),
        title: Text(
          // OGPがあればそのタイトル、なければURLを表示
          article.ogp?.title ?? article.urlString,
          style: const TextStyle(fontWeight: FontWeight.bold),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
        ),
        // TODO: タップでURLを開く、スワイプで削除などのアクションを実装
        onTap: () {},
      ),
    );
  }
}
