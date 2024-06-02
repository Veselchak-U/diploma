import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_pet/app/assets/assets.gen.dart';
import 'package:get_pet/app/l10n/l10n.dart';
import 'package:get_pet/app/style/app_colors.dart';
import 'package:get_pet/app/style/app_text_styles.dart';
import 'package:get_pet/features/home/presentation/home_pages/home_page/home_page.dart';
import 'package:get_pet/features/home/presentation/home_pages/profile_page/profile_page.dart';
import 'package:get_pet/features/home/presentation/home_pages/support_page/support_page.dart';
import 'package:get_pet/features/home/presentation/home_screen_vm.dart';
import 'package:get_pet/features/search/presentation/search_screen.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const _pages = <Widget>[
    HomePage(),
    SearchScreen(),
    SupportPage(),
    ProfilePage(),
  ];

  @override
  Widget build(BuildContext context) {
    final vm = context.read<HomeScreenVm>();
    final theme = Theme.of(context);
    final selectedColor = theme.colorScheme.secondary;
    final selectedColorFilter = ColorFilter.mode(
      selectedColor,
      BlendMode.srcIn,
    );

    return ValueListenableBuilder(
      valueListenable: vm.pageIndex,
      builder: (context, pageIndex, _) {
        return Scaffold(
          body: SafeArea(
            child: PageView(
              controller: vm.pageController,
              physics: const NeverScrollableScrollPhysics(),
              children: _pages,
            ),
          ),
          bottomNavigationBar: BottomNavigationBar(
            unselectedItemColor: AppColors.onBackgroundLight,
            showUnselectedLabels: true,
            items: [
              BottomNavigationBarItem(
                icon: Assets.icons.iconHome40.svg(
                  colorFilter: pageIndex == 0 ? selectedColorFilter : null,
                ),
                label: l10n.home,
              ),
              BottomNavigationBarItem(
                icon: Assets.icons.iconSearch40.svg(
                  colorFilter: pageIndex == 1 ? selectedColorFilter : null,
                ),
                label: l10n.search,
              ),
              BottomNavigationBarItem(
                icon: ValueListenableBuilder(
                  valueListenable: vm.unreadNotificationCount,
                  builder: (context, unreadNotificationCount, child) {
                    return Stack(
                      alignment: Alignment.topRight,
                      children: [
                        child ?? const SizedBox.shrink(),
                        unreadNotificationCount == 0
                            ? const SizedBox.shrink()
                            : Container(
                                decoration: const BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: AppColors.errorLight,
                                ),
                                padding: const EdgeInsets.all(4).r,
                                child: Text(
                                  '$unreadNotificationCount',
                                  style: AppTextStyles.s11w600.copyWith(
                                    color: AppColors.white,
                                  ),
                                ),
                              ),
                      ],
                    );
                  },
                  child: Assets.icons.iconSupport40.svg(
                    colorFilter: pageIndex == 2 ? selectedColorFilter : null,
                  ),
                ),
                label: l10n.support,
              ),
              BottomNavigationBarItem(
                icon: Assets.icons.iconUser40.svg(
                  colorFilter: pageIndex == 3 ? selectedColorFilter : null,
                ),
                label: l10n.profile,
              ),
            ],
            currentIndex: pageIndex,
            selectedItemColor: selectedColor,
            onTap: vm.onPageSelected,
          ),
        );
      },
    );
  }
}
