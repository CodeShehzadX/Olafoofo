import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

/// The small centered grab handle shown at the top of modal bottom sheets.
class SheetDragHandle extends StatelessWidget {
  const SheetDragHandle({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 44,
      height: 5,
      margin: const EdgeInsets.only(top: 12, bottom: 8),
      decoration: BoxDecoration(
        color: AppColors.blackText,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
