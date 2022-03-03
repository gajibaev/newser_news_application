import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/articles/articles.dart';
import 'package:news_application/sections/sections.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_application/sections/view/sections_read_button.dart';
import 'package:news_application/utils/utils.dart';
import 'package:news_application/widgets/widgets.dart';
import 'package:rxdart/subjects.dart';
import 'package:theme_provider/theme_provider.dart';

class SectionsView extends StatefulWidget {
  const SectionsView({Key? key}) : super(key: key);

  @override
  State<SectionsView> createState() => _SectionsViewState();
}

class _SectionsViewState extends State<SectionsView> {
  BehaviorSubject<int> selectedSectionIndex = BehaviorSubject.seeded(0);

  FixedExtentScrollController scrollController = FixedExtentScrollController();

  void _scrollToIndex(int index) async {
    selectedSectionIndex.add(index);
    await Future.delayed(const Duration(milliseconds: 100));
    scrollController.animateToItem(index,
        curve: Curves.easeOutQuint,
        duration: const Duration(milliseconds: 1000));
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return BlocBuilder<SectionsBloc, SectionsState>(
      builder: (context, state) {
        if (state.loadInfo.status == LoadStatus.error) {
          Future.delayed(
            const Duration(milliseconds: 100),
            () => MessageWidget.showDialogMessage(
              context,
              title: 'Oopss..',
              message:
                  'For some reason the sections didn`t load. Do you want to load sections now?',
              actionTitle: 'Yes',
              onTap: () {
                Navigator.pop(context, true);
                BlocProvider.of<SectionsBloc>(context).add(LoadSections());
              },
              showAction: true,
              routeOnDismiss: const RouteSettings(
                name: 'sections',
                arguments: AxisDirection.left,
              ),
            ),
          );
        }
        return LoadStatusWidget(
          status: state.loadInfo.status,
          onNotLoadedWidget: Container(),
          onLoadWidget: const CircularProgressIndicator(),
          onLoadedWidget: Stack(
            children: [
              Container(
                constraints: const BoxConstraints.expand(),
                alignment: Alignment.center,
                child: SectionsListView(
                  sectionsTextStyle: GoogleFonts.lora(
                    fontWeight: FontWeight.normal,
                    fontSize: 22,
                    color: theme.textTheme.bodyMedium!.color,
                  ),
                  scrollController: scrollController,
                  selectedSectionIndex: selectedSectionIndex.stream,
                  onChangeSelectedItem: (index) {
                    selectedSectionIndex.add(index);
                    BlocProvider.of<ArticlesBloc>(context)
                        .add(SelectedSectionIndexChanged(index));
                  },
                ),
              ),
              Container(
                constraints: const BoxConstraints.expand(),
                child: Column(
                  children: [
                    Flexible(
                      flex: 1,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          const Flexible(
                            flex: 1,
                            child: ThemeChanger(),
                          ),
                          Flexible(
                            flex: 2,
                            child: Container(
                              padding: const EdgeInsets.only(top: 15),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'Newser',
                                      style: TextStyle(
                                        fontFamily: 'Chomsky',
                                        fontSize: 56,
                                        color:
                                            theme.textTheme.bodyMedium!.color,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    alignment: Alignment.center,
                                    child: Text(
                                      'sections',
                                      style: GoogleFonts.lora(
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        fontStyle: FontStyle.italic,
                                        color: theme.textTheme.bodyLarge!.color,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Flexible(
                            flex: 1,
                            child: SizedBox(
                              height: 30,
                              width: 30,
                            ),
                          ),
                        ],
                      ),
                    ),
                    Flexible(
                      flex: 5,
                      child: Container(),
                    ),
                    Flexible(
                      flex: 1,
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        padding: const EdgeInsets.only(bottom: 25),
                        child: SectionsReadButton(
                          onPressed: () {
                            context.read<ArticlesBloc>().add(
                                  LoadArticlesByIndex(
                                      selectedSectionIndex.value),
                                );
                            Navigator.pushNamed(context, 'articles')
                                .then((value) => setState(() {}));
                          },
                        ),
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
          onErrorWidget: Center(
            child: MessageWidget(
              title: 'Oopss..',
              message:
                  'For some reason the sections didn`t load. Do you want to load sections now?',
              actionTitle: 'Yes',
              onTap: () {
                BlocProvider.of<SectionsBloc>(context).add(LoadSections());
              },
            ),
          ),
        );
      },
    );
  }
}
