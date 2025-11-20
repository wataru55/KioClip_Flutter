import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:app/providers/group_provider.dart';
import 'package:app/styles/app_styles.dart';
import 'package:app/widgets/group_card.dart'; // ★★★ 追加 ★★★

class GroupSelectionSheet extends HookConsumerWidget {
  const GroupSelectionSheet({super.key, required this.onGroupsSelected});

  final void Function(List<String> groupIds) onGroupsSelected;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupListAsyncValue = ref.watch(groupListProvider);
    final selectedGroupIds = useState<Set<String>>({});

    return Scaffold(
      appBar: AppBar(
        title: const Text('グループを選択'),
        automaticallyImplyLeading: false,
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(),
            child: const Text('キャンセル'),
          ),
          TextButton(
            onPressed: selectedGroupIds.value.isNotEmpty
                ? () {
                    onGroupsSelected(selectedGroupIds.value.toList());
                    Navigator.of(context).pop();
                  }
                : null,
            child: const Text('追加'),
          ),
        ],
      ),
      body: groupListAsyncValue.when(
        data: (groups) {
          if (groups.isEmpty) {
            return const Center(child: Text('グループがありません'));
          }
          // ★★★ GridViewを使用 ★★★
          return GridView.builder(
            padding: const EdgeInsets.all(AppStyles.edgeAllPadding),
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              crossAxisSpacing: 16.0,
              mainAxisSpacing: 16.0,
              childAspectRatio: 4 / 3,
            ),
            itemCount: groups.length,
            itemBuilder: (context, index) {
              final group = groups[index];
              final isSelected = selectedGroupIds.value.contains(group.id);

              return GroupCard(
                // ★★★ GroupCardを使用 ★★★
                group: group,
                isSelectionMode: true,
                isSelected: isSelected,
                onTap: () {
                  final newSet = Set<String>.from(selectedGroupIds.value);
                  if (isSelected) {
                    newSet.remove(group.id);
                  } else {
                    newSet.add(group.id);
                  }
                  selectedGroupIds.value = newSet;
                },
              );
            },
          );
        },
        error: (err, stack) => Center(child: Text('エラー: $err')),
        loading: () => const Center(child: CircularProgressIndicator()),
      ),
    );
  }
}
