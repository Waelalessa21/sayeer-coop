import 'package:flutter/material.dart';
import 'package:sayeercoop/common/layout/responsive.dart';
import 'package:sayeercoop/common/theme/colors.dart';

class StartButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final String? text;

  const StartButton({super.key, this.onPressed, this.text});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return ConstrainedBox(
      constraints: BoxConstraints(
        minWidth: 130,
        maxWidth: isDesktop ? 200 : MediaQuery.of(context).size.width * 0.9,
      ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: TColors.textDarkBlue,
          padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 20),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Text(
          text ?? "أعرف أكثر",
          style: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
