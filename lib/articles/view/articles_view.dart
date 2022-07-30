import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_application/articles/articles.dart';
import 'package:news_application/utils/utils.dart';
import 'package:news_application/widgets/widgets.dart';

import 'articles_list_view.dart';

class ArticlesView extends StatelessWidget {
  const ArticlesView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Flexible(
          flex: 9,
          child: Container(
            height: double.infinity,
            alignment: Alignment.center,
            child: Container(
              alignment: Alignment.center,
              height: double.infinity,
              child: BlocBuilder<ArticlesBloc, ArticlesState>(
                builder: (context, state) {
                  if (state.loadInfo.status == LoadStatus.error) {
                    Future.delayed(
                      const Duration(milliseconds: 100),
                      () => MessageWidget.showDialogMessage(
                        context,
                        title: 'Oopss..',
                        message:
                            'For some reason the articles didn`t load. Do you want to load articles now?',
                        actionTitle: 'Yes',
                        showAction: true,
                        onTap: () {
                          Navigator.pop(context, true);
                          Navigator.pop(context, true);
                        },
                        routeOnDismiss: const RouteSettings(
                            name: 'sections', arguments: AxisDirection.left),
                      ),
                    );
                  }
                  return LoadStatusWidget(
                    status: state.loadInfo.status,
                    onNotLoadedWidget: Container(),
                    onLoadWidget: const ArticlesListView(
                      section: '',
                      showShimmer: true,
                    ),
                    onLoadedWidget: ArticlesListView(
                      section: state.articles.isNotEmpty
                          ? state.articles[0].section ?? ''
                          : '',
                      articles: state.articles,
                    ),
                    onErrorWidget: const ArticlesListView(
                      showShimmer: true,
                    ),
                  );
                },
              ),
            ),
          ),
        ),
      ],
    );
  }
}
