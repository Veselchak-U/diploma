import 'package:clipboard/clipboard.dart';
import 'package:flutter/material.dart';
import 'package:get_pet/features/home/domain/entity/pet_entity.dart';
import 'package:get_pet/features/home/domain/logic/pet_details_controller.dart';
import 'package:get_pet/features/login/data/model/user_api_model.dart';
import 'package:get_pet/widgets/app_overlays.dart';

class PetDetailsScreenVm {
  final BuildContext _context;
  final PetEntity _pet;
  final PetDetailsController _petDetailsController;

  PetDetailsScreenVm(
    this._context,
    this._pet,
    this._petDetailsController,
  ) {
    _init();
  }

  late final PetEntity pet;
  final user = ValueNotifier<UserApiModel?>(null);
  final loading = ValueNotifier<bool>(false);

  void _init() {
    pet = _pet;
    _petDetailsController.addListener(_petDetailsControllerListener);
    _getUser(_pet.userId);
  }

  void dispose() {
    _petDetailsController.removeListener(_petDetailsControllerListener);
    _petDetailsController.dispose();
    user.dispose();
    loading.dispose();
  }

  void _getUser(int? userId) {
    if (userId == null) {
      AppOverlays.showErrorBanner(
          msg: 'Пользователь, создавший анкету, не задан.');
      return;
    }

    _petDetailsController.getUser(userId);
  }

  void _petDetailsControllerListener() {
    _handleLoading(_petDetailsController.state);
    _handleUser(_petDetailsController.state);
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
        user.value = state.user;
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

  void copyPhone() {
    final phone = user.value?.telephone;
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
}
