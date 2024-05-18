import 'package:flutter/material.dart';
import 'package:get_pet/app/navigation/app_route.dart';
import 'package:get_pet/app/service/info/info_service.dart';
import 'package:get_pet/features/login/domain/logic/login_controller.dart';
import 'package:get_pet/widgets/app_overlays.dart';
import 'package:go_router/go_router.dart';

class LoginScreenVm {
  final BuildContext _context;
  final LoginController _loginController;
  final InfoService _infoService;

  final String? logoutReason;

  LoginScreenVm(
    this._context,
    this._loginController,
    this._infoService, {
    this.logoutReason,
  }) {
    _init();
  }

  final loading = ValueNotifier<bool>(false);
  final appVersion = ValueNotifier<String>('');
  final isPhoneComplete = ValueNotifier<bool>(false);

  void _init() {
    _loginController.addListener(_loginControllerListener);
    _getAppVersion();
    _showLogoutReason();
  }

  void dispose() {
    _loginController.removeListener(_loginControllerListener);
    _loginController.dispose();
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
    _loginController.loginByGoogle();
  }

  void _loginControllerListener() {
    _updateLoading(_loginController.state);
    _handleSuccess(_loginController.state);
    _handleError(_loginController.state);
  }

  void _updateLoading(LoginControllerState state) {
    loading.value = switch (state) {
      const LoginController$Loading() => true,
      _ => false,
    };
  }

  void _handleSuccess(LoginControllerState state) {
    switch (state) {
      case final LoginController$LoginSuccess state:
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

  void _handleError(LoginControllerState state) {
    switch (state) {
      case LoginController$Error():
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
      duration: const Duration(seconds: 10),
    );
  }
}
