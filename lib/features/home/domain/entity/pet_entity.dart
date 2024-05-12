import 'dart:typed_data';

import 'package:get_pet/features/home/data/model/category_api_model.dart';
import 'package:get_pet/features/home/domain/entity/pet_type.dart';

class PetEntity {
  final int? id;
  final CategoryApiModel category;
  final String title;
  final Uint8List photo;
  final String breed;
  final String location;
  final String age;
  final String color;
  final String weight;
  final PetType type;
  final String description;

  PetEntity({
    this.id,
    required this.category,
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

  PetEntity copyWith({
    CategoryApiModel? category,
    String? title,
    Uint8List? photo,
    String? breed,
    String? location,
    String? age,
    String? color,
    String? weight,
    PetType? type,
    String? description,
  }) {
    return PetEntity(
      category: category ?? this.category,
      title: title ?? this.title,
      photo: photo ?? this.photo,
      breed: breed ?? this.breed,
      location: location ?? this.location,
      age: age ?? this.age,
      color: color ?? this.color,
      weight: weight ?? this.weight,
      type: type ?? this.type,
      description: description ?? this.description,
    );
  }
}
