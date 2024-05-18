import 'package:flutter/material.dart';
import 'package:get_pet/app/assets/assets.gen.dart';
import 'package:get_pet/widgets/loading_indicator.dart';

class InitialScreen extends StatelessWidget {
  const InitialScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Center(
            child: Assets.images.splash.image(),
          ),
          const Center(
            child: SizedBox(
              width: 320,
              height: 400,
              child: Align(
                alignment: Alignment.bottomCenter,
                child: LoadingIndicator(),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
