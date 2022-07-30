import 'package:flutter/material.dart';

import 'article_view.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage({Key? key}) : super(key: key);

  static String get routeName => '/article';

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SafeArea(
      child: WillPopScope(
        onWillPop: () async {
          Navigator.pop(context);
          return false;
        },
        child: Scaffold(
          backgroundColor: theme.backgroundColor,
          body: const Padding(
            padding: EdgeInsets.all(0),
            child: ArticleView(),
          ),
        ),
      ),
    );
  }
}
