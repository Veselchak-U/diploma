import 'package:flutter/material.dart';
import 'package:get_pet/app/assets/assets.gen.dart';
import 'package:get_pet/app/l10n/l10n.dart';
import 'package:get_pet/features/home/presentation/add_page/add_page.dart';
import 'package:get_pet/features/home/presentation/home_page/home_page.dart';
import 'package:get_pet/features/home/presentation/profile_page/profile_page.dart';
import 'package:get_pet/features/home/presentation/search_page/search_page.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  static const _pages = <Widget>[
    HomePage(),
    SearchPage(),
    AddPage(),
    ProfilePage(),
  ];

  int _pageIndex = 0;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final selectedColor = theme.colorScheme.secondary;
    final selectedColorFilter = ColorFilter.mode(
      selectedColor,
      BlendMode.srcIn,
    );

    return Scaffold(
      body: SafeArea(
        child: _pages[_pageIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: [
          BottomNavigationBarItem(
            icon: Assets.icons.iconHome40.svg(
              colorFilter: _pageIndex == 0 ? selectedColorFilter : null,
            ),
            label: l10n.home,
          ),
          BottomNavigationBarItem(
            icon: Assets.icons.iconSearch40.svg(
              colorFilter: _pageIndex == 1 ? selectedColorFilter : null,
            ),
            label: l10n.search,
          ),
          BottomNavigationBarItem(
            icon: Assets.icons.iconAdd40.svg(
              colorFilter: _pageIndex == 2 ? selectedColorFilter : null,
            ),
            label: l10n.add,
          ),
          BottomNavigationBarItem(
            icon: Assets.icons.iconUser40.svg(
              colorFilter: _pageIndex == 3 ? selectedColorFilter : null,
            ),
            label: l10n.profile,
          ),
        ],
        currentIndex: _pageIndex,
        selectedItemColor: selectedColor,
        onTap: _onPageSelected,
      ),
    );
  }

  void _onPageSelected(int value) {
    setState(() {
      _pageIndex = value;
    });
  }
}
