import 'package:flutter/material.dart';
import 'package:get_pet/features/login/data/model/user_api_model.dart';
import 'package:get_pet/features/login/domain/logic/user_controller.dart';
import 'package:get_pet/widgets/app_overlays.dart';

class ProfilePageVm {
  final BuildContext _context;
  final UserController _userController;

  ProfilePageVm(
    this._context,
    this._userController,
  ) {
    _init();
  }

  final loading = ValueNotifier<bool>(false);
  final user = ValueNotifier<UserApiModel?>(null);

  Future<void> _init() async {
    _userController.addListener(_userControllerListener);
    _userController.getUser();
  }

  void dispose() {
    _userController.removeListener(_userControllerListener);
    _userController.dispose();
    loading.dispose();
    user.dispose();
  }

  void logout() {}

  void _userControllerListener() {
    final state = _userController.state;
    _handleLoading(state);
    _handleUserUpdate(state);
    _handleError(state);
  }

  void _handleLoading(UserControllerState state) {
    loading.value = switch (state) {
      const UserController$Loading() => true,
      _ => false,
    };
  }

  void _handleUserUpdate(UserControllerState state) {
    switch (state) {
      case UserController$UserUpdated():
        user.value = state.user;
        break;
      default:
        break;
    }
  }

  void _handleError(UserControllerState state) {
    switch (state) {
      case UserController$Error():
        AppOverlays.showErrorBanner(msg: '${state.error}');
        break;
      default:
        break;
    }
  }
}
