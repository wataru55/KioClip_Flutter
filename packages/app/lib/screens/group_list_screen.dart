import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:auto_route/auto_route.dart';
import 'package:app/router/app_router.dart';
import 'package:app/providers/article_provider.dart';
import 'package:app/providers/group_provider.dart';

import 'package:app/styles/app_styles.dart';
import 'package:app/widgets/group_card.dart';

@RoutePage()
class GroupListScreen extends ConsumerWidget {
  const GroupListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupListAsyncValue = ref.watch(groupListProvider);
    final isEditMode = ref.watch(groupEditModeProvider);

    return groupListAsyncValue.when(
      data: (groups) {
        if (groups.isEmpty) {
          return const Center(child: Text('グループがありません'));
        }

        return GridView.builder(
          itemCount: groups.length,
          itemBuilder: (context, index) {
            final group = groups[index];
            return GroupCard(
              group: group,
              showDeleteButton: isEditMode,
              onDeleteTap: isEditMode
                  ? () async {
                      final confirmed = await showDialog<bool>(
                        context: context,
                        builder: (context) => AlertDialog(
                          title: const Text('グループを削除'),
                          content: const Text('このグループを削除します。\n記事本体は削除されません。'),
                          actions: [
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(false),
                              child: const Text('キャンセル'),
                            ),
                            TextButton(
                              onPressed: () => Navigator.of(context).pop(true),
                              style: TextButton.styleFrom(
                                foregroundColor: Colors.red,
                              ),
                              child: const Text('削除'),
                            ),
                          ],
                        ),
                      );
                      if (confirmed != true) return;

                      await ref
                          .read(groupNotifierProvider.notifier)
                          .deleteGroup(group.id);

                      if (!context.mounted) return;

                      final deleteState = ref.read(groupNotifierProvider);
                      if (deleteState.hasError) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              'グループの削除に失敗しました: ${deleteState.error}',
                            ),
                          ),
                        );
                        return;
                      }

                      ref.invalidate(groupArticleListProvider(group.id));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('グループを削除しました')),
                      );
                    }
                  : null,
              onTap: isEditMode
                  ? null
                  : () {
                      context.router.push(
                        GroupArticleDetailsRoute(group: group),
                      );
                    },
            );
          },
          padding: const EdgeInsets.all(AppStyles.edgeAllPadding),
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            mainAxisSpacing: 5,
            crossAxisSpacing: 5,
            childAspectRatio: 1.5,
          ),
        );
      },

      error: (error, stack) {
        return Center(
          // エラーオブジェクト(error)の内容をそのまま表示する
          child: Text('エラーが発生しました: $error'),
        );
      },

      loading: () => const Center(child: CircularProgressIndicator()),
    );
  }
}
