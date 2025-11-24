import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:app/screens/home_screen.dart';
import 'package:app/screens/group_list_screen.dart';
import 'package:app/screens/article_list_screen.dart';
import 'package:app/screens/group_article_details_screen.dart';
import 'package:domain/models/group.dart';

part 'app_router.gr.dart';

@AutoRouterConfig()
class AppRouter extends RootStackRouter {
  @override
  List<AutoRoute> get routes => [
    AutoRoute(
      page: HomeRoute.page,
      initial: true,
      children: [
        // ★★★ GroupTab（ラッパー）を作成し、その中でネストする ★★★
        AutoRoute(
          path: 'groups',
          page: GroupTabRoute.page, // GroupTabRouteを作成
          children: [
            AutoRoute(page: GroupListRoute.page, path: '', initial: true),
            AutoRoute(page: GroupArticleDetailsRoute.page, path: 'details'),
          ],
        ),
        AutoRoute(page: ArticleListRoute.page, path: 'articles'),
      ],
    ),
  ];
}

// ★★★ GroupTab用の空のページを作成（スタックを保持するため） ★★★
@RoutePage(name: 'GroupTabRoute')
class GroupTabPage extends AutoRouter {
  const GroupTabPage({super.key});
}
