// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'SectionResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SectionResponse _$SectionResponseFromJson(Map<String, dynamic> json) =>
    SectionResponse(
      json['status'] as String?,
      json['copyright'] as String?,
      json['num_results'] as int?,
      (json['results'] as List<dynamic>?)
          ?.map((e) => Section.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$SectionResponseToJson(SectionResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'copyright': instance.copyright,
      'numResults': instance.num_results,
      'results': instance.results,
    };
