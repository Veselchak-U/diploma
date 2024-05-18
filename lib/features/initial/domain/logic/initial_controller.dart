import 'dart:async';

import 'package:control/control.dart';
import 'package:get_pet/app/service/storage/local_storage.dart';
import 'package:get_pet/features/login/data/repository/user_repository.dart';

part 'initial_controller_state.dart';

final class InitialController extends StateController<InitialControllerState>
    with SequentialControllerHandler {
  final LocalStorage _localStorage;
  final UserRepository _userRepository;

  InitialController(
    this._localStorage,
    this._userRepository, {
    super.initialState = const InitialController$Idle(),
  }) {
    _init();
  }

  void _init() {}

  @override
  void dispose() {
    super.dispose();
  }

  void initialChecking() {
    return handle(
      () async {
        // Check if token exist
        final userId = await _localStorage.getUserId();
        if (userId == null) {
          setState(const InitialController$Unauthorized(''));
          return;
        }

        // Check if user incomplete
        final user = await _userRepository.getUserById(userId);
        if (user == null) {
          setState(InitialController$Unauthorized(
            'Пользователь с id: $userId не найден в БД',
          ));
          return;
        }
        if (!user.isComplete) {
          setState(const InitialController$UserIncomplete());
          return;
        }

        setState(const InitialController$Success());
      },
      _errorHandler,
      _doneHandler,
    );
  }

  FutureOr<void> _errorHandler(Object e, StackTrace st) {
    setState(InitialController$Error(e));
  }

  FutureOr<void> _doneHandler() {
    setState(const InitialController$Idle());
  }
}
