import 'dart:async';

import 'package:control/control.dart';
import 'package:get_pet/app/service/storage/local_storage.dart';
import 'package:get_pet/features/login/data/repository/login_repository.dart';

part 'login_controller_state.dart';

final class LoginController extends StateController<LoginControllerState>
    with SequentialControllerHandler {
  final LoginRepository _loginRepository;
  final LocalStorage _localStorage;

  LoginController(
    this._loginRepository,
    this._localStorage, {
    super.initialState = const LoginController$Idle(),
  }) {
    _init();
  }

  void _init() {}

  @override
  void dispose() {
    super.dispose();
  }

  void login() {
    return handle(
      () async {
        setState(const LoginController$Loading());

        final model = await _loginRepository.login();
        await _localStorage.setUserId(model?.userId);
      },
      _errorHandler,
      _doneHandler,
    );
  }

  FutureOr<void> _errorHandler(Object e, StackTrace st) {
    setState(LoginController$Error(e));
  }

  FutureOr<void> _doneHandler() {
    // Blocked to avoid blinking of loading on UI
    // setState(const LoginController$Idle());
  }
}
