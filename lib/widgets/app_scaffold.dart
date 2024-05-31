import 'package:flutter/material.dart';
import 'package:get_pet/app/style/app_text_styles.dart';

class AppScaffold extends StatelessWidget {
  final Widget body;
  final String? title;
  final Widget? leading;
  final List<Widget>? actions;
  final Widget? drawer;

  const AppScaffold({
    required this.body,
    this.title,
    this.leading,
    this.actions,
    this.drawer,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: drawer,
      appBar: title != null || leading != null || actions != null
          ? AppBar(
              title: Text(
                title ?? '',
                style: AppTextStyles.s18w600,
              ),
              centerTitle: true,
              leading: leading,
              actions: actions,
            )
          : null,
      body: SafeArea(child: body),
    );
  }
}
