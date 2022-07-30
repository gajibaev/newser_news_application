// ignore_for_file: file_names
import 'models.dart';

class SectionArticles {
  SectionArticles(this.section, this.articles, this.loadDate);

  static SectionArticles empty = SectionArticles('', [], DateTime.now());

  final String section;
  final DateTime loadDate;
  final List<Article> articles;
}
