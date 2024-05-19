import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_pet/features/home/presentation/add_question/add_question_screen_vm.dart';
import 'package:get_pet/widgets/app_scaffold.dart';
import 'package:get_pet/widgets/loading_button.dart';
import 'package:get_pet/widgets/loading_indicator.dart';
import 'package:provider/provider.dart';

class AddQuestionScreen extends StatefulWidget {
  const AddQuestionScreen({super.key});

  @override
  State<AddQuestionScreen> createState() => _AddQuestionScreenState();
}

class _AddQuestionScreenState extends State<AddQuestionScreen> {
  late final AddQuestionScreenVm vm;

  @override
  void initState() {
    super.initState();
    vm = context.read<AddQuestionScreenVm>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Обращение в поддержку',
      body: Form(
        key: vm.formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24).r,
          child: Column(
            children: [
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Тема проблемы',
                  helperText: '',
                ),
                initialValue: vm.questionTitle,
                textInputAction: TextInputAction.next,
                onChanged: vm.onTitleChanged,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) =>
                    (value == null || value.isEmpty) ? 'Заполните тему' : null,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Описание проблемы',
                  helperText: '',
                ),
                initialValue: vm.questionDescription,
                textInputAction: TextInputAction.next,
                onChanged: vm.onDescriptionChanged,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Заполните описание'
                    : null,
              ),
              ValueListenableBuilder(
                valueListenable: vm.questionPhotoUrl,
                builder: (context, questionPhotoUrl, _) {
                  return questionPhotoUrl == null
                      ? Padding(
                          padding: const EdgeInsets.all(32).r,
                          child: ValueListenableBuilder(
                            valueListenable: vm.imageLoading,
                            builder: (context, imageLoading, _) {
                              return LoadingButton(
                                label: 'Добавить фото',
                                loading: imageLoading,
                                onPressed: vm.onAddPhoto,
                              );
                            },
                          ),
                        )
                      : CachedNetworkImage(
                          imageUrl: questionPhotoUrl,
                          placeholder: (_, __) => const LoadingIndicator(),
                          errorWidget: (_, __, ___) => const Icon(Icons.error),
                        );
                },
              ),
              Padding(
                padding: const EdgeInsets.all(32).r,
                child: ValueListenableBuilder(
                  valueListenable: vm.loading,
                  builder: (context, loading, _) {
                    return LoadingButton(
                      label: 'Отправить обращение',
                      loading: loading,
                      onPressed: vm.onAddQuestion,
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
}
