import 'package:flutter/foundation.dart';
import 'package:get_pet/app/service/logger/logger_service.dart';
import 'package:get_pet/features/home/data/model/category_api_model.dart';
import 'package:get_pet/features/home/data/repository/pet_repository.dart';
import 'package:get_pet/features/home/domain/entity/pet_entity.dart';

class HomeScreenVm {
  final PetRepository _petRepository;

  HomeScreenVm(
    this._petRepository,
  ) {
    _init();
  }

  final categories = ValueNotifier<List<CategoryApiModel>>([]);
  final newPets = ValueNotifier<List<PetEntity>>([]);

  Future<void> _init() async {
    categories.value = await _petRepository.getCategories();
    newPets.value = await _petRepository.getNewPets();
  }

  void dispose() {
    categories.dispose();
  }

  void addPet() {
    LoggerService().d('HomeScreenVm.addPet()');
  }

  void search() {
    LoggerService().d('HomeScreenVm.search()');
  }
}
