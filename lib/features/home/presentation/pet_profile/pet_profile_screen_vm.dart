import 'dart:typed_data';

import 'package:flutter/material.dart';
import 'package:get_pet/app/service/logger/logger_service.dart';
import 'package:get_pet/features/home/data/model/category_api_model.dart';
import 'package:get_pet/features/home/domain/entity/pet_entity.dart';
import 'package:get_pet/features/home/domain/entity/pet_type.dart';
import 'package:get_pet/features/home/domain/logic/pet_profile_controller.dart';
import 'package:get_pet/widgets/app_overlays.dart';
import 'package:image_picker/image_picker.dart';

class PetProfileScreenVm {
  final PetEntity? _pet;
  final PetProfileController _petProfileController;

  PetProfileScreenVm(
    this._pet,
    this._petProfileController,
  ) {
    _init();
  }

  late final bool isAddMode;
  final categories = ValueNotifier<List<CategoryApiModel>>([]);
  final petPhoto = ValueNotifier<Uint8List?>(null);
  final formKey = GlobalKey<FormState>();

  int? petId;
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
    isAddMode = _pet == null;
    _initPet(_pet);
    _petProfileController.getCategories();
  }

  void dispose() {
    _petProfileController.removeListener(_petProfileControllerListener);
    categories.dispose();
    petPhoto.dispose();
  }

  void _initPet(PetEntity? pet) {
    if (pet == null) return;

    petId = pet.id;
    petCategory = pet.category;
    petTitle = pet.title;
    petPhoto.value = pet.photo;
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
    LoggerService().d('PetProfileScreenVm.onAdd()');
    if (formKey.currentState?.validate() != true) return;

    if (_checkFieldFullness() == false) return;

    final pet = PetEntity(
      category: petCategory!,
      title: petTitle,
      photo: petPhoto.value!,
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

  bool _checkFieldFullness() {
    String? error;
    if (petCategory == null) error = 'Не заполнено: Category';
    if (petTitle.isEmpty) error = 'Не заполнено: Title';
    if (petPhoto.value == null) error = 'Не заполнено: Photo';
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

  void _petProfileControllerListener() {
    switch (_petProfileController.state) {
      case final PetProfileController$CategoriesSuccess state:
        categories.value = state.categories;
        break;
      case final PetProfileController$Error state:
        AppOverlays.showErrorBanner(msg: '${state.error}');
        break;
      default:
        break;
    }
  }

  Future<void> onAddPhoto() async {
    final image = await ImagePicker().pickImage(
      source: ImageSource.gallery,
    );
    if (image != null) {
      petPhoto.value = await image.readAsBytes();
    }
  }
}
