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
      routes: [const GroupListRoute(), ArticleListRoute()],
      appBarBuilder: (_, tabsRouter) => AppBar(title: const Text('KioClip')),
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
