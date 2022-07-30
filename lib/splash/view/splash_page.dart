import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/sections/sections.dart';
import 'package:news_application/utils/utils.dart';
import 'package:news_application/widgets/widgets.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({Key? key}) : super(key: key);

  static String get routeName => '/';

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {
  bool isLoaded = false;
  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    Future.delayed(
      const Duration(milliseconds: 500),
      () {
        BlocProvider.of<SectionsBloc>(context).add(
          LoadSections(),
        );
      },
    );
    return SafeArea(
      child: Scaffold(
        backgroundColor: theme.backgroundColor,
        body: BlocListener<SectionsBloc, SectionsState>(
          listener: (context, state) {
            switch (state.loadInfo.status) {
              case LoadStatus.loaded:
                if (!isLoaded) {
                  isLoaded = true;
                  Navigator.pushReplacementNamed(context, 'sections',
                      arguments: AxisDirection.left);
                }
                break;
              case LoadStatus.error:
                MessageWidget.showDialogMessage(
                  context,
                  title: 'Oopss..',
                  message: state.loadInfo.message,
                  actionTitle: 'Yes',
                  onTap: () {
                    Navigator.pop(context, true);
                    BlocProvider.of<SectionsBloc>(context).add(LoadSections());
                  },
                );
                break;
              default:
            }
          },
          child: Stack(
            children: [
              Container(
                constraints: const BoxConstraints.expand(),
                child: const Center(
                  child: Text(
                    'N',
                    style: TextStyle(fontFamily: 'Chomsky', fontSize: 172),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
