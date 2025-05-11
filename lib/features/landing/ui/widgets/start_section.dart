import 'package:flutter/material.dart';
import 'package:sayeercoop/features/landing/ui/widgets/phone_mock.dart';
import 'package:sayeercoop/features/landing/ui/widgets/start_text.dart';

class StartSection extends StatefulWidget {
  const StartSection({super.key});

  @override
  State<StartSection> createState() => _StartSectionState();
}

class _StartSectionState extends State<StartSection>
    with TickerProviderStateMixin {
  late AnimationController _phoneAnimationController;
  late AnimationController _textAnimationController;
  late Animation<double> _phoneSlideAnimation;
  late Animation<double> _textFadeAnimation;
  late Animation<Offset> _textSlideAnimation;

  @override
  void initState() {
    super.initState();
    _phoneAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    );
    _phoneSlideAnimation = Tween<double>(begin: 50.0, end: 0.0).animate(
      CurvedAnimation(
        parent: _phoneAnimationController,
        curve: Curves.easeOutCubic,
      ),
    );
    _textAnimationController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
    );
    _textFadeAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: _textAnimationController,
        curve: const Interval(0.2, 0.8, curve: Curves.easeOut),
      ),
    );
    _textSlideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.2),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _textAnimationController,
        curve: const Interval(0.2, 0.7, curve: Curves.easeOut),
      ),
    );
    Future.delayed(const Duration(milliseconds: 100), () {
      _phoneAnimationController.forward();
      _textAnimationController.forward();
    });
  }

  @override
  void dispose() {
    _phoneAnimationController.dispose();
    _textAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final screenWidth = MediaQuery.of(context).size.width;
    final isDesktop = screenWidth > 800;

    return Stack(
      children: [
        isDesktop
            ? Padding(
              padding: EdgeInsets.symmetric(horizontal: screenWidth * 0.08),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  FadeTransition(
                    opacity: _textFadeAnimation,
                    child: SlideTransition(
                      position: _textSlideAnimation,
                      child: const TextContent(isDesktop: true),
                    ),
                  ),

                  AnimatedBuilder(
                    animation: _phoneAnimationController,
                    builder: (context, child) {
                      return Transform.translate(
                        offset: Offset(_phoneSlideAnimation.value, 0),
                        child: child,
                      );
                    },
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.3,
                      child: PhoneImage(),
                    ),
                  ),
                ],
              ),
            )
            : Padding(
              padding: const EdgeInsets.symmetric(horizontal: 24),
              child: Column(
                children: [
                  FadeTransition(
                    opacity: _textFadeAnimation,
                    child: SlideTransition(
                      position: _textSlideAnimation,
                      child: const TextContent(isDesktop: false),
                    ),
                  ),
                  const SizedBox(height: 40),
                  SizedBox(
                    height: MediaQuery.of(context).size.height * 0.7,
                    child: AnimatedBuilder(
                      animation: _phoneAnimationController,
                      builder: (context, child) {
                        return Transform.translate(
                          offset: Offset(0, -_phoneSlideAnimation.value),
                          child: child,
                        );
                      },
                      child: const PhoneImage(),
                    ),
                  ),
                ],
              ),
            ),
      ],
    );
  }
}
