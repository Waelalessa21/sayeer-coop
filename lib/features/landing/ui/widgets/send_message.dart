import 'package:flutter/material.dart';
import 'package:sayeercoop/common/layout/responsive.dart';
import 'package:sayeercoop/common/theme/colors.dart';
import 'package:sayeercoop/features/landing/ui/widgets/message_form.dart';

class SendMessage extends StatelessWidget {
  const SendMessage({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child:
          isDesktop
              ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(bottom: 100.0),
                    child: Column(
                      children: [
                        Text(
                          "تواصل معنا",
                          style: TextStyle(
                            color: TColors.SbuttomColor,
                            fontWeight: FontWeight.bold,
                            fontFamily: "IBMPlexSansArabic",
                            fontSize: 40,
                          ),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'وصل لنا الرسالة اللي تبيها أو اسأل السؤال اللي تبي تعرفه!',
                          style: TextStyle(
                            fontSize: 20,
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 75),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.3,
                    child: const SendMessageForm(),
                  ),
                ],
              )
              : Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "تواصل معنا",
                    style: TextStyle(
                      color: TColors.SbuttomColor,
                      fontWeight: FontWeight.bold,
                      fontFamily: "IBMPlexSansArabic",
                      fontSize: 32,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'وصل لنا الرسالة اللي تبيها أو اسأل السؤال اللي تبي تعرفه!',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 18, color: Colors.grey[700]),
                  ),
                  const SizedBox(height: 32),
                  SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: const SendMessageForm(),
                  ),
                ],
              ),
    );
  }
}
