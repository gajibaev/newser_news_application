// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ArticleResponse.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ArticleResponse _$ArticleResponseFromJson(Map<String, dynamic> json) =>
    ArticleResponse(
      json['status'] as String?,
      json['copyright'] as String?,
      json['num_results'] as int?,
      (json['results'] as List<dynamic>?)
          ?.map((e) => Article.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ArticleResponseToJson(ArticleResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'copyright': instance.copyright,
      'num_results': instance.num_results,
      'results': instance.results,
    };
