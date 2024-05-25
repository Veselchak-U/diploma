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

  Future<void> deletePet(int id);
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

    // return [
    //   CategoryApiModel(
    //     id: 1,
    //     name: 'Коты',
    //     photo: Uint8List(0),
    //     count: 250,
    //   ),
    //   CategoryApiModel(
    //     id: 2,
    //     name: 'Собаки',
    //     photo: Uint8List(0),
    //     count: 340,
    //   ),
    //   CategoryApiModel(
    //     id: 3,
    //     name: 'Рыбки',
    //     photo: Uint8List(0),
    //     count: 10,
    //   ),
    // ];
  }

  @override
  Future<List<PetApiModel>> getNewPets() async {
    final result = await _remoteStorage.select(
      from: 'questionnaire',
      where: {},
    );

    final models = result.map((e) => PetApiModel.fromJson(e)).toList();

    return models;

    // return [
    //   PetApiModel(
    //     id: 1,
    //     userId: -1,
    //     categoryId: 1,
    //     title: 'Шотландская вислоухая',
    //     photo:
    //         'https://firebasestorage.googleapis.com/v0/b/getpet-ea0fa.appspot.com/o/images%2Fusers%2F1%2F9dddbf5d-3e9b-44df-946e-235232d0c0bc?alt=media&token=501c2551-5bc8-4fcf-bc1a-85bb00010b4f',
    //     breed: 'Шотландская вислоухая',
    //     location: 'Шахты (111 км)',
    //     age: '1,5 года',
    //     color: 'Фолд',
    //     weight: '2,9 кг',
    //     type: PetType.mating,
    //     description:
    //         'Кошка Маруся ищет кота для прекрасного времяпровождения. Шерсть красивая, потомство будет очень красивое.',
    //   ),
    //   PetApiModel(
    //     id: 2,
    //     userId: -1,
    //     categoryId: 2,
    //     title: 'Стаффордширский терьер',
    //     photo:
    //         'https://firebasestorage.googleapis.com/v0/b/getpet-ea0fa.appspot.com/o/images%2Fusers%2F1%2F9dddbf5d-3e9b-44df-946e-235232d0c0bc?alt=media&token=501c2551-5bc8-4fcf-bc1a-85bb00010b4f',
    //     breed: 'Шотландская вислоухая',
    //     location: 'Ростов-на-Дону (57 км)',
    //     age: '1,5 года',
    //     color: 'Фолд',
    //     weight: '2,9 кг',
    //     type: PetType.adopting,
    //     description:
    //         'Кошка Маруся ищет кота для прекрасного времяпровождения. Шерсть красивая, потомство будет очень красивое.',
    //   ),
    //   PetApiModel(
    //     id: 3,
    //     userId: -1,
    //     categoryId: 2,
    //     title: 'Стаффордширский терьер',
    //     photo:
    //         'https://firebasestorage.googleapis.com/v0/b/getpet-ea0fa.appspot.com/o/images%2Fusers%2F1%2F9dddbf5d-3e9b-44df-946e-235232d0c0bc?alt=media&token=501c2551-5bc8-4fcf-bc1a-85bb00010b4f',
    //     breed: 'Шотландская вислоухая',
    //     location: 'Ростов-на-Дону (57 км)',
    //     age: '1,5 года',
    //     color: 'Фолд',
    //     weight: '2,9 кг',
    //     type: PetType.sale,
    //     description:
    //         'Кошка Маруся ищет кота для прекрасного времяпровождения. Шерсть красивая, потомство будет очень красивое.',
    //   ),
    //   PetApiModel(
    //     id: 4,
    //     userId: -1,
    //     categoryId: 1,
    //     title: 'Шотландская вислоухая',
    //     photo:
    //         'https://firebasestorage.googleapis.com/v0/b/getpet-ea0fa.appspot.com/o/images%2Fusers%2F1%2F9dddbf5d-3e9b-44df-946e-235232d0c0bc?alt=media&token=501c2551-5bc8-4fcf-bc1a-85bb00010b4f',
    //     breed: 'Шотландская вислоухая',
    //     location: 'Шахты (111 км)',
    //     age: '1,5 года',
    //     color: 'Фолд',
    //     weight: '2,9 кг',
    //     type: PetType.mating,
    //     description:
    //         'Кошка Маруся ищет кота для прекрасного времяпровождения. Шерсть красивая, потомство будет очень красивое.',
    //   ),
    // ];
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
}
