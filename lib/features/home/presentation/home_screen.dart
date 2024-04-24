import 'package:flutter/material.dart';
import 'package:get_pet/features/home/presentation/home_screen_vm.dart';
import 'package:get_pet/widgets/app_scaffold.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final vm = context.read<HomeScreenVm>();

    return const AppScaffold(
      title: 'Home',
      body: Text('Home'),
    );
  }
}
