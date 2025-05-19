import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sayeercoop/common/layout/responsive.dart';
import 'package:sayeercoop/common/theme/colors.dart';

class FilePickerField extends StatefulWidget {
  final String title;
  final PlatformFile? file;
  final Function(PlatformFile) onFileSelected;
  final bool isLoading;

  const FilePickerField({
    super.key,
    required this.title,
    required this.file,
    required this.onFileSelected,
    this.isLoading = false,
  });

  @override
  State<FilePickerField> createState() => _FilePickerFieldState();
}

class _FilePickerFieldState extends State<FilePickerField>
    with SingleTickerProviderStateMixin {
  late AnimationController _shakeController;
  late Animation<Offset> _shakeAnimation;

  @override
  void initState() {
    super.initState();
    _shakeController = AnimationController(
      duration: const Duration(milliseconds: 600),
      vsync: this,
    );

    _shakeAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(0.02, 0),
    ).animate(
      CurvedAnimation(parent: _shakeController, curve: Curves.easeInOut),
    );
  }

  @override
  void didUpdateWidget(covariant FilePickerField oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (widget.isLoading && !_shakeController.isAnimating) {
      _shakeController.repeat(reverse: true);
    } else if (!widget.isLoading && _shakeController.isAnimating) {
      _shakeController.stop();
    }
  }

  @override
  void dispose() {
    _shakeController.dispose();
    super.dispose();
  }

  Future<void> _pickFile() async {
    try {
      final result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['pdf'],
      );
      if (result != null && result.files.isNotEmpty) {
        widget.onFileSelected(result.files.first);
      }
    } catch (_) {}
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            fontSize: isDesktop ? 14 : 13.sp,
            fontWeight: FontWeight.w300,
            color: TColors.textDarkBlue,
          ),
        ),
        SizedBox(height: 10.h),
        InkWell(
          onTap: _pickFile,
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
                Icon(Icons.upload_file, color: TColors.primary, size: 12.sp),
                SizedBox(width: 12.w),
                Expanded(
                  child: SlideTransition(
                    position:
                        widget.isLoading
                            ? _shakeAnimation
                            : AlwaysStoppedAnimation(Offset.zero),
                    child: Text(
                      widget.file == null ? "سيرتك الذاتية" : widget.file!.name,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        fontSize: isDesktop ? 14 : 11.sp,
                        color: TColors.textDarkBlue,
                        fontWeight: FontWeight.w400,
                      ),
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
