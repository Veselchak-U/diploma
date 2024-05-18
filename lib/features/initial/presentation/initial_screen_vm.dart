import 'package:flutter/material.dart';
import 'package:get_pet/app/l10n/l10n.dart';
import 'package:get_pet/app/navigation/app_route.dart';
import 'package:get_pet/app/service/logger/logger_service.dart';
import 'package:get_pet/features/initial/domain/logic/initial_controller.dart';
import 'package:go_router/go_router.dart';

typedef NextScreen = ({String name, String reason});

class InitialScreenVm {
  final BuildContext _context;
  final InitialController _initialController;

  InitialScreenVm(
    this._context,
    this._initialController,
  ) {
    _init();
  }

  void _init() {
    _initialController.addListener(_initialControllerListener);
    _initialController.initialChecking();
  }

  void dispose() {
    _initialController.removeListener(_initialControllerListener);
    _initialController.dispose();
  }

  void _initialControllerListener() {
    _handleState(_initialController.state);
  }

  void _handleState(InitialControllerState state) {
    final NextScreen? nextScreen = switch (state) {
      InitialController$Unauthorized() => (
          name: AppRoute.login.name,
          reason: state.reason,
        ),
      InitialController$UserIncomplete() => (
          name: AppRoute.registration.name,
          reason: '',
        ),
      const InitialController$Success() => (
          name: AppRoute.home.name,
          reason: '',
        ),
      InitialController$Error() => (
          name: AppRoute.login.name,
          reason: '${l10n.initError}: ${state.error}',
        ),
      _ => null,
    };

    if (nextScreen == null) return;

    LoggerService().d(
        'InitialScreenVm: nextScreen="${nextScreen.name}", reason=${nextScreen.reason}');
    _context.pushReplacementNamed(nextScreen.name, extra: nextScreen.reason);
  }
}
