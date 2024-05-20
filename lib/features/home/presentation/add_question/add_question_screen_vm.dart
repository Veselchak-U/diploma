import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_pet/app/service/logger/logger_service.dart';
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

  final questionImageUrl = ValueNotifier<String?>(null);
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
    questionImageUrl.dispose();
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

  Future<void> onAddPhoto() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      _supportController.uploadImage(File(image.path));
    }
  }

  Future<void> onAddQuestion() async {
    if (formKey.currentState?.validate() != true) return;

    _supportController.addQuestion(
      title: questionTitle,
      description: questionDescription,
      imageUrl: questionImageUrl.value,
    );
  }

  void _supportControllerListener() {
    final state = _supportController.state;
    _handleLoading(state);
    _handleUploadImage(state);
    _handleAddSuccess(state);
    _handleError(state);
  }

  void _handleLoading(SupportControllerState state) {
    switch (state) {
      case SupportController$Loading():
        loading.value = true;
        break;
      default:
        loading.value = false;
        break;
    }
  }

  void _handleUploadImage(SupportControllerState state) {
    switch (state) {
      case SupportController$ImageLoading():
        imageLoading.value = true;
        break;
      case SupportController$ImageSuccess():
        questionImageUrl.value = state.imageUrl;
        imageLoading.value = false;
        break;
      default:
        imageLoading.value = false;
        break;
    }
  }

  void _handleAddSuccess(SupportControllerState state) {
    switch (state) {
      case SupportController$AddSuccess():
        AppOverlays.showErrorBanner(
            msg: 'Обращение отправлено', isError: false);
        GoRouter.of(_context).pop();
        break;
      default:
        break;
    }
  }

  void _handleError(SupportControllerState state) {
    switch (state) {
      case SupportController$Error():
        AppOverlays.showErrorBanner(msg: '${state.error}');
        break;
      default:
        break;
    }
  }
}
