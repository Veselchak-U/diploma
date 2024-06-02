import 'dart:async';

import 'package:control/control.dart';
import 'package:get_pet/features/home/data/repository/pet_repository.dart';
import 'package:get_pet/features/home/domain/entity/pet_entity.dart';
import 'package:get_pet/features/login/data/model/user_api_model.dart';
import 'package:get_pet/features/login/data/repository/user_repository.dart';

part 'pet_details_controller_state.dart';

final class PetDetailsController
    extends StateController<PetDetailsControllerState>
    with SequentialControllerHandler {
  final UserRepository _userRepository;
  final PetRepository _petRepository;

  PetDetailsController(
    this._userRepository,
    this._petRepository, {
    super.initialState = const PetDetailsController$Idle(),
  }) {
    _init();
  }

  void _init() {}

  @override
  void dispose() {
    super.dispose();
  }

  void getUser(int userId) {
    return handle(
      () async {
        setState(const PetDetailsController$Loading());
        final user = await _userRepository.getUserById(userId);
        if (user != null) {
          final currentUserId = await _userRepository.getCurrentUserId();
          final isMyPet = currentUserId != null && currentUserId == user.id;
          setState(PetDetailsController$UserSuccess(user, isMyPet));
        }
      },
      _errorHandler,
      _doneHandler,
    );
  }

  void deletePet(PetEntity pet) {
    return handle(
      () async {
        setState(const PetDetailsController$Loading());
        await _petRepository.deletePet(pet);
        setState(const PetDetailsController$DeletePetSuccess());
      },
      _errorHandler,
      _doneHandler,
    );
  }

  FutureOr<void> _errorHandler(Object e, StackTrace st) {
    setState(PetDetailsController$Error(e));
  }

  FutureOr<void> _doneHandler() {
    setState(const PetDetailsController$Idle());
  }
}
