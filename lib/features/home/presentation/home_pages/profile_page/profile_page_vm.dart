import 'package:flutter/material.dart';
import 'package:get_pet/app/navigation/app_route.dart';
import 'package:get_pet/features/home/data/repository/pet_repository.dart';
import 'package:get_pet/features/home/domain/entity/pet_entity.dart';
import 'package:get_pet/features/home/domain/logic/pet_profile/pet_profile_controller.dart';
import 'package:get_pet/features/login/data/model/user_api_model.dart';
import 'package:get_pet/features/login/domain/logic/user_controller.dart';
import 'package:get_pet/widgets/app_overlays.dart';
import 'package:get_pet/widgets/bottom_sheets.dart';
import 'package:get_pet/widgets/loading_button.dart';
import 'package:go_router/go_router.dart';

class ProfilePageVm {
  final BuildContext _context;
  final UserController _userController;
  final PetProfileController _petProfileController;
  final PetRepository _petRepository;

  ProfilePageVm(
    this._context,
    this._userController,
    this._petProfileController,
    this._petRepository,
  ) {
    _init();
  }

  final loading = ValueNotifier<bool>(false);
  final user = ValueNotifier<UserApiModel?>(null);
  final myPetsLoading = ValueNotifier<bool>(false);
  final myPets = ValueNotifier<List<PetEntity>>([]);

  Future<void> _init() async {
    _userController.addListener(_userControllerListener);
    _userController.getUser();
    _petProfileController.addListener(_petProfileControllerListener);
    _petProfileController.getCurrentUserPets();
  }

  void dispose() {
    _userController.removeListener(_userControllerListener);
    _userController.dispose();
    _petProfileController.removeListener(_petProfileControllerListener);
    _petProfileController.dispose();
    loading.dispose();
    user.dispose();
    myPetsLoading.dispose();
    myPets.dispose();
  }

  Future<void> logout() async {
    final result = await BottomSheets.showConfirmationDialog(
      context: _context,
      title: 'Подтверждение',
      text: 'Вы действительно хотите выйти из системы?',
      confirmLabel: 'Выйти',
    );

    if (result != true) return;

    _userController.logout();
  }

  Future<void> deleteCurrentUser() async {
    final result = await BottomSheets.showConfirmationDialog(
      context: _context,
      title: 'Подтверждение',
      text: 'Внимание! Все связанные с вашим профилем данные будут '
          'безвозвратно удалены из системы. Вы действительно хотите удалить '
          'свой профиль?',
      confirmLabel: 'Да, удалить безвозвратно',
      confirmLabelType: LoadingButtonType.red,
    );

    if (result != true) return;

    _userController.deleteCurrentUser();
  }

  Future<void> deletePet(PetEntity pet) async {
    final result = await BottomSheets.showConfirmationDialog(
      context: _context,
      title: 'Подтверждение',
      text: 'Вы действительно хотите удалить объявление "${pet.title}"?',
      confirmLabel: 'Да, удалить',
    );

    if (result == true) {
      loading.value = true;
      await _petRepository.deletePet(pet);
      _petProfileController.getCurrentUserPets();
      loading.value = false;
    }
  }

  Future<void> refreshMyPets() {
    _petProfileController.getCurrentUserPets();

    return Future.value();
  }

  void openPetDetails(PetEntity pet) {
    GoRouter.of(_context).pushNamed(
      AppRoute.petDetails.name,
      extra: pet,
    );
  }

  void _userControllerListener() {
    final state = _userController.state;
    _handleLoading(state);
    _handleUserUpdate(state);
    _handleLogout(state);
    _handleDelete(state);
    _handleError(state);
  }

  void _handleLoading(UserControllerState state) {
    loading.value = switch (state) {
      const UserController$Loading() => true,
      _ => false,
    };
  }

  void _handleUserUpdate(UserControllerState state) {
    switch (state) {
      case UserController$UserUpdated():
        user.value = state.user;
        _petProfileController.getCurrentUserPets();
        break;
      default:
        break;
    }
  }

  void _handleLogout(UserControllerState state) {
    switch (state) {
      case UserController$LogoutSuccess():
        _context.pushReplacementNamed(
          AppRoute.login.name,
          extra: 'Пользователь вышел из системы',
        );
        break;
      default:
        break;
    }
  }

  void _handleDelete(UserControllerState state) {
    switch (state) {
      case UserController$DeleteSuccess():
        _context.pushReplacementNamed(
          AppRoute.login.name,
          extra: 'Пользователь был удалён',
        );
        break;
      default:
        break;
    }
  }

  void _handleError(UserControllerState state) {
    switch (state) {
      case UserController$Error():
        AppOverlays.showErrorBanner(msg: '${state.error}');
        break;
      default:
        break;
    }
  }

  void _petProfileControllerListener() {
    final state = _petProfileController.state;
    _handleUserPets(state);
    _handlePetsLoading(state);
    _handlePetsError(state);
  }

  void _handleUserPets(PetProfileControllerState state) {
    switch (state) {
      case PetProfileController$CurrentUserPetsSuccess():
        myPets.value = state.pets;
        break;
      default:
        break;
    }
  }

  void _handlePetsLoading(PetProfileControllerState state) {
    myPetsLoading.value = switch (state) {
      const PetProfileController$CurrentUserPetsLoading() => true,
      _ => false,
    };
  }

  void _handlePetsError(PetProfileControllerState state) {
    switch (state) {
      case PetProfileController$Error():
        AppOverlays.showErrorBanner(msg: '${state.error}');
        break;
      default:
        break;
    }
  }
}
