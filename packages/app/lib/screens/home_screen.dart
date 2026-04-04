import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:auto_route/auto_route.dart';
import 'package:app/router/app_router.dart';
import 'package:app/widgets/add_group_modal.dart';
import 'package:app/widgets/add_article_modal.dart';
import 'package:app/widgets/stacked_fab.dart';
import 'package:app/providers/group_provider.dart';

@RoutePage()
class HomeScreen extends ConsumerWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AutoTabsScaffold(
      routes: [const GroupTabRoute(), ArticleListRoute()],
      appBarBuilder: (context, tabsRouter) {
        return _buildAppBar(context, tabsRouter, ref);
      },
      bottomNavigationBuilder: _buildBottomNavigationBar,
      floatingActionButtonBuilder: _buildFloatingActionButton,
    );
  }

  PreferredSizeWidget _buildAppBar(
    BuildContext context,
    TabsRouter tabsRouter,
    WidgetRef ref,
  ) {
    final topRoute = tabsRouter.topRoute;
    final isGroupListRoute =
        tabsRouter.activeIndex == 0 && topRoute.name == GroupListRoute.name;
    final isEditMode = ref.watch(groupEditModeProvider);

    if (topRoute.name == GroupArticleDetailsRoute.name) {
      final args = topRoute.argsAs<GroupArticleDetailsRouteArgs>();
      return AppBar(
        title: Text(args.group.name),
        leading: const AutoLeadingButton(),
      );
    }

    return AppBar(
      title: const Text('KioClip'),
      actions: isGroupListRoute
          ? [
              TextButton(
                onPressed: () {
                  ref.read(groupEditModeProvider.notifier).state = !isEditMode;
                },
                child: Text(
                  isEditMode ? '完了' : '編集',
                  style: TextStyle(
                    fontWeight: isEditMode
                        ? FontWeight.bold
                        : FontWeight.normal,
                  ),
                ),
              ),
            ]
          : null,
    );
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
      final args = topRoute.argsAs<GroupArticleDetailsRouteArgs>();
      return _buildArticleFab(context, groupId: args.group.id);
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

  Widget _buildArticleFab(BuildContext context, {String? groupId}) {
    return StackedFAB(
      onPressed: () {
        showModalBottomSheet(
          context: context,
          isScrollControlled: true,
          builder: (context) => AddArticleModal(groupId: groupId),
        );
      },
    );
  }
}
