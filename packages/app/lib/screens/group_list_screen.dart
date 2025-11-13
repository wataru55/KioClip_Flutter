import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:app/providers/group_provider.dart';
import 'package:domain/models/group.dart' as domain;

import 'package:app/widgets/add_group_modal.dart';
import 'package:app/styles/app_styles.dart';
import 'package:app/widgets/stacked_fab.dart';

class GroupListScreen extends ConsumerWidget {
  const GroupListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupListAsyncValue = ref.watch(groupListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('グループ一覧')),
      body: groupListAsyncValue.when(
        data: (groups) {
          if (groups.isEmpty) {
            return const Center(child: Text('グループがありません'));
          }

          return GridView.builder(
            itemCount: groups.length,
            itemBuilder: (context, index) {
              final group = groups[index];
              return _GroupCard(group: group);
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
      ),

      floatingActionButton: StackedFAB(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => const AddGroupModal(),
          );
        },
      ),
    );
  }
}

// ==========================================================
// この画面専用の、プライベートなカードウィジェット
// ==========================================================

class _GroupCard extends StatelessWidget {
  const _GroupCard({required this.group});

  final domain.Group group;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 8.0, left: 8.0),
      child: Stack(
        clipBehavior: Clip.none, // 子要素が Stack の境界を超えて表示できるようにする
        children: [
          // 1. 下のカード（影の役目）
          Container(
            decoration: BoxDecoration(
              color: AppStyles.cardBackgroundColor, // 影の色（薄い緑）
              borderRadius: BorderRadius.circular(AppStyles.cornerRadius),
              border: Border.all(
                color: Colors.black,
                width: AppStyles.borderWidth,
              ),
            ),
          ),

          // 2. 上のカード（コンテンツが乗る）
          Positioned(
            top: -8.0,
            left: -8.0,
            right: 0.5,
            bottom: 0.5,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(AppStyles.cornerRadius),
                side: const BorderSide(
                  color: Colors.black,
                  width: AppStyles.borderWidth,
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: () {},
                child: Padding(
                  padding: const EdgeInsets.all(AppStyles.edgeAllPadding),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        group.name,
                        style: const TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                        ),
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '記事数： 0',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
