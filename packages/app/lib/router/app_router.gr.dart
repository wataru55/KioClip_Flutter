// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// AutoRouterGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

part of 'app_router.dart';

/// generated route for
/// [ArticleListScreen]
class ArticleListRoute extends PageRouteInfo<ArticleListRouteArgs> {
  ArticleListRoute({Key? key, Group? group, List<PageRouteInfo>? children})
    : super(
        ArticleListRoute.name,
        args: ArticleListRouteArgs(key: key, group: group),
        initialChildren: children,
      );

  static const String name = 'ArticleListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<ArticleListRouteArgs>(
        orElse: () => const ArticleListRouteArgs(),
      );
      return ArticleListScreen(key: args.key, group: args.group);
    },
  );
}

class ArticleListRouteArgs {
  const ArticleListRouteArgs({this.key, this.group});

  final Key? key;

  final Group? group;

  @override
  String toString() {
    return 'ArticleListRouteArgs{key: $key, group: $group}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! ArticleListRouteArgs) return false;
    return key == other.key && group == other.group;
  }

  @override
  int get hashCode => key.hashCode ^ group.hashCode;
}

/// generated route for
/// [GroupArticleDetailsScreen]
class GroupArticleDetailsRoute
    extends PageRouteInfo<GroupArticleDetailsRouteArgs> {
  GroupArticleDetailsRoute({
    required Group group,
    Key? key,
    List<PageRouteInfo>? children,
  }) : super(
         GroupArticleDetailsRoute.name,
         args: GroupArticleDetailsRouteArgs(group: group, key: key),
         initialChildren: children,
       );

  static const String name = 'GroupArticleDetailsRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      final args = data.argsAs<GroupArticleDetailsRouteArgs>();
      return GroupArticleDetailsScreen(group: args.group, key: args.key);
    },
  );
}

class GroupArticleDetailsRouteArgs {
  const GroupArticleDetailsRouteArgs({required this.group, this.key});

  final Group group;

  final Key? key;

  @override
  String toString() {
    return 'GroupArticleDetailsRouteArgs{group: $group, key: $key}';
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    if (other is! GroupArticleDetailsRouteArgs) return false;
    return group == other.group && key == other.key;
  }

  @override
  int get hashCode => group.hashCode ^ key.hashCode;
}

/// generated route for
/// [GroupListScreen]
class GroupListRoute extends PageRouteInfo<void> {
  const GroupListRoute({List<PageRouteInfo>? children})
    : super(GroupListRoute.name, initialChildren: children);

  static const String name = 'GroupListRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const GroupListScreen();
    },
  );
}

/// generated route for
/// [GroupTabPage]
class GroupTabRoute extends PageRouteInfo<void> {
  const GroupTabRoute({List<PageRouteInfo>? children})
    : super(GroupTabRoute.name, initialChildren: children);

  static const String name = 'GroupTabRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const GroupTabPage();
    },
  );
}

/// generated route for
/// [HomeScreen]
class HomeRoute extends PageRouteInfo<void> {
  const HomeRoute({List<PageRouteInfo>? children})
    : super(HomeRoute.name, initialChildren: children);

  static const String name = 'HomeRoute';

  static PageInfo page = PageInfo(
    name,
    builder: (data) {
      return const HomeScreen();
    },
  );
}
