// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pet_api_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PetApiModel _$PetApiModelFromJson(Map<String, dynamic> json) => PetApiModel(
      id: json['idquestionnaire'] as int,
      categoryId: json['category_id'] as int,
      title: json['title'] as String,
      photo: json['photo'] as String,
      breed: json['breed'] as String,
      location: json['location'] as String,
      age: json['age'] as String,
      color: json['color'] as String,
      weight: json['weight'] as String,
      type: $enumDecode(_$PetTypeEnumMap, json['type']),
      description: json['description'] as String,
    );

Map<String, dynamic> _$PetApiModelToJson(PetApiModel instance) =>
    <String, dynamic>{
      'idquestionnaire': instance.id,
      'category_id': instance.categoryId,
      'title': instance.title,
      'photo': instance.photo,
      'breed': instance.breed,
      'location': instance.location,
      'age': instance.age,
      'color': instance.color,
      'weight': instance.weight,
      'type': _$PetTypeEnumMap[instance.type]!,
      'description': instance.description,
    };

const _$PetTypeEnumMap = {
  PetType.adopting: 'adopting',
  PetType.mating: 'mating',
};
