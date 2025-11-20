import 'package:flutter/material.dart';
import 'package:domain/models/group.dart' as domain;
import 'package:app/styles/app_styles.dart';

class GroupCard extends StatelessWidget {
  const GroupCard({
    super.key,
    required this.group,
    this.isSelected = false,
    this.isSelectionMode = false,
    required this.onTap,
  });

  final domain.Group group;
  final bool isSelected;
  final bool isSelectionMode;
  final VoidCallback? onTap;

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
                side: BorderSide(
                  color: isSelected ? Colors.green : Colors.black,
                  width: isSelected ? 3.0 : AppStyles.borderWidth,
                ),
              ),
              clipBehavior: Clip.antiAlias,
              child: InkWell(
                onTap: onTap, // ★★★ 修正：親から渡されたonTapを使用 ★★★
                child: Padding(
                  padding: const EdgeInsets.all(AppStyles.edgeAllPadding),
                  child: Stack(
                    // ★★★ Stackを追加してチェックマークを配置 ★★★
                    children: [
                      Center(
                        // 中央揃えのためにCenterでラップ
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
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(height: 4),
                            Text(
                              '記事数： 0',
                              style: TextStyle(
                                fontSize: 14,
                                color: Colors.grey[600],
                              ),
                            ),
                          ],
                        ),
                      ),
                      // ★★★ 選択モードかつ選択中の場合にチェックマークを表示 ★★★
                      if (isSelectionMode && isSelected)
                        const Positioned(
                          top: 0,
                          right: 0,
                          child: Icon(
                            Icons.check_circle,
                            color: Colors.green,
                            size: 24,
                          ),
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
