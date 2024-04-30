import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_pet/app/style/app_text_styles.dart';
import 'package:get_pet/features/home/data/model/category_api_model.dart';
import 'package:get_pet/features/home/presentation/home_screen_vm.dart';
import 'package:provider/provider.dart';

class HomePageCategories extends StatelessWidget {
  const HomePageCategories({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<HomeScreenVm>();

    return ValueListenableBuilder(
      valueListenable: vm.categories,
      builder: (context, categories, _) {
        return SizedBox(
          height: 56.r,
          child: ListView.separated(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsets.symmetric(horizontal: 16).r,
            itemCount: categories.length,
            itemBuilder: (context, index) => _CategoryItem(categories[index]),
            separatorBuilder: (context, _) => SizedBox(width: 16.r),
          ),
        );
      },
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final CategoryApiModel category;

  const _CategoryItem(this.category, {super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final screenWidth = MediaQuery.sizeOf(context).width;

    return SizedBox(
      width: screenWidth / 2,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16).r,
          border: Border.all(color: theme.disabledColor),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 24).r,
          child: Row(
            children: [
              SizedBox(width: 32.r, height: 32.r, child: const Placeholder()),
              SizedBox(width: 16.r),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(category.name, style: AppTextStyles.s13w600),
                  Text('Всего ${category.count}', style: AppTextStyles.s11w400),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
