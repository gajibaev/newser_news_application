import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_application/articles/articles.dart';
import 'package:news_application/articles/view/articles_list_header.dart';
import 'package:news_application/articles/view/articles_list_view_shimmer.dart';
import 'package:news_application/utils/utils.dart';

import 'articles_list_view_item.dart';

class ArticlesListView extends StatelessWidget {
  const ArticlesListView(
      {Key? key,
      this.articles = const [],
      this.showShimmer = false,
      this.section = ''})
      : super(key: key);

  final String section;
  final List<ArticleData> articles;
  final bool showShimmer;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return DisableOverScrollIndicator(
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
            delegate: ArticlesListHeader(
              child: Container(
                constraints: const BoxConstraints.expand(),
                alignment: Alignment.bottomCenter,
                padding: const EdgeInsets.only(top: 15),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 60,
                            height: 45,
                            child: IconButton(
                              splashColor: Colors.transparent,
                              icon: Icon(
                                CupertinoIcons.back,
                                color: theme.cardColor,
                              ),
                              onPressed: () {
                                Navigator.pop(context);
                              },
                            ),
                          ),
                          Text(
                            section.capitalize(),
                            style: GoogleFonts.roboto(
                              fontWeight: FontWeight.bold,
                              fontSize: 24,
                              color: theme.textTheme.bodyMedium!.color,
                            ),
                          ),
                          const SizedBox(
                            width: 65,
                          ),
                        ],
                      ),
                    ),
                    Divider(
                      color: theme.textTheme.bodyLarge!.color,
                    ),
                  ],
                ),
              ),
            ),
          ),
          SliverList(
            delegate: SliverChildBuilderDelegate(
              (BuildContext context, int index) {
                return Container(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  child: showShimmer
                      ? const ArticlesListViewShimmer()
                      : articles.isNotEmpty
                          ? ArticlesListViewItem(
                              data: articles[index],
                              onPressed: () {
                                if (articles.isNotEmpty) {
                                  Navigator.pushNamed(
                                    context,
                                    'article',
                                    arguments: articles[index],
                                  );
                                }
                              },
                            )
                          : Container(),
                );
              },
              childCount: showShimmer ? 10 : articles.length, // 1000 list items
            ),
          ),
        ],
      ),
    );
  }
}
