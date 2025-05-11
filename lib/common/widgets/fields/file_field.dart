import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sayeercoop/common/layout/responsive.dart';
import 'package:sayeercoop/common/theme/colors.dart';

class FilePickerField extends StatelessWidget {
  final String title;
  final PlatformFile? file;
  final Function(PlatformFile) onFileSelected;

  const FilePickerField({
    super.key,
    required this.title,
    required this.file,
    required this.onFileSelected,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

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
        InkWell(
          onTap: () async {
            final result = await FilePicker.platform.pickFiles(
              type: FileType.custom,
              allowedExtensions: ['pdf'],
            );
            if (result != null) onFileSelected(result.files.first);
          },
          borderRadius: BorderRadius.circular(12.r),
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 14.h),
            decoration: BoxDecoration(
              color: TColors.textWhite,
              borderRadius: BorderRadius.circular(12.r),
              border: Border.all(color: TColors.borderSecondary),
            ),
            child: Row(
              children: [
                Icon(Icons.upload_file, color: TColors.primary, size: 14.sp),
                SizedBox(width: 12.w),
                Expanded(
                  child: Text(
                    file == null ? "اختر الملف (PDF)" : file!.name,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 8.sp,
                      color: TColors.textDarkBlue,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
