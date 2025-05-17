import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sayeercoop/common/layout/responsive.dart';
import 'package:sayeercoop/common/theme/colors.dart';
import 'package:sayeercoop/features/landing/ui/widgets/message_form.dart';

class SendMessage extends StatefulWidget {
  const SendMessage({super.key});

  @override
  State<SendMessage> createState() => _SendMessageState();
}

class _SendMessageState extends State<SendMessage>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1000),
    );

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    // بدء الأنيميشن بعد بناء الواجهة
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _controller.forward();
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: FadeTransition(
        opacity: _fadeAnimation,
        child: SlideTransition(
          position: _slideAnimation,
          child:
              isDesktop
                  ? Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(bottom: 100.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "تواصل معنا",
                              style: TextStyle(
                                color: TColors.SbuttomColor,
                                fontWeight: FontWeight.bold,
                                fontFamily: "IBMPlexSansArabic",
                                fontSize: 30,
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
                            const SizedBox(height: 12),
                            SizedBox(
                              width: MediaQuery.of(context).size.width * 0.2,
                              child: Lottie.asset("assets/images/contact.json"),
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
                  //Mobile
                  : Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,

                        children: [
                          Text(
                            "تواصل معنا",
                            style: TextStyle(
                              color: TColors.SbuttomColor,
                              fontWeight: FontWeight.bold,
                              fontFamily: "IBMPlexSansArabic",
                              fontSize: 26,
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width * 0.1,
                            child: Lottie.asset("assets/images/contact.json"),
                          ),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'وصل لنا الرسالة اللي تبيها أو اسأل السؤال اللي تبي تعرفه!',
                        textAlign: TextAlign.center,
                        style: TextStyle(fontSize: 15, color: Colors.grey[700]),
                      ),
                      const SizedBox(height: 32),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.7,
                        child: const SendMessageForm(),
                      ),
                    ],
                  ),
        ),
      ),
    );
  }
}
