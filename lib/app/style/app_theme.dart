import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_pet/app/style/app_colors.dart';
import 'package:get_pet/app/style/app_text_styles.dart';

class AppTheme {
  static final light = ThemeData(
    brightness: Brightness.light,
    colorScheme: const ColorScheme(
      brightness: Brightness.light,
      primary: AppColors.primaryLight,
      onPrimary: AppColors.white,
      secondary: AppColors.secondaryLight,
      onSecondary: AppColors.white,
      error: AppColors.errorLight,
      onError: AppColors.white,
      background: AppColors.backgroundLight,
      onBackground: AppColors.onBackgroundLight,
      surface: AppColors.backgroundLight,
      onSurface: AppColors.onBackgroundLight,
    ),
    disabledColor: AppColors.disabledLight,
    elevatedButtonTheme: _elevatedButtonThemeLight,
    textButtonTheme: _textButtonThemeLight,
    bottomSheetTheme: _bottomSheetThemeLight,
    sliderTheme: _sliderThemeLight,
  );

  static final dark = ThemeData(
    brightness: Brightness.dark,
    colorScheme: const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xff8ecff2),
      onPrimary: Color(0xff003548),
      secondary: Color(0xffb5c9d7),
      onSecondary: Color(0xff1f333d),
      error: Color(0xffffb4ab),
      onError: Color(0xff690005),
      background: Color(0xff0f1417),
      onBackground: Color(0xffdfe3e7),
      surface: Color(0xff0f1417),
      onSurface: Color(0xffdfe3e7),
    ),
  );

  static final _elevatedButtonThemeLight = ElevatedButtonThemeData(
    style: ButtonStyle(
      // fixedSize: MaterialStateProperty.all(
      //   Size(double.maxFinite, 56.r),
      // ),
      padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 8).h,
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(const Radius.circular(16).r),
        ),
      ),
      textStyle: MaterialStateProperty.all(
        AppTextStyles.s16w500,
      ),
      backgroundColor: MaterialStateProperty.resolveWith(
        (states) => states.contains(MaterialState.disabled)
            ? AppColors.disabledLight
            : AppColors.primaryLight,
      ),
      foregroundColor: MaterialStateProperty.all(
        AppColors.white,
      ),
    ),
  );

  static final _textButtonThemeLight = TextButtonThemeData(
    style: ButtonStyle(
      fixedSize: MaterialStateProperty.all(
        Size(double.maxFinite, 56.r),
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.all(const Radius.circular(16).r),
        ),
      ),
      textStyle: MaterialStateProperty.all(
        AppTextStyles.s16w500,
      ),
      backgroundColor: MaterialStateProperty.resolveWith(
        (states) => states.contains(MaterialState.disabled)
            ? AppColors.disabledLight
            : Colors.transparent,
      ),
      foregroundColor: MaterialStateProperty.all(
        AppColors.primaryLight,
      ),
    ),
  );

  static const _bottomSheetThemeLight = BottomSheetThemeData(
    backgroundColor: AppColors.white,
  );

  static const _sliderThemeLight = SliderThemeData(
    inactiveTrackColor: AppColors.inactiveSliderLight,
  );
}
