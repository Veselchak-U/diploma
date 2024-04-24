import 'dart:async';

import 'package:control/control.dart';
import 'package:get_pet/app/service/storage/local_storage.dart';

part 'initial_controller_state.dart';

final class InitialController extends StateController<InitialControllerState>
    with SequentialControllerHandler {
  final LocalStorage _localStorage;

  InitialController(
    this._localStorage, {
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
