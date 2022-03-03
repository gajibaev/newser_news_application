import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_application/widgets/swipes_detector.dart';
import 'package:rxdart/subjects.dart';

class SectionsReadButton extends StatelessWidget {
  const SectionsReadButton({Key? key, required this.onPressed})
      : super(key: key);

  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return CupertinoButton(
      onPressed: onPressed,
      color: theme.cardColor,
      child: SizedBox(
        width: 160,
        child: Text(
          'Read News  🗞️',
          textAlign: TextAlign.center,
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w500,
            fontSize: 14,
            color: theme.textTheme.bodySmall!.color,
          ),
        ),
      ),
    );
  }
}
