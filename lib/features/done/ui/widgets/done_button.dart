import 'package:flutter/material.dart';
import 'package:sayeercoop/common/layout/responsive.dart';
import 'package:sayeercoop/common/widgets/buttons/app_button.dart';
import 'package:sayeercoop/common/routing/extension.dart';
import 'package:sayeercoop/common/routing/routes.dart';

class DoneButton extends StatelessWidget {
  const DoneButton({super.key});

  @override
  Widget build(BuildContext context) {
    return AnimatedOpacity(
      opacity: 1.0,
      duration: const Duration(seconds: 3),
      child: SizedBox(
        width:
            Responsive.isDesktop(context)
                ? MediaQuery.of(context).size.width * 0.3
                : MediaQuery.of(context).size.width * 0.5,
        child: CustomButton(
          text: "عودة إلى الصفحة الرئيسية",
          onPressed: () {
            context.pushReplacementNamed(Routes.landingScreen);
          },
        ),
      ),
    );
  }
}
