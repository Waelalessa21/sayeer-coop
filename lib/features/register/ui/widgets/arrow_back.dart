import 'package:flutter/material.dart';
import 'package:sayeercoop/common/theme/colors.dart';

class ArrowButton extends StatelessWidget {
  final VoidCallback onTap;

  const ArrowButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 16,
        height: 16,
        decoration: BoxDecoration(
          color: TColors.textWhite,
          borderRadius: BorderRadius.circular(5),
          boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 4,
              offset: Offset(0, 2),
            ),
          ],
        ),
        child: const Icon(Icons.arrow_back_ios, size: 8, color: Colors.black87),
      ),
    );
  }
}
