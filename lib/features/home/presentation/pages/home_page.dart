import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView(
        children: const [
          _HeadSection(),
          _CategoriesSection(),
          _AnimalsSection(),
        ],
      ),
    );
  }
}

class _HeadSection extends StatelessWidget {
  const _HeadSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _CategoriesSection extends StatelessWidget {
  const _CategoriesSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}

class _AnimalsSection extends StatelessWidget {
  const _AnimalsSection({super.key});

  @override
  Widget build(BuildContext context) {
    return const Placeholder();
  }
}
