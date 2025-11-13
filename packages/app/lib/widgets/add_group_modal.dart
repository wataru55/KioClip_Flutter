import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:app/providers/group_provider.dart';

class AddGroupModal extends HookConsumerWidget {
  const AddGroupModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController();

    return Padding(
      // Paddingで、モーダルの周囲に余白を持たせる
      padding: EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min, // 高さを最小限にする
        children: [
          const Text(
            '新しいグループ',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          const SizedBox(height: 16),
          TextField(
            controller: textController,
            decoration: const InputDecoration(
              labelText: 'グループ名',
              border: OutlineInputBorder(),
            ),
            autofocus: true, // モーダル表示時に自動でフォーカスを当てる
          ),
          const SizedBox(height: 16),
          ElevatedButton(
            onPressed: () async {
              final groupName = textController.text;
              if (groupName.isNotEmpty) {
                // groupNotifierProviderを読み取り、addGroupメソッドを呼び出す
                final notifier = ref.read(groupNotifierProvider.notifier);
                // 非同期処理なので、awaitで待つ
                await notifier.addGroup(groupName);
                // 追加が完了したら、モーダルを閉じる
                if (context.mounted) {
                  Navigator.of(context).pop();
                }
              }
            },
            child: const Text('追加'),
          ),
        ],
      ),
    );
  }
}
