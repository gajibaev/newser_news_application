// ignore_for_file: non_constant_identifier_names, file_names
import 'package:json_annotation/json_annotation.dart';
import 'package:news_repository/news_repository.dart';

part 'ArticleResponse.g.dart';

@JsonSerializable()
class ArticleResponse {
  ArticleResponse(this.status, this.copyright, this.num_results, this.results);

  factory ArticleResponse.fromJson(Map<String, dynamic> json) =>
      _$ArticleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleResponseToJson(this);

  @JsonValue("status")
  final String? status;

  @JsonValue("copyright")
  final String? copyright;

  @JsonValue("num_results")
  final int? num_results;

  @JsonValue("results")
  final List<Article>? results;
}
