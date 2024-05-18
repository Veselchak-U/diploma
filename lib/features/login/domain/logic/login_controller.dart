import 'dart:async';

import 'package:control/control.dart';
import 'package:get_pet/app/service/logger/exception/logic_exception.dart';
import 'package:get_pet/app/service/storage/local_storage.dart';
import 'package:get_pet/features/login/data/model/user_api_model.dart';
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

  void loginByGoogle() {
    return handle(
      () async {
        setState(const LoginController$Loading());

        final user = await _loginRepository.loginByGoogle();
        if (user == null) {
          throw const LogicException('Пользователь не найден в БД');
        }

        final userId = user.id;
        if (userId == null) {
          throw const LogicException('У пользователя не задан id');
        }
        await _localStorage.setUserId(userId);

        setState(LoginController$Success(user));
      },
      _errorHandler,
      _doneHandler,
    );
  }

  // void loginByPhone(String phone) {
  //   return handle(
  //     () async {
  //       setState(const LoginController$Loading());
  //
  //       final user = await _loginRepository.loginByPhone(phone);
  //       await _localStorage.setUserId(user?.id);
  //
  //       setState(const LoginController$Success());
  //     },
  //     _errorHandler,
  //     _doneHandler,
  //   );
  // }

  FutureOr<void> _errorHandler(Object e, StackTrace st) {
    setState(LoginController$Error(e));
  }

  FutureOr<void> _doneHandler() {
    // Blocked to avoid blinking of loading on UI
    // setState(const LoginController$Idle());
  }
}
