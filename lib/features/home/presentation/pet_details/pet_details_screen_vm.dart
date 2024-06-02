import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get_pet/app/navigation/app_route.dart';
import 'package:get_pet/features/home/domain/entity/pet_entity.dart';
import 'package:get_pet/features/home/domain/logic/pet_common/pet_common_controller.dart';
import 'package:get_pet/features/home/domain/logic/pet_details/pet_details_controller.dart';
import 'package:get_pet/features/login/data/model/user_api_model.dart';
import 'package:get_pet/widgets/app_overlays.dart';
import 'package:get_pet/widgets/bottom_sheets.dart';
import 'package:get_pet/widgets/loading_button.dart';
import 'package:go_router/go_router.dart';

typedef UserDetails = ({UserApiModel? user, bool isMyPet});

class PetDetailsScreenVm {
  final BuildContext _context;
  final PetEntity _pet;
  final PetDetailsController _petDetailsController;
  final PetCommonController _petCommonController;

  PetDetailsScreenVm(
    this._context,
    this._pet,
    this._petDetailsController,
    this._petCommonController,
  ) {
    _init();
  }

  late final PetEntity pet;
  final userDetails = ValueNotifier<UserDetails>((user: null, isMyPet: false));
  final loading = ValueNotifier<bool>(false);

  void _init() {
    pet = _pet;
    _petDetailsController.addListener(_petDetailsControllerListener);
    _getUser(_pet.userId);
  }

  void dispose() {
    _petDetailsController.removeListener(_petDetailsControllerListener);
    _petDetailsController.dispose();
    userDetails.dispose();
    loading.dispose();
  }

  void onEditPet() {
    GoRouter.of(_context).pushNamed(AppRoute.petProfile.name, extra: pet);
  }

  Future<void> onDeletePet() async {
    final result = await BottomSheets.showConfirmationDialog(
      context: _context,
      title: 'Подтверждение',
      text: 'Вы действительно хотите удалить объявление "${pet.title}"?',
      confirmLabel: 'Да, удалить',
      confirmLabelType: LoadingButtonType.danger,
    );

    if (result == true) {
      _petDetailsController.deletePet(pet);
    }
  }

  void copyPhone() {
    final phone = userDetails.value.user?.telephone;
    if (phone == null) {
      AppOverlays.showErrorBanner(
        msg: 'Телефон пользователя не задан',
        isError: false,
      );
      return;
    }

    FlutterClipboard.copy(phone).then((_) {
      AppOverlays.showErrorBanner(
        msg: 'Телефон $phone скопирован',
        isError: false,
      );
    });
  }

  void _getUser(int? userId) {
    if (userId == null) {
      AppOverlays.showErrorBanner(
          msg: 'Пользователь, создавший объявление, не задан.');
      return;
    }

    _petDetailsController.getUser(userId);
  }

  void _petDetailsControllerListener() {
    _handleLoading(_petDetailsController.state);
    _handleUser(_petDetailsController.state);
    _handleDeletePet(_petDetailsController.state);
    _handleError(_petDetailsController.state);
  }

  void _handleLoading(PetDetailsControllerState state) {
    switch (state) {
      case PetDetailsController$Loading():
        loading.value = true;
        break;
      default:
        loading.value = false;
        break;
    }
  }

  void _handleUser(PetDetailsControllerState state) {
    switch (state) {
      case PetDetailsController$UserSuccess():
        userDetails.value = (user: state.user, isMyPet: state.isMyPet);
        break;
      default:
        break;
    }
  }

  void _handleDeletePet(PetDetailsControllerState state) {
    switch (state) {
      case PetDetailsController$DeletePetSuccess():
        _petCommonController.getNewPets();

        GoRouter.of(_context).pop();
        break;
      default:
        break;
    }
  }

  void _handleError(PetDetailsControllerState state) {
    switch (state) {
      case PetDetailsController$Error():
        AppOverlays.showErrorBanner(msg: '${state.error}');
        break;
      default:
        break;
    }
  }
}
