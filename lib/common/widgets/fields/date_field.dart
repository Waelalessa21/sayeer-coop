import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sayeercoop/common/layout/responsive.dart';
import 'package:sayeercoop/common/theme/colors.dart';

class DateField extends StatelessWidget {
  final String title;
  final DateTime? selectedDate;
  final Function(DateTime) onDateSelected;

  const DateField({
    super.key,
    required this.title,
    required this.selectedDate,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    String formatPart(String? value) {
      if (value == null) return '--';
      return value.padLeft(2, '0');
    }

    final day = selectedDate?.day.toString();
    final month = selectedDate?.month.toString();
    final year = selectedDate?.year.toString();

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: TextStyle(
            fontSize: isDesktop ? 14 : 13.sp,
            fontWeight: FontWeight.w300,
            color: TColors.textDarkBlue,
          ),
        ),
        SizedBox(height: 10.h),
        GestureDetector(
          onTap: () async {
            final date = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2023),
              lastDate: DateTime(2030),
              builder: (context, child) {
                return Theme(
                  data: Theme.of(context).copyWith(
                    dialogBackgroundColor: Colors.white,
                    colorScheme: ColorScheme.light(
                      primary: TColors.textDarkBlue,
                      onPrimary: Colors.white,
                      onSurface: TColors.textDarkBlue,
                    ),
                    textButtonTheme: TextButtonThemeData(
                      style: TextButton.styleFrom(
                        foregroundColor: TColors.textDarkBlue,
                      ),
                    ),
                  ),
                  child: child!,
                );
              },
            );
            if (date != null) onDateSelected(date);
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              _buildDateBox(formatPart(day)),
              _buildDateBox(formatPart(month)),
              _buildDateBox(formatPart(year?.substring(2))),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildDateBox(String value) {
    return Container(
      width: 20.w,
      height: 20.w,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(8.r),
        border: Border.all(color: TColors.borderSecondary),
      ),
      child: Text(
        value,
        style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 8.sp,
          color: TColors.textDarkBlue,
        ),
      ),
    );
  }
}
