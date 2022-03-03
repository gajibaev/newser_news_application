import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/utils/utils.dart';

import '../sections.dart';

class SectionsListView extends StatefulWidget {
  const SectionsListView({
    Key? key,
    required this.sectionsTextStyle,
    required this.onChangeSelectedItem,
    required this.selectedSectionIndex,
    required this.scrollController,
  }) : super(key: key);

  final Function(int) onChangeSelectedItem;
  final Stream<int> selectedSectionIndex;
  final TextStyle sectionsTextStyle;
  final FixedExtentScrollController scrollController;

  @override
  State<SectionsListView> createState() => _SectionsListViewState();
}

class _SectionsListViewState extends State<SectionsListView> {
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlocBuilder<SectionsBloc, SectionsState>(
      buildWhen: (previous, current) =>
          previous.loadInfo.status != current.loadInfo.status,
      builder: (context, state) {
        return Stack(
          children: [
            Center(
              child: StreamBuilder<int>(
                initialData: 0,
                stream: widget.selectedSectionIndex,
                builder: (context, snapshot) {
                  String currentSection;
                  if (state.sections!.isNotEmpty) {
                    currentSection = state
                        .sections![snapshot.data! % state.sections!.length]
                        .name;
                  } else {
                    currentSection = '0';
                  }
                  double width =
                      textSize(currentSection, widget.sectionsTextStyle).width +
                          85 +
                          40;
                  return AnimatedContainer(
                    duration: const Duration(milliseconds: 100),
                    height: 30,
                    width: width,
                    color: Colors.transparent,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          RotatedBox(
                            quarterTurns: 90,
                            child: Icon(
                              Icons.arrow_back_ios,
                              color: theme.cardColor,
                            ),
                          ),
                          Icon(
                            Icons.arrow_back_ios,
                            color: theme.cardColor,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
            StreamBuilder<int>(
              stream: widget.selectedSectionIndex,
              builder: (context, snapshot) {
                return DisableOverScrollIndicator(
                  child: CupertinoPicker.builder(
                    scrollController: widget.scrollController,
                    useMagnifier: true,
                    itemExtent: 45,
                    diameterRatio: 1.3,
                    onSelectedItemChanged: (index) {
                      widget.onChangeSelectedItem(index);
                    },
                    childCount: state.sections!.length,
                    itemBuilder: (context, index) {
                      return SectionsListViewItem(
                        state.sections![index].displayName,
                        sectionsTextStyle: snapshot.data == index
                            ? widget.sectionsTextStyle
                                .copyWith(fontWeight: FontWeight.bold)
                            : widget.sectionsTextStyle,
                        onTap: () {},
                      );
                    },
                  ),
                );
              },
            ),
          ],
        );
      },
    );
  }
}
