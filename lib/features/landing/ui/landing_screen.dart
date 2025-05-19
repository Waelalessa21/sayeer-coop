import 'package:flutter/material.dart';
import 'package:sayeercoop/common/layout/responsive.dart';
import 'package:sayeercoop/common/widgets/header/desktop_headers.dart';
import 'package:sayeercoop/common/widgets/header/mobile_header.dart';
import 'package:sayeercoop/features/landing/ui/widgets/know_us.dart';
import 'package:sayeercoop/features/landing/ui/widgets/send_message.dart';
import 'package:sayeercoop/features/landing/ui/widgets/start_section.dart';
import 'package:sayeercoop/features/landing/ui/widgets/why_sayeer.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen> {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _knowUsKey = GlobalKey();
  final GlobalKey _whySayeer = GlobalKey();

  final GlobalKey _sendMessageKey = GlobalKey();

  bool _showStart = false;
  bool _showKnowUs = false;
  bool _showSendMessage = false;
  bool _showWhySayeer = false;

  void _scrollToKnowUs() {
    final context = _knowUsKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  void _scrollToSendMessage() {
    final context = _sendMessageKey.currentContext;
    if (context != null) {
      Scrollable.ensureVisible(
        context,
        duration: const Duration(milliseconds: 600),
        curve: Curves.easeInOut,
      );
    }
  }

  @override
  void initState() {
    super.initState();

    Future.delayed(const Duration(milliseconds: 300), () {
      setState(() => _showStart = true);
    });

    Future.delayed(const Duration(milliseconds: 1000), () {
      setState(() => _showKnowUs = true);
    });

    Future.delayed(const Duration(milliseconds: 1500), () {
      setState(() => _showWhySayeer = true);
    });

    Future.delayed(const Duration(milliseconds: 2000), () {
      setState(() => _showSendMessage = true);
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget _animatedSection({required bool visible, required Widget child}) {
    return AnimatedOpacity(
      opacity: visible ? 1.0 : 0.0,
      duration: const Duration(milliseconds: 700),
      curve: Curves.easeOut,
      child: visible ? child : const SizedBox.shrink(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F9FE),
      body: SafeArea(
        child: SingleChildScrollView(
          controller: _scrollController,
          child: Column(
            children: [
              Responsive(
                mobile: MobileHeader(
                  onKnowUsTap: _scrollToKnowUs,
                  onSendMessageTap: _scrollToSendMessage,
                ),
                desktop: DesktopHeader(
                  onKnowUsTap: _scrollToKnowUs,
                  onSendMessageTap: _scrollToSendMessage,
                ),
              ),

              _animatedSection(
                visible: _showStart,
                child: const StartSection(),
              ),
              const SizedBox(height: 60),

              _animatedSection(
                visible: _showKnowUs,
                child: KnowUs(key: _knowUsKey),
              ),
              const SizedBox(height: 60),

              _animatedSection(
                visible: _showWhySayeer,
                child: WhySayeer(key: _whySayeer),
              ),
              const SizedBox(height: 60),

              _animatedSection(
                visible: _showSendMessage,
                child: SendMessage(key: _sendMessageKey),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
