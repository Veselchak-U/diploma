import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_pet/app/l10n/l10n.dart';
import 'package:get_pet/features/login/presentation/login_screen_vm.dart';
import 'package:get_pet/widgets/app_scaffold.dart';
import 'package:get_pet/widgets/loading_button.dart';
import 'package:provider/provider.dart';

class LoginScreen extends StatefulWidget {
  final Widget drawer;

  const LoginScreen({
    required this.drawer,
    super.key,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  static const _appBarHeight = 56.0;

  @override
  Widget build(BuildContext context) {
    final vm = context.read<LoginScreenVm>();
    final theme = Theme.of(context);

    return KeyboardDismissOnTap(
      child: AppScaffold(
        drawer: widget.drawer,
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 24).r,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              const Spacer(),
              Text(
                l10n.enterActivationCode,
                style: theme.textTheme.headlineSmall,
                textAlign: TextAlign.center,
              ),
              const Spacer(),
              ValueListenableBuilder(
                valueListenable: vm.loading,
                builder: (context, loading, _) {
                  return LoadingButton(
                    label: l10n.activateDevice,
                    loading: loading,
                    onPressed: vm.login,
                  );
                },
              ),
              const Spacer(),
              KeyboardVisibilityBuilder(
                builder: (context, isKeyboardVisible) {
                  return isKeyboardVisible
                      ? const SizedBox.shrink()
                      : ValueListenableBuilder(
                          valueListenable: vm.appVersion,
                          builder: (context, appVersion, _) {
                            return Padding(
                              padding: EdgeInsets.only(
                                top: _appBarHeight,
                                bottom: 24.r,
                              ),
                              child: Text(
                                appVersion,
                                style: theme.textTheme.bodySmall,
                              ),
                            );
                          },
                        );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
