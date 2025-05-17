import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sayeercoop/common/layout/responsive.dart';
import 'package:sayeercoop/common/theme/colors.dart';

class CustomTextField extends StatefulWidget {
  final String hintText;
  final String? labelText;
  final String? fieldTitle;
  final bool obscureText;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  final TextInputType keyboardType;
  final Widget? prefixIcon;
  final Widget? suffixIcon;
  final bool isPassword;
  final bool showPasswordToggle;
  final int? maxLines;
  final TextInputAction? textInputAction;
  final FocusNode? focusNode;
  final Function(String)? onChanged;
  final Function(String)? onSubmitted;
  final bool readOnly;
  final String? errorText;
  final String? helperText;
  final bool enabled;
  final int? maxLength;
  final AutovalidateMode autovalidateMode;

  const CustomTextField({
    super.key,
    required this.hintText,
    this.labelText,
    this.fieldTitle,
    this.obscureText = false,
    this.controller,
    this.validator,
    this.keyboardType = TextInputType.text,
    this.prefixIcon,
    this.suffixIcon,
    this.isPassword = false,
    this.showPasswordToggle = true,
    this.maxLines = 1,
    this.textInputAction,
    this.focusNode,
    this.onChanged,
    this.onSubmitted,
    this.readOnly = false,
    this.errorText,
    this.helperText,
    this.enabled = true,
    this.autovalidateMode = AutovalidateMode.onUserInteraction,
    this.maxLength,
  });

  @override
  State<CustomTextField> createState() => _CustomTextFieldState();
}

class _CustomTextFieldState extends State<CustomTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.obscureText;
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.fieldTitle != null)
          Padding(
            padding: EdgeInsets.only(bottom: 12.h),
            child: Text(
              widget.fieldTitle!,
              style: TextStyle(
                fontSize: isDesktop ? 14 : 13.sp,
                fontWeight: FontWeight.w300,
                color: TColors.textDarkBlue,
              ),
            ),
          ),
        TextFormField(
          controller: widget.controller,
          obscureText: _obscureText,
          keyboardType: widget.keyboardType,
          validator: widget.validator,
          maxLines: widget.maxLines,
          textInputAction: widget.textInputAction,
          focusNode: widget.focusNode,
          onChanged: widget.onChanged,
          onFieldSubmitted: widget.onSubmitted,
          readOnly: widget.readOnly,
          enabled: widget.enabled,
          maxLength: widget.maxLength,
          autovalidateMode: widget.autovalidateMode,
          style: TextStyle(fontSize: isDesktop ? 20 : 12.sp),
          decoration: InputDecoration(
            labelText: widget.labelText,
            hintText: widget.hintText,
            errorText: widget.errorText,
            helperText: widget.helperText,

            prefixIcon: widget.prefixIcon,
            suffixIcon:
                widget.isPassword && widget.showPasswordToggle
                    ? IconButton(
                      icon: Icon(
                        _obscureText ? Icons.visibility : Icons.visibility_off,
                        color: TColors.primary,
                        size: isDesktop ? 20 : 18.sp,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                    : widget.suffixIcon,
            filled: true,
            fillColor: MaterialStateColor.resolveWith(
              (states) => TColors.textWhite,
            ),
            contentPadding: EdgeInsets.symmetric(
              horizontal: isDesktop ? 4.w : 14.w,
              vertical: isDesktop ? 18.h : 16.h,
            ),
            isDense: true,
            hoverColor: TColors.textWhite,
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: TColors.borderSecondary),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: TColors.primary, width: 1.5),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: TColors.error),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: const BorderSide(color: TColors.error, width: 1.5),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(12.r),
              borderSide: BorderSide(color: TColors.grey.withOpacity(0.4)),
            ),
          ),
        ),
      ],
    );
  }
}
