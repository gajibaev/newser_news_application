part of 'articles_bloc.dart';

class ArticlesState {
  const ArticlesState({
    this.articles = const [],
    this.loadInfo = const LoadInfo(LoadStatus.notLoaded, message: ' '),
    this.selectedArticleTitle,
  });

  final LoadInfo loadInfo;

  final List<ArticleData> articles;

  final String? selectedArticleTitle;

  ArticlesState copyWith({
    LoadInfo? loadInfo,
    List<ArticleData>? articles,
    String? selectedArticleTitle,
  }) {
    return ArticlesState(
      loadInfo: loadInfo ?? this.loadInfo,
      articles: articles ?? this.articles,
      selectedArticleTitle: selectedArticleTitle ?? this.selectedArticleTitle,
    );
  }
}
