import 'package:json_annotation/json_annotation.dart';

part 'pet_api_model.g.dart';

@JsonSerializable()
class PetApiModel {
  @JsonKey(name: 'idquestionnaire')
  final int id;
  final int categoryId;
  final String title;
  final String photo;
  final String breed;
  final String location;
  final String age;
  final String color;
  final String weight;
  final String type;
  final String description;

  PetApiModel({
    required this.id,
    required this.categoryId,
    required this.title,
    required this.photo,
    required this.breed,
    required this.location,
    required this.age,
    required this.color,
    required this.weight,
    required this.type,
    required this.description,
  });

  factory PetApiModel.fromJson(Map<String, dynamic> json) {
    return _$PetApiModelFromJson(json);
  }

  Map<String, dynamic> toJson() => _$PetApiModelToJson(this);
}
