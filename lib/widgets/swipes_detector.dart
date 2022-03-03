import 'package:flutter/material.dart';

class SwipeDetector extends StatefulWidget {
  const SwipeDetector({
    Key? key,
    this.behavior,
    this.onSwipe,
    this.onSwipeUp,
    this.onSwipeDown,
    this.onSwipeLeft,
    this.onSwipeRight,
    this.liveFeedback = false,
    required this.onPanEnd,
    required this.child,
  }) : super(key: key);

  final HitTestBehavior? behavior;

  final Widget child;

  final void Function(SwipeDirection direction, Offset offset)? onSwipe;

  final void Function(Offset offset)? onSwipeUp;

  final void Function(Offset offset)? onSwipeDown;

  final void Function(Offset offset)? onSwipeLeft;

  final void Function(Offset offset)? onSwipeRight;

  final VoidCallback onPanEnd;

  final bool liveFeedback;

  @override
  _SwipeDetectorState createState() => _SwipeDetectorState();
}

class _SwipeDetectorState extends State<SwipeDetector> {
  late Offset _startPosition;
  late Offset _updatePosition;

  @override
  Widget build(
    BuildContext context,
  ) {
    return GestureDetector(
      behavior: widget.behavior,
      onPanStart: (details) {
        _startPosition = details.globalPosition;
      },
      onPanUpdate: (details) {
        _updatePosition = details.globalPosition;
        if (widget.liveFeedback) {
          _calculateAndExecute();
        }
      },
      onPanEnd: (details) {
        _calculateAndExecute();
        widget.onPanEnd();
      },
      child: widget.child,
    );
  }

  void _calculateAndExecute() {
    final offset = _updatePosition - _startPosition;
    final direction = _getSwipeDirection(offset);

    widget.onSwipe?.call(
      direction,
      offset,
    );

    switch (direction) {
      case SwipeDirection.up:
        widget.onSwipeUp?.call(offset);
        break;
      case SwipeDirection.down:
        widget.onSwipeDown?.call(offset);
        break;
      case SwipeDirection.left:
        widget.onSwipeLeft?.call(offset);
        break;
      case SwipeDirection.right:
        widget.onSwipeRight?.call(offset);
        break;
    }
  }

  SwipeDirection _getSwipeDirection(
    Offset offset,
  ) {
    if (offset.dx.abs() > offset.dy.abs()) {
      if (offset.dx > 0) {
        return SwipeDirection.right;
      } else {
        return SwipeDirection.left;
      }
    } else {
      if (offset.dy > 0) {
        return SwipeDirection.down;
      } else {
        return SwipeDirection.up;
      }
    }
  }
}

enum SwipeDirection {
  up,

  down,

  left,

  right,
}
