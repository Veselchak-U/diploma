import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_pet/app/style/app_colors.dart';
import 'package:get_pet/app/style/app_text_styles.dart';
import 'package:get_pet/features/home/domain/entity/question_entity.dart';
import 'package:get_pet/features/home/presentation/home_pages/support_page/support_page_vm.dart';
import 'package:get_pet/widgets/app_scaffold.dart';
import 'package:get_pet/widgets/loading_button.dart';
import 'package:get_pet/widgets/loading_indicator.dart';
import 'package:provider/provider.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({super.key});

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final vm = context.read<SupportPageVm>();

    return AppScaffold(
      body: Column(
        children: [
          Center(
            child: Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 16, vertical: 24).r,
              child: LoadingButton(
                label: 'Написать в поддержку',
                onPressed: vm.addNewQuestion,
              ),
            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: vm.loading,
              builder: (context, loading, _) {
                return ValueListenableBuilder(
                  valueListenable: vm.questions,
                  builder: (context, questions, _) {
                    return Stack(
                      alignment: Alignment.center,
                      children: [
                        questions.isEmpty
                            ? const _EmptyQuestionsWidget()
                            : _QuestionsListWidget(questions),
                        if (loading) const LoadingIndicator(),
                      ],
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _EmptyQuestionsWidget extends StatelessWidget {
  const _EmptyQuestionsWidget();

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Обращений ещё не было'),
    );
  }
}

class _QuestionsListWidget extends StatelessWidget {
  final List<QuestionEntity> questions;

  const _QuestionsListWidget(this.questions);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<SupportPageVm>();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 16).r,
          child: Text(
            'Мои обращения',
            style: AppTextStyles.s13w600,
          ),
        ),
        Expanded(
          child: RefreshIndicator(
            onRefresh: () async => vm.updateQuestions(),
            child: ListView.separated(
              itemBuilder: (context, index) => _QuestionItem(questions[index]),
              separatorBuilder: (context, _) => SizedBox(height: 8.r),
              itemCount: questions.length,
            ),
          ),
        ),
      ],
    );
  }
}

class _QuestionItem extends StatelessWidget {
  final QuestionEntity question;

  const _QuestionItem(this.question);

  @override
  Widget build(BuildContext context) {
    final vm = context.read<SupportPageVm>();

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8).r,
      child: Container(
        decoration: BoxDecoration(
          border: Border.all(color: AppColors.gray3Light),
          borderRadius: BorderRadius.all(const Radius.circular(16).r),
        ),
        child: InkWell(
          borderRadius: BorderRadius.all(const Radius.circular(16).r),
          onTap: () => vm.openQuestionDetails(question),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14).r,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  question.title,
                  style: question.isNew
                      ? AppTextStyles.s13w600
                      : AppTextStyles.s13w400,
                  // overflow: TextOverflow.ellipsis,
                ),
                SizedBox(height: 7.r),
                Text(
                  question.description,
                  style: question.isNew
                      ? AppTextStyles.s13w600
                      : AppTextStyles.s13w400,
                  // overflow: TextOverflow.ellipsis,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
