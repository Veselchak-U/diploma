import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_pet/app/style/app_text_styles.dart';
import 'package:get_pet/features/home/domain/entity/pet_entity.dart';
import 'package:get_pet/features/home/presentation/home_screen_vm.dart';
import 'package:get_pet/widgets/loading_indicator.dart';
import 'package:provider/provider.dart';

class HomePageAnimals extends StatelessWidget {
  const HomePageAnimals({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<HomeScreenVm>();

    return Stack(
      alignment: Alignment.center,
      children: [
        ValueListenableBuilder(
          valueListenable: vm.newPets,
          builder: (context, newPets, _) {
            return RefreshIndicator(
              onRefresh: vm.updateNewPets,
              child: GridView.count(
                padding: const EdgeInsets.all(16).r,
                crossAxisCount: 2,
                childAspectRatio: 0.695,
                mainAxisSpacing: 16.r,
                crossAxisSpacing: 16.r,
                children: List.generate(
                  newPets.length,
                  (index) => _PetItem(newPets[index]),
                ),
              ),
            );
          },
        ),
        ValueListenableBuilder(
          valueListenable: vm.loading,
          builder: (context, loading, _) {
            return Visibility(
              visible: loading,
              child: const LoadingIndicator(),
            );
          },
        ),
      ],
    );
  }
}

class _PetItem extends StatelessWidget {
  final PetEntity pet;

  const _PetItem(this.pet, {super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<HomeScreenVm>();
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(16).r,
      onLongPress: () => vm.deletePet(pet),
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16).r,
          border: Border.all(color: theme.disabledColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: CachedNetworkImage(
                imageUrl: pet.photoUrl,
                imageBuilder: (context, imageProvider) {
                  return Container(
                    width: double.maxFinite,
                    height: double.maxFinite,
                    foregroundDecoration: BoxDecoration(
                      borderRadius: BorderRadius.vertical(
                        top: const Radius.circular(16).r,
                      ),
                      image: DecorationImage(
                        image: imageProvider,
                        fit: BoxFit.cover,
                      ),
                    ),
                  );
                },
                placeholder: (_, __) => const LoadingIndicator(),
                errorWidget: (_, __, ___) => const Icon(Icons.error),
              ),
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(8).r,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(pet.category.name),
                    Text(pet.title, style: AppTextStyles.s13w600),
                    Text(pet.location, style: AppTextStyles.s11w400),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
