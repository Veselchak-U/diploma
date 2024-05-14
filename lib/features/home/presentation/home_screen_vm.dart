import 'package:flutter/cupertino.dart';
import 'package:get_pet/app/navigation/app_route.dart';
import 'package:get_pet/app/service/logger/logger_service.dart';
import 'package:get_pet/features/home/data/model/category_api_model.dart';
import 'package:get_pet/features/home/data/repository/pet_repository.dart';
import 'package:get_pet/features/home/domain/entity/pet_entity.dart';
import 'package:get_pet/widgets/bottom_sheets.dart';
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
  final loading = ValueNotifier<bool>(true);

  Future<void> _init() async {
    categories.value = await _petRepository.getCategories();
    newPets.value = await _petRepository.getNewPets();
    loading.value = false;
  }

  void dispose() {
    categories.dispose();
    newPets.dispose();
    loading.dispose();
  }

  void addPet() {
    LoggerService().d('HomeScreenVm.addPet()');
    GoRouter.of(_context).pushNamed(AppRoute.petProfile.name);
  }

  void search() {
    LoggerService().d('HomeScreenVm.search()');
  }

  Future<void> deletePet(PetEntity pet) async {
    LoggerService().d('HomeScreenVm.deletePet(): $pet');

    final result = await BottomSheets.showConfirmationDialog(
      context: _context,
      title: 'Подтверждение',
      text: 'Вы действительно хотите удалить анкету "${pet.title}"?',
      confirmLabel: 'Да, удалить',
    );

    if (result == true) {
      loading.value = true;
      await _petRepository.deletePet(pet);
      newPets.value = await _petRepository.getNewPets();
      loading.value = false;
    }
  }

  Future<void> updateNewPets() {
    loading.value = true;
    _petRepository.getNewPets().then(
      (value) {
        newPets.value = value;
        loading.value = false;
      },
    );

    return Future.value();
  }

  void openPetDetails(PetEntity pet) {
    GoRouter.of(_context).pushNamed(
      AppRoute.petDetails.name,
      extra: pet,
    );
  }
}
