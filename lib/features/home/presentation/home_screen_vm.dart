import 'package:flutter/cupertino.dart';
import 'package:get_pet/app/navigation/app_route.dart';
import 'package:get_pet/features/home/data/model/category_api_model.dart';
import 'package:get_pet/features/home/domain/entity/pet_entity.dart';
import 'package:get_pet/features/home/domain/logic/pet_common/pet_common_controller.dart';
import 'package:get_pet/features/home/domain/logic/support/support_controller.dart';
import 'package:get_pet/features/search/domain/entity/search_filter.dart';
import 'package:get_pet/features/search/presentation/search_screen_vm.dart';
import 'package:get_pet/widgets/app_overlays.dart';
import 'package:go_router/go_router.dart';

class HomeScreenVm {
  final BuildContext _context;
  final PetCommonController _petCommonController;
  final SupportController _supportController;
  final SearchScreenVm _searchScreenVm;

  HomeScreenVm(
    this._context,
    this._petCommonController,
    this._supportController,
    this._searchScreenVm,
  ) {
    _init();
  }

  final pageController = PageController();

  final pageIndex = ValueNotifier<int>(0);
  final categories = ValueNotifier<List<CategoryApiModel>>([]);
  final newPets = ValueNotifier<List<PetEntity>>([]);
  final loading = ValueNotifier<bool>(false);
  final unreadNotificationCount = ValueNotifier<int>(0);

  Future<void> _init() async {
    _petCommonController.addListener(_petCommonControllerListener);
    _petCommonController.getCategories();

    _supportController.addListener(_supportControllerListener);
    _supportController.getUserQuestions();
  }

  void dispose() {
    _petCommonController.removeListener(_petCommonControllerListener);
    _supportController.removeListener(_supportControllerListener);

    pageController.dispose();

    pageIndex.dispose();
    categories.dispose();
    newPets.dispose();
    loading.dispose();
    unreadNotificationCount.dispose();
  }

  void addPet() {
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

  Future<void> updateNewPets() {
    _petCommonController.getNewPets();

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

  void _petCommonControllerListener() {
    final state = _petCommonController.state;
    _handlePetCommonLoading(state);
    _handleCategoriesUpdate(state);
    _handleNewPetUpdate(state);
    _handlePetCommonError(state);
  }

  void _handlePetCommonLoading(PetCommonControllerState state) {
    switch (state) {
      case PetCommonController$Loading():
        loading.value = true;
        break;
      default:
        loading.value = false;
        break;
    }
  }

  void _handleCategoriesUpdate(PetCommonControllerState state) {
    switch (state) {
      case final PetCommonController$CategoriesUpdated state:
        categories.value = state.categories;
        _petCommonController.getNewPets();
        break;
      default:
        break;
    }
  }

  void _handleNewPetUpdate(PetCommonControllerState state) {
    switch (state) {
      case final PetCommonController$NewPetsUpdated state:
        newPets.value = state.newPets;
        break;
      default:
        break;
    }
  }

  void _handlePetCommonError(PetCommonControllerState state) {
    switch (state) {
      case PetCommonController$Error():
        AppOverlays.showErrorBanner(msg: '${state.error}');
        break;
      default:
        break;
    }
  }
}
