import 'package:json_annotation/json_annotation.dart';
import 'package:news_repository/news_repository.dart';

part 'SectionResponse.g.dart';

@JsonSerializable()
class SectionResponse {
  SectionResponse(this.status, this.copyright, this.num_results, this.results);

  factory SectionResponse.fromJson(Map<String, dynamic> json) =>
      _$SectionResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SectionResponseToJson(this);

  @JsonValue("status")
  final String? status;

  @JsonValue("copyright")
  final String? copyright;

  @JsonValue("num_results")
  final int? num_results;

  @JsonValue("results")
  final List<Section>? results;
}
