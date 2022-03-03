part of 'articles_bloc.dart';

class ArticlesState {
  const ArticlesState({
    this.articles = const [],
    this.loadInfo = const LoadInfo(LoadStatus.notLoaded, message: ' '),
    this.selectedSectionName,
  });

  final LoadInfo loadInfo;

  final List<ArticleData> articles;

  final String? selectedSectionName;

  ArticlesState copyWith({
    LoadInfo? loadInfo,
    List<ArticleData>? articles,
    String? selectedSectionName,
  }) {
    return ArticlesState(
      loadInfo: loadInfo ?? this.loadInfo,
      articles: articles ?? this.articles,
      selectedSectionName: selectedSectionName ?? this.selectedSectionName,
    );
  }
}
