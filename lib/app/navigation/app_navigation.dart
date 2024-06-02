import 'dart:async';

import 'package:flutter/widgets.dart';
import 'package:get_pet/app/di.dart';
import 'package:get_pet/app/navigation/app_route.dart';
import 'package:get_pet/app/navigation/navigation_error_screen.dart';
import 'package:get_pet/app/service/info/info_service.dart';
import 'package:get_pet/app/service/logger/logger_service.dart';
import 'package:get_pet/app/service/storage/local_storage.dart';
import 'package:get_pet/features/home/data/repository/pet_repository.dart';
import 'package:get_pet/features/home/domain/entity/pet_entity.dart';
import 'package:get_pet/features/home/domain/entity/question_entity.dart';
import 'package:get_pet/features/home/domain/logic/pet_common/pet_common_controller.dart';
import 'package:get_pet/features/home/domain/logic/pet_details/pet_details_controller.dart';
import 'package:get_pet/features/home/domain/logic/pet_profile/pet_profile_controller.dart';
import 'package:get_pet/features/home/domain/logic/support/support_controller.dart';
import 'package:get_pet/features/home/presentation/home_pages/profile_page/profile_page_vm.dart';
import 'package:get_pet/features/home/presentation/home_pages/support_page/support_page_vm.dart';
import 'package:get_pet/features/home/presentation/home_screen.dart';
import 'package:get_pet/features/home/presentation/home_screen_vm.dart';
import 'package:get_pet/features/home/presentation/pet_details/pet_details_screen.dart';
import 'package:get_pet/features/home/presentation/pet_details/pet_details_screen_vm.dart';
import 'package:get_pet/features/home/presentation/pet_profile/pet_profile_screen.dart';
import 'package:get_pet/features/home/presentation/pet_profile/pet_profile_screen_vm.dart';
import 'package:get_pet/features/home/presentation/question_add/question_add_screen.dart';
import 'package:get_pet/features/home/presentation/question_add/question_add_screen_vm.dart';
import 'package:get_pet/features/home/presentation/question_details/question_details_screen.dart';
import 'package:get_pet/features/initial/domain/logic/initial_controller.dart';
import 'package:get_pet/features/initial/presentation/initial_screen.dart';
import 'package:get_pet/features/initial/presentation/initial_screen_vm.dart';
import 'package:get_pet/features/login/data/model/user_api_model.dart';
import 'package:get_pet/features/login/domain/logic/user_controller.dart';
import 'package:get_pet/features/login/presentation/login_screen/login_screen.dart';
import 'package:get_pet/features/login/presentation/login_screen/login_screen_vm.dart';
import 'package:get_pet/features/login/presentation/registration_screen/registration_screen.dart';
import 'package:get_pet/features/login/presentation/registration_screen/registration_screen_vm.dart';
import 'package:get_pet/features/search/domain/logic/pet_search_controller.dart';
import 'package:get_pet/features/search/presentation/search_screen_vm.dart';
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
              DI.get<PetCommonController>(),
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
            DI.get<UserController>(),
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
        name: AppRoute.registration.name,
        path: AppRoute.registration.path,
        builder: (context, state) => Provider(
          lazy: false,
          create: (context) => RegistrationScreenVm(
            context,
            state.extra as UserApiModel,
            DI.get<UserController>(),
          ),
          dispose: (context, vm) => vm.dispose(),
          child: const RegistrationScreen(),
        ),
      ),
      GoRoute(
        name: AppRoute.home.name,
        path: AppRoute.home.path,
        builder: (context, state) {
          final searchScreenVm = SearchScreenVm(
            context,
            DI.get<PetSearchController>(),
          );

          final homeScreenVm = HomeScreenVm(
            context,
            DI.get<PetCommonController>(),
            DI.get<SupportController>(),
            searchScreenVm,
          );

          return MultiProvider(
            providers: [
              Provider.value(value: searchScreenVm),
              Provider.value(value: homeScreenVm),
              Provider(
                lazy: false,
                create: (context) => SupportPageVm(
                  context,
                  DI.get<SupportController>(),
                ),
                dispose: (context, vm) => vm.dispose(),
              ),
              Provider(
                lazy: false,
                create: (context) => ProfilePageVm(
                  context,
                  DI.get<UserController>(),
                  DI.get<PetProfileController>(),
                  DI.get<PetRepository>(),
                ),
                dispose: (context, vm) => vm.dispose(),
              ),
            ],
            child: const HomeScreen(),
          );
        },
        routes: [
          GoRoute(
            name: AppRoute.petProfile.name,
            path: AppRoute.petProfile.path,
            builder: (context, state) => Provider(
              lazy: false,
              create: (context) => PetProfileScreenVm(
                context,
                state.extra as PetEntity?,
                DI.get<PetProfileController>(),
                DI.get<PetCommonController>(),
              ),
              dispose: (context, vm) => vm.dispose(),
              child: const PetProfileScreen(),
            ),
          ),
          GoRoute(
            name: AppRoute.petDetails.name,
            path: AppRoute.petDetails.path,
            builder: (context, state) => Provider(
              lazy: false,
              create: (context) => PetDetailsScreenVm(
                context,
                state.extra as PetEntity,
                DI.get<PetDetailsController>(),
                DI.get<PetCommonController>(),
              ),
              dispose: (context, vm) => vm.dispose(),
              child: const PetDetailsScreen(),
            ),
          ),
          GoRoute(
            name: AppRoute.questionAdd.name,
            path: AppRoute.questionAdd.path,
            builder: (context, state) => Provider(
              lazy: false,
              create: (context) => QuestionAddScreenVm(
                context,
                DI.get<SupportController>(),
              ),
              dispose: (context, vm) => vm.dispose(),
              child: const QuestionAddScreen(),
            ),
          ),
          GoRoute(
            name: AppRoute.questionDetails.name,
            path: AppRoute.questionDetails.path,
            builder: (context, state) => QuestionDetailsScreen(
              state.extra as QuestionEntity,
            ),
          ),
        ],
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
