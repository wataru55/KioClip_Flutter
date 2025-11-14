import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:app/screens/group_list_screen.dart';
import 'package:app/screens/article_list_screen.dart';
import 'package:app/widgets/add_group_modal.dart';
import 'package:app/widgets/add_article_modal.dart';
import 'package:app/widgets/stacked_fab.dart';

class HomeScreen extends HookWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // 表示する画面のリストを定義しておく
    final pages = [const GroupListScreen(), const ArticleListScreen()];

    final selectedIndex = useState(0);

    return Scaffold(
      appBar: AppBar(title: const Text('KioClip')),
      body: pages[selectedIndex.value],

      floatingActionButton: selectedIndex.value == 0
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
            ),

      bottomNavigationBar: BottomNavigationBar(
        items: const [
          BottomNavigationBarItem(icon: Icon(Icons.folder_copy), label: 'グループ'),
          BottomNavigationBarItem(icon: Icon(Icons.article), label: '記事'),
        ],

        currentIndex: selectedIndex.value,
        onTap: (index) => selectedIndex.value = index,
      ),
    );
  }
}
