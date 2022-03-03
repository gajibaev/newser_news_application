import 'package:flutter/material.dart';
import 'package:news_application/utils/utils.dart';

class LoadStatusWidget extends StatelessWidget {
  const LoadStatusWidget(
      {Key? key,
      required this.status,
      this.onNotLoadedWidget,
      this.onLoadWidget,
      this.onLoadedWidget,
      this.onErrorWidget})
      : super(key: key);

  final LoadStatus status;
  final Widget? onNotLoadedWidget;
  final Widget? onLoadWidget;
  final Widget? onLoadedWidget;
  final Widget? onErrorWidget;

  @override
  Widget build(BuildContext context) {
    switch (status) {
      case LoadStatus.notLoaded:
        return onNotLoadedWidget ?? Container();
      case LoadStatus.load:
        return onLoadWidget ?? Container();
      case LoadStatus.loaded:
        return onLoadedWidget ?? Container();
      case LoadStatus.error:
        return onErrorWidget ?? Container();
      default:
    }
    return Container();
  }
}
