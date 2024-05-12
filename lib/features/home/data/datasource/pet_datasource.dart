import 'dart:async';

import 'package:get_pet/app/service/logger/exception/logic_exception.dart';
import 'package:get_pet/app/service/storage/remote_storage.dart';
import 'package:get_pet/features/home/data/model/category_api_model.dart';
import 'package:get_pet/features/home/data/model/pet_api_model.dart';

abstract interface class PetDatasource {
  Future<List<CategoryApiModel>> getCategories();

  Future<List<PetApiModel>> getNewPets();

  Future<void> addPet(PetApiModel model);

  Future<void> updatePet(PetApiModel model);
}

class PetDatasourceImpl implements PetDatasource {
  final RemoteStorage _remoteStorage;

  const PetDatasourceImpl(this._remoteStorage);

  @override
  Future<List<CategoryApiModel>> getCategories() async {
    final result = await _remoteStorage.selectAll(
      from: 'category',
    );

    return result.isEmpty
        ? []
        : result.map((e) => CategoryApiModel.fromJson(e)).toList();

    // return [
    //   CategoryApiModel(
    //     id: 1,
    //     name: 'Коты',
    //     photo: '',
    //     count: 250,
    //   ),
    //   CategoryApiModel(
    //     id: 2,
    //     name: 'Собаки',
    //     photo: '',
    //     count: 340,
    //   ),
    //   CategoryApiModel(
    //     id: 3,
    //     name: 'Рыбки',
    //     photo: '',
    //     count: 10,
    //   ),
    // ];
  }

  @override
  Future<List<PetApiModel>> getNewPets() async {
    final result = await _remoteStorage.selectAll(
      from: 'questionnaire',
    );

    final models = result.map((e) => PetApiModel.fromJson(e)).toList();

    return models;

    // return [
    //   PetApiModel(
    //     id: 1,
    //     userId: -1,
    //     categoryId: 1,
    //     title: 'Шотландская вислоухая',
    //     photo: '',
    //     breed: 'breed 1',
    //     location: 'Шахты (111 км)',
    //     age: 'age 1',
    //     color: 'color 1',
    //     weight: 'weight 1',
    //     type: PetType.mating,
    //     description: 'description 1',
    //   ),
    //   PetApiModel(
    //     id: 2,
    //     userId: -1,
    //     categoryId: 2,
    //     title: 'Стаффордширский терьер',
    //     photo: '',
    //     breed: 'breed 2',
    //     location: 'Ростов-на-Дону (57 км)',
    //     age: 'age 2',
    //     color: 'color 2',
    //     weight: 'weight 2',
    //     type: PetType.adopting,
    //     description: 'description 2',
    //   ),
    //   PetApiModel(
    //     id: 3,
    //     userId: -1,
    //     categoryId: 2,
    //     title: 'Стаффордширский терьер',
    //     photo: '',
    //     breed: 'breed 3',
    //     location: 'Ростов-на-Дону (57 км)',
    //     age: 'age 3',
    //     color: 'color 3',
    //     weight: 'weight 3',
    //     type: PetType.sale,
    //     description: 'description 3',
    //   ),
    //   PetApiModel(
    //     id: 4,
    //     userId: -1,
    //     categoryId: 1,
    //     title: 'Шотландская вислоухая',
    //     photo: '',
    //     breed: 'breed 4',
    //     location: 'Шахты (111 км)',
    //     age: 'age 4',
    //     color: 'color 4',
    //     weight: 'weight 4',
    //     type: PetType.mating,
    //     description: 'description 4',
    //   ),
    // ];
  }

  @override
  Future<void> addPet(PetApiModel model) {
    return _remoteStorage.insert(
      to: 'questionnaire',
      data: model.toJson(),
    );
  }

  @override
  Future<void> updatePet(PetApiModel model) {
    final id = model.id;
    if (id == null) {
      throw const LogicException('Cannot update pet: id == null');
    }

    return _remoteStorage.update(
      to: 'questionnaire',
      id: id,
      data: model.toJson(),
    );
  }
}
