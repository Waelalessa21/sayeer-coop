import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sayeercoop/common/theme/colors.dart';
import 'package:sayeercoop/common/widgets/fields/app_text_field.dart';
import 'package:sayeercoop/common/widgets/fields/date_field.dart';
import 'package:sayeercoop/common/widgets/fields/file_field.dart';

class RegisterForm extends StatefulWidget {
  final int currentStep;
  final TextEditingController nameController;
  final TextEditingController phoneController;
  final TextEditingController emailController;
  final TextEditingController majorController;
  final TextEditingController gpaController;
  final TextEditingController bioController;
  final TextEditingController experienceController;
  final DateTime? expectedStartDate;
  final PlatformFile? cvFile;
  final Function(DateTime) onDateSelected;
  final Function(PlatformFile) onFileSelected;
  final VoidCallback sendCVByEmail;

  const RegisterForm({
    super.key,
    required this.currentStep,
    required this.nameController,
    required this.phoneController,
    required this.emailController,
    required this.majorController,
    required this.gpaController,
    required this.bioController,
    required this.experienceController,
    required this.expectedStartDate,
    required this.cvFile,
    required this.onDateSelected,
    required this.onFileSelected,
    required this.sendCVByEmail,
  });

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  String gpaOutOf = '5';

  String? validatePhone(String? value) {
    final pattern = RegExp(r'^(05)[0-9]{8}$');
    if (value == null || !pattern.hasMatch(value)) return 'رقم غير صحيح';
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || !value.contains('@')) return 'بريد غير صالح';
    return null;
  }

  String? validateGpa(String? value) {
    final gpa = double.tryParse(value ?? '');
    if (gpa == null) return 'المعدل غير صالح';
    final max = gpaOutOf == '5' ? 5.0 : 4.0;
    if (gpa < 0 || gpa > max) return 'المعدل يجب أن يكون بين 0 و $max';
    return null;
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.currentStep) {
      case 0:
        return Column(
          children: [
            CustomTextField(
              fieldTitle: "الاسم",
              controller: widget.nameController,
              hintText: "عبدالله سعود",
              validator: (v) => v!.isEmpty ? "مطلوب" : null,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              fieldTitle: "رقم الجوال",
              controller: widget.phoneController,
              hintText: "05XXXXXXXX",
              keyboardType: TextInputType.phone,
              validator: validatePhone,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              fieldTitle: "الإيميل",
              controller: widget.emailController,
              hintText: "Abdullah@example.com",
              keyboardType: TextInputType.emailAddress,
              validator: validateEmail,
            ),
          ],
        );
      case 1:
        return Column(
          children: [
            CustomTextField(
              fieldTitle: "التخصص",
              controller: widget.majorController,
              hintText: "علوم حاسب",
              validator: (v) => v!.isEmpty ? "مطلوب" : null,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  flex: 3,
                  child: CustomTextField(
                    fieldTitle: "المعدل",
                    controller: widget.gpaController,
                    hintText: "4.32",
                    keyboardType: TextInputType.number,
                    validator: validateGpa,
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  flex: 1,
                  child: DropdownMenu<String>(
                    initialSelection: gpaOutOf,
                    onSelected: (v) => setState(() => gpaOutOf = v!),
                    inputDecorationTheme: InputDecorationTheme(
                      filled: true,
                      fillColor: TColors.textWhite,
                      hoverColor: TColors.textWhite,
                      enabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(
                          color: TColors.borderSecondary,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(
                          color: TColors.primary,
                          width: 1.5,
                        ),
                      ),
                      errorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(color: TColors.error),
                      ),
                      focusedErrorBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: const BorderSide(
                          color: TColors.error,
                          width: 1.5,
                        ),
                      ),
                      disabledBorder: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12.r),
                        borderSide: BorderSide(
                          color: TColors.grey.withOpacity(0.4),
                        ),
                      ),
                    ),
                    menuStyle: MenuStyle(
                      shape: MaterialStateProperty.all(
                        RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                        ),
                      ),
                      backgroundColor: MaterialStateProperty.all(Colors.white),
                      elevation: MaterialStateProperty.all(6),
                    ),
                    dropdownMenuEntries: [
                      DropdownMenuEntry(value: "5", label: "5"),
                      DropdownMenuEntry(value: "4", label: "4"),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            CustomTextField(
              fieldTitle: "نبذة",
              controller: widget.bioController,
              hintText:
                  "طالب علوم حاسب، مبرمج تطبيقات و مهتم بالذكاء الاصطناعي",
              validator: (v) => v!.isEmpty ? "مطلوب" : null,
            ),
          ],
        );
      case 2:
        return Column(
          children: [
            DateField(
              title: "التاريخ المتوقع لبداية التدريب",
              selectedDate: widget.expectedStartDate,
              onDateSelected: widget.onDateSelected,
            ),
            const SizedBox(height: 16),
            FilePickerField(
              title: "رفع السيرة الذاتية",
              file: widget.cvFile,
              onFileSelected: widget.onFileSelected,
              sendCVByEmail: widget.sendCVByEmail,
            ),
            const SizedBox(height: 16),
            CustomTextField(
              fieldTitle: "الخبرات إن وجدت",
              controller: widget.experienceController,
              hintText: "مثال: تدريب صيفي، مشروع تخرج، عمل تطوعي...",
              maxLines: 3,
            ),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
