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
        AutoRoute(page: GroupListRoute.page, path: 'groups'),
        AutoRoute(page: ArticleListRoute.page, path: 'articles'),
      ],
    ),
    AutoRoute(page: GroupArticleDetailsRoute.page, path: '/group_details'),
  ];
}
