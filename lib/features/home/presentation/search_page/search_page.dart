import 'package:flutter/material.dart';
import 'package:get_pet/widgets/app_scaffold.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({super.key});

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      body: Center(child: Text('SearchPage')),
    );
  }
}
