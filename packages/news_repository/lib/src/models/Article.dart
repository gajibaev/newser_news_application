import 'package:json_annotation/json_annotation.dart';
import 'package:news_repository/src/models/models.dart';

part 'Article.g.dart';

@JsonSerializable()
class Article {
  Article(
    this.slug_name,
    this.section,
    this.subsection,
    this.title,
    this.abstract,
    this.uri,
    this.url,
    this.byline,
    this.thumbnail_standard,
    this.item_type,
    this.source,
    this.updated_date,
    this.created_date,
    this.published_date,
    this.firstPublished_date,
    this.material_type_facet,
    this.kicker,
    this.subhead_line,
    this.multimedia,
  );

  Map<String, dynamic> toJson() => _$ArticleToJson(this);

  factory Article.fromJson(Map<String, dynamic> json) =>
      _$ArticleFromJson(json);

  @JsonValue("slug_name")
  final String? slug_name;

  @JsonValue("section")
  final String? section;

  @JsonValue("subsection")
  final String? subsection;

  @JsonValue("title")
  final String? title;

  @JsonValue("abstract")
  final String? abstract;

  @JsonValue("uri")
  final String? uri;

  @JsonValue("url")
  final String? url;

  @JsonValue("byline")
  final String? byline;

  @JsonValue("thumbnail_standard")
  final String? thumbnail_standard;

  @JsonValue("item_type")
  final String? item_type;

  @JsonValue("source")
  final String? source;

  @JsonValue("updated_date")
  final String? updated_date;

  @JsonValue("created_date")
  final String? created_date;

  @JsonValue("published_date")
  final String? published_date;

  @JsonValue("firstPublished_date")
  final String? firstPublished_date;

  @JsonValue("material_type_facet")
  final String? material_type_facet;

  @JsonValue("kicker")
  final String? kicker;

  @JsonValue("subhead_line")
  final String? subhead_line;

  @JsonValue("multimedia")
  final List<Multimedia>? multimedia;
}
