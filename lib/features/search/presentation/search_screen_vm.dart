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

  SearchScreenVm(
    this._context,
    this._petSearchController,
  ) {
    _init();
  }

  final loading = ValueNotifier<bool>(false);
  final categories = ValueNotifier<List<CategoryApiModel>>([]);
  final selectedCategories = ValueNotifier<List<CategoryApiModel>>([]);
  final selectedTypes = ValueNotifier<List<PetType>>([]);
  final searchText = ValueNotifier<String>('');
  final foundedPets = ValueNotifier<List<PetEntity>>([]);

  final searchFieldFocusNode = FocusNode();
  final searchFieldController = TextEditingController();

  Future<void> _init() async {
    _petSearchController.addListener(_petSearchControllerListener);
    _petSearchController.getCategories();
  }

  void dispose() {
    _petSearchController.removeListener(_petSearchControllerListener);
    _petSearchController.dispose();

    loading.dispose();
    categories.dispose();
    selectedCategories.dispose();
    selectedTypes.dispose();
    searchText.dispose();
    foundedPets.dispose();

    searchFieldFocusNode.dispose();
    searchFieldController.dispose();
  }

  void onTapCategory(CategoryApiModel value) {
    final newList = [...selectedCategories.value];

    if (newList.contains(value)) {
      newList.remove(value);
    } else {
      newList.add(value);
    }
    selectedCategories.value = newList;

    _searchPets();
  }

  void onTapPetType(PetType value) {
    final newList = [...selectedTypes.value];

    if (newList.contains(value)) {
      newList.remove(value);
    } else {
      newList.add(value);
    }
    selectedTypes.value = newList;

    _searchPets();
  }

  void onSearchTextChanged(String value) {
    searchText.value = value;

    _searchPets();
  }

  void _searchPets() {
    final searchFilter = SearchFilter(
      selectedCategories: selectedCategories.value,
      selectedTypes: selectedTypes.value,
      searchText: searchText.value,
    );

    if (searchFilter.isEmpty) {
      foundedPets.value = [];
      return;
    }

    _petSearchController.searchPets(searchFilter);
  }

  void openPetDetails(PetEntity pet) {
    GoRouter.of(_context).pushNamed(
      AppRoute.petDetails.name,
      extra: pet,
    );
  }

  void _onSearchOutside(SearchFilter newFilter) {
    selectedCategories.value = newFilter.selectedCategories;
    selectedTypes.value = newFilter.selectedTypes;
    searchText.value = newFilter.searchText;
    searchFieldController.text = newFilter.searchText;

    // Handle tap on home page "Search" field
    if (newFilter.isEmpty) {
      searchFieldFocusNode.requestFocus();
    }

    _searchPets();
  }

  void _petSearchControllerListener() {
    final state = _petSearchController.state;
    _handleLoading(state);
    _handleCategories(state);
    _handlePets(state);
    _handleSearchOutside(state);
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

  void _handleSearchOutside(PetSearchControllerState state) {
    switch (state) {
      case PetSearchController$SearchOutside():
        _onSearchOutside(state.searchFilter);
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
