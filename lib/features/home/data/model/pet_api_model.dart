import 'package:get_pet/features/home/domain/entity/pet_type.dart';
import 'package:json_annotation/json_annotation.dart';

part 'pet_api_model.g.dart';

@JsonSerializable()
class PetApiModel {
  @JsonKey(name: 'idquestionnaire')
  final int? id;
  @JsonKey(name: 'user_iduser')
  final int userId;
  @JsonKey(name: 'category_idcategory')
  final int categoryId;
  final String title;
  final String breed;
  final String location;
  final String age;
  final String color;
  final String weight;
  final PetType type;
  final String description;
  final String photo;

  PetApiModel({
    required this.id,
    required this.userId,
    required this.categoryId,
    required this.title,
    required this.breed,
    required this.location,
    required this.age,
    required this.color,
    required this.weight,
    required this.type,
    required this.description,
    required this.photo,
  });

  factory PetApiModel.fromJson(Map<String, dynamic> json) {
    return _$PetApiModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PetApiModelToJson(this);
}
