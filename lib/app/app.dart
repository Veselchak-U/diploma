import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_pet/app/l10n/app_localizations.dart';
import 'package:get_pet/app/l10n/l10n.dart';
import 'package:get_pet/app/navigation/app_navigation.dart';
import 'package:get_pet/app/service/lifecycle/lifecycle_controller.dart';
import 'package:get_pet/app/style/app_theme.dart';
import 'package:get_pet/widgets/app_overlays.dart';

class App extends StatefulWidget {
  final LifecycleController _lifecycleController;

  const App(
    this._lifecycleController, {
    super.key,
  });

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> with WidgetsBindingObserver {
  final _scaffoldMessengerKey = GlobalKey<ScaffoldMessengerState>();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    widget._lifecycleController.onStateChanged(state);
  }

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(375, 712),
      builder: (context, child) {
        final theme = AppTheme.light;

        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          scaffoldMessengerKey: _scaffoldMessengerKey,
          localizationsDelegates: AppLocalizations.localizationsDelegates,
          supportedLocales: AppLocalizations.supportedLocales,
          theme: theme,
          routerConfig: AppNavigation.router,
          builder: (context, child) {
            L10n.init(context);
            AppOverlays.init(
              scaffoldMessengerKey: _scaffoldMessengerKey,
              theme: theme,
            );

            return MediaQuery(
              data: MediaQuery.of(context).copyWith(
                textScaler: TextScaler.noScaling,
              ),
              child: child ?? const SizedBox.shrink(),
            );
          },
        );
      },
    );
  }
}
