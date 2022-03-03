import 'package:flutter/material.dart';

class ArticleHeader extends SliverPersistentHeaderDelegate {
  ArticleHeader({required this.child});

  int index = 0;

  final Widget child;

  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return LayoutBuilder(builder: (context, constraints) {
      return child;
    });
  }

  @override
  double get maxExtent => 350;

  @override
  double get minExtent => 50;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
