import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_pet/app/assets/assets.gen.dart';
import 'package:get_pet/app/l10n/l10n.dart';
import 'package:get_pet/app/style/app_text_styles.dart';
import 'package:get_pet/features/home/presentation/home_screen_vm.dart';
import 'package:provider/provider.dart';

class HomePageHead extends StatelessWidget {
  const HomePageHead({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<HomeScreenVm>();
    final theme = Theme.of(context);

    return Padding(
      padding: const EdgeInsets.all(16).r,
      child: Column(
        children: [
          Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Expanded(
                child: Text.rich(
                  TextSpan(
                    children: [
                      TextSpan(
                        text: l10n.findCouple,
                        style: AppTextStyles.s13w600,
                      ),
                      TextSpan(
                        text: ' ${l10n.forYourPet}',
                        style: AppTextStyles.s13w400,
                      ),
                    ],
                  ),
                ), // Text(l10n.findCouple),
              ),
              SizedBox(
                width: 120.w,
                child: ElevatedButton(
                  onPressed: vm.addPet,
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Assets.icons.iconPaw.svg(),
                      SizedBox(width: 4.w),
                      Text(
                        l10n.orAdd,
                        style: AppTextStyles.s13w400,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
          SizedBox(height: 22.h),
          Material(
            color: theme.disabledColor,
            borderRadius: BorderRadius.circular(16.r),
            child: InkWell(
              borderRadius: BorderRadius.circular(16.r),
              onTap: vm.search,
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 24, vertical: 8).r,
                child: Row(
                  children: [
                    Assets.icons.iconSearch40.svg(width: 24.r, height: 24.r),
                    SizedBox(width: 8.w),
                    Text(
                      l10n.search,
                      style: AppTextStyles.s12w400,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
