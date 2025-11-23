import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:auto_route/auto_route.dart';
import 'package:app/router/app_router.dart';
import 'package:app/widgets/add_group_modal.dart';
import 'package:app/widgets/add_article_modal.dart';
import 'package:app/widgets/stacked_fab.dart';

@RoutePage()
class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // ★★★ AutoTabsScaffoldを使ってタブナビゲーションを実装 ★★★
    return AutoTabsScaffold(
      routes: [const GroupTabRoute(), ArticleListRoute()],
      appBarBuilder: (_, tabsRouter) {
        // 現在のトップルートを取得
        final topRoute = tabsRouter.topRoute;

        // 詳細画面の場合
        if (topRoute.name == GroupArticleDetailsRoute.name) {
          // argsからGroupオブジェクトを取得してタイトルに表示
          final args = topRoute.argsAs<GroupArticleDetailsRouteArgs>();
          return AppBar(
            title: Text(args.group.name),
            leading: const AutoLeadingButton(), // 自動で戻るボタンを表示
          );
        }

        // 通常のタブ画面の場合
        return AppBar(
          title: const Text('KioClip'),
          leading: null, // 戻るボタンなし
        );
      },
      bottomNavigationBuilder: (_, tabsRouter) {
        return BottomNavigationBar(
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.folder_copy),
              label: 'グループ',
            ),
            BottomNavigationBarItem(icon: Icon(Icons.article), label: '記事'),
          ],
          currentIndex: tabsRouter.activeIndex,
          onTap: tabsRouter.setActiveIndex,
        );
      },
      floatingActionButtonBuilder: (_, tabsRouter) {
        return tabsRouter.activeIndex == 0
            ? StackedFAB(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => const AddGroupModal(),
                  );
                },
              )
            : StackedFAB(
                onPressed: () {
                  showModalBottomSheet(
                    context: context,
                    isScrollControlled: true,
                    builder: (context) => const AddArticleModal(),
                  );
                },
              );
      },
    );
  }
}
