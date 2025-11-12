import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:app/providers/group_provider.dart';
import 'package:domain/models/group.dart' as domain;

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

        error: (error, stack) => const Center(child: Text('エラーが発生しました')),

        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
