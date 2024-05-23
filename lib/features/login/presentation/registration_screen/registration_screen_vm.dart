import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_pet/app/navigation/app_route.dart';
import 'package:get_pet/app/service/logger/logger_service.dart';
import 'package:get_pet/features/login/data/model/user_api_model.dart';
import 'package:get_pet/features/login/domain/logic/user_controller.dart';
import 'package:get_pet/widgets/app_overlays.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class RegistrationScreenVm {
  final BuildContext _context;
  final UserApiModel _user;
  final UserController _userController;

  RegistrationScreenVm(
    this._context,
    this._user,
    this._userController,
  ) {
    _init();
  }

  final formKey = GlobalKey<FormState>();
  final userPhotoUrl = ValueNotifier<String?>(null);
  final imageLoading = ValueNotifier<bool>(false);
  final loading = ValueNotifier<bool>(false);

  String userName = '';
  String userSurname = '';
  String userTelephone = '';

  void _init() {
    _userController.addListener(_loginControllerListener);
    _initUserFields(_user);
  }

  void dispose() {
    _userController.removeListener(_loginControllerListener);
    _userController.dispose();
    userPhotoUrl.dispose();
    imageLoading.dispose();
    loading.dispose();
  }

  void _initUserFields(UserApiModel user) {
    userName = user.name;
    userSurname = user.surname;
    userTelephone = user.telephone;
    userPhotoUrl.value = user.photo;
  }

  Future<void> onAddPhoto() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      _userController.uploadImage(File(image.path));
    }
  }

  void onNameChanged(String value) {
    LoggerService().d('RegistrationScreenVm.onNameChanged(): "$value"');
    userName = value;
  }

  void onSurnameChanged(String value) {
    LoggerService().d('RegistrationScreenVm.onSurnameChanged(): "$value"');
    userSurname = value;
  }

  void onPhoneChanged(String value) {
    LoggerService().d('RegistrationScreenVm.onPhoneChanged(): "$value"');
    userTelephone = value;
  }

  void completeRegister() {
    LoggerService().d('RegistrationScreenVm.completeRegister()');
    if (formKey.currentState?.validate() != true) return;

    final user = UserApiModel(
      id: _user.id,
      name: userName,
      surname: userSurname,
      email: _user.email,
      telephone: userTelephone,
      photo: userPhotoUrl.value ?? '',
    );

    _userController.updateUser(user);
  }

  void _loginControllerListener() {
    final state = _userController.state;
    _handleUploadImage(state);
    _updateLoading(state);
    _handleUpdateUser(state);
    _handleError(state);
  }

  void _handleUploadImage(UserControllerState state) {
    switch (state) {
      case UserController$ImageLoading():
        imageLoading.value = true;
        break;
      case UserControllerS$ImageSuccess():
        userPhotoUrl.value = state.imageUrl;
        imageLoading.value = false;
        break;
      default:
        imageLoading.value = false;
        break;
    }
  }

  void _updateLoading(UserControllerState state) {
    loading.value = switch (state) {
      const UserController$Loading() => true,
      _ => false,
    };
  }

  void _handleUpdateUser(UserControllerState state) {
    switch (state) {
      case final UserController$UserUpdated _:
        _context.pushReplacementNamed(AppRoute.home.name);
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
}
