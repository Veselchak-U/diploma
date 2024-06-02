import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_pet/app/style/app_colors.dart';
import 'package:get_pet/app/style/app_text_styles.dart';
import 'package:get_pet/features/home/presentation/pet_details/pet_details_screen_vm.dart';
import 'package:get_pet/features/login/data/model/user_api_model.dart';
import 'package:get_pet/widgets/app_scaffold.dart';
import 'package:get_pet/widgets/loading_button.dart';
import 'package:get_pet/widgets/loading_indicator.dart';
import 'package:get_pet/widgets/user_avatar.dart';
import 'package:provider/provider.dart';

class PetDetailsScreen extends StatelessWidget {
  const PetDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<PetDetailsScreenVm>();
    final theme = Theme.of(context);
    final screenSize = MediaQuery.of(context).size;

    return AppScaffold(
      title: 'Просмотр объявления',
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Expanded(
                child: Hero(
                  tag: vm.pet.photoUrl,
                  child: CachedNetworkImage(
                    imageUrl: vm.pet.photoUrl,
                    fit: BoxFit.cover,
                    placeholder: (_, __) => const LoadingIndicator(),
                    errorWidget: (_, __, ___) => const Icon(Icons.error),
                  ),
                ),
              ),
              SizedBox(height: screenSize.height * 0.18),
            ],
          ),
          DraggableScrollableSheet(
            initialChildSize: 0.25,
            maxChildSize: 0.75,
            snap: true,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: theme.scaffoldBackgroundColor,
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(20.r),
                  ),
                ),
                // padding: const EdgeInsets.all(16).r,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Container(
                      width: 45.r,
                      height: 5.r,
                      margin: const EdgeInsets.only(top: 16).r,
                      decoration: BoxDecoration(
                        color: AppColors.gray2Light,
                        borderRadius: BorderRadius.circular(5.r),
                      ),
                    ),
                    Expanded(
                      child: SingleChildScrollView(
                        controller: scrollController,
                        child: Padding(
                          padding: const EdgeInsets.all(16).r,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              SizedBox(height: 16.r),
                              Text(vm.pet.title, style: AppTextStyles.s20w600),
                              SizedBox(height: 8.r),
                              Text(
                                vm.pet.location,
                                style: AppTextStyles.s13w400.copyWith(
                                  color: AppColors.grayLight,
                                ),
                              ),
                              SizedBox(height: 24.r),
                              Wrap(
                                spacing: 8.r,
                                runSpacing: 8.r,
                                children: [
                                  _PetDetailPiece(
                                    text: vm.pet.category.name,
                                    label: 'Категория',
                                  ),
                                  _PetDetailPiece(
                                    text: vm.pet.color,
                                    label: 'Окрас',
                                  ),
                                  _PetDetailPiece(
                                    text: vm.pet.age,
                                    label: 'Возраст',
                                  ),
                                  _PetDetailPiece(
                                    text: vm.pet.weight,
                                    label: 'Вес',
                                  ),
                                  _PetDetailPiece(
                                    text: '${vm.pet.type}',
                                    label: 'Тип приёма',
                                  ),
                                  _PetDetailPiece(
                                    text: vm.pet.breed,
                                    label: 'Порода',
                                  ),
                                ],
                              ),
                              SizedBox(height: 16.r),
                              Text('Описание', style: AppTextStyles.s15w600),
                              SizedBox(height: 10.r),
                              Text(vm.pet.description,
                                  style: AppTextStyles.s15w400),
                              SizedBox(height: 24.r),
                              ValueListenableBuilder(
                                valueListenable: vm.userDetails,
                                builder: (context, userDetails, _) {
                                  return ValueListenableBuilder(
                                    valueListenable: vm.loading,
                                    builder: (context, loading, _) {
                                      final isMyPet = userDetails.isMyPet;

                                      return loading
                                          ? const LoadingIndicator()
                                          : isMyPet
                                              ? const _ControlButtons()
                                              : _UserDetails(userDetails.user);
                                    },
                                  );
                                },
                              ),
                              SizedBox(height: 24.r),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ); // const Placeholder();
            },
          ),
        ],
      ),
    );
  }
}

class _PetDetailPiece extends StatelessWidget {
  final String text;
  final String label;

  const _PetDetailPiece({
    required this.text,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: AppColors.gray2Light),
        borderRadius: BorderRadius.all(Radius.circular(16.r)),
      ),
      padding: const EdgeInsets.all(16).r,
      child: Column(
        children: [
          Text(text, style: AppTextStyles.s13w600),
          Text(label, style: AppTextStyles.s11w400),
        ],
      ),
    );
  }
}

class _ControlButtons extends StatelessWidget {
  const _ControlButtons({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<PetDetailsScreenVm>();

    return Row(
      children: [
        Expanded(
          child: LoadingButton(
            label: 'Редактировать',
            onPressed: vm.onEditPet,
          ),
        ),
        SizedBox(width: 8.r),
        Expanded(
          child: LoadingButton(
            label: 'Удалить',
            type: LoadingButtonType.red,
            onPressed: vm.onDeletePet,
          ),
        ),
      ],
    );
  }
}

class _UserDetails extends StatefulWidget {
  final UserApiModel? user;

  const _UserDetails(this.user);

  @override
  State<_UserDetails> createState() => _UserDetailsState();
}

class _UserDetailsState extends State<_UserDetails> {
  final _phoneOpened = ValueNotifier<bool>(false);

  @override
  void dispose() {
    _phoneOpened.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final user = widget.user;
    if (user == null) return const SizedBox.shrink();

    final vm = context.read<PetDetailsScreenVm>();

    return Row(
      children: [
        UserAvatar(user.photo),
        SizedBox(width: 8.r),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Опубликовано',
                style: AppTextStyles.s9w600,
              ),
              Text(
                '${widget.user?.name ?? ""} ${widget.user?.surname ?? ""}',
                style: AppTextStyles.s11w400,
              ),
            ],
          ),
        ),
        SizedBox(width: 8.r),
        ValueListenableBuilder(
          valueListenable: _phoneOpened,
          builder: (context, phoneOpened, _) {
            return phoneOpened
                ? Material(
                    borderRadius: BorderRadius.all(Radius.circular(16.r)),
                    child: InkWell(
                      borderRadius: BorderRadius.all(Radius.circular(16.r)),
                      onTap: vm.copyPhone,
                      child: Padding(
                        padding: const EdgeInsets.all(8).r,
                        child: Row(
                          children: [
                            Text(
                              widget.user?.telephone ?? "",
                              style: AppTextStyles.s13w400,
                            ),
                            SizedBox(width: 4.r),
                            Icon(Icons.copy, size: 18.r),
                          ],
                        ),
                      ),
                    ),
                  )
                : SizedBox(
                    width: 150.r,
                    child: LoadingButton(
                      label: 'Связаться',
                      onPressed: _openPhone,
                    ),
                  );
          },
        ),
      ],
    );
  }

  void _openPhone() {
    _phoneOpened.value = true;
  }
}
