import 'package:flutter/material.dart';


import '../../../utils/app_animation.dart';
import '../../../utils/app_images.dart';
import '../../../utils/colors.dart';

class IconLoader extends StatefulWidget {
  const IconLoader({super.key});

  @override
  State<IconLoader> createState() => _IconLoaderState();
}

class _IconLoaderState extends State<IconLoader>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..repeat(); // Repeat animation indefinitely
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return  Image.asset(
      AppAnimation.loaderAnimation,
      width: 80,
      height: 80,
      color: AppColors.secondary,
    );
  }
}
