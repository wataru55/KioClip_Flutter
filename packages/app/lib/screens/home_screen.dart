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
    return AutoTabsScaffold(
      routes: [const GroupTabRoute(), ArticleListRoute()],
      appBarBuilder: _buildAppBar,
      bottomNavigationBuilder: _buildBottomNavigationBar,
      floatingActionButtonBuilder: _buildFloatingActionButton,
    );
  }

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    TabsRouter tabsRouter,
  ) {
    final topRoute = tabsRouter.topRoute;

    if (topRoute.name == GroupArticleDetailsRoute.name) {
      final args = topRoute.argsAs<GroupArticleDetailsRouteArgs>();
      return AppBar(
        title: Text(args.group.name),
        leading: const AutoLeadingButton(),
      );
    }

    return AppBar(title: const Text('KioClip'), leading: null);
  }

  Widget _buildBottomNavigationBar(
    BuildContext context,
    TabsRouter tabsRouter,
  ) {
    return BottomNavigationBar(
      items: const [
        BottomNavigationBarItem(icon: Icon(Icons.folder_copy), label: 'グループ'),
        BottomNavigationBarItem(icon: Icon(Icons.article), label: '記事'),
      ],
      currentIndex: tabsRouter.activeIndex,
      onTap: tabsRouter.setActiveIndex,
    );
  }

  Widget _buildFloatingActionButton(
    BuildContext context,
    TabsRouter tabsRouter,
  ) {
    final topRoute = tabsRouter.topRoute;

    if (topRoute.name == GroupArticleDetailsRoute.name) {
      return _buildArticleFab(context);
    }

    return tabsRouter.activeIndex == 0
        ? _buildGroupFab(context)
        : _buildArticleFab(context);
  }

  Widget _buildGroupFab(BuildContext context) {
    return StackedFAB(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => const AddGroupModal(),
        );
      },
    );
  }

  Widget _buildArticleFab(BuildContext context) {
    return StackedFAB(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => const AddArticleModal(),
        );
      },
    );
  }
}
