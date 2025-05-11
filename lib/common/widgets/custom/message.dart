import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:sayeercoop/common/theme/colors.dart';

void showToastMessage(
  BuildContext context,
  String message,
  String iconPath, {
  bool isError = true,
}) {
  FToast fToast = FToast();
  final theme = Theme.of(context);
  final isDarkMode = theme.brightness == Brightness.dark;
  final screenWidth = MediaQuery.of(context).size.width;

  fToast.init(context);

  final Color textColor = theme.colorScheme.onSurface;
  final Color borderColor =
      isDarkMode
          ? (isError
              ? theme.colorScheme.error.withOpacity(0.5)
              : theme.colorScheme.primary.withOpacity(0.5))
          : (isError
              ? theme.colorScheme.error.withOpacity(0.3)
              : theme.colorScheme.primary.withOpacity(0.3));

  Widget toast = FadeInUp(
    from: 20,
    child: Container(
      width: screenWidth * 0.9,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: TColors.textWhite,
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 6,
            spreadRadius: 1,
            offset: const Offset(0, 2),
          ),
        ],
        border: Border.all(color: borderColor, width: 1),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Image.asset(iconPath, width: 20, height: 20),
          const SizedBox(width: 10),
          Expanded(
            child: Text(
              message,
              style: TextStyle(
                color: textColor,
                fontSize: 12,
                fontWeight: FontWeight.w500,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
          const SizedBox(width: 10),
          GestureDetector(
            onTap: () {
              fToast.removeCustomToast();
            },
            child: Icon(
              Icons.close,
              color: textColor.withOpacity(0.6),
              size: 16,
            ),
          ),
        ],
      ),
    ),
  );

  // Show the toast
  fToast.showToast(
    child: toast,
    gravity: ToastGravity.TOP,
    toastDuration: const Duration(seconds: 3),
  );
}
