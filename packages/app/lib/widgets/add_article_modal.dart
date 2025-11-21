import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

import 'package:app/providers/article_provider.dart';
import 'package:app/styles/app_styles.dart';

class AddArticleModal extends HookConsumerWidget {
  const AddArticleModal({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // TextEditingControllerをフックで管理
    final textController = useTextEditingController();
    final errorMessage = useState<String?>(null);
    final isButtonEnabled = useState(false);

    ref.listen<AsyncValue<void>>(articleNotifierProvider, (previous, next) {
      if (next is AsyncData) {
        if (context.mounted) Navigator.of(context).pop();
      }
      // Notifier起因のエラーもローカル状態に反映する
      if (next is AsyncError) {
        errorMessage.value = next.error.toString().replaceFirst(
          'Exception: ',
          '',
        );
      }
    });

    useEffect(() {
      void listener() {
        final text = textController.text.trim();
        // ユーザーが何か入力した場合にのみ、リアルタイムでバリデーションを実行する
        if (text.isEmpty) {
          errorMessage.value = null;
          isButtonEnabled.value = false;
        } else {
          errorMessage.value = null;
          final articleAsyncValue = ref.read(articleNotifierProvider);
          isButtonEnabled.value = !articleAsyncValue.isLoading;
        }
      }

      textController.addListener(listener);
      listener();

      return () => textController.removeListener(listener);
    }, []);

    // Notifierがローディング中かどうかを監視する
    final articleAsyncValue = ref.watch(articleNotifierProvider);
    final isLoading = articleAsyncValue.isLoading;

    // ボタンを有効にするための条件を定義
    final submitAvailable = isButtonEnabled.value && !isLoading;

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
            decoration: InputDecoration(
              labelText: 'URL',
              border: OutlineInputBorder(),
              errorText: errorMessage.value,
            ),
            keyboardType: TextInputType.url,
            autofocus: true,
          ),

          const SizedBox(height: AppStyles.sizedBoxHeight),

          ElevatedButton(
            onPressed: submitAvailable
                ? () {
                    ref
                        .read(articleNotifierProvider.notifier)
                        .addArticle(textController.text);
                  }
                : null,
            child: isLoading
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
