import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:sayeercoop/common/widgets/buttons/app_button.dart';
import 'package:sayeercoop/common/widgets/custom/message.dart';
import 'package:sayeercoop/common/widgets/fields/app_text_field.dart';

class SendMessageForm extends StatefulWidget {
  const SendMessageForm({super.key});

  @override
  State<SendMessageForm> createState() => _SendMessageFormState();
}

class _SendMessageFormState extends State<SendMessageForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController messageController = TextEditingController();
  final TextEditingController titleController = TextEditingController();

  bool isLoading = false;
  AutovalidateMode autoValidate = AutovalidateMode.onUserInteraction;

  void _submitForm() async {
    if (_formKey.currentState!.validate()) {
      setState(() => isLoading = true);

      try {
        await FirebaseFirestore.instance.collection('messages').add({
          'title': titleController.text,
          'message': messageController.text,
          'email': emailController.text,
          'timestamp': FieldValue.serverTimestamp(),
        });

        showToastMessage(
          context,
          "رسالتك وصلت! انتظر ردنا",
          "assets/icons/startup.png",
          isError: false,
        );

        setState(() {
          titleController.clear();
          messageController.clear();
          emailController.clear();
          autoValidate = AutovalidateMode.disabled;
        });
      } catch (e) {
        showToastMessage(
          context,
          "حدث خطأ",
          "assets/icons/exclamation.png",
          isError: true,
        );
      } finally {
        setState(() => isLoading = false);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Form(
      key: _formKey,
      autovalidateMode: autoValidate,
      child: Column(
        children: [
          CustomTextField(
            controller: titleController,
            autovalidateMode: autoValidate,

            fieldTitle: "عنوان رسالتك",
            validator:
                (value) =>
                    value == null || value.isEmpty ? 'هذا الحقل مطلوب' : null,
            hintText: 'مقر التدريب التعاوني',
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: messageController,
            autovalidateMode: autoValidate,

            maxLines: 5,
            fieldTitle: "رسالتك",
            validator:
                (value) =>
                    value == null || value.isEmpty ? 'هذا الحقل مطلوب' : null,
            hintText: 'وين راح يكون التدريب التعاوني؟',
          ),
          const SizedBox(height: 16),
          CustomTextField(
            controller: emailController,
            autovalidateMode: autoValidate,
            fieldTitle: "بريدك الالكتروني",
            keyboardType: TextInputType.emailAddress,
            validator:
                (value) =>
                    value != null && value.contains('@')
                        ? null
                        : 'بريد غير صحيح',
            hintText: 'abdullah@gmail.com',
          ),
          const SizedBox(height: 24),
          CustomButton(onPressed: _submitForm, text: "إرسال"),
        ],
      ),
    );
  }
}
