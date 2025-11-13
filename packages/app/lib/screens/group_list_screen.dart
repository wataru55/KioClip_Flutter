import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:app/providers/group_provider.dart';
import 'package:domain/models/group.dart' as domain;

import 'package:app/widgets/add_group_modal.dart';

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

          return ListView.builder(
            itemCount: groups.length,
            itemBuilder: (context, index) {
              final group = groups[index];
              return ListTile(title: Text(group.name));
            },
          );
        },

        error: (error, stack) {
          // デバッグのために、コンソールにもエラーを出力すると便利じゃぞ
          print(error);
          print(stack);

          return Center(
            // エラーオブジェクト(error)の内容をそのまま表示する
            child: Text('エラーが発生しました: $error'),
          );
        },

        loading: () => const Center(child: CircularProgressIndicator()),
      ),

      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            context: context,
            isScrollControlled: true,
            builder: (context) => const AddGroupModal(),
          );
        },
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.0),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
