import 'package:flutter/material.dart';

class DisableOverScrollIndicator extends StatelessWidget {
  const DisableOverScrollIndicator({Key? key, required this.child})
      : super(key: key);

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<OverscrollIndicatorNotification>(
      onNotification: (overScroll) {
        overScroll.disallowIndicator();
        return true;
      },
      child: child,
    );
  }
}
