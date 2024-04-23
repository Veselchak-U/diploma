import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_pet/app/l10n/l10n.dart';
import 'package:get_pet/app/navigation/app_route.dart';
import 'package:get_pet/app/style/app_text_styles.dart';
import 'package:go_router/go_router.dart';
import 'package:open_settings_plus/open_settings_plus.dart';

class AppDrawer extends StatelessWidget {
  final Future<String> getPackageInfo;

  const AppDrawer({
    required this.getPackageInfo,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: const EdgeInsets.only(top: 32).r,
              child: _MenuItemButton(
                l10n.settings,
                icon: const Icon(Icons.settings),
                onTap: () => _openSettingsScreen(context),
              ),
            ),
            Visibility(
              visible: Platform.isAndroid,
              child: _MenuItemButton(
                l10n.androidSettings,
                icon: const Icon(Icons.android),
                onTap: () => _openAppSettings(),
              ),
            ),
            const Spacer(),
            FutureBuilder(
              future: getPackageInfo,
              builder: (context, snapshot) {
                if (snapshot.data == null) return const SizedBox.shrink();

                return Padding(
                  padding: const EdgeInsets.only(bottom: 24).r,
                  child: _MenuItemButton(
                    snapshot.data ?? '',
                    textColor: theme.colorScheme.onSurface.withOpacity(0.5),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }

  void _openSettingsScreen(BuildContext context) {
    GoRouter.of(context).pushNamed(AppRoute.settings.name);
    Scaffold.of(context).closeDrawer();
  }

  void _openAppSettings() {
    switch (OpenSettingsPlus.shared) {
      case OpenSettingsPlusAndroid android:
        android.applicationDetails();
        break;
      case OpenSettingsPlusIOS ios:
        ios.appSettings();
        break;
    }
  }
}

class _MenuItemButton extends StatelessWidget {
  final String text;
  final VoidCallback? onTap;
  final Color? textColor;
  final Widget? icon;

  const _MenuItemButton(
    this.text, {
    this.onTap,
    this.textColor,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        height: 56.r,
        child: Padding(
          padding: EdgeInsets.symmetric(horizontal: 24.r),
          child: Row(
            children: [
              if (icon != null)
                Padding(
                  padding: const EdgeInsets.only(right: 8).r,
                  child: icon,
                ),
              Expanded(
                child: Text(
                  text,
                  style: AppTextStyles.s16w400.copyWith(
                    color: textColor,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
