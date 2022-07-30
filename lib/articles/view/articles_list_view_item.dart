import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:news_application/articles/articles.dart';
import 'package:news_application/widgets/no_image_available.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ArticlesListViewItem extends StatelessWidget {
  const ArticlesListViewItem(
      {Key? key, required this.data, required this.onPressed})
      : super(key: key);

  final ArticleData data;
  final Function() onPressed;

  final double height = 90;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: height,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Row(
          children: [
            Flexible(
              flex: 2,
              child: data.multimedia != null
                  ? SizedBox(
                      height: height,
                      width: height,
                      child: ExtendedImage.network(
                        data.multimedia![0].url!,
                        filterQuality: FilterQuality.high,
                        isAntiAlias: true,
                        loadStateChanged: (state) {
                          switch (state.extendedImageLoadState) {
                            case LoadState.loading:
                              return Shimmer(
                                color: Colors.white,
                                child: Container(
                                  height: height,
                                  width: 120,
                                  decoration: BoxDecoration(
                                    color: Colors.black12,
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                ),
                              );
                            case LoadState.completed:
                              break;
                            case LoadState.failed:
                              return SizedBox(
                                height: height,
                                width: height,
                                child: const NoImageAwailable(),
                              );
                          }
                          return null;
                        },
                        shape: BoxShape.rectangle,
                        borderRadius: BorderRadius.circular(10),
                        fit: BoxFit.cover,
                      ),
                    )
                  : SizedBox(
                      height: height,
                      width: height,
                      child: const NoImageAwailable(),
                    ),
            ),
            Flexible(
              flex: 4,
              child: Container(
                padding: EdgeInsets.only(
                    left: height * 0.15,
                    top: height * 0.06,
                    bottom: height * 0.06),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Flexible(
                      flex: 6,
                      child: SizedBox(
                        height: height * 0.85,
                        child: Text(
                          data.title ?? 'no title',
                          maxLines: 2,
                          style: const TextStyle(
                            fontFamily: 'RozhaOne',
                            fontSize: 16,
                            height: 1.2,
                          ),
                          overflow: TextOverflow.ellipsis,
                          textAlign: TextAlign.left,
                        ),
                      ),
                    ),
                    Flexible(
                      flex: 2,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: 200,
                            child: Text(
                              data.publishedDate ?? '',
                              overflow: TextOverflow.ellipsis,
                              style: GoogleFonts.roboto(
                                color: theme.textTheme.bodyLarge!.color,
                                fontWeight: FontWeight.w600,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
