import 'package:flutter/material.dart';
import 'package:get_pet/app/navigation/app_route.dart';
import 'package:get_pet/features/home/data/model/category_api_model.dart';
import 'package:get_pet/features/home/domain/entity/pet_entity.dart';
import 'package:get_pet/features/home/domain/entity/pet_type.dart';
import 'package:get_pet/features/search/domain/entity/search_filter.dart';
import 'package:get_pet/features/search/domain/logic/pet_search_controller.dart';
import 'package:get_pet/widgets/app_overlays.dart';
import 'package:go_router/go_router.dart';

class SearchScreenVm {
  final BuildContext _context;
  final PetSearchController _petSearchController;
  final SearchFilter? _searchFilter;

  SearchScreenVm(
    this._context,
    this._petSearchController,
    this._searchFilter,
  ) {
    _init();
  }

  final loading = ValueNotifier<bool>(false);
  final categories = ValueNotifier<List<CategoryApiModel>>([]);
  final selectedCategories = ValueNotifier<List<CategoryApiModel>>([]);
  final selectedTypes = ValueNotifier<List<PetType>>([]);
  final searchText = ValueNotifier<String>('');

  final foundedPets = ValueNotifier<List<PetEntity>>([]);

  Future<void> _init() async {
    _petSearchController.addListener(_petSearchControllerListener);
    _petSearchController.getCategories();

    if (_searchFilter != null) {
      selectedCategories.value = _searchFilter.selectedCategories;
      selectedTypes.value = _searchFilter.selectedTypes;
      searchText.value = _searchFilter.searchText;

      _petSearchController.searchPets(_searchFilter);
    }
  }

  void dispose() {
    _petSearchController.removeListener(_petSearchControllerListener);
    _petSearchController.dispose();

    loading.dispose();
    categories.dispose();
    selectedCategories.dispose();
    selectedTypes.dispose();
    searchText.dispose();
  }

  void searchPets() {
    final searchFilter = SearchFilter(
      selectedCategories: selectedCategories.value,
      selectedTypes: selectedTypes.value,
      searchText: searchText.value,
    );

    _petSearchController.searchPets(searchFilter);
  }

  void openPetDetails(PetEntity pet) {
    GoRouter.of(_context).pushNamed(
      AppRoute.petDetails.name,
      extra: pet,
    );
  }

  void _petSearchControllerListener() {
    final state = _petSearchController.state;
    _handleLoading(state);
    _handleCategories(state);
    _handlePets(state);
    _handleError(state);
  }

  void _handleLoading(PetSearchControllerState state) {
    loading.value = switch (state) {
      const PetSearchController$Loading() => true,
      _ => false,
    };
  }

  void _handleCategories(PetSearchControllerState state) {
    switch (state) {
      case PetSearchController$CategoriesSuccess():
        categories.value = state.categories;
        break;
      default:
        break;
    }
  }

  void _handlePets(PetSearchControllerState state) {
    switch (state) {
      case PetSearchController$SearchSuccess():
        foundedPets.value = state.foundedPets;
        break;
      default:
        break;
    }
  }

  void _handleError(PetSearchControllerState state) {
    switch (state) {
      case PetSearchController$Error():
        AppOverlays.showErrorBanner(msg: '${state.error}');
        break;
      default:
        break;
    }
  }
}
