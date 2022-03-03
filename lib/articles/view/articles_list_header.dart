import 'package:flutter/material.dart';

class ArticlesListHeader extends SliverPersistentHeaderDelegate {
  ArticlesListHeader({required this.child});

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
  double get maxExtent => 85;

  @override
  double get minExtent => 80;

  @override
  bool shouldRebuild(covariant SliverPersistentHeaderDelegate oldDelegate) =>
      true;
}
