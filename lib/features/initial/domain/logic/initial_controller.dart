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
        final token = await _localStorage.getUserId();
        if (token == null) {
          setState(const InitialController$Unauthorized(''));
          return;
        }
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
