import 'package:flutter/material.dart';
import 'package:get_pet/app/navigation/app_route.dart';
import 'package:get_pet/features/login/data/model/user_api_model.dart';
import 'package:get_pet/features/login/domain/logic/user_controller.dart';
import 'package:get_pet/widgets/app_overlays.dart';
import 'package:get_pet/widgets/bottom_sheets.dart';
import 'package:get_pet/widgets/loading_button.dart';
import 'package:go_router/go_router.dart';

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

  Future<void> logout() async {
    final result = await BottomSheets.showConfirmationDialog(
      context: _context,
      title: 'Подтверждение',
      text: 'Вы действительно хотите выйти из системы?',
      confirmLabel: 'Выйти',
    );

    if (result != true) return;

    _userController.logout();
  }

  Future<void> deleteCurrentUser() async {
    final result = await BottomSheets.showConfirmationDialog(
      context: _context,
      title: 'Подтверждение',
      text: 'Внимание! Все связанные с вашим профилем данные будут '
          'безвозвратно удалены из системы. Вы действительно хотите удалить '
          'свой профиль?',
      confirmLabel: 'Да, удалить безвозвратно',
      confirmLabelType: LoadingButtonType.red,
    );

    if (result != true) return;

    _userController.deleteCurrentUser();
  }

  void _userControllerListener() {
    final state = _userController.state;
    _handleLoading(state);
    _handleUserUpdate(state);
    _handleLogout(state);
    _handleDelete(state);
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

  void _handleLogout(UserControllerState state) {
    switch (state) {
      case UserController$LogoutSuccess():
        _context.pushReplacementNamed(
          AppRoute.login.name,
          extra: 'Пользователь вышел из системы',
        );
        break;
      default:
        break;
    }
  }

  void _handleDelete(UserControllerState state) {
    switch (state) {
      case UserController$DeleteSuccess():
        _context.pushReplacementNamed(
          AppRoute.login.name,
          extra: 'Пользователь был удалён',
        );
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
