import 'package:flutter/widgets.dart';
import 'package:get_pet/app/service/logger/logger_service.dart';
import 'package:get_pet/features/home/data/model/category_api_model.dart';
import 'package:get_pet/features/home/domain/entity/pet_entity.dart';
import 'package:get_pet/features/home/domain/entity/pet_type.dart';
import 'package:get_pet/features/home/domain/logic/pet_profile_controller.dart';
import 'package:get_pet/widgets/app_overlays.dart';

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
  final formKey = GlobalKey<FormState>();

  int? petId;
  CategoryApiModel? petCategory;
  String? petTitle;
  String? petPhoto;
  String? petBreed;
  String? petLocation;
  String? petAge;
  String? petColor;
  String? petWeight;
  PetType? petType;
  String? petDescription;

  Future<void> _init() async {
    _petProfileController.addListener(_petProfileControllerListener);
    isAddMode = _pet == null;
    _initPet(_pet);
    _petProfileController.getCategories();
  }

  void dispose() {
    _petProfileController.removeListener(_petProfileControllerListener);
    categories.dispose();
  }

  void _initPet(PetEntity? pet) {
    if (pet == null) return;

    petId = pet.id;
    petCategory = pet.category;
    petTitle = pet.title;
    petPhoto = pet.photo;
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
      title: petTitle!,
      photo: petPhoto!,
      breed: petBreed!,
      location: petLocation!,
      age: petAge!,
      color: petColor!,
      weight: petWeight!,
      type: petType!,
      description: petDescription!,
    );

    _petProfileController.addPet(pet);
  }

  bool _checkFieldFullness() {
    String? error;
    if (petCategory == null) error = 'petCategory == null';
    if (petTitle == null) error = 'petTitle == null';
    if (petPhoto == null) error = 'petPhoto == null';
    if (petBreed == null) error = 'petBreed == null';
    if (petLocation == null) error = 'petLocation == null';
    if (petAge == null) error = 'petAge == null';
    if (petColor == null) error = 'petColor == null';
    if (petWeight == null) error = 'petWeight == null';
    if (petType == null) error = 'petType == null';
    if (petDescription == null) error = 'petDescription == null';

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
}
