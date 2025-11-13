import 'package:flutter/material.dart';
import 'package:app/styles/app_styles.dart';

class StackedFAB extends StatelessWidget {
  const StackedFAB({super.key, required this.onPressed});

  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        // 1. 下の円（影の役目）
        Container(
          width: 56, // 標準のFABサイズ
          height: 56,
          decoration: BoxDecoration(
            color: Theme.of(context).cardColor, // グリッドの影と同じ色
            shape: BoxShape.circle,
            border: Border.all(
              color: Colors.black,
              width: AppStyles.borderWidth, // グリッドの定数を使う
            ),
          ),
        ),
        // 2. 上のボタン本体
        Positioned(
          top: -4.0, // ズラす量（縦）
          left: -4.0, // ズラす量（横）
          child: FloatingActionButton(
            onPressed: onPressed,
            elevation: 0, // 標準の影は不要なので0にする
            backgroundColor: const Color(0xFFB2D8B2), // カードの背景色と合わせる
            shape: const CircleBorder(
              side: BorderSide(
                color: Colors.black,
                width: AppStyles.borderWidth, // グリッドの定数を使う
              ),
            ),
            child: const Icon(Icons.add),
          ),
        ),
      ],
    );
  }
}
