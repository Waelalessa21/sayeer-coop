import 'package:flutter/material.dart';
import 'package:sayeercoop/common/layout/responsive.dart';
import 'package:sayeercoop/common/theme/colors.dart';

class KnowUs extends StatefulWidget {
  const KnowUs({super.key});

  @override
  State<KnowUs> createState() => _KnowUsState();
}

class _KnowUsState extends State<KnowUs> with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late final Animation<double> _fadeAnimation;
  late final Animation<Offset> _slideAnimation;
  bool _imageLoaded = false;

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

    WidgetsBinding.instance.addPostFrameCallback((_) {
      precacheImage(const AssetImage("assets/images/www.png"), context).then((
        _,
      ) {
        setState(() => _imageLoaded = true);
        _controller.forward();
      });
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
      child:
          _imageLoaded
              ? FadeTransition(
                opacity: _fadeAnimation,
                child: SlideTransition(
                  position: _slideAnimation,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      RichText(
                        textAlign: TextAlign.center,
                        text: TextSpan(
                          text: 'تعرف على ',
                          style: TextStyle(
                            fontSize: isDesktop ? 30 : 26,
                            color: Colors.black,
                            fontFamily: "IBMPlexSansArabic",
                          ),
                          children: [
                            TextSpan(
                              text: 'ساير؟',
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
                        'ساير تطبيق يجمع عروض السيارات من الوكالات والمعارض في مكان واحد ليسهّل عليك عملية البحث والاختيار',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: isDesktop ? 18 : 15,
                          color: Colors.grey[700],
                        ),
                      ),
                      const SizedBox(height: 24),
                      SizedBox(
                        width:
                            isDesktop
                                ? MediaQuery.of(context).size.width * 0.8
                                : double.infinity,

                        child: Image.asset("assets/images/www.png"),
                      ),
                    ],
                  ),
                ),
              )
              : const SizedBox(),
    );
  }
}
