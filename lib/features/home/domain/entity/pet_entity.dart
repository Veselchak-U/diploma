import 'package:get_pet/features/home/data/model/category_api_model.dart';
import 'package:get_pet/features/home/domain/entity/pet_type.dart';

class PetEntity {
  final int? id;
  final int? userId;
  final CategoryApiModel category;
  final String title;
  final String photoUrl;
  final String breed;
  final String location;
  final String age;
  final String color;
  final String weight;
  final PetType type;
  final String description;

  PetEntity({
    this.id,
    this.userId,
    required this.category,
    required this.title,
    required this.photoUrl,
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
    String? photoUrl,
    String? breed,
    String? location,
    String? age,
    String? color,
    String? weight,
    PetType? type,
    String? description,
  }) {
    return PetEntity(
      id: id,
      userId: userId,
      category: category ?? this.category,
      title: title ?? this.title,
      photoUrl: photoUrl ?? this.photoUrl,
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
