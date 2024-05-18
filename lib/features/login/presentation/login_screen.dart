import 'package:flutter/material.dart';
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
  @override
  Widget build(BuildContext context) {
    final vm = context.read<LoginScreenVm>();
    final theme = Theme.of(context);

    return AppScaffold(
      body: Center(
        child: LoadingButton(
          label: 'Вход через Google',
          onPressed: vm.loginByGoogle,
        ),
      ),
    );

    // return SignInScreen(
    //   providers: [
    //     GoogleProvider(
    //       clientId:
    //           '201697189483-i3a16rfjv3d0pbjbei3b46k3fu9svuia.apps.googleusercontent.com',
    //     ),
    //   ],
    //   actions: [
    //     EmailLinkSignInAction((context) {
    //       debugPrint('!!! EmailLinkSignInAction');
    //     }),
    //     VerifyPhoneAction((context, action) {
    //       debugPrint('!!! VerifyPhoneAction: $action');
    //     }),
    //     ForgotPasswordAction((context, email) {
    //       debugPrint('!!! AuthStateChangeAction: $email');
    //     }),
    //     AuthStateChangeAction<SignedIn>((context, state) {
    //       debugPrint('!!! AuthStateChangeAction: $state');
    //     }),
    //   ],
    // );
  }
}
