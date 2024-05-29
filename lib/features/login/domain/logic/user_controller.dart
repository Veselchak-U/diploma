import 'dart:async';
import 'dart:io';

import 'package:control/control.dart';
import 'package:get_pet/app/service/storage/remote_file_storage.dart';
import 'package:get_pet/features/login/data/model/user_api_model.dart';
import 'package:get_pet/features/login/data/repository/login_repository.dart';
import 'package:get_pet/features/login/data/repository/user_repository.dart';

part 'user_controller_state.dart';

final class UserController extends StateController<UserControllerState>
    with SequentialControllerHandler {
  final LoginRepository _loginRepository;
  final UserRepository _userRepository;
  final RemoteFileStorage _remoteFileStorage;

  UserController(
    this._loginRepository,
    this._userRepository,
    this._remoteFileStorage, {
    super.initialState = const UserController$Idle(),
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
        setState(const UserController$Loading());
        final user = await _loginRepository.loginByGoogle();
        setState(UserController$LoginSuccess(user));
      },
      _errorHandler,
      _doneHandler,
    );
  }

  void uploadImage(File file) {
    return handle(
      () async {
        setState(const UserController$ImageLoading());
        final imageUrl = await _remoteFileStorage.uploadUserImage(file);
        setState(UserControllerS$ImageSuccess(imageUrl));
      },
      _errorHandler,
      _doneHandler,
    );
  }

  void updateUser(UserApiModel user) {
    return handle(
      () async {
        setState(const UserController$Loading());
        await _userRepository.updateUser(user);
        setState(UserController$UserUpdated(user));
      },
      _errorHandler,
      _doneHandler,
    );
  }

  void getUser() {
    return handle(
      () async {
        setState(const UserController$Loading());
        final user = await _userRepository.getCurrentUser();
        setState(UserController$UserUpdated(user));
      },
      _errorHandler,
      _doneHandler,
    );
  }

  void logout() {
    return handle(
      () async {
        setState(const UserController$LogoutLoading());
        await _loginRepository.logout();
        setState(const UserController$LogoutSuccess());
      },
      _errorHandler,
      _doneHandler,
    );
  }

  void deleteCurrentUser() {
    return handle(
      () async {
        setState(const UserController$DeleteLoading());
        await _loginRepository.deleteCurrentUser();
        setState(const UserController$DeleteSuccess());
      },
      _errorHandler,
      _doneHandler,
    );
  }

  FutureOr<void> _errorHandler(Object e, StackTrace st) {
    setState(UserController$Error(e));
  }

  FutureOr<void> _doneHandler() {
    // Blocked to avoid blinking of loading on UI
    // setState(const LoginController$Idle());
  }
}
