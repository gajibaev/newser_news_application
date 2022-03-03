import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MessageWidget extends StatelessWidget {
  const MessageWidget(
      {Key? key,
      required this.onTap,
      this.message,
      this.title,
      this.actionTitle,
      this.showAction = false})
      : super(key: key);

  final String? title;
  final String? message;
  final String? actionTitle;
  final bool showAction;
  final Function()? onTap;

  static Future<dynamic> showDialogMessage(
    BuildContext context, {
    Function()? onTap,
    RouteSettings? routeOnDismiss,
    String? title,
    String? message,
    String? actionTitle,
    bool? showAction = false,
  }) {
    return showDialog(
      context: context,
      routeSettings: routeOnDismiss,
      builder: (context) {
        return MessageWidget(
          onTap: onTap ?? () {},
          message: message ?? '',
          title: title ?? '',
          actionTitle: actionTitle ?? '',
          showAction: showAction ?? false,
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    double height = showAction ? 180 : 128;
    ThemeData themeData = Theme.of(context);
    return Container(
      constraints: const BoxConstraints.expand(),
      alignment: Alignment.center,
      child: Container(
        height: height,
        width: 250,
        padding: const EdgeInsets.symmetric(horizontal: 5),
        decoration: BoxDecoration(
          color: themeData.backgroundColor,
          borderRadius: BorderRadius.circular(15),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            SizedBox(
              height: 35,
              child: Padding(
                padding: const EdgeInsets.only(top: 12.5),
                child: Text(
                  title ?? '',
                  style: TextStyle(
                    fontSize: 16,
                    color: themeData.textTheme.bodyMedium!.color,
                    fontWeight: FontWeight.bold,
                  ),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
            Container(
              height: 80,
              alignment: Alignment.center,
              padding: const EdgeInsets.symmetric(vertical: 2.5),
              child: Text(
                message ?? '',
                style: TextStyle(
                    fontSize: 16, color: themeData.textTheme.bodyLarge!.color),
                textAlign: TextAlign.center,
              ),
            ),
            showAction
                ? Container(
                    height: 52.5,
                    padding: const EdgeInsets.only(bottom: 10),
                    child: CupertinoButton(
                      color: themeData.cardColor,
                      onPressed: onTap,
                      child: SizedBox(
                        width: 95,
                        child: Text(
                          (actionTitle ?? '').toUpperCase(),
                          style: TextStyle(
                            fontSize: 12,
                            color: themeData.textTheme.bodyMedium!.color,
                            fontWeight: FontWeight.bold,
                            letterSpacing: 1,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ),
                  )
                : Container(),
          ],
        ),
      ),
    );
  }
}
