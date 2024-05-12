import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_pet/features/home/data/model/category_api_model.dart';
import 'package:get_pet/features/home/domain/entity/pet_type.dart';
import 'package:get_pet/features/home/presentation/pet_profile/pet_profile_screen_vm.dart';
import 'package:get_pet/widgets/app_scaffold.dart';
import 'package:get_pet/widgets/loading_button.dart';
import 'package:provider/provider.dart';

class PetProfileScreen extends StatefulWidget {
  const PetProfileScreen({super.key});

  @override
  State<PetProfileScreen> createState() => _PetProfileScreenState();
}

class _PetProfileScreenState extends State<PetProfileScreen> {
  late final PetProfileScreenVm vm;

  @override
  void initState() {
    super.initState();
    vm = context.read<PetProfileScreenVm>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: vm.isAddMode ? 'Добавление анкеты' : 'Изменение анкеты',
      body: Form(
        key: vm.formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24).r,
          child: Column(
            children: [
              ValueListenableBuilder(
                valueListenable: vm.petPhoto,
                builder: (context, petPhoto, _) {
                  return petPhoto == null
                      ? Padding(
                          padding: const EdgeInsets.all(32).r,
                          child: LoadingButton(
                            label: 'Добавить фото',
                            onPressed: vm.onAddPhoto,
                          ),
                        )
                      : Image.memory(petPhoto);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Название анкеты',
                  helperText: '',
                ),
                initialValue: vm.petTitle,
                textInputAction: TextInputAction.next,
                onChanged: vm.onTitleChanged,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Заполните название анкеты'
                    : null,
              ),
              ValueListenableBuilder(
                valueListenable: vm.categories,
                builder: (context, categories, _) {
                  return DropdownButtonFormField<CategoryApiModel>(
                    decoration: const InputDecoration(
                      labelText: 'Категория',
                      helperText: '',
                    ),
                    value: vm.petCategory,
                    items: _getDropdownItemsFromList(categories),
                    onChanged: vm.onCategoryChanged,
                    autovalidateMode: AutovalidateMode.onUserInteraction,
                    validator: (value) =>
                        (value == null) ? 'Выберите категорию' : null,
                  );
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Порода',
                  helperText: '',
                ),
                initialValue: vm.petBreed,
                textInputAction: TextInputAction.next,
                onChanged: vm.onBreedChanged,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Заполните породу'
                    : null,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Местоположение',
                  helperText: '',
                ),
                initialValue: vm.petLocation,
                textInputAction: TextInputAction.next,
                onChanged: vm.onLocationChanged,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Заполните местоположение'
                    : null,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Возраст',
                  helperText: '',
                ),
                initialValue: vm.petAge,
                textInputAction: TextInputAction.next,
                onChanged: vm.onAgeChanged,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Заполните возраст'
                    : null,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Окрас',
                  helperText: '',
                ),
                initialValue: vm.petColor,
                textInputAction: TextInputAction.next,
                onChanged: vm.onColorChanged,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) =>
                    (value == null || value.isEmpty) ? 'Заполните окрас' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Вес',
                  helperText: '',
                ),
                initialValue: vm.petWeight,
                textInputAction: TextInputAction.next,
                onChanged: vm.onWeightChanged,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) =>
                    (value == null || value.isEmpty) ? 'Заполните вес' : null,
              ),
              DropdownButtonFormField<PetType>(
                decoration: const InputDecoration(
                  labelText: 'Тип приёма',
                  helperText: '',
                ),
                value: vm.petType,
                items: _getDropdownItemsFromList(PetType.values),
                onChanged: vm.onTypeChanged,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) =>
                    (value == null) ? 'Выберите тип приёма' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Описание',
                  helperText: '',
                ),
                maxLines: 5,
                initialValue: vm.petDescription,
                textInputAction: TextInputAction.next,
                onChanged: vm.onDescriptionChanged,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Заполните описание'
                    : null,
              ),
              Padding(
                padding: const EdgeInsets.all(32).r,
                child: ValueListenableBuilder(
                  valueListenable: vm.loading,
                  builder: (context, loading, _) {
                    return LoadingButton(
                      label:
                          vm.isAddMode ? 'Добавить анкету' : 'Изменить анкету',
                      loading: loading,
                      onPressed: vm.isAddMode ? vm.onAddPet : vm.onUpdatePet,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  List<DropdownMenuItem<T>> _getDropdownItemsFromList<T>(List<T>? list) {
    if (list == null || list.isEmpty) {
      return [];
    }

    return List.generate(
      list.length,
      (index) => DropdownMenuItem<T>(
        value: list[index],
        child: Text(list[index].toString()),
      ),
    );
  }
}
