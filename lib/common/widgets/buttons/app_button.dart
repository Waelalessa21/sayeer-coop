import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sayeercoop/common/layout/responsive.dart';
import 'package:sayeercoop/common/theme/colors.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final bool isFullWidth;
  final bool isLoading;
  final Color? backgroundColor;
  final Color? textColor;
  final bool isOutlined;
  final IconData? icon;
  final double? width;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.isFullWidth = true,
    this.isLoading = false,
    this.backgroundColor,
    this.textColor,
    this.isOutlined = false,
    this.icon,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDesktop = Responsive.isDesktop(context);

    final buttonStyle =
        isOutlined
            ? OutlinedButton.styleFrom(
              side: BorderSide(
                color: backgroundColor ?? theme.colorScheme.primary,
              ),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              padding: EdgeInsets.symmetric(vertical: isDesktop ? 18 : 16),
            )
            : ElevatedButton.styleFrom(
              backgroundColor: TColors.textDarkBlue,
              foregroundColor: textColor ?? Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
              elevation: 0,
              padding: EdgeInsets.symmetric(vertical: isDesktop ? 18 : 16),
            );

    final buttonChild =
        isLoading
            ? SizedBox(
              width: isDesktop ? 20 : 18.sp,
              height: isDesktop ? 20 : 18.sp,
              child: CircularProgressIndicator(
                color: isOutlined ? theme.colorScheme.primary : Colors.white,
                strokeWidth: 2,
              ),
            )
            : Row(
              mainAxisSize: MainAxisSize.min,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                if (icon != null) ...[
                  Icon(icon, size: isDesktop ? 16 : 14.sp),
                  SizedBox(width: 6.w),
                ],
                Text(
                  text,
                  style: TextStyle(
                    fontSize: isDesktop ? 14 : 12.sp,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            );

    return SizedBox(
      width: isFullWidth ? double.infinity : width ?? (isDesktop ? 200 : 160.w),
      child:
          isOutlined
              ? OutlinedButton(
                onPressed: isLoading ? null : onPressed,
                style: buttonStyle,
                child: buttonChild,
              )
              : ElevatedButton(
                onPressed: isLoading ? null : onPressed,
                style: buttonStyle,
                child: buttonChild,
              ),
    );
  }
}
