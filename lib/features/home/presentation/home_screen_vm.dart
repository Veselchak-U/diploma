import 'package:flutter/cupertino.dart';
import 'package:get_pet/app/navigation/app_route.dart';
import 'package:get_pet/app/service/logger/logger_service.dart';
import 'package:get_pet/features/home/data/model/category_api_model.dart';
import 'package:get_pet/features/home/data/repository/pet_repository.dart';
import 'package:get_pet/features/home/domain/entity/pet_entity.dart';
import 'package:go_router/go_router.dart';

class HomeScreenVm {
  final BuildContext _context;
  final PetRepository _petRepository;

  HomeScreenVm(
    this._context,
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
    GoRouter.of(_context).pushNamed(AppRoute.petProfile.name);
  }

  void search() {
    LoggerService().d('HomeScreenVm.search()');
  }
}
