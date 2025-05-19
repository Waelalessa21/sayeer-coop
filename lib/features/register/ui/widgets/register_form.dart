import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:sayeercoop/common/helpers/extractor.dart';
import 'package:sayeercoop/common/helpers/validator.dart';
import 'package:sayeercoop/common/theme/colors.dart';
import 'package:sayeercoop/common/widgets/custom/message.dart';
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
  });

  @override
  State<RegisterForm> createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm>
    with SingleTickerProviderStateMixin {
  String gpaOutOf = '5';
  late AnimationController _controller;
  late List<Animation<Offset>> _slideAnimations;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      duration: const Duration(milliseconds: 800),
      vsync: this,
    );

    _buildAnimations();
    _controller.forward();
  }

  void _buildAnimations() {
    _slideAnimations = List.generate(6, (index) {
      return Tween<Offset>(
        begin: const Offset(0, 0.3),
        end: Offset.zero,
      ).animate(
        CurvedAnimation(
          parent: _controller,
          curve: Interval(index * 0.1, 1.0, curve: Curves.easeOut),
        ),
      );
    });
  }

  @override
  void didUpdateWidget(covariant RegisterForm oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.currentStep != widget.currentStep) {
      _controller.reset();
      _buildAnimations();
      _controller.forward();
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    switch (widget.currentStep) {
      case 0:
        return Column(
          children: [
            SlideTransition(
              position: _slideAnimations[0],
              child: CustomTextField(
                fieldTitle: "الاسم",
                controller: widget.nameController,
                hintText: "عبدالله سعود",
                validator: Validators.validateRequired,
              ),
            ),
            const SizedBox(height: 16),
            SlideTransition(
              position: _slideAnimations[1],
              child: CustomTextField(
                fieldTitle: "رقم الجوال",
                controller: widget.phoneController,
                hintText: "05XXXXXXXX",
                keyboardType: TextInputType.phone,
                validator: Validators.validatePhone,
              ),
            ),
            const SizedBox(height: 16),
            SlideTransition(
              position: _slideAnimations[2],
              child: CustomTextField(
                fieldTitle: "الإيميل",
                controller: widget.emailController,
                hintText: "Abdullah@example.com",
                keyboardType: TextInputType.emailAddress,
                validator: Validators.validateEmail,
              ),
            ),
          ],
        );
      case 1:
        return Column(
          children: [
            SlideTransition(
              position: _slideAnimations[0],
              child: CustomTextField(
                fieldTitle: "التخصص",
                controller: widget.majorController,
                keyboardType: TextInputType.text,
                hintText: "علوم حاسب",
                validator: Validators.validateRequired,
              ),
            ),
            const SizedBox(height: 16),
            SlideTransition(
              position: _slideAnimations[1],
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Expanded(
                    flex: 2,
                    child: CustomTextField(
                      fieldTitle: "المعدل",
                      controller: widget.gpaController,
                      hintText: "4.32",
                      keyboardType: TextInputType.text,
                      validator:
                          (value) => Validators.validateGpa(value, gpaOutOf),
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
                        backgroundColor: MaterialStateProperty.all(
                          Colors.white,
                        ),
                        elevation: MaterialStateProperty.all(6),
                      ),
                      dropdownMenuEntries: const [
                        DropdownMenuEntry(value: "5", label: "5"),
                        DropdownMenuEntry(value: "4", label: "4"),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            SlideTransition(
              position: _slideAnimations[2],
              child: CustomTextField(
                fieldTitle: "نبذة",
                maxLines: 4,
                maxLength: 120,
                controller: widget.bioController,
                hintText:
                    "طالب علوم حاسب، مبرمج تطبيقات و مهتم بالذكاء الاصطناعي",
                validator: Validators.validateRequired,
              ),
            ),
          ],
        );
      case 2:
        return Column(
          children: [
            SlideTransition(
              position: _slideAnimations[0],
              child: DateField(
                title: "التاريخ المتوقع لبداية التدريب",
                selectedDate: widget.expectedStartDate,
                onDateSelected: widget.onDateSelected,
              ),
            ),
            const SizedBox(height: 16),
            SlideTransition(
              position: _slideAnimations[1],
              child: FilePickerField(
                title: "رفع السيرة الذاتية",
                file: widget.cvFile,
                onFileSelected: (file) async {
                  showDialog(
                    context: context,
                    barrierDismissible: false,
                    builder:
                        (context) =>
                            const Center(child: CircularProgressIndicator()),
                  );

                  try {
                    widget.onFileSelected(file);
                    final text = await extractPdfText(file);
                    if (text == null && context.mounted) {
                      showToastMessage(
                        context,
                        "تأكد من حجم الملف!",
                        'assets/icons/warning.png',
                        isError: true,
                      );
                    }
                  } finally {
                    if (mounted) {
                      Navigator.of(context).pop();
                    }
                  }
                },
              ),
            ),
            const SizedBox(height: 16),
            SlideTransition(
              position: _slideAnimations[2],
              child: CustomTextField(
                fieldTitle: "الخبرات إن وجدت",
                controller: widget.experienceController,
                hintText: "مثال: تدريب صيفي، مشروع تخرج، عمل تطوعي...",
                maxLines: 3,
              ),
            ),
          ],
        );
      default:
        return const SizedBox.shrink();
    }
  }
}
