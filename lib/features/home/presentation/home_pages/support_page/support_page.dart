import 'package:flutter/material.dart';
import 'package:get_pet/widgets/app_scaffold.dart';

class SupportPage extends StatefulWidget {
  const SupportPage({super.key});

  @override
  State<SupportPage> createState() => _SupportPageState();
}

class _SupportPageState extends State<SupportPage> {
  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      body: Center(child: Text('SupportPage')),
    );
  }
}
