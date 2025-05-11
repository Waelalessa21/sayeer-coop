import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sayeercoop/common/routing/routes.dart';
import 'package:sayeercoop/common/theme/colors.dart';
import 'package:sayeercoop/common/widgets/buttons/header_button.dart';

class DesktopHeader extends StatelessWidget {
  final VoidCallback onKnowUsTap;
  final VoidCallback onSendMessageTap;

  const DesktopHeader({
    super.key,
    required this.onKnowUsTap,
    required this.onSendMessageTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 120.0, vertical: 48),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () => context.go(Routes.landingScreen),
            child: Text(
              'ساير',
              style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 26,
                color: TColors.Ssecondery,
              ),
            ),
          ),
          Row(
            children: [
              HeaderLink(label: 'تعرف علينا', onTap: onKnowUsTap),
              const SizedBox(width: 24),
              HeaderLink(
                label: 'قدّم الآن',
                onTap: () => context.go(Routes.registerScreen),
              ),
              const SizedBox(width: 24),
              HeaderLink(label: 'اكتب رسالتك', onTap: onSendMessageTap),
            ],
          ),
        ],
      ),
    );
  }
}
