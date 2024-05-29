import 'dart:async';

import 'package:get_pet/app/service/logger/exception/logic_exception.dart';
import 'package:get_pet/app/service/storage/remote_storage.dart';
import 'package:get_pet/features/home/data/model/category_api_model.dart';
import 'package:get_pet/features/home/data/model/pet_api_model.dart';

abstract interface class PetDatasource {
  Future<List<CategoryApiModel>> getCategories();

  Future<List<PetApiModel>> getNewPets();

  Future<List<PetApiModel>> getPetsByUser(int userId);

  Future<void> addPet(PetApiModel model);

  Future<void> updatePet(PetApiModel model);

  Future<void> deletePet(int id);

  Future<void> deleteAllByUser(int userId);
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
}
