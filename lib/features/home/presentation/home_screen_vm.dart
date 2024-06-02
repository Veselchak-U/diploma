import 'package:flutter/cupertino.dart';
import 'package:get_pet/app/navigation/app_route.dart';
import 'package:get_pet/app/service/logger/logger_service.dart';
import 'package:get_pet/features/home/data/model/category_api_model.dart';
import 'package:get_pet/features/home/data/repository/pet_repository.dart';
import 'package:get_pet/features/home/domain/entity/pet_entity.dart';
import 'package:get_pet/features/home/domain/logic/support/support_controller.dart';
import 'package:get_pet/features/search/domain/entity/search_filter.dart';
import 'package:get_pet/features/search/presentation/search_screen_vm.dart';
import 'package:get_pet/widgets/bottom_sheets.dart';
import 'package:go_router/go_router.dart';

class HomeScreenVm {
  final BuildContext _context;
  final PetRepository _petRepository;
  final SupportController _supportController;
  final SearchScreenVm _searchScreenVm;

  HomeScreenVm(
    this._context,
    this._petRepository,
    this._supportController,
    this._searchScreenVm,
  ) {
    _init();
  }

  final pageController = PageController();

  final pageIndex = ValueNotifier<int>(0);
  final categories = ValueNotifier<List<CategoryApiModel>>([]);
  final newPets = ValueNotifier<List<PetEntity>>([]);
  final loading = ValueNotifier<bool>(true);
  final unreadNotificationCount = ValueNotifier<int>(0);

  Future<void> _init() async {
    categories.value = await _petRepository.getCategories();
    newPets.value = await _petRepository.getNewPets();
    loading.value = false;
    _supportController.addListener(_supportControllerListener);
    _supportController.getUserQuestions();
  }

  void dispose() {
    _supportController.removeListener(_supportControllerListener);

    pageController.dispose();

    pageIndex.dispose();
    categories.dispose();
    newPets.dispose();
    loading.dispose();
    unreadNotificationCount.dispose();
  }

  void addPet() {
    LoggerService().d('HomeScreenVm.addPet()');
    GoRouter.of(_context).pushNamed(AppRoute.petProfile.name);
  }

  void onPageSelected(int value) {
    pageIndex.value = value;
    pageController.jumpToPage(value);
  }

  void onTapSearchText() {
    _searchScreenVm.onSearchOutside(
      SearchFilter(searchText: ' '),
    );

    onPageSelected(1);
  }

  void onTapCategory(CategoryApiModel category) {
    _searchScreenVm.onSearchOutside(
      SearchFilter(selectedCategories: [category]),
    );

    onPageSelected(1);
  }

  Future<void> deletePet(PetEntity pet) async {
    LoggerService().d('HomeScreenVm.deletePet(): $pet');

    final result = await BottomSheets.showConfirmationDialog(
      context: _context,
      title: 'Подтверждение',
      text: 'Вы действительно хотите удалить объявление "${pet.title}"?',
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

  void _supportControllerListener() {
    final state = _supportController.state;
    _handleSupportQuestions(state);
  }

  void _handleSupportQuestions(SupportControllerState state) {
    switch (state) {
      case final SupportController$QuestionsSuccess state:
        final unreadCount = state.questions.where((e) => e.isNew).length;
        unreadNotificationCount.value = unreadCount;
        break;
      default:
        break;
    }
  }
}
