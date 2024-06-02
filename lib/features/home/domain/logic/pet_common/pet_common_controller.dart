import 'dart:async';

import 'package:control/control.dart';
import 'package:get_pet/features/home/data/model/category_api_model.dart';
import 'package:get_pet/features/home/data/repository/pet_repository.dart';
import 'package:get_pet/features/home/domain/entity/pet_entity.dart';

part 'pet_common_controller_state.dart';

final class PetCommonController
    extends StateController<PetCommonControllerState>
    with SequentialControllerHandler {
  final PetRepository _petRepository;

  PetCommonController(
    this._petRepository, {
    super.initialState = const PetCommonController$Idle([]),
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
        setState(PetCommonController$Loading(state.categories));
        final categories = await _petRepository.getCategories();
        setState(PetCommonController$CategoriesUpdated(categories));
      },
      _errorHandler,
      _doneHandler,
    );
  }

  void getNewPets() {
    return handle(
      () async {
        setState(PetCommonController$Loading(state.categories));
        final newPets = await _petRepository.getNewPets();
        setState(PetCommonController$NewPetsUpdated(state.categories, newPets));
      },
      _errorHandler,
      _doneHandler,
    );
  }

  FutureOr<void> _errorHandler(Object e, StackTrace st) {
    setState(PetCommonController$Error(e, state.categories));
  }

  FutureOr<void> _doneHandler() {
    setState(PetCommonController$Idle(state.categories));
  }
}
