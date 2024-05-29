import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_pet/app/style/app_text_styles.dart';
import 'package:get_pet/features/home/domain/entity/pet_entity.dart';
import 'package:get_pet/widgets/loading_indicator.dart';

class PetCard extends StatelessWidget {
  final VoidCallback openPetDetails;
  final VoidCallback deletePet;

  final PetEntity pet;

  const PetCard(
    this.pet, {
    required this.openPetDetails,
    required this.deletePet,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return InkWell(
      borderRadius: BorderRadius.circular(16).r,
      onTap: openPetDetails,
      onLongPress: deletePet,
      child: DecoratedBox(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(16).r,
          border: Border.all(color: theme.disabledColor),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Hero(
                tag: pet.id ?? -1,
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
