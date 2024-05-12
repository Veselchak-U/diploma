// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'category_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CategoryApiModel _$CategoryApiModelFromJson(Map<String, dynamic> json) =>
    CategoryApiModel(
      id: json['idcategory'] as int,
      name: json['name'] as String,
      photo: StringUtils.base64ToUint8List(json['photo'] as String),
      count: json['count'] as int?,
    );

Map<String, dynamic> _$CategoryApiModelToJson(CategoryApiModel instance) =>
    <String, dynamic>{
      'idcategory': instance.id,
      'name': instance.name,
      'photo': StringUtils.uint8ListToBase64(instance.photo),
      'count': instance.count,
    };
