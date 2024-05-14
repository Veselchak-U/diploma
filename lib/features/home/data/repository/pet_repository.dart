import 'package:get_pet/app/service/logger/exception/logic_exception.dart';
import 'package:get_pet/app/service/storage/local_storage.dart';
import 'package:get_pet/features/home/data/datasource/pet_datasource.dart';
import 'package:get_pet/features/home/data/model/category_api_model.dart';
import 'package:get_pet/features/home/data/model/pet_api_model.dart';
import 'package:get_pet/features/home/domain/entity/pet_entity.dart';
import 'package:get_pet/features/login/data/model/user_api_model.dart';

abstract interface class PetRepository {
  Future<List<CategoryApiModel>> getCategories();

  Future<List<PetEntity>> getNewPets();

  Future<void> addPet(PetEntity pet);

  Future<void> updatePet(PetEntity pet);

  Future<void> deletePet(PetEntity pet);

  Future<UserApiModel> getUser(int userId);
}

class PetRepositoryImpl implements PetRepository {
  final PetDatasource _petDatasource;
  final LocalStorage _localStorage;

  PetRepositoryImpl(
    this._petDatasource,
    this._localStorage,
  );

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
  Future<void> addPet(PetEntity pet) async {
    final userId = await _localStorage.getUserId();
    if (userId == null) {
      throw const LogicException('Cannot add pet: userId == null');
    }

    final model = _convertToPetApiModel(pet, userId);

    return _petDatasource.addPet(model);
  }

  @override
  Future<void> updatePet(PetEntity pet) async {
    final userId = await _localStorage.getUserId();
    if (userId == null) {
      throw const LogicException('Cannot update pet: userId == null');
    }

    final model = _convertToPetApiModel(pet, userId);

    return _petDatasource.updatePet(model);
  }

  @override
  Future<void> deletePet(PetEntity pet) {
    final petId = pet.id;
    if (petId == null) {
      throw const LogicException('Cannot delete pet: petId == null');
    }

    return _petDatasource.deletePet(petId);
  }

  PetEntity _convertToPetEntity(PetApiModel model) {
    final category = _categories.firstWhere((e) => e.id == model.categoryId);

    return PetEntity(
      id: model.id,
      userId: model.userId,
      category: category,
      title: model.title,
      photoUrl: model.photo,
      breed: model.breed,
      location: model.location,
      age: model.age,
      color: model.color,
      weight: model.weight,
      type: model.type,
      description: model.description,
    );
  }

  PetApiModel _convertToPetApiModel(PetEntity entity, int userId) {
    return PetApiModel(
      id: entity.id,
      userId: userId,
      categoryId: entity.category.id,
      title: entity.title,
      photo: entity.photoUrl,
      breed: entity.breed,
      location: entity.location,
      age: entity.age,
      color: entity.color,
      weight: entity.weight,
      type: entity.type,
      description: entity.description,
    );
  }

  @override
  Future<UserApiModel> getUser(int userId) {
    return _petDatasource.getUser(userId);
  }
}
