import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sayeercoop/common/helpers/extractor.dart';
import 'package:sayeercoop/common/layout/responsive.dart';
import 'package:sayeercoop/common/routing/routes.dart';
import 'package:sayeercoop/common/theme/colors.dart';
import 'package:sayeercoop/common/widgets/buttons/app_button.dart';
import 'package:sayeercoop/common/widgets/custom/message.dart';
import 'package:sayeercoop/features/register/ui/widgets/arrow_back.dart';
import 'package:sayeercoop/features/register/ui/widgets/loadingOverlay.dart';
import 'package:sayeercoop/features/register/ui/widgets/register_form.dart';
import 'package:sayeercoop/features/register/ui/widgets/step_icon_container.dart';

class RegisterStepper extends StatefulWidget {
  const RegisterStepper({super.key});

  @override
  State<RegisterStepper> createState() => _RegisterStepperState();
}

class _RegisterStepperState extends State<RegisterStepper> {
  final _formKey = GlobalKey<FormState>();
  int currentStep = 0;
  bool isLoading = false;

  final bioController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneController = TextEditingController();
  final majorController = TextEditingController();
  final gpaController = TextEditingController();
  final experienceController = TextEditingController();
  DateTime? expectedStartDate;
  PlatformFile? cvFile;

  final List<String> stepTitles = [
    'المعلومات الشخصية',
    'المؤهل العلمي',
    'التدريب التعاوني',
  ];

  final List<String> stepSubtitles = [
    'عرفنا عليك؟',
    'علّمنا عن دراستك!',
    'أكمل معلومات التدريب',
  ];

  final List<String> stepIcons = [
    'assets/icons/profile.png',
    'assets/icons/mortarboard.png',
    'assets/icons/teaching.png',
  ];

  void nextStep() {
    if (_formKey.currentState!.validate()) {
      if (currentStep < 2) {
        setState(() => currentStep++);
      } else {
        submitForm();
      }
    }
  }

  void previousStep() {
    if (currentStep > 0) {
      setState(() => currentStep--);
    }
  }

  @override
  void initState() {
    super.initState();
    _initializeSerialCounter();
  }

  void _initializeSerialCounter() async {
    final docRef = FirebaseFirestore.instance
        .collection('sequence')
        .doc('coop_id');
    final snapshot = await docRef.get();
    if (!snapshot.exists) {
      await docRef.set({'last': 99});
    }
  }

  void submitForm() async {
    if (!_formKey.currentState!.validate()) {
      showToastMessage(
        context,
        'تأكد من إدخال جميع الحقول بشكل صحيح',
        'assets/icons/error.png',
        isError: true,
      );
      return;
    }

    try {
      setState(() => isLoading = true);
      await Future.delayed(Duration.zero);
      final snapshot =
          await FirebaseFirestore.instance
              .collection('sequence')
              .doc('coop_id')
              .get();
      int serial = 100;
      if (snapshot.exists && snapshot.data()?['last'] != null) {
        serial = snapshot.data()!['last'] + 1;
      }
      await FirebaseFirestore.instance
          .collection('sequence')
          .doc('coop_id')
          .set({'last': serial});
      await FirebaseFirestore.instance.collection('coops').add({
        'name': nameController.text,
        'phone': phoneController.text,
        'email': emailController.text,
        'major': majorController.text,
        'gpa': gpaController.text,
        'bio': bioController.text,
        'experience': experienceController.text,
        'expectedStartDate': expectedStartDate?.toIso8601String(),
        'timestamp': FieldValue.serverTimestamp(),
        'serial': serial,
      });
      setState(() => isLoading = false);
      context.go(Routes.doneScreen);
    } catch (e) {
      setState(() => isLoading = false);
      showToastMessage(
        context,
        'حدث خطأ أثناء إرسال البيانات: ${e.toString()}',
        'assets/icons/warning.png',
        isError: true,
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    return Stack(
      children: [
        Padding(
          padding: EdgeInsets.all(20.w),
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  child: Row(
                    key: ValueKey(currentStep),
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      StepIconContainer(iconPath: stepIcons[currentStep]),
                      SizedBox(width: 4.w),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            stepTitles[currentStep],
                            style: TextStyle(
                              fontSize: isDesktop ? 8.sp : 14.sp,
                              fontWeight: FontWeight.bold,
                              color: TColors.textDarkBlue,
                            ),
                          ),
                          SizedBox(height: 6.h),
                          Text(
                            stepSubtitles[currentStep],
                            style: TextStyle(
                              fontSize: isDesktop ? 6.sp : 11.sp,
                              color: Colors.grey,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 30.h),
                RegisterForm(
                  key: const PageStorageKey('register_form'),
                  currentStep: currentStep,
                  nameController: nameController,
                  phoneController: phoneController,
                  emailController: emailController,
                  majorController: majorController,
                  gpaController: gpaController,
                  bioController: bioController,
                  experienceController: experienceController,
                  expectedStartDate: expectedStartDate,
                  cvFile: cvFile,
                  onDateSelected:
                      (date) => setState(() => expectedStartDate = date),
                  onFileSelected: (file) async {
                    setState(() => cvFile = file);
                    final text = await extractPdfText(file);
                    if (text != null && context.mounted) {
                      await FirebaseFirestore.instance
                          .collection('cv_texts')
                          .add({
                            'name': nameController.text,
                            'email': emailController.text,
                            'phone': phoneController.text,
                            'major': majorController.text,
                            'text': text,
                            'timestamp': FieldValue.serverTimestamp(),
                          });
                    } else if (context.mounted) {
                      showToastMessage(
                        context,
                        'تعذر قراءة محتوى الملف',
                        'assets/icons/warning.png',
                        isError: true,
                      );
                    }
                  },
                ),
                SizedBox(height: 40.h),
                CustomButton(
                  text: currentStep == 2 ? "إرسال" : "التالي",
                  onPressed: nextStep,
                ),
                const SizedBox(height: 10),
                if (currentStep > 0) ArrowButton(onTap: previousStep),
              ],
            ),
          ),
        ),
        if (isLoading)
          const LoadingOverlay(
            message: 'طلبك انطلق… وساير رفيقك للانطلاق في مسارك🚀',
          ),
      ],
    );
  }
}
