import 'package:flutter/material.dart';

import 'articles_view.dart';

class ArticlesPage extends StatelessWidget {
  const ArticlesPage({Key? key}) : super(key: key);

  static String get routeName => '/articles';

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
            child: ArticlesView(),
          ),
        ),
      ),
    );
  }
}
