import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoImageAwailable extends StatelessWidget {
  const NoImageAwailable({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return Container(
      child: Center(
        child: Text(
          'No Image Available',
          textAlign: TextAlign.center,
          style: GoogleFonts.roboto(
            fontWeight: FontWeight.w400,
            color: theme.cardColor.withOpacity(0.6),
          ),
        ),
      ),
      decoration: BoxDecoration(
        shape: BoxShape.rectangle,
        borderRadius: BorderRadius.circular(10),
        border: Border.all(
          color: theme.cardColor.withOpacity(0.4),
          width: 1,
        ),
      ),
    );
  }
}
