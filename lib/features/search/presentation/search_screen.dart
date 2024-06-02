import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_pet/app/style/app_text_styles.dart';
import 'package:get_pet/features/home/data/model/category_api_model.dart';
import 'package:get_pet/features/home/domain/entity/pet_type.dart';
import 'package:get_pet/features/home/presentation/home_pages/home_page/widgets/pet_card.dart';
import 'package:get_pet/features/search/presentation/search_screen_vm.dart';
import 'package:get_pet/widgets/app_scaffold.dart';
import 'package:get_pet/widgets/loading_indicator.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen>
    with AutomaticKeepAliveClientMixin {
  late final SearchScreenVm vm;

  @override
  bool get wantKeepAlive => true;

  @override
  void initState() {
    super.initState();
    vm = context.read<SearchScreenVm>();
  }

  @override
  void dispose() {
    vm.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    super.build(context);

    return AppScaffold(
      title: 'Поиск объявлений',
      body: ValueListenableBuilder(
        valueListenable: vm.loading,
        builder: (context, loading, _) {
          return ValueListenableBuilder(
            valueListenable: vm.foundedPets,
            builder: (context, foundedPets, _) {
              return Stack(
                children: [
                  CustomScrollView(
                    slivers: [
                      SliverToBoxAdapter(
                        child: ValueListenableBuilder(
                          valueListenable: vm.categories,
                          builder: (context, categories, _) {
                            return ValueListenableBuilder(
                              valueListenable: vm.selectedCategories,
                              builder: (context, selectedCategories, _) {
                                return _SearchChipsSection<CategoryApiModel>(
                                  title: 'Категория',
                                  items: categories,
                                  selected: selectedCategories,
                                  onTap: vm.onTapCategory,
                                );
                              },
                            );
                          },
                        ),
                      ),
                      SliverToBoxAdapter(
                        child: ValueListenableBuilder(
                          valueListenable: vm.selectedTypes,
                          builder: (context, selectedTypes, _) {
                            return _SearchChipsSection<PetType>(
                              title: 'Тип приёма',
                              items: PetType.values,
                              selected: selectedTypes,
                              onTap: vm.onTapPetType,
                            );
                          },
                        ),
                      ),
                      const SliverToBoxAdapter(
                        child: _SearchTextSection(),
                      ),
                      SliverPadding(
                        padding: const EdgeInsets.all(16).r,
                        sliver: SliverGrid.count(
                          crossAxisCount: 2,
                          childAspectRatio: 0.695,
                          mainAxisSpacing: 16.r,
                          crossAxisSpacing: 16.r,
                          children: List.generate(
                            foundedPets.length,
                            (index) {
                              final pet = foundedPets[index];

                              return PetCard(
                                pet,
                                openPetDetails: () => vm.openPetDetails(pet),
                              );
                            },
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (loading) const LoadingIndicator(),
                ],
              );
            },
          );
        },
      ),
    );
  }
}

class _SearchChipsSection<T> extends StatelessWidget {
  final String title;
  final List<T> items;
  final List<T> selected;
  final Function(T) onTap;

  const _SearchChipsSection({
    required this.title,
    required this.items,
    required this.selected,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    if (items.isEmpty) return const SizedBox.shrink();

    final theme = Theme.of(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16).r,
          child: Text(
            title,
            style: AppTextStyles.s13w600,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16).r,
          child: Wrap(
            spacing: 8.r,
            children: List.generate(
              items.length,
              (index) {
                final item = items[index];

                return FilterChip(
                  label: Text('$item'),
                  labelStyle: AppTextStyles.s13w400,
                  side: BorderSide.none,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(14.r),
                  ),
                  elevation: 2.0,
                  selectedColor: theme.colorScheme.primary,
                  backgroundColor: theme.disabledColor,
                  selected: selected.contains(item),
                  onSelected: (_) => onTap(item),
                );
              },
            ),
          ),
        ),
      ],
    );
  }
}

class _SearchTextSection extends StatelessWidget {
  const _SearchTextSection();

  @override
  Widget build(BuildContext context) {
    final vm = context.read<SearchScreenVm>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16).r,
          child: Text(
            'Ключевые слова',
            style: AppTextStyles.s13w600,
          ),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16).r,
          child: TextFormField(
            focusNode: vm.searchFieldFocusNode,
            controller: vm.searchFieldController,
            textInputAction: TextInputAction.search,
            onChanged: vm.onSearchTextChanged,
            onTapOutside: (_) {
              FocusManager.instance.primaryFocus?.unfocus();
            },
          ),
        ),
      ],
    );
  }
}
