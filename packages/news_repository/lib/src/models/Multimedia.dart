// ignore_for_file: non_constant_identifier_names, file_names
import 'package:json_annotation/json_annotation.dart';

part 'Multimedia.g.dart';

@JsonSerializable()
class Multimedia {
  Multimedia(this.url, this.format, this.height, this.width, this.type,
      this.subtype, this.caption, this.copyright);

  factory Multimedia.fromJson(Map<String, dynamic> json) =>
      _$MultimediaFromJson(json);

  Map<String, dynamic> toJson() => _$MultimediaToJson(this);

  @JsonValue("url")
  final String? url;

  @JsonValue("format")
  final String? format;

  @JsonValue("height")
  final int? height;

  @JsonValue("width")
  final int? width;

  @JsonValue("type")
  final String? type;

  @JsonValue("subtype")
  final String? subtype;

  @JsonValue("caption")
  final String? caption;

  @JsonValue("copyright")
  final String? copyright;
}
