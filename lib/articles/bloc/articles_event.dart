part of 'articles_bloc.dart';

@immutable
abstract class ArticlesEvent {}

class ArticlesLoadInfoChanged extends ArticlesEvent {
  ArticlesLoadInfoChanged(this.info);

  final LoadInfo info;
}

class LoadArticlesBySectionIndex extends ArticlesEvent {
  LoadArticlesBySectionIndex(this.sectionIndex);

  final int sectionIndex;
}

class LoadArticlesBySectionName extends ArticlesEvent {
  LoadArticlesBySectionName(this.sectionName);

  final String sectionName;
}

class SelectArticle extends ArticlesEvent {
  SelectArticle(this.articleTitle);

  final String articleTitle;
}
