import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_pet/app/l10n/l10n.dart';
import 'package:get_pet/app/style/app_text_styles.dart';
import 'package:get_pet/features/settings/presentation/settings_screen_vm.dart';
import 'package:get_pet/widgets/app_scaffold.dart';
import 'package:provider/provider.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<SettingsScreenVm>();

    return AppScaffold(
      title: l10n.settings,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(height: 16.r),
          _MenuItemButton(
            label: l10n.shareLogs,
            onTap: vm.shareLogs,
          ),
        ],
      ),
    );
  }
}

class _MenuItemButton extends StatelessWidget {
  final String label;
  final bool isDanger;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;

  const _MenuItemButton({
    required this.label,
    this.isDanger = false,
    this.onTap,
    this.onLongPress,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final labelColor = isDanger
        ? onTap == null
            ? theme.colorScheme.error.withOpacity(0.3)
            : theme.colorScheme.error
        : onTap == null
            ? theme.disabledColor
            : null;

    return InkWell(
      onTap: onTap,
      onLongPress: onLongPress,
      child: SizedBox(
        width: double.maxFinite,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 16.r, horizontal: 24.r),
          child: Text(
            label,
            style: AppTextStyles.s16w400.copyWith(
              color: labelColor,
            ),
          ),
        ),
      ),
    );
  }
}
