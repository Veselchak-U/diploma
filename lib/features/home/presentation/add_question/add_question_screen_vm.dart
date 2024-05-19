import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_pet/app/service/logger/logger_service.dart';
import 'package:get_pet/features/home/domain/logic/pet_profile/pet_profile_controller.dart';
import 'package:get_pet/features/home/domain/logic/support/support_controller.dart';
import 'package:get_pet/widgets/app_overlays.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class AddQuestionScreenVm {
  final BuildContext _context;
  final SupportController _supportController;

  AddQuestionScreenVm(
    this._context,
    this._supportController,
  ) {
    _init();
  }

  final questionPhotoUrl = ValueNotifier<String?>(null);
  final loading = ValueNotifier<bool>(true);
  final imageLoading = ValueNotifier<bool>(false);
  final formKey = GlobalKey<FormState>();

  String questionTitle = '';
  String questionDescription = '';

  Future<void> _init() async {
    _supportController.addListener(_supportControllerListener);
  }

  void dispose() {
    _supportController.removeListener(_supportControllerListener);
    questionPhotoUrl.dispose();
    loading.dispose();
    imageLoading.dispose();
  }

  void onTitleChanged(String value) {
    LoggerService().d('PetProfileScreenVm.onTitleChanged(): "$value"');
    questionTitle = value;
  }

  void onDescriptionChanged(String value) {
    LoggerService().d('PetProfileScreenVm.onDescriptionChanged(): "$value"');
    questionDescription = value;
  }

  Future<void> onAddQuestion() async {
    if (formKey.currentState?.validate() != true) return;
  }

  Future<void> onAddPhoto() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      _supportController.uploadImage(File(image.path));
    }
  }

  void _supportControllerListener() {
    final state = _supportController.state;
    _handleLoading(state);
    _handleCategories(state);
    _handleUploadImage(state);
    _handleAddOrUpdateSuccess(state);
    _handleError(state);
  }

  void _handleLoading(PetProfileControllerState state) {
    switch (state) {
      case PetProfileController$Loading():
        loading.value = true;
        break;
      default:
        loading.value = false;
        break;
    }
  }

  void _handleCategories(PetProfileControllerState state) {
    switch (state) {
      case PetProfileController$CategoriesSuccess():
        categories.value = state.categories;
        break;
      default:
        break;
    }
  }

  void _handleUploadImage(PetProfileControllerState state) {
    switch (state) {
      case PetProfileController$ImageLoading():
        imageLoading.value = true;
        break;
      case PetProfileController$ImageSuccess():
        petPhotoUrl.value = state.imageUrl;
        imageLoading.value = false;
        break;
      default:
        imageLoading.value = false;
        break;
    }
  }

  void _handleAddOrUpdateSuccess(PetProfileControllerState state) {
    switch (state) {
      case PetProfileController$AddSuccess():
        AppOverlays.showErrorBanner(msg: 'Анкета добавлена!', isError: false);
        GoRouter.of(_context).pop();
        break;
      case PetProfileController$UpdateSuccess():
        AppOverlays.showErrorBanner(msg: 'Анкета изменена!', isError: false);
        GoRouter.of(_context).pop();
        break;
      default:
        break;
    }
  }

  void _handleError(PetProfileControllerState state) {
    switch (state) {
      case PetProfileController$Error():
        AppOverlays.showErrorBanner(msg: '${state.error}');
        break;
      default:
        break;
    }
  }
}
