import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:get_pet/app/style/app_text_styles.dart';
import 'package:get_pet/features/home/presentation/home_pages/profile_page/profile_page_vm.dart';
import 'package:get_pet/features/login/data/model/user_api_model.dart';
import 'package:get_pet/widgets/app_scaffold.dart';
import 'package:get_pet/widgets/loading_button.dart';
import 'package:get_pet/widgets/user_avatar.dart';
import 'package:provider/provider.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);

    final vm = context.read<ProfilePageVm>();

    return AppScaffold(
      body: Column(
        children: [
          ValueListenableBuilder(
            valueListenable: vm.user,
            builder: (context, user, _) {
              if (user == null) return const SizedBox.shrink();

              return Padding(
                padding: const EdgeInsets.fromLTRB(16, 24, 8, 24).r,
                child: _UserDetails(user),
              );
            },
          ),
          const Expanded(
            child: _UserQuestionnaries(),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16).r,
            child: LoadingButton(
              label: 'Удалить профиль',
              loading: false,
              type: LoadingButtonType.red,
              onPressed: () {}, //vm.addNewQuestion,
            ),
          ),
        ],
      ),
    );
  }
}

class _UserDetails extends StatelessWidget {
  final UserApiModel user;

  const _UserDetails(
    this.user, {
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final vm = context.read<ProfilePageVm>();

    return Row(
      children: [
        UserAvatar(user.photo),
        SizedBox(width: 24.r),
        Expanded(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '${user.name} ${user.surname}',
                style: AppTextStyles.s16w400,
              ),
              SizedBox(height: 4.r),
              Text(
                user.telephone,
                style: AppTextStyles.s13w400,
              ),
            ],
          ),
        ),
        SizedBox(
          width: 56.r,
          height: 56.r,
          child: IconButton(
            icon: const Icon(Icons.exit_to_app),
            onPressed: vm.logout,
          ),
        ),
      ],
    );
    ;
  }
}

class _UserQuestionnaries extends StatelessWidget {
  const _UserQuestionnaries({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();

    // ValueListenableBuilder(
    //   valueListenable: vm.loading,
    //   builder: (context, loading, _) {
    //     return ValueListenableBuilder(
    //       valueListenable: vm.questions,
    //       builder: (context, questions, _) {
    //         return Stack(
    //           alignment: Alignment.center,
    //           children: [
    //             questions.isEmpty
    //                 ? const _EmptyQuestionsWidget()
    //                 : _QuestionsListWidget(questions),
    //             if (loading) const LoadingIndicator(),
    //           ],
    //         );
    //       },
    //     );
    //   },
    // ),
  }
}
