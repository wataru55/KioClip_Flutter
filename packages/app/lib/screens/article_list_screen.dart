import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:app/providers/article_provider.dart';
import 'package:domain/models/article.dart' as domain;
import 'package:domain/models/group.dart' as domain;
import 'package:app/styles/app_styles.dart';
import 'package:app/utils/article_utils.dart';
import 'package:app/widgets/group_selection_sheet.dart';

class ArticleListScreen extends ConsumerWidget {
  const ArticleListScreen({super.key, this.group});

  final domain.Group? group;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final articleListAsyncValue = group != null
        ? ref.watch(groupArticleListProvider(group!.id))
        : ref.watch(articleListProvider);

    // ★★★ グループ詳細画面として使われる場合はScaffoldでラップ ★★★
    final content = articleListAsyncValue.when(
      data: (articles) {
        if (articles.isEmpty) {
          return const Center(child: Text('記事がありません'));
        }

        return ListView.builder(
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

    // groupIdが指定されている場合はScaffoldでラップ（グループ詳細画面）
    if (group != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(group!.name), // TODO: グループ名を表示する
          // 戻るボタンは自動で表示される
        ),
        body: content,
      );
    }

    // groupIdがnullの場合はそのまま返す（HomeScreenのbodyとして使われる）
    return content;
  }
}

// ==========================================================
// この画面専用の、プライベートなカードウィジェット
// ==========================================================

class _ArticleCard extends ConsumerWidget {
  const _ArticleCard({required this.article});

  final domain.Article article;

  /// サムネイル画像を構築する
  Widget _buildThumbnail() {
    if (article.ogp?.imageUrl != null) {
      return Image.network(
        article.ogp!.imageUrl!,
        width: AppStyles.articleThumbnailWidth,
        height: AppStyles.articleThumbnailHeight,
        fit: BoxFit.fill,
        errorBuilder: (context, error, stackTrace) {
          return _buildPlaceholder();
        },
      );
    }
    return _buildPlaceholder();
  }

  /// プレースホルダー画像を構築する
  Widget _buildPlaceholder() {
    return Container(
      width: AppStyles.articleThumbnailWidth,
      height: AppStyles.articleThumbnailHeight,
      color: AppStyles.articleThumbnailPlaceholderColor,
      child: const Icon(Icons.public, size: AppStyles.articleThumbnailIconSize),
    );
  }

  /// タイトルを構築する
  Widget _buildTitle() {
    return Text(
      article.ogp?.title ?? article.urlString,
      style: const TextStyle(
        fontSize: AppStyles.articleTitleFontSize,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
      overflow: TextOverflow.ellipsis,
      maxLines: 2,
    );
  }

  /// メタデータ（ホスト名と日付）を構築する
  Widget _buildMetadata() {
    return Row(
      children: [
        Expanded(
          child: Text(
            ArticleUtils.getHostName(article.urlString),
            style: const TextStyle(
              fontSize: AppStyles.articleHostFontSize,
              color: AppStyles.articleTextSecondaryColor,
            ),
            overflow: TextOverflow.ellipsis,
            maxLines: 1,
          ),
        ),
        const SizedBox(width: AppStyles.cardSpacing),
        Text(
          ArticleUtils.formatDate(article.createdAt),
          style: const TextStyle(
            fontSize: AppStyles.articleDateFontSize,
            color: AppStyles.articleTextSecondaryColor,
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      // ★★★ marginをSlidableの外側に移動 ★★★
      padding: const EdgeInsets.only(bottom: AppStyles.cardMarginBottom),
      child: Slidable(
        startActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (context) async {
                final notifier = ref.watch(articleNotifierProvider.notifier);
                await notifier.deleteArticle(article.id);
              },
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
              icon: Icons.delete,
            ),
          ],
        ),
        endActionPane: ActionPane(
          motion: const DrawerMotion(),
          children: [
            SlidableAction(
              onPressed: (context) {
                showModalBottomSheet(
                  context: context,
                  isScrollControlled: true,
                  useSafeArea: true,
                  builder: (context) => GroupSelectionSheet(
                    onGroupsSelected: (groupIds) async {
                      final notifier = ref.read(
                        articleNotifierProvider.notifier,
                      );
                      await notifier.addArticleToGroups(article.id, groupIds);
                    },
                  ),
                );
              },
              backgroundColor: Colors.blue,
              foregroundColor: Colors.white,
              icon: Icons.folder,
            ),

            SlidableAction(
              onPressed: (context) {
                // TODO: 通知設定の処理を実装
              },
              backgroundColor: Colors.orange,
              foregroundColor: Colors.white,
              icon: Icons.notifications,
            ),
          ],
        ),
        child: Card(
          // ★★★ Cardのmarginを削除 ★★★
          margin: EdgeInsets.zero,
          shape: const RoundedRectangleBorder(borderRadius: BorderRadius.zero),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              _buildThumbnail(),
              Expanded(
                child: Padding(
                  padding: const EdgeInsets.all(AppStyles.edgeAllPadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      _buildTitle(),
                      const SizedBox(height: AppStyles.cardSpacing),
                      _buildMetadata(),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
