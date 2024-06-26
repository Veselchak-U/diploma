import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_pet/app/assets/assets.gen.dart';
import 'package:get_pet/features/login/presentation/login_screen/login_screen_vm.dart';
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
  @override
  Widget build(BuildContext context) {
    final vm = context.read<LoginScreenVm>();

    return AppScaffold(
      title: 'Авторизация',
      body: Center(
        child: ValueListenableBuilder(
          valueListenable: vm.loading,
          builder: (context, loading, _) {
            return Padding(
              padding: const EdgeInsets.all(24).r,
              child: LoadingButton(
                label: 'Вход через Google',
                icon: Assets.icons.iconGoogle48.svg(
                  width: 48.r,
                  height: 48.r,
                ),
                type: LoadingButtonType.transparent,
                loading: loading,
                onPressed: vm.loginByGoogle,
              ),
            );
          },
        ),
      ),
    );
  }
}
