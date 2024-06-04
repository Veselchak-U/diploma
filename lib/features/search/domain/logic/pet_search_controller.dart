import 'dart:async';

import 'package:control/control.dart';
import 'package:get_pet/features/home/data/model/category_api_model.dart';
import 'package:get_pet/features/home/data/repository/pet_repository.dart';
import 'package:get_pet/features/home/domain/entity/pet_entity.dart';
import 'package:get_pet/features/search/domain/entity/search_filter.dart';

part 'pet_search_controller_state.dart';

final class PetSearchController
    extends StateController<PetSearchControllerState>
    with DroppableControllerHandler {
  final PetRepository _petRepository;

  PetSearchController(
    this._petRepository, {
    super.initialState = const PetSearchController$Idle(),
  }) {
    _init();
  }

  void _init() {}

  @override
  void dispose() {
    super.dispose();
  }

  void getCategories() {
    return handle(
      () async {
        setState(const PetSearchController$Loading());
        final categories = await _petRepository.getCategories();
        setState(PetSearchController$CategoriesSuccess(categories));
      },
      _errorHandler,
      _doneHandler,
    );
  }

  void searchPets(SearchFilter searchFilter) {
    return handle(
      () async {
        setState(const PetSearchController$Loading());
        final foundedPets = await _petRepository.searchPets(searchFilter);
        setState(PetSearchController$SearchSuccess(foundedPets));
      },
      _errorHandler,
      _doneHandler,
    );
  }

  void searchOutside(SearchFilter searchFilter) {
    return handle(
      () async {
        setState(PetSearchController$SearchOutside(searchFilter));
      },
      _errorHandler,
      _doneHandler,
    );
  }

  FutureOr<void> _errorHandler(Object e, StackTrace st) {
    setState(PetSearchController$Error(e));
  }

  FutureOr<void> _doneHandler() {
    setState(const PetSearchController$Idle());
  }
}
