import 'package:flutter/material.dart';
import 'package:sayeercoop/common/layout/responsive.dart';
import 'package:sayeercoop/common/theme/colors.dart';
import 'package:sayeercoop/common/widgets/custom/why_sayer.dart';

class WhySayeer extends StatefulWidget {
  const WhySayeer({super.key});

  @override
  State<WhySayeer> createState() => _WhySayeerState();
}

class _WhySayeerState extends State<WhySayeer>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;

  @override
  void initState() {
    super.initState();

    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );

    _fadeAnimation = CurvedAnimation(parent: _controller, curve: Curves.easeIn);

    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, 0.1),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));

    _controller.forward();
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RichText(
                textAlign: TextAlign.center,
                text: TextSpan(
                  text: 'انضم الان ',
                  style: TextStyle(
                    fontSize: isDesktop ? 30 : 26,
                    color: Colors.black,
                    fontFamily: "IBMPlexSansArabic",
                  ),
                  children: [
                    TextSpan(
                      text: 'لـساير',
                      style: TextStyle(
                        color: TColors.SbuttomColor,
                        fontWeight: FontWeight.bold,
                        fontSize: isDesktop ? 30 : 26,
                        fontFamily: "IBMPlexSansArabic",
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              Text(
                'من هنا تبدأ الحكاية… بخطوة واحدة نحو مستقبل أفضل',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: isDesktop ? 18 : 15,
                  color: Colors.grey[700],
                ),
              ),
              const SizedBox(height: 24),

              isDesktop
                  ? SizedBox(
                    width: MediaQuery.of(context).size.width * 0.6,
                    child: WhySayerCard(
                      icon: Icons.rocket_launch,
                      label: 'وش تنتظر؟',
                      description: 'ابدا مسيرتك معنا الان',
                    ),
                  )
                  : WhySayerCard(
                    icon: Icons.rocket_launch,
                    label: 'وش تنتظر؟',
                    description: 'ابدا مسيرتك معنا الان',
                  ),
            ],
          ),
        ),
      ),
    );
  }
}
