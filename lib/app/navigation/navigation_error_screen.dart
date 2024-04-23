import 'package:flutter/material.dart';
import 'package:get_pet/app/l10n/l10n.dart';
import 'package:get_pet/app/navigation/app_route.dart';
import 'package:get_pet/widgets/app_scaffold.dart';
import 'package:go_router/go_router.dart';

class NavigationErrorScreen extends StatelessWidget {
  final Exception? error;

  const NavigationErrorScreen(this.error, {super.key});

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: l10n.pageNotFound,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SelectableText(error?.toString() ?? l10n.pageNotFound),
            const SizedBox(height: 32),
            ElevatedButton(
              onPressed: () => context.goNamed(AppRoute.initial.name),
              child: Text(l10n.toInitialScreen),
            ),
          ],
        ),
      ),
    );
  }
}
