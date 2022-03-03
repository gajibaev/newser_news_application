import 'package:flutter/material.dart';

class SectionsListViewItem extends StatelessWidget {
  const SectionsListViewItem(this.sectionName,
      {Key? key, required this.onTap, required this.sectionsTextStyle})
      : super(key: key);

  final TextStyle sectionsTextStyle;
  final String sectionName;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      decoration: const BoxDecoration(),
      child: SizedBox(
        width: 245,
        child: Text(
          sectionName,
          style: sectionsTextStyle,
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
