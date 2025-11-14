import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:app/styles/app_styles.dart';

class AddArticleModal extends HookConsumerWidget {
  const AddArticleModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TextEditingControllerをフックで管理
    final textController = useTextEditingController();
    // 処理中の状態をフックで管理
    final isLoading = useState(false);

    return Padding(
      padding: EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
        bottom: MediaQuery.of(context).viewInsets.bottom + 20,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            '新しいURL',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),

          const SizedBox(height: AppStyles.sizedBoxHeight),

          TextField(
            controller: textController,
            decoration: const InputDecoration(
              labelText: 'URL',
              border: OutlineInputBorder(),
            ),
            keyboardType: TextInputType.url,
            autofocus: true,
          ),

          const SizedBox(height: AppStyles.sizedBoxHeight),

          ElevatedButton(
            onPressed: () {
              // 未実装：記事の追加処理を実装する
            },
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
