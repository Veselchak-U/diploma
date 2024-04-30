import 'package:get_pet/features/home/data/model/category_api_model.dart';

class PetEntity {
  final int? id;
  final CategoryApiModel category;
  final String title;
  final String photo;
  final String breed;
  final String location;
  final String age;
  final String color;
  final String weight;
  final String type;
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
}
