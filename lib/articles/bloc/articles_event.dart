part of 'articles_bloc.dart';

@immutable
abstract class ArticlesEvent {}

class ArticlesLoadInfoChanged extends ArticlesEvent {
  ArticlesLoadInfoChanged(this.info);

  final LoadInfo info;
}

class SelectedSectionIndexChanged extends ArticlesEvent {
  SelectedSectionIndexChanged(this.sectionIndex);

  final int sectionIndex;
}

class LoadArticlesByIndex extends ArticlesEvent {
  LoadArticlesByIndex(this.sectionIndex);

  final int sectionIndex;
}

class LoadArticlesBySectionName extends ArticlesEvent {
  LoadArticlesBySectionName(this.sectionName);

  final String sectionName;
}
