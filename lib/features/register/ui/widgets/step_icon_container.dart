import 'package:flutter/material.dart';
import 'package:sayeercoop/common/layout/responsive.dart';
import 'package:sayeercoop/common/theme/colors.dart';

class StepIconContainer extends StatelessWidget {
  final String iconPath;

  const StepIconContainer({super.key, required this.iconPath});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    return Container(
      width:
          isDesktop
              ? MediaQuery.of(context).size.width * 0.04
              : MediaQuery.of(context).size.width * 0.05,
      height:
          isDesktop
              ? MediaQuery.of(context).size.height * 0.04
              : MediaQuery.of(context).size.height * 0.05,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: [
          BoxShadow(
            color: TColors.primary.withOpacity(0.3),
            blurRadius: 21,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Image.asset(iconPath, fit: BoxFit.contain),
    );
  }
}
