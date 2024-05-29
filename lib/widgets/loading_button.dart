import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_pet/app/style/app_colors.dart';
import 'package:get_pet/app/style/app_text_styles.dart';
import 'package:get_pet/widgets/loading_indicator.dart';

enum LoadingButtonType { primary, transparent, red }

class LoadingButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final bool loading;
  final LoadingButtonType type;
  final Widget? icon;

  const LoadingButton({
    required this.label,
    required this.onPressed,
    this.loading = false,
    this.type = LoadingButtonType.primary,
    this.icon,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final button = switch (type) {
      LoadingButtonType.primary => ElevatedButton(
          onPressed: loading ? null : onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8).r,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon != null ? icon! : const SizedBox.shrink(),
                icon != null ? SizedBox(width: 8.r) : const SizedBox.shrink(),
                Text(label, style: AppTextStyles.s15w500),
              ],
            ),
          ),
        ),
      LoadingButtonType.transparent => TextButton(
          onPressed: loading ? null : onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8).r,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon != null ? icon! : const SizedBox.shrink(),
                icon != null ? SizedBox(width: 8.r) : const SizedBox.shrink(),
                Text(label, style: AppTextStyles.s15w500),
              ],
            ),
          ),
        ),
      LoadingButtonType.red => TextButton(
          onPressed: loading ? null : onPressed,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 8).r,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon != null ? icon! : const SizedBox.shrink(),
                icon != null ? SizedBox(width: 8.r) : const SizedBox.shrink(),
                Text(label,
                    style: AppTextStyles.s15w500.copyWith(
                      color: AppColors.errorLight,
                    )),
              ],
            ),
          ),
        ),
    };

    return Stack(
      alignment: Alignment.center,
      children: [
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 600),
          child: button,
        ),
        loading ? const LoadingIndicator() : const SizedBox.shrink(),
      ],
    );
  }
}
