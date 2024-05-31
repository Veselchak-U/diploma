import 'package:flutter/material.dart';
import 'package:get_pet/features/search/presentation/search_screen_vm.dart';
import 'package:get_pet/widgets/app_scaffold.dart';
import 'package:get_pet/widgets/loading_button.dart';
import 'package:provider/provider.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  @override
  Widget build(BuildContext context) {
    final vm = context.read<SearchScreenVm>();

    return AppScaffold(
      title: 'Поиск объявлений',
      body: Center(
        child: Column(
          children: [
            LoadingButton(
              label: 'Поиск',
              onPressed: vm.searchPets,
            ),
          ],
        ),
      ),
    );
  }
}
