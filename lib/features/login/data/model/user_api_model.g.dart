// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserApiModel _$UserApiModelFromJson(Map<String, dynamic> json) => UserApiModel(
      id: json['id'] as int?,
      expiresAt: _$JsonConverterFromJson<String, DateTime>(
          json['expiresAt'], const ConvertDateTime().fromJson),
      deletedAt: _$JsonConverterFromJson<String, DateTime>(
          json['deleted_at'], const ConvertDateTime().fromJson),
      code: json['code'] as String?,
      active: json['active'] as bool?,
    );

Value? _$JsonConverterFromJson<Json, Value>(
  Object? json,
  Value? Function(Json json) fromJson,
) =>
    json == null ? null : fromJson(json as Json);
