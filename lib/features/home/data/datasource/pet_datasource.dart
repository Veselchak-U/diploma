import 'dart:async';

import 'package:get_pet/app/service/logger/exception/logic_exception.dart';
import 'package:get_pet/app/service/storage/remote_storage.dart';
import 'package:get_pet/features/home/data/model/category_api_model.dart';
import 'package:get_pet/features/home/data/model/pet_api_model.dart';
import 'package:get_pet/features/search/domain/entity/search_filter.dart';

abstract interface class PetDatasource {
  Future<List<CategoryApiModel>> getCategories();

  Future<List<PetApiModel>> getNewPets();

  Future<List<PetApiModel>> getPetsByUser(int userId);

  Future<void> addPet(PetApiModel model);

  Future<void> updatePet(PetApiModel model);

  Future<void> deletePet(int id);

  Future<void> deleteAllByUser(int userId);

  Future<List<PetApiModel>> searchPets(SearchFilter searchFilter);
}

class PetDatasourceImpl implements PetDatasource {
  final RemoteStorage _remoteStorage;

  const PetDatasourceImpl(this._remoteStorage);

  @override
  Future<List<CategoryApiModel>> getCategories() async {
    final result = await _remoteStorage.select(
      from: 'category',
      where: {},
    );

    return result.isEmpty
        ? []
        : result.map((e) => CategoryApiModel.fromJson(e)).toList();
  }

  @override
  Future<List<PetApiModel>> getNewPets() async {
    final result = await _remoteStorage.select(
      from: 'questionnaire',
      where: {},
    );
    final models = result.map((e) => PetApiModel.fromJson(e)).toList();

    return models;
  }

  @override
  Future<List<PetApiModel>> getPetsByUser(int userId) async {
    final result = await _remoteStorage.select(
      from: 'questionnaire',
      where: {'user_iduser': userId},
    );
    final models = result.map((e) => PetApiModel.fromJson(e)).toList();

    return models;
  }

  @override
  Future<void> addPet(PetApiModel pet) {
    return _remoteStorage.insert(
      to: 'questionnaire',
      data: pet.toJson(),
    );
  }

  @override
  Future<void> updatePet(PetApiModel pet) {
    final petId = pet.id;
    if (petId == null) {
      throw const LogicException('Cannot update pet: id == null');
    }

    return _remoteStorage.update(
      to: 'questionnaire',
      data: pet.toJson(),
      where: {'idquestionnaire': petId},
    );
  }

  @override
  Future<void> deletePet(int petId) {
    return _remoteStorage.delete(
      from: 'questionnaire',
      where: {'idquestionnaire': petId},
    );
  }

  @override
  Future<void> deleteAllByUser(int userId) {
    return _remoteStorage.delete(
      from: 'questionnaire',
      where: {'user_iduser': userId},
    );
  }

  @override
  Future<List<PetApiModel>> searchPets(SearchFilter searchFilter) async {
    final wheres = <String, dynamic>{};

    final categories = searchFilter.selectedCategories;
    if (categories.isNotEmpty) {
      final ids = categories.map((e) => e.id).toList();
      wheres['category_idcategory'] = ['in', ids];
    }

    final types = searchFilter.selectedTypes;
    if (types.isNotEmpty) {
      final labels = types.map((e) => '"${e.name}"').toList();
      wheres['type'] = ['in', labels];
    }

    final text = searchFilter.searchText.trim();
    if (text.isNotEmpty) {
      wheres['_SQL'] = '('
          '`title` like "%$text%"'
          ' OR `breed` like "%$text%"'
          ' OR `location` like "%$text%"'
          ' OR `age` like "%$text%"'
          ' OR `color` like "%$text%"'
          ' OR `weight` like "%$text%"'
          ' OR `description` like "%$text%"'
          ')';
    }

    final result = await _remoteStorage.select(
      from: 'questionnaire',
      where: wheres,
    );
    final models = result.map((e) => PetApiModel.fromJson(e)).toList();

    return models;
  }
}
