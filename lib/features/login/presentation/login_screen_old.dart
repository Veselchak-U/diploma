// import 'package:flutter/material.dart';
// import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:get_pet/app/l10n/l10n.dart';
// import 'package:get_pet/app/style/app_text_styles.dart';
// import 'package:get_pet/features/login/presentation/login_screen_vm.dart';
// import 'package:get_pet/widgets/app_scaffold.dart';
// import 'package:get_pet/widgets/loading_button.dart';
// import 'package:mask_text_input_formatter/mask_text_input_formatter.dart';
// import 'package:provider/provider.dart';
//
// class LoginScreenOld extends StatefulWidget {
//   final Widget drawer;
//
//   const LoginScreenOld({
//     required this.drawer,
//     super.key,
//   });
//
//   @override
//   State<LoginScreenOld> createState() => _LoginScreenOldState();
// }
//
// class _LoginScreenOldState extends State<LoginScreenOld> {
//   static const _appBarHeight = 56.0;
//
//   final _maskFormatter = MaskTextInputFormatter(mask: '###-###-####');
//
//   String get _phone => '+7${_maskFormatter.getUnmaskedText()}';
//
//   @override
//   Widget build(BuildContext context) {
//     final vm = context.read<LoginScreenVm>();
//     final theme = Theme.of(context);
//
//     return KeyboardDismissOnTap(
//       child: AppScaffold(
//         drawer: widget.drawer,
//         body: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 24).r,
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.center,
//             children: [
//               const Spacer(),
//               Text(
//                 l10n.enterPhoneNumber,
//                 style: theme.textTheme.headlineSmall,
//                 textAlign: TextAlign.center,
//               ),
//               const Spacer(),
//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 48).r,
//                 child: TextFormField(
//                   autofocus: true,
//                   onChanged: (value) => vm.onPhoneChanged(_phone),
//                   style: AppTextStyles.s24w600,
//                   decoration: InputDecoration(
//                     prefix: const Text('+7 '),
//                     hintStyle: const TextStyle(color: Colors.black12),
//                     helperText: l10n.enterOnlyNumbers,
//                   ),
//                   keyboardType: TextInputType.number,
//                   autocorrect: false,
//                   inputFormatters: [_maskFormatter],
//                 ),
//               ),
//               const Spacer(),
//               ValueListenableBuilder(
//                 valueListenable: vm.isPhoneComplete,
//                 builder: (context, isPhoneComplete, _) {
//                   return ValueListenableBuilder(
//                     valueListenable: vm.loading,
//                     builder: (context, loading, _) {
//                       return LoadingButton(
//                         label: l10n.login,
//                         loading: loading,
//                         onPressed:
//                             isPhoneComplete ? () => vm.login(_phone) : null,
//                       );
//                     },
//                   );
//                 },
//               ),
//               const Spacer(),
//               KeyboardVisibilityBuilder(
//                 builder: (context, isKeyboardVisible) {
//                   return isKeyboardVisible
//                       ? const SizedBox.shrink()
//                       : ValueListenableBuilder(
//                           valueListenable: vm.appVersion,
//                           builder: (context, appVersion, _) {
//                             return Padding(
//                               padding: EdgeInsets.only(
//                                 top: _appBarHeight,
//                                 bottom: 24.r,
//                               ),
//                               child: Text(
//                                 appVersion,
//                                 style: theme.textTheme.bodySmall,
//                               ),
//                             );
//                           },
//                         );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
