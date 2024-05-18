import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_pet/app/l10n/l10n.dart';
import 'package:get_pet/features/login/presentation/registration_screen/registration_screen_vm.dart';
import 'package:get_pet/widgets/app_scaffold.dart';
import 'package:get_pet/widgets/loading_button.dart';
import 'package:get_pet/widgets/loading_indicator.dart';
import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
import 'package:provider/provider.dart';

class RegistrationScreen extends StatefulWidget {
  const RegistrationScreen({
    super.key,
  });

  @override
  State<RegistrationScreen> createState() => _RegistrationScreenState();
}

class _RegistrationScreenState extends State<RegistrationScreen> {
  final _maskFormatter = MaskTextInputFormatter(mask: '###-###-####');

  String get _fullPhone => '+7${_maskFormatter.getUnmaskedText()}';

  @override
  Widget build(BuildContext context) {
    final vm = context.read<RegistrationScreenVm>();

    return AppScaffold(
      title: 'Завершение регистрации',
      body: Form(
        key: vm.formKey,
        child: SingleChildScrollView(
          padding: const EdgeInsets.all(24).r,
          child: Column(
            children: [
              ValueListenableBuilder(
                valueListenable: vm.userPhotoUrl,
                builder: (context, userPhotoUrl, _) {
                  return userPhotoUrl == null
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
                          imageUrl: userPhotoUrl,
                          placeholder: (_, __) => const LoadingIndicator(),
                          errorWidget: (_, __, ___) => const Icon(Icons.error),
                        );
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Имя',
                  helperText: '',
                ),
                initialValue: vm.userName,
                textInputAction: TextInputAction.next,
                onChanged: vm.onNameChanged,
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => (value == null || value.isEmpty)
                    ? 'Заполните имя пользователя'
                    : null,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Фамилия',
                  helperText: '',
                ),
                initialValue: vm.userSurname,
                textInputAction: TextInputAction.next,
                onChanged: vm.onSurnameChanged,
              ),
              TextFormField(
                decoration: InputDecoration(
                  labelText: 'Телефон',
                  prefix: const Text('+7 '),
                  hintStyle: const TextStyle(color: Colors.black12),
                  helperText: l10n.enterOnlyNumbers,
                ),
                initialValue: vm.userTelephone,
                textInputAction: TextInputAction.next,
                onChanged: (value) => vm.onPhoneChanged(_fullPhone),
                keyboardType: TextInputType.number,
                autocorrect: false,
                inputFormatters: [_maskFormatter],
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (value) => (value == null || value.length != 12)
                    ? 'Заполните телефон'
                    : null,
              ),
              Padding(
                padding: const EdgeInsets.all(32).r,
                child: ValueListenableBuilder(
                  valueListenable: vm.loading,
                  builder: (context, loading, _) {
                    return LoadingButton(
                      label: 'Завершить регистрацию',
                      loading: loading,
                      onPressed: vm.completeRegister,
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
