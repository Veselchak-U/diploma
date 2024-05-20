import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_pet/features/home/data/model/question_api_model.dart';
import 'package:get_pet/widgets/app_scaffold.dart';
import 'package:get_pet/widgets/loading_indicator.dart';

class QuestionDetailsScreen extends StatelessWidget {
  final QuestionApiModel question;

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
              initialValue: question.description,
              textInputAction: TextInputAction.next,
              readOnly: true,
            ),
            TextFormField(
              decoration: const InputDecoration(
                labelText: 'Ответ администратора',
                helperText: '',
              ),
              initialValue: question.answer,
              textInputAction: TextInputAction.next,
              readOnly: true,
            ),
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
