import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_pet/features/home/domain/entity/question_entity.dart';
import 'package:get_pet/widgets/app_scaffold.dart';
import 'package:get_pet/widgets/loading_indicator.dart';

class QuestionDetailsScreen extends StatelessWidget {
  final QuestionEntity question;

  const QuestionDetailsScreen(
    this.question, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Моя заявка',
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24).r,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Тема',
                helperText: '',
              ),
              initialValue: question.title,
              textInputAction: TextInputAction.next,
              readOnly: true,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Описание',
                helperText: '',
              ),
              maxLines: 5,
              initialValue: question.description,
              textInputAction: TextInputAction.next,
              readOnly: true,
            ),
            question.answer != null
                ? TextFormField(
                    decoration: const InputDecoration(
                      labelText: 'Ответ администратора',
                      helperText: '',
                    ),
                    maxLines: 5,
                    initialValue: question.answer,
                    textInputAction: TextInputAction.next,
                    readOnly: true,
                  )
                : const SizedBox.shrink(),
            question.photo == null
                ? const SizedBox.shrink()
                : CachedNetworkImage(
                    imageUrl: question.photo ?? '',
                    placeholder: (_, __) => const LoadingIndicator(),
                    errorWidget: (_, __, ___) => const Icon(Icons.error),
                  ),
          ],
        ),
      ),
    );
  }
}
