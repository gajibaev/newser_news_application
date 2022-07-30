import 'package:flutter/material.dart';
import 'package:news_application/sections/sections.dart';
import 'package:news_application/widgets/will_pop_exit_scope.dart';

class SectionsPage extends StatelessWidget {
  const SectionsPage({Key? key}) : super(key: key);

  static String get routeName => '/sections';

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.backgroundColor,
        body: const DoubleBackToCloseAppWidget(
          child: Padding(
            padding: EdgeInsets.all(0),
            child: SectionsView(),
          ),
        ),
      ),
    );
  }
}
