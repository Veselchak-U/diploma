import 'dart:async';

import 'package:get_pet/app/service/storage/remote_storage.dart';
import 'package:get_pet/features/home/data/model/category_api_model.dart';
import 'package:get_pet/features/home/data/model/pet_api_model.dart';

abstract interface class PetDatasource {
  Future<List<CategoryApiModel>> getCategories();

  Future<List<PetApiModel>> getNewPets();
}

class PetDatasourceImpl implements PetDatasource {
  final RemoteStorage _remoteStorage;

  const PetDatasourceImpl(this._remoteStorage);

  @override
  Future<List<CategoryApiModel>> getCategories() async {
    // final Map result = await _remoteStorage.selectAll(
    //   from: 'category',
    // );
    //
    // return result.isEmpty
    //     ? []
    //     : CategoryApiModel.fromJson(result as Map<String, dynamic>);

    return [
      CategoryApiModel(
        id: 1,
        name: 'Коты',
        photo: '',
        count: 250,
      ),
      CategoryApiModel(
        id: 2,
        name: 'Собаки',
        photo: '',
        count: 340,
      ),
      CategoryApiModel(
        id: 3,
        name: 'Рыбки',
        photo: '',
        count: 10,
      ),
    ];
  }

  @override
  Future<List<PetApiModel>> getNewPets() async {
    return [
      PetApiModel(
        id: 1,
        categoryId: 1,
        title: 'Шотландская вислоухая',
        photo: 'photo 1',
        breed: 'breed 1',
        location: 'Шахты (111 км)',
        age: 'age 1',
        color: 'color 1',
        weight: 'weight 1',
        type: 'type 1',
        description: 'description 1',
      ),
      PetApiModel(
        id: 2,
        categoryId: 2,
        title: 'Стаффордширский терьер',
        photo: 'photo 2',
        breed: 'breed 2',
        location: 'Ростов-на-Дону (57 км)',
        age: 'age 2',
        color: 'color 2',
        weight: 'weight 2',
        type: 'type 2',
        description: 'description 2',
      ),
      PetApiModel(
        id: 3,
        categoryId: 2,
        title: 'Стаффордширский терьер',
        photo: 'photo 3',
        breed: 'breed 3',
        location: 'Ростов-на-Дону (57 км)',
        age: 'age 3',
        color: 'color 3',
        weight: 'weight 3',
        type: 'type 3',
        description: 'description 3',
      ),
      PetApiModel(
        id: 4,
        categoryId: 1,
        title: 'Шотландская вислоухая',
        photo: 'photo 4',
        breed: 'breed 4',
        location: 'Шахты (111 км)',
        age: 'age 4',
        color: 'color 4',
        weight: 'weight 4',
        type: 'type 4',
        description: 'description 4',
      ),
    ];
  }
}
