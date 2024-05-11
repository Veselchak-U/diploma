import 'package:get_pet/features/home/data/datasource/pet_datasource.dart';
import 'package:get_pet/features/home/data/model/category_api_model.dart';
import 'package:get_pet/features/home/data/model/pet_api_model.dart';
import 'package:get_pet/features/home/domain/entity/pet_entity.dart';

abstract interface class PetRepository {
  Future<List<CategoryApiModel>> getCategories();

  Future<List<PetEntity>> getNewPets();
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

  PetEntity _convertToPetEntity(PetApiModel model) {
    final category = _categories.firstWhere((e) => e.id == model.categoryId);

    return PetEntity(
      id: model.id,
      category: category,
      title: model.title,
      photo: model.photo,
      breed: model.breed,
      location: model.location,
      age: model.age,
      color: model.color,
      weight: model.weight,
      type: model.type,
      description: model.description,
    );
  }
}
