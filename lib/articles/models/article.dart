import 'models.dart';

class ArticleData {
  final String? slugName;

  final String? section;

  final String? subsection;

  final String? title;

  final String? abstract_;

  final String? uri;

  final String? url;

  final String? byline;

  final String? thumbnailStandard;

  final String? itemType;

  final String? source;

  final String? updatedDate;

  final String? createdDate;

  final String? publishedDate;

  final String? firstPublishedDate;

  final String? materialTypeFacet;

  final String? kicker;

  final String? subheadline;

  final List<MultimediaData>? multimedia;

  ArticleData({
    this.slugName,
    this.section,
    this.subsection,
    this.title,
    this.abstract_,
    this.uri,
    this.url,
    this.byline,
    this.thumbnailStandard,
    this.itemType,
    this.source,
    this.updatedDate,
    this.createdDate,
    this.publishedDate,
    this.firstPublishedDate,
    this.materialTypeFacet,
    this.kicker,
    this.subheadline,
    this.multimedia,
  });
}
