import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_pet/features/home/presentation/home_pages/home_page/widgets/pet_card.dart';
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
                  (index) {
                    final pet = newPets[index];

                    return PetCard(
                      pet,
                      openPetDetails: () => vm.openPetDetails(pet),
                    );
                  },
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
