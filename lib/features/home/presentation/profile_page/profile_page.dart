import 'package:flutter/material.dart';
import 'package:get_pet/widgets/app_scaffold.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return const AppScaffold(
      body: Center(child: Text('ProfilePage')),
    );
  }
}
