import 'package:flutter/material.dart';
import 'package:get_pet/app/l10n/l10n.dart';
import 'package:get_pet/app/navigation/app_route.dart';
import 'package:get_pet/app/service/logger/logger_service.dart';
import 'package:get_pet/features/home/domain/logic/pet_common/pet_common_controller.dart';
import 'package:get_pet/features/initial/domain/logic/initial_controller.dart';
import 'package:get_pet/widgets/app_overlays.dart';
import 'package:go_router/go_router.dart';

typedef NextScreen = ({String name, String reason});

class InitialScreenVm {
  final BuildContext _context;
  final InitialController _initialController;
  final PetCommonController _petCommonController;

  InitialScreenVm(
    this._context,
    this._initialController,
    this._petCommonController,
  ) {
    _init();
  }

  void _init() {
    _initialController.addListener(_initialControllerListener);
    _initialController.initialChecking();
    _petCommonController.addListener(_petCommonControllerListener);
  }

  void dispose() {
    _initialController.removeListener(_initialControllerListener);
    _initialController.dispose();
  }

  void _initialControllerListener() {
    final state = _initialController.state;
    _handleState(state);
    _handleSuccess(state);
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

  void _handleSuccess(InitialControllerState state) {
    switch (state) {
      case const InitialController$Success():
        _petCommonController.getCategories();
        break;
      default:
        break;
    }
  }

  void _petCommonControllerListener() {
    final state = _petCommonController.state;
    switch (state) {
      case PetCommonController$CategoriesUpdated():
        _petCommonController.removeListener(_petCommonControllerListener);
        _context.pushReplacementNamed(AppRoute.home.name);
        break;
      case PetCommonController$Error():
        AppOverlays.showErrorBanner(msg: '${state.error}');
        break;
      default:
        break;
    }
  }
}
