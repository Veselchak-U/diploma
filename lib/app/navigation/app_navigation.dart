import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get_pet/app/di.dart';
import 'package:get_pet/app/navigation/app_route.dart';
import 'package:get_pet/app/navigation/navigation_error_screen.dart';
import 'package:get_pet/app/service/info/info_service.dart';
import 'package:get_pet/app/service/logger/logger_service.dart';
import 'package:get_pet/app/service/storage/local_storage.dart';
import 'package:get_pet/features/home/presentation/home_screen.dart';
import 'package:get_pet/features/home/presentation/home_screen_vm.dart';
import 'package:get_pet/features/initial/domain/logic/initial_controller.dart';
import 'package:get_pet/features/initial/presentation/initial_screen.dart';
import 'package:get_pet/features/initial/presentation/initial_screen_vm.dart';
import 'package:get_pet/features/login/domain/logic/login_controller.dart';
import 'package:get_pet/features/login/presentation/login_screen.dart';
import 'package:get_pet/features/login/presentation/login_screen_vm.dart';
import 'package:get_pet/features/settings/presentation/settings_screen.dart';
import 'package:get_pet/features/settings/presentation/settings_screen_vm.dart';
import 'package:get_pet/widgets/app_drawer.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

class AppNavigation {
  static final _unauthorizedLocations = [
    AppRoute.initial.path,
    AppRoute.login.path,
    AppRoute.settings.path,
  ];

  static late final GlobalKey<NavigatorState> _rootNavigatorKey;
  static late final LocalStorage _localStorage;

  static Future<bool> get _isUnauthorizedUser =>
      _localStorage.getUserId().then((value) => value == null);

  static void init({
    required GlobalKey<NavigatorState> navigatorKey,
    required LocalStorage localStorage,
  }) {
    _rootNavigatorKey = navigatorKey;
    _localStorage = localStorage;
  }

  static void goToScreen({required String name, String? reason}) {
    final context = _rootNavigatorKey.currentContext;
    if (context != null) {
      LoggerService().d('AppNavigation.goToScreen($name)');
      context.pushReplacementNamed(name, extra: reason);
    } else {
      LoggerService()
          .d('AppNavigation.goToScreen($name) cancelled - context == null');
    }
  }

  static void goLoginScreen([String? logoutReason]) {
    final context = _rootNavigatorKey.currentContext;
    if (context != null) {
      LoggerService().d('AppNavigation.goLoginScreen()');
      context.goNamed(AppRoute.login.name, extra: logoutReason);
    } else {
      LoggerService().d('AppNavigation.goLoginScreen(), context == null');
    }
  }

  static GoRouter router = GoRouter(
    navigatorKey: _rootNavigatorKey,
    debugLogDiagnostics: true,
    initialLocation: AppRoute.initial.path,
    redirect: _redirect,
    errorBuilder: (context, state) {
      LoggerService().e('AppNavigation',
          error: state.error, stackTrace: StackTrace.current);
      return NavigationErrorScreen(state.error);
    },
    routes: <RouteBase>[
      GoRoute(
        name: AppRoute.initial.name,
        path: AppRoute.initial.path,
        pageBuilder: (context, state) => NoTransitionPage(
          child: Provider(
            lazy: false,
            create: (context) => InitialScreenVm(
              context,
              DI.get<InitialController>(),
            ),
            dispose: (context, vm) => vm.dispose(),
            child: const InitialScreen(),
          ),
        ),
      ),
      GoRoute(
        name: AppRoute.login.name,
        path: AppRoute.login.path,
        builder: (context, state) => Provider(
          lazy: false,
          create: (context) => LoginScreenVm(
            context,
            DI.get<LoginController>(),
            DI.get<InfoService>(),
            logoutReason: state.extra as String?,
          ),
          dispose: (context, vm) => vm.dispose(),
          child: LoginScreen(
            drawer: AppDrawer(
              getPackageInfo: DI.get<InfoService>().getPackageInfo(),
            ),
          ),
        ),
      ),
      GoRoute(
        name: AppRoute.home.name,
        path: AppRoute.home.path,
        builder: (context, state) => Provider(
          lazy: false,
          create: (context) => HomeScreenVm(),
          dispose: (context, vm) => vm.dispose(),
          child: const HomeScreen(),
        ),
      ),
      GoRoute(
        name: AppRoute.settings.name,
        path: AppRoute.settings.path,
        builder: (context, state) => Provider(
          lazy: false,
          create: (context) => SettingsScreenVm(),
          dispose: (context, vm) => vm.dispose(),
          child: const SettingsScreen(),
        ),
      ),
    ],
  );

  static FutureOr<String?> _redirect(
    BuildContext context,
    GoRouterState state,
  ) async {
    LoggerService().d('AppNavigation navigate to "${state.uri.toString()}"');
    if (await _isUnauthorizedUser) {
      final currentLocation = state.uri.toString();
      if (!_unauthorizedLocations.contains(currentLocation)) {
        LoggerService().d('AppNavigation._redirect("${AppRoute.login.path}")');
        return AppRoute.login.path;
      }
    }
    return null;
  }
}
