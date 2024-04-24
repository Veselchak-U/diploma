// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserApiModel _$UserApiModelFromJson(Map<String, dynamic> json) => UserApiModel(
      iduser: json['iduser'] as int,
      name: json['name'] as String,
      surname: json['surname'] as String,
      telephone: json['telephone'] as String,
      photo: json['photo'] as String,
    );

Map<String, dynamic> _$UserApiModelToJson(UserApiModel instance) =>
    <String, dynamic>{
      'name': instance.name,
      'surname': instance.surname,
      'telephone': instance.telephone,
      'photo': instance.photo,
    };
