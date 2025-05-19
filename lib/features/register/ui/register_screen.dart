import 'package:flutter/material.dart';
import 'package:sayeercoop/common/layout/responsive.dart';
import 'package:sayeercoop/features/register/ui/widgets/register_stepper.dart';

class RegisterScreen extends StatefulWidget {
  final String? referralCode;

  const RegisterScreen({super.key, this.referralCode});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen>
    with SingleTickerProviderStateMixin {
  double _opacity = 0.0;

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(milliseconds: 300), () {
      setState(() {
        _opacity = 1.0;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);
    final screenWidth = MediaQuery.of(context).size.width;
    final screenHeight = MediaQuery.of(context).size.height;

    final animatedImage = AnimatedOpacity(
      duration: Duration(seconds: 1),
      opacity: _opacity,
      curve: Curves.easeIn,
      child: Image.asset("assets/images/JoinSayeer.png", fit: BoxFit.contain),
    );

    return Scaffold(
      backgroundColor: Color(0xFFF2F9FE),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
            child: Padding(
              padding: const EdgeInsets.all(16),
              child:
                  isDesktop
                      ? Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SizedBox(
                            width: screenWidth * 0.4,
                            child: const RegisterStepper(),
                          ),
                          const SizedBox(width: 40),
                          SizedBox(
                            width: screenWidth * 0.4,
                            height: screenHeight * 0.6,
                            child: animatedImage,
                          ),
                        ],
                      )
                      : Column(
                        children: [
                          SizedBox(
                            width: screenHeight * 0.7,
                            height: screenHeight * 0.5,
                            child: animatedImage,
                          ),
                          SizedBox(
                            width: screenWidth * 0.85,
                            child: const RegisterStepper(),
                          ),
                        ],
                      ),
            ),
          ),
        ),
      ),
    );
  }
}
