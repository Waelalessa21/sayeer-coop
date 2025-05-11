import 'package:flutter/material.dart';
import 'package:sayeercoop/common/layout/responsive.dart';
import 'package:sayeercoop/common/widgets/header/desktop_headers.dart';
import 'package:sayeercoop/common/widgets/header/mobile_header.dart';
import 'package:sayeercoop/features/landing/ui/widgets/know_us.dart';
import 'package:sayeercoop/features/landing/ui/widgets/send_message.dart';
import 'package:sayeercoop/features/landing/ui/widgets/start_section.dart';

class LandingScreen extends StatefulWidget {
  const LandingScreen({super.key});

  @override
  State<LandingScreen> createState() => _LandingScreenState();
}

class _LandingScreenState extends State<LandingScreen>
    with SingleTickerProviderStateMixin {
  final ScrollController _scrollController = ScrollController();
  final GlobalKey _knowUsKey = GlobalKey();
  final GlobalKey _sendMessageKey = GlobalKey();

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
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF2F9FE),
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
              StartSection(),
              const SizedBox(height: 60),
              KnowUs(key: _knowUsKey),
              SendMessage(key: _sendMessageKey),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
