import 'package:flutter/material.dart';
import 'package:sayeercoop/common/theme/colors.dart';
import 'package:url_launcher/url_launcher.dart';

class DownloadButton extends StatefulWidget {
  const DownloadButton({super.key, required this.isDesktop});

  final bool isDesktop;

  @override
  State<DownloadButton> createState() => _DownloadButtonState();
}

class _DownloadButtonState extends State<DownloadButton>
    with SingleTickerProviderStateMixin {
  bool isHovered = false;
  bool isFlying = false;
  late AnimationController _controller;
  late Animation<Offset> _rocketAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    );

    _rocketAnimation = Tween<Offset>(
      begin: Offset.zero,
      end: const Offset(13, -2),
    ).animate(CurvedAnimation(parent: _controller, curve: Curves.easeOut));
  }

  Future<void> launchAppStore() async {
    if (!isFlying) {
      setState(() => isFlying = true);
      await _controller.forward();
      await _controller.reverse();
      setState(() => isFlying = false);
    }

    final url = Uri.parse(
      "https://apps.apple.com/us/app/sayer-%D8%B3%D8%A7%D9%8A%D8%B1/id6596770954",
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final double imageWidth =
        widget.isDesktop
            ? MediaQuery.of(context).size.width * 0.25
            : MediaQuery.of(context).size.width * 0.35;

    return MouseRegion(
      onEnter: (_) => setState(() => isHovered = true),
      onExit: (_) => setState(() => isHovered = false),
      child: GestureDetector(
        onTap: launchAppStore,
        behavior: HitTestBehavior.opaque,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              width: imageWidth,
              child: Image.asset("assets/images/download.png"),
            ),
            const SizedBox(height: 16),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Row(
                children: [
                  SlideTransition(
                    position: _rocketAnimation,
                    child: const Text('🚀', style: TextStyle(fontSize: 24)),
                  ),
                  const SizedBox(width: 8),
                  Text(
                    'القى سيارتك الان! حمل التطبيق',
                    style: TextStyle(
                      color: isHovered ? TColors.primary : TColors.SbuttomColor,
                      fontSize: widget.isDesktop ? 22 : 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
