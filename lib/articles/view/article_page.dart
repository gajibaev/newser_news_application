import 'package:flutter/material.dart';
import 'package:news_application/articles/articles.dart';

import 'article_view.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage({Key? key, this.data}) : super(key: key);

  final ArticleData? data;

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
          body: Padding(
            padding: const EdgeInsets.all(0),
            child: ArticleView(
              data: data ?? ArticleData(),
            ),
          ),
        ),
      ),
    );
  }
}
