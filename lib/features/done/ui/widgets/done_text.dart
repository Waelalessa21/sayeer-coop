import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sayeercoop/common/layout/responsive.dart';
import 'package:sayeercoop/common/theme/colors.dart';

class DoneText extends StatelessWidget {
  const DoneText({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    return Column(
      children: [
        AnimatedOpacity(
          opacity: 1.0,
          duration: const Duration(seconds: 1),
          child: Text(
            'تم التسجيل بنجاح!',
            style: TextStyle(
              fontSize: isDesktop ? 10.sp : 24.sp,
              fontWeight: FontWeight.bold,
              color: TColors.textDarkBlue,
            ),
          ),
        ),
        SizedBox(height: 20.h),
        AnimatedOpacity(
          opacity: 1.0,
          duration: const Duration(seconds: 2),
          child: Text(
            'لقد تم إرسال بياناتك بنجاح، في حال قبولك سيتم التواصل معك.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isDesktop ? 8.sp : 14.sp,
              color: TColors.textSecondary,
            ),
          ),
        ),
      ],
    );
  }
}
