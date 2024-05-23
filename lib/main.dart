import 'dart:async';
import 'dart:io';

import 'package:control/control.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get_pet/app/app.dart';
import 'package:get_pet/app/di.dart';
import 'package:get_pet/app/navigation/app_navigation.dart';
import 'package:get_pet/app/service/info/info_service.dart';
import 'package:get_pet/app/service/lifecycle/lifecycle_controller.dart';
import 'package:get_pet/app/service/logger/logger_service.dart';
import 'package:get_pet/app/service/logger/observer/state_controller_observer.dart';
import 'package:get_pet/app/service/storage/local_storage.dart';
import 'package:get_pet/app/style/app_theme.dart';
import 'package:get_pet/config.dart';
import 'package:get_pet/firebase_options.dart';
import 'package:window_manager/window_manager.dart';
import 'package:windows_single_instance/windows_single_instance.dart';

void main() {
  runZoned(
    () => runZonedGuarded(
      _initializeApp,
      (error, stackTrace) {
        LoggerService()
            .e('main.runZonedGuarded()', error: error, stackTrace: stackTrace);
      },
    ),
  );
}

Future<void> _initializeApp() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  FlutterError.onError = (details) {
    LoggerService().e('FlutterError.onError()',
        error: details.exception,
        stackTrace: details.stack ?? StackTrace.current);
    FlutterError.presentError(details);
  };

  PlatformDispatcher.instance.onError = (error, stackTrace) {
    LoggerService().e('PlatformDispatcher.onError()',
        error: error, stackTrace: stackTrace);
    return true;
  };

  await SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await SystemChrome.setEnabledSystemUIMode(
    SystemUiMode.edgeToEdge,
  );
  SystemChrome.setSystemUIOverlayStyle(
    AppTheme.systemOverlayStyleLight,
  );

  await DI().init();

  final localStorage = DI.get<LocalStorage>();
  await localStorage.checkFirstRun();

  await Config.init();
  final infoService = DI.get<InfoService>();
  await LoggerService.init(infoService.getAppInfo(), toFile: true);

  final rootNavigatorKey = GlobalKey<NavigatorState>(debugLabel: 'root');
  AppNavigation.init(
    navigatorKey: rootNavigatorKey,
    localStorage: localStorage,
  );

  Controller.observer = StateControllerObserver();

  if (Platform.isWindows) {
    await WindowsSingleInstance.ensureSingleInstance([], "instance_checker");

    await windowManager.ensureInitialized();
    const windowOptions = WindowOptions(
      minimumSize: Size(375, 712),
      maximumSize: Size(375, 712),
      center: true,
    );
    windowManager.waitUntilReadyToShow(windowOptions, () async {
      await windowManager.show();
      await windowManager.focus();
    });
  }

  runApp(App(
    DI.get<LifecycleController>(),
  ));
}
