// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'Multimedia.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Multimedia _$MultimediaFromJson(Map<String, dynamic> json) => Multimedia(
      json['url'] as String?,
      json['format'] as String?,
      json['height'] as int?,
      json['width'] as int?,
      json['type'] as String?,
      json['subtype'] as String?,
      json['caption'] as String?,
      json['copyright'] as String?,
    );

Map<String, dynamic> _$MultimediaToJson(Multimedia instance) =>
    <String, dynamic>{
      'url': instance.url,
      'format': instance.format,
      'height': instance.height,
      'width': instance.width,
      'type': instance.type,
      'subtype': instance.subtype,
      'caption': instance.caption,
      'copyright': instance.copyright,
    };
