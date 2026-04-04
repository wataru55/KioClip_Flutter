import 'package:flutter/material.dart';
import 'package:auto_route/auto_route.dart';
import 'package:domain/models/group.dart';
import 'package:app/screens/article_list_screen.dart';

@RoutePage()
class GroupArticleDetailsScreen extends StatelessWidget {
  final Group group;

  const GroupArticleDetailsScreen({required this.group, super.key});

  @override
  Widget build(BuildContext context) {
    return ArticleListScreen(group: group);
  }
}
