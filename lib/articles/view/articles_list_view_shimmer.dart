import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';

class ArticlesListViewShimmer extends StatelessWidget {
  const ArticlesListViewShimmer({Key? key}) : super(key: key);

  final double height = 90;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
      child: Row(
        children: [
          Flexible(
            flex: 2,
            child: Shimmer(
              color: Colors.grey,
              child: Container(
                height: height,
                width: height,
                decoration: BoxDecoration(
                  color: Colors.black12,
                  borderRadius: BorderRadius.circular(10),
                ),
              ),
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
                    flex: 5,
                    child: Shimmer(
                      color: Colors.grey,
                      child: Container(
                        height: 65,
                        decoration: BoxDecoration(
                          color: Colors.black12,
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: Shimmer(
                      color: Colors.grey,
                      child: Padding(
                        padding: const EdgeInsets.only(top: 5),
                        child: Container(
                          height: 20,
                          decoration: BoxDecoration(
                            color: Colors.black12,
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
