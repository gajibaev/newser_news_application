import 'package:flutter/material.dart';

class Routes {
  static Route fadeRoute(Widget widget,
      {required AxisDirection direction, Curve? curve, Duration? duration}) {
    return PageRouteBuilder(
      transitionDuration: duration ?? const Duration(milliseconds: 750),
      reverseTransitionDuration: duration ?? const Duration(milliseconds: 750),
      pageBuilder: (context, animation, secondaryAnimation) => widget,
      transitionsBuilder: (context, animation, secondaryAnimation, child) {
        var begin = Offset.zero;
        switch (direction) {
          case AxisDirection.down:
            begin = const Offset(0, -1);
            break;
          case AxisDirection.up:
            begin = const Offset(0, 1);
            break;
          case AxisDirection.left:
            begin = const Offset(1, 0);
            break;
          case AxisDirection.right:
            begin = const Offset(-1, 0);
            break;
          default:
        }
        const end = Offset.zero;

        final tween = Tween(begin: begin, end: end);
        final curvedAnimation = CurvedAnimation(
          parent: animation,
          curve: curve ?? Curves.linear,
        );
        return SlideTransition(
          position: tween.animate(curvedAnimation),
          child: GestureDetector(
            onHorizontalDragEnd: (dragEndDetails) {},
            child: widget,
          ),
        );
      },
    );
  }
}
