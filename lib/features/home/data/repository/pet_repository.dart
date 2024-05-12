import 'dart:convert';
import 'dart:typed_data';

import 'package:get_pet/features/home/data/datasource/pet_datasource.dart';
import 'package:get_pet/features/home/data/model/category_api_model.dart';
import 'package:get_pet/features/home/data/model/pet_api_model.dart';
import 'package:get_pet/features/home/domain/entity/pet_entity.dart';

abstract interface class PetRepository {
  Future<List<CategoryApiModel>> getCategories();

  Future<List<PetEntity>> getNewPets();

  Future<void> addPet(PetEntity pet);
}

class PetRepositoryImpl implements PetRepository {
  final PetDatasource _petDatasource;

  PetRepositoryImpl(this._petDatasource);

  List<CategoryApiModel> _categories = [];

  @override
  Future<List<CategoryApiModel>> getCategories() async {
    if (_categories.isNotEmpty) return _categories;

    _categories = await _petDatasource.getCategories();

    return _categories;
  }

  @override
  Future<List<PetEntity>> getNewPets() async {
    final models = await _petDatasource.getNewPets();
    final entities = models.map(_convertToPetEntity).toList();

    return entities;
  }

  @override
  Future<void> addPet(PetEntity pet) {
    final model = _convertToPetApiModel(pet);

    return _petDatasource.addPet(model);
  }

  PetEntity _convertToPetEntity(PetApiModel model) {
    final category = _categories.firstWhere((e) => e.id == model.categoryId);

    return PetEntity(
      id: model.id,
      category: category,
      title: model.title,
      photo: model.photo.isNotEmpty
          ? UriData.parse(model.photo).contentAsBytes()
          : Uint8List(0),
      breed: model.breed,
      location: model.location,
      age: model.age,
      color: model.color,
      weight: model.weight,
      type: model.type,
      description: model.description,
    );
  }

  PetApiModel _convertToPetApiModel(PetEntity entity) {
    return PetApiModel(
      id: entity.id,
      categoryId: entity.category.id,
      title: entity.title,
      photo: entity.photo.isNotEmpty ? base64.encode(entity.photo) : '',
      breed: entity.breed,
      location: entity.location,
      age: entity.age,
      color: entity.color,
      weight: entity.weight,
      type: entity.type,
      description: entity.description,
    );
  }
}
