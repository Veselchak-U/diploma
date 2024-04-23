import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_pet/app/l10n/l10n.dart';
import 'package:get_pet/app/style/app_text_styles.dart';
import 'package:get_pet/widgets/loading_button.dart';
import 'package:go_router/go_router.dart';

class BottomSheets {
  static Future<bool?> showConfirmationDialog({
    required BuildContext context,
    required String title,
    required String text,
    String? confirmLabel,
    LoadingButtonType confirmLabelType = LoadingButtonType.primary,
    bool showCancelButton = true,
    String? cancelLabel,
    LoadingButtonType cancelLabelType = LoadingButtonType.transparent,
    bool? isDismissible,
  }) async {
    final result = await showBottomSheet<bool>(
      context: context,
      isDismissible: isDismissible,
      title: title,
      description: text,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LoadingButton(
              label: confirmLabel ?? 'OK',
              type: confirmLabelType,
              onPressed: () => GoRouter.of(context).pop(true),
            ),
            Visibility(
              visible: showCancelButton,
              child: Padding(
                padding: EdgeInsets.only(top: 10.r),
                child: LoadingButton(
                  label: cancelLabel ?? l10n.cancel,
                  type: cancelLabelType,
                  onPressed: () => GoRouter.of(context).pop(false),
                ),
              ),
            ),
          ],
        ),
      ),
    );
    return result;
  }

  static Future<void> showInformationDialog({
    required BuildContext context,
    required String title,
    required String text,
    String? confirmLabel,
  }) async {
    await showBottomSheet(
      context: context,
      title: title,
      description: text,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 20.r),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            LoadingButton(
              label: confirmLabel ?? 'OK',
              type: LoadingButtonType.primary,
              onPressed: () => GoRouter.of(context).pop(),
            ),
          ],
        ),
      ),
    );
  }

  static Future<T?> showBottomSheet<T>({
    required BuildContext context,
    String? title,
    String? description,
    required Widget body,
    bool? isDismissible,
  }) {
    final theme = Theme.of(context);

    return showModalBottomSheet<T>(
      context: context,
      isScrollControlled: true,
      isDismissible: isDismissible ?? true,
      enableDrag: isDismissible ?? true,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(
          top: Radius.circular(20.r),
        ),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.symmetric(vertical: 10).r,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                width: 45.r,
                height: 5.r,
                decoration: BoxDecoration(
                  color: theme.dividerColor,
                  borderRadius: BorderRadius.circular(5.r),
                ),
              ),
              title != null
                  ? Padding(
                      padding: EdgeInsets.all(20.r),
                      child: Text(
                        title,
                        style: AppTextStyles.s16w500,
                        textAlign: TextAlign.center,
                      ),
                    )
                  : SizedBox(height: 10.r),
              Visibility(
                visible: description?.isNotEmpty == true,
                child: Padding(
                  padding: EdgeInsets.fromLTRB(20.r, 0, 20.r, 40.r),
                  child: Text(
                    description ?? '',
                    style: AppTextStyles.s16w400,
                    textAlign: TextAlign.center,
                  ),
                ),
              ),
              SafeArea(
                child: body,
              ),
            ],
          ),
        );
      },
    );
  }
}
