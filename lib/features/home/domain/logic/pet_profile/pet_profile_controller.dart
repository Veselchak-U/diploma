import 'dart:async';
import 'dart:io';

import 'package:control/control.dart';
import 'package:get_pet/app/service/storage/remote_file_storage.dart';
import 'package:get_pet/features/home/data/model/category_api_model.dart';
import 'package:get_pet/features/home/data/repository/pet_repository.dart';
import 'package:get_pet/features/home/domain/entity/pet_entity.dart';

part 'pet_profile_controller_state.dart';

final class PetProfileController
    extends StateController<PetProfileControllerState>
    with SequentialControllerHandler {
  final PetRepository _petRepository;
  final RemoteFileStorage _remoteFileStorage;

  PetProfileController(
    this._petRepository,
    this._remoteFileStorage, {
    super.initialState = const PetProfileController$Idle(),
  }) {
    _init();
  }

  void _init() {}

  @override
  void dispose() {
    super.dispose();
  }

  void getCategories() {
    return handle(
      () async {
        final categories = await _petRepository.getCategories();
        setState(PetProfileController$CategoriesSuccess(categories));
      },
      _errorHandler,
      _doneHandler,
    );
  }

  void uploadImage(File file) {
    return handle(
      () async {
        setState(const PetProfileController$ImageLoading());
        final imageUrl = await _remoteFileStorage.uploadUserImage(file);
        setState(PetProfileController$ImageSuccess(imageUrl));
      },
      _errorHandler,
      _doneHandler,
    );
  }

  void addPet(PetEntity pet) {
    return handle(
      () async {
        setState(const PetProfileController$Loading());
        await _petRepository.addPet(pet);
        setState(const PetProfileController$AddSuccess());
      },
      _errorHandler,
      _doneHandler,
    );
  }

  void updatePet(PetEntity pet) {
    return handle(
      () async {
        setState(const PetProfileController$Loading());
        await _petRepository.updatePet(pet);
        setState(const PetProfileController$UpdateSuccess());
      },
      _errorHandler,
      _doneHandler,
    );
  }

  FutureOr<void> _errorHandler(Object e, StackTrace st) {
    setState(PetProfileController$Error(e));
  }

  FutureOr<void> _doneHandler() {
    setState(const PetProfileController$Idle());
  }
}
