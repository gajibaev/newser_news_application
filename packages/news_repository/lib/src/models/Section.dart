// ignore_for_file: non_constant_identifier_names, file_names
import 'package:json_annotation/json_annotation.dart';

part 'Section.g.dart';

@JsonSerializable()
class Section {
  Section(this.section, this.display_name);

  static const String allSection = 'all';

  @JsonValue("section")
  final String? section;

  @JsonValue("display_name")
  final String? display_name;

  factory Section.fromJson(Map<String, dynamic> json) =>
      _$SectionFromJson(json);

  Map<String, dynamic> toJson() => _$SectionToJson(this);
}
