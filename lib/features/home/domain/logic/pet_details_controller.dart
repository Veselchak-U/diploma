import 'dart:async';

import 'package:control/control.dart';
import 'package:get_pet/features/login/data/model/user_api_model.dart';
import 'package:get_pet/features/login/data/repository/user_repository.dart';

part 'pet_details_controller_state.dart';

final class PetDetailsController
    extends StateController<PetDetailsControllerState>
    with SequentialControllerHandler {
  final UserRepository _userRepository;

  PetDetailsController(
    this._userRepository, {
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
          setState(PetDetailsController$UserSuccess(user));
        }
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
