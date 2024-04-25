import 'package:flutter/material.dart';
import 'package:get_pet/features/home/presentation/home_page/widgets/home_page_animals.dart';
import 'package:get_pet/features/home/presentation/home_page/widgets/home_page_categories.dart';
import 'package:get_pet/features/home/presentation/home_page/widgets/home_page_head.dart';
import 'package:get_pet/features/home/presentation/home_screen_vm.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final HomeScreenVm vm;

  @override
  void initState() {
    super.initState();
    vm = context.read<HomeScreenVm>();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: const [
          HomePageHead(),
          HomePageCategories(),
          HomePageAnimals(),
        ],
      ),
    );
  }
}
