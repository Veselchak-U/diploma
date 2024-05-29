import 'package:flutter/material.dart';
import 'package:get_pet/app/navigation/app_route.dart';
import 'package:get_pet/app/service/info/info_service.dart';
import 'package:get_pet/features/login/domain/logic/user_controller.dart';
import 'package:get_pet/widgets/app_overlays.dart';
import 'package:go_router/go_router.dart';

class LoginScreenVm {
  final BuildContext _context;
  final UserController _userController;
  final InfoService _infoService;

  final String? logoutReason;

  LoginScreenVm(
    this._context,
    this._userController,
    this._infoService, {
    this.logoutReason,
  }) {
    _init();
  }

  final loading = ValueNotifier<bool>(false);
  final appVersion = ValueNotifier<String>('');
  final isPhoneComplete = ValueNotifier<bool>(false);

  void _init() {
    _userController.addListener(_loginControllerListener);
    _getAppVersion();
    _showLogoutReason();
  }

  void dispose() {
    _userController.removeListener(_loginControllerListener);
    _userController.dispose();
    loading.dispose();
    appVersion.dispose();
    isPhoneComplete.dispose();
  }

  void onPhoneChanged(String phone) {
    final phoneComplete = phone.length == 12;
    if (isPhoneComplete.value == phoneComplete) return;

    isPhoneComplete.value = phoneComplete;
  }

  Future<void> loginByGoogle() async {
    _userController.loginByGoogle();
  }

  void _loginControllerListener() {
    _updateLoading(_userController.state);
    _handleSuccess(_userController.state);
    _handleError(_userController.state);
  }

  void _updateLoading(UserControllerState state) {
    loading.value = switch (state) {
      const UserController$Loading() => true,
      _ => false,
    };
  }

  void _handleSuccess(UserControllerState state) {
    switch (state) {
      case final UserController$LoginSuccess state:
        if (state.user.isComplete) {
          _context.pushReplacementNamed(AppRoute.home.name);
        } else {
          _context.pushReplacementNamed(
            AppRoute.registration.name,
            extra: state.user,
          );
        }
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

  Future<void> _getAppVersion() async {
    appVersion.value = await _infoService.getPackageInfo();
  }

  void _showLogoutReason() {
    if (logoutReason == null || logoutReason?.isEmpty == true) return;

    AppOverlays.showErrorBanner(
      msg: logoutReason ?? '',
      duration: const Duration(seconds: 5),
    );
  }
}
