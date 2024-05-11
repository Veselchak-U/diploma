import 'package:flutter/widgets.dart';
import 'package:get_pet/app/service/logger/logger_service.dart';
import 'package:get_pet/features/home/data/model/category_api_model.dart';
import 'package:get_pet/features/home/data/repository/pet_repository.dart';
import 'package:get_pet/features/home/domain/entity/pet_entity.dart';
import 'package:get_pet/features/home/domain/entity/pet_type.dart';

class PetProfileScreenVm {
  final PetEntity? _pet;
  final PetRepository _petRepository;

  PetProfileScreenVm(
    this._pet,
    this._petRepository,
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
    isAddMode = _pet == null;
    _initPet(_pet);
    categories.value = await _petRepository.getCategories();
  }

  void dispose() {
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

  void onAdd() {
    LoggerService().d('PetProfileScreenVm.onAdd()');
  }
}
