// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Article.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticleFromJson(Map<String, dynamic> json) => Article(
      json['slug_name'] as String?,
      json['section'] as String?,
      json['subsection'] as String?,
      json['title'] as String?,
      json['abstract'] as String?,
      json['uri'] as String?,
      json['url'] as String?,
      json['byline'] as String?,
      json['thumbnail_standard'] as String?,
      json['item_type'] as String?,
      json['source'] as String?,
      json['updated_date'] as String?,
      json['created_date'] as String?,
      json['published_date'] as String?,
      json['firstPublished_date'] as String?,
      json['material_type_facet'] as String?,
      json['kicker'] as String?,
      json['subhead_line'] as String?,
      (json['multimedia'] as List<dynamic>?)
          ?.map((e) => Multimedia.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$ArticleToJson(Article instance) => <String, dynamic>{
      'slug_name': instance.slug_name,
      'section': instance.section,
      'subsection': instance.subsection,
      'title': instance.title,
      'abstract': instance.abstract,
      'uri': instance.uri,
      'url': instance.url,
      'byline': instance.byline,
      'thumbnail_standard': instance.thumbnail_standard,
      'item_type': instance.item_type,
      'source': instance.source,
      'updated_date': instance.updated_date,
      'created_date': instance.created_date,
      'published_date': instance.published_date,
      'firstPublished_date': instance.firstPublished_date,
      'material_type_facet': instance.material_type_facet,
      'kicker': instance.kicker,
      'subhead_line': instance.subhead_line,
      'multimedia': instance.multimedia,
    };
