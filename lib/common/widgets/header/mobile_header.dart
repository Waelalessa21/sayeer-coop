import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';
import 'package:sayeercoop/common/routing/extension.dart';
import 'package:sayeercoop/common/routing/routes.dart';
import 'package:sayeercoop/common/theme/colors.dart';
import 'package:sayeercoop/common/widgets/buttons/header_button.dart';

class MobileHeader extends StatefulWidget {
  final VoidCallback onKnowUsTap;
  final VoidCallback onSendMessageTap;

  const MobileHeader({
    super.key,
    required this.onKnowUsTap,
    required this.onSendMessageTap,
  });

  @override
  State<MobileHeader> createState() => _MobileHeaderState();
}

class _MobileHeaderState extends State<MobileHeader>
    with TickerProviderStateMixin {
  bool showMenu = false;
  late AnimationController _controller;
  late Animation<Offset> _slideAnimation;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _slideAnimation = Tween<Offset>(
      begin: const Offset(0, -0.3),
      end: Offset.zero,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeInOut));
    _fadeAnimation = Tween<double>(
      begin: 0,
      end: 1,
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  void _toggleMenu(bool value) {
    setState(() => showMenu = value);
    if (value) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      child:
          showMenu
              ? Container(
                key: const ValueKey('menu'),
                width: double.infinity,
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Image.asset("assets/icons/startup.png", width: 25),
                        Align(
                          alignment: Alignment.centerLeft,
                          child: IconButton(
                            splashColor: Colors.transparent,
                            highlightColor: Colors.transparent,
                            icon: const Icon(Icons.arrow_upward),
                            color: TColors.Ssecondery,
                            onPressed: () => _toggleMenu(false),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 20),
                    FadeTransition(
                      opacity: _fadeAnimation,
                      child: SlideTransition(
                        position: _slideAnimation,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            HeaderLink(
                              label: 'تعرف علينا',
                              onTap: () {
                                _toggleMenu(false);
                                widget.onKnowUsTap();
                              },
                            ),
                            SizedBox(width: 20.w),
                            HeaderLink(
                              label: 'قدّم الآن',
                              onTap: () {
                                _toggleMenu(false);
                                context.go(Routes.registerScreen);
                              },
                            ),
                            SizedBox(width: 20.w),
                            HeaderLink(
                              label: 'اكتب رسالتك',
                              onTap: () {
                                _toggleMenu(false);
                                widget.onSendMessageTap();
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              )
              : Container(
                key: const ValueKey('header'),
                padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 12.h),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'ساير',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 22,
                        color: TColors.Ssecondery,
                      ),
                    ),
                    IconButton(
                      icon: const Icon(Icons.menu),
                      color: TColors.Ssecondery,
                      splashColor: Colors.transparent,
                      onPressed: () => _toggleMenu(true),
                    ),
                  ],
                ),
              ),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
}
