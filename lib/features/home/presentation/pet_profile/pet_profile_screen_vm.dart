import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get_pet/app/service/logger/logger_service.dart';
import 'package:get_pet/features/home/data/model/category_api_model.dart';
import 'package:get_pet/features/home/domain/entity/pet_entity.dart';
import 'package:get_pet/features/home/domain/entity/pet_type.dart';
import 'package:get_pet/features/home/domain/logic/pet_common/pet_common_controller.dart';
import 'package:get_pet/features/home/domain/logic/pet_profile/pet_profile_controller.dart';
import 'package:get_pet/widgets/app_overlays.dart';
import 'package:go_router/go_router.dart';
import 'package:image_picker/image_picker.dart';

class PetProfileScreenVm {
  final BuildContext _context;
  final PetEntity? _pet;
  final PetProfileController _petProfileController;
  final PetCommonController _petCommonController;

  PetProfileScreenVm(
    this._context,
    this._pet,
    this._petProfileController,
    this._petCommonController,
  ) {
    _init();
  }

  late final bool isAddMode;
  final categories = ValueNotifier<List<CategoryApiModel>>([]);
  final petPhotoUrl = ValueNotifier<String?>(null);
  final loading = ValueNotifier<bool>(true);
  final imageLoading = ValueNotifier<bool>(false);
  final formKey = GlobalKey<FormState>();

  CategoryApiModel? petCategory;
  String petTitle = '';
  String petBreed = '';
  String petLocation = '';
  String petAge = '';
  String petColor = '';
  String petWeight = '';
  PetType? petType;
  String petDescription = '';

  Future<void> _init() async {
    _petProfileController.addListener(_petProfileControllerListener);
    _petProfileController.getCategories();
    isAddMode = _pet == null;
    _initPetFields(_pet);
  }

  void dispose() {
    _petProfileController.removeListener(_petProfileControllerListener);
    categories.dispose();
    petPhotoUrl.dispose();
    loading.dispose();
    imageLoading.dispose();
  }

  void _initPetFields(PetEntity? pet) {
    if (pet == null) return;

    petCategory = pet.category;
    petTitle = pet.title;
    petPhotoUrl.value = pet.photoUrl;
    petBreed = pet.breed;
    petLocation = pet.location;
    petAge = pet.age;
    petColor = pet.color;
    petWeight = pet.weight;
    petType = pet.type;
    petDescription = pet.description;
  }

  void onTitleChanged(String value) {
    LoggerService().d('PetProfileScreenVm.onTitleChanged(): "$value"');
    petTitle = value;
  }

  void onCategoryChanged(CategoryApiModel? value) {
    LoggerService().d('PetProfileScreenVm.onCategoryChanged(): "$value"');
    petCategory = value;
  }

  void onBreedChanged(String value) {
    LoggerService().d('PetProfileScreenVm.onBreedChanged(): "$value"');
    petBreed = value;
  }

  void onLocationChanged(String value) {
    LoggerService().d('PetProfileScreenVm.onLocationChanged(): "$value"');
    petLocation = value;
  }

  void onAgeChanged(String value) {
    LoggerService().d('PetProfileScreenVm.onAgeChanged(): "$value"');
    petAge = value;
  }

  void onColorChanged(String value) {
    LoggerService().d('PetProfileScreenVm.onColorChanged(): "$value"');
    petColor = value;
  }

  void onWeightChanged(String value) {
    LoggerService().d('PetProfileScreenVm.onWeightChanged(): "$value"');
    petWeight = value;
  }

  void onTypeChanged(PetType? value) {
    LoggerService().d('PetProfileScreenVm.onTypeChanged(): "$value"');
    petType = value;
  }

  void onDescriptionChanged(String value) {
    LoggerService().d('PetProfileScreenVm.onDescriptionChanged(): "$value"');
    petDescription = value;
  }

  void onAddPet() {
    LoggerService().d('PetProfileScreenVm.onAddPet()');
    if (formKey.currentState?.validate() != true) return;

    if (_checkFieldFullness() == false) return;

    final pet = PetEntity(
      category: petCategory!,
      title: petTitle,
      photoUrl: petPhotoUrl.value!,
      breed: petBreed,
      location: petLocation,
      age: petAge,
      color: petColor,
      weight: petWeight,
      type: petType!,
      description: petDescription,
    );

    _petProfileController.addPet(pet);
  }

  void onUpdatePet() {
    LoggerService().d('PetProfileScreenVm.onUpdatePet()');
    if (formKey.currentState?.validate() != true) return;

    if (_checkFieldFullness() == false) return;

    final pet = PetEntity(
      id: _pet?.id,
      category: petCategory!,
      title: petTitle,
      photoUrl: petPhotoUrl.value!,
      breed: petBreed,
      location: petLocation,
      age: petAge,
      color: petColor,
      weight: petWeight,
      type: petType!,
      description: petDescription,
    );

    _petProfileController.updatePet(pet);
  }

  bool _checkFieldFullness() {
    String? error;
    if (petCategory == null) error = 'Не заполнено: Category';
    if (petTitle.isEmpty) error = 'Не заполнено: Title';
    if (petPhotoUrl.value == null) error = 'Не заполнено: Photo';
    if (petBreed.isEmpty) error = 'Не заполнено: Breed';
    if (petLocation.isEmpty) error = 'Не заполнено: Location';
    if (petAge.isEmpty) error = 'Не заполнено: Age';
    if (petColor.isEmpty) error = 'Не заполнено: Color';
    if (petWeight.isEmpty) error = 'Не заполнено: Weight';
    if (petType == null) error = 'Не заполнено: Type';
    if (petDescription.isEmpty) error = 'Не заполнено: Description';

    if (error != null) {
      AppOverlays.showErrorBanner(msg: error);
      return false;
    }

    return true;
  }

  Future<void> onAddPhoto() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      _petProfileController.uploadImage(File(image.path));
    }
  }

  void _petProfileControllerListener() {
    final state = _petProfileController.state;
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
        AppOverlays.showErrorBanner(
            msg: 'Объявление добавлено!', isError: false);

        _petCommonController.getNewPets();

        GoRouter.of(_context).pop();
        break;
      case PetProfileController$UpdateSuccess():
        AppOverlays.showErrorBanner(
            msg: 'Объявление изменено!', isError: false);

        _petCommonController.getNewPets();

        GoRouter.of(_context).pop();
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
