import 'package:flutter/material.dart';
import 'package:get_pet/widgets/app_scaffold.dart';

class AddPage extends StatefulWidget {
  const AddPage({super.key});

  @override
  State<AddPage> createState() => _AddPageState();
}

class _AddPageState extends State<AddPage> {
  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      body: Center(child: Text('AddPage')),
    );
  }
}
