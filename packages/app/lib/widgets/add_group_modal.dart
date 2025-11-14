import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:app/providers/group_provider.dart';
import 'package:app/styles/app_styles.dart';

class AddGroupModal extends HookConsumerWidget {
  const AddGroupModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final textController = useTextEditingController();

    final isLoading = useState(false);

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
          const SizedBox(height: AppStyles.sizedBoxHeight),
          TextField(
            controller: textController,
            decoration: const InputDecoration(
              labelText: 'グループ名',
              border: OutlineInputBorder(),
            ),
            autofocus: true, // モーダル表示時に自動でフォーカスを当てる
          ),
          const SizedBox(height: AppStyles.sizedBoxHeight),
          ElevatedButton(
            // isLoadingがtrueの間はボタンを押せなくする
            onPressed: isLoading.value
                ? null
                : () async {
                    // 1. 空白を取り除き、検証する
                    final groupName = textController.text.trim();
                    if (groupName.isEmpty) {
                      // 空の場合は何もしない
                      return;
                    }

                    // 処理開始
                    isLoading.value = true;

                    try {
                      // 2. データベース操作を試みる
                      final notifier = ref.read(groupNotifierProvider.notifier);
                      await notifier.addGroup(groupName);

                      // 成功した場合のみモーダルを閉じる
                      if (context.mounted) {
                        Navigator.of(context).pop();
                      }
                    } catch (e) {
                      // 3. エラーを捕まえ、利用者に知らせる
                      if (context.mounted) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text('エラー: グループの追加に失敗しました')),
                        );
                      }
                    } finally {
                      // 成功しようが失敗しようが、必ず処理中状態を解除する
                      if (context.mounted) {
                        isLoading.value = false;
                      }
                    }
                  },

            // 処理中はインジケータを表示し、そうでなければ文字を表示する
            child: isLoading.value
                ? const SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2.5),
                  )
                : const Text('追加'),
          ),
        ],
      ),
    );
  }
}
