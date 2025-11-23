import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:auto_route/auto_route.dart';
import 'package:app/router/app_router.dart';
import 'package:app/providers/group_provider.dart';

import 'package:app/styles/app_styles.dart';
import 'package:app/widgets/group_card.dart';

@RoutePage()
class GroupListScreen extends ConsumerWidget {
  const GroupListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupListAsyncValue = ref.watch(groupListProvider);

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
              onTap: () {
                context.router.push(GroupArticleDetailsRoute(group: group));
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
