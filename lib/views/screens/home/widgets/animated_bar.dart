import 'package:crm_android/utils/colors.dart';
import 'package:flutter/material.dart';

class AnimatedBar extends StatelessWidget {
  const AnimatedBar({
    super.key,
    required this.isActive,
  });
  final bool isActive;
  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      margin: const EdgeInsets.only(
        bottom: 2,
      ),
      duration: const Duration(milliseconds: 200),
      decoration: const BoxDecoration(
          color: CRMAppColorPallete.lightBlue,
          borderRadius: BorderRadius.all(Radius.circular(12))),
      height: 4,
      width: isActive ? 20 : 0,
    );
  }
}
