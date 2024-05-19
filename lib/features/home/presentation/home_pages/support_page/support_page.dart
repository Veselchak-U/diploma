import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_pet/app/style/app_text_styles.dart';
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
                onPressed: vm.createNewQuestion,
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
                            : Align(
                                alignment: Alignment.centerLeft,
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 16).r,
                                  child: Text(
                                    'Мои заявки',
                                    style: AppTextStyles.s13w600,
                                  ),
                                ),
                              ),
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
  const _EmptyQuestionsWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: Text('Обращений ещё не было'),
    );
  }
}
