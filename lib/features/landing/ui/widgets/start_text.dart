import 'package:flutter/material.dart';
import 'package:sayeercoop/features/landing/ui/widgets/start_button.dart';
import 'package:url_launcher/url_launcher.dart';

class TextContent extends StatelessWidget {
  final bool isDesktop;

  const TextContent({super.key, required this.isDesktop});

  Future<void> launchAppStore() async {
    final url = Uri.parse(
      "https://apps.apple.com/us/app/sayer-%D8%B3%D8%A7%D9%8A%D8%B1/id6596770954",
    );
    if (await canLaunchUrl(url)) {
      await launchUrl(url, mode: LaunchMode.externalApplication);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Directionality(
      textDirection: TextDirection.rtl,
      child: Column(
        crossAxisAlignment:
            isDesktop ? CrossAxisAlignment.start : CrossAxisAlignment.center,
        children: [
          Text(
            "ساير",
            style: TextStyle(
              fontSize: isDesktop ? 54 : 38,
              fontWeight: FontWeight.bold,
              color: const Color(0xFF4A63F6),
              height: 1.1,
            ),
            textAlign: isDesktop ? TextAlign.justify : TextAlign.center,
          ),
          const SizedBox(height: 8),
          Text(
            "ما تحتار معنا",
            style: TextStyle(
              fontSize: isDesktop ? 48 : 34,
              fontWeight: FontWeight.w900,
              color: const Color(0xFF0F172A),
              height: 1.1,
            ),
            textAlign: isDesktop ? TextAlign.justify : TextAlign.center,
          ),
          const SizedBox(height: 24),
          RichText(
            textAlign: isDesktop ? TextAlign.justify : TextAlign.center,
            text: TextSpan(
              style: TextStyle(
                fontSize: isDesktop ? 20 : 18,
                height: 1.6,
                fontFamily: "IBMPlexSansArabic",
              ),
              children: const [
                TextSpan(
                  text: "ساير حلها لك! ",
                  style: TextStyle(color: Color(0xFF64748B)),
                ),
                TextSpan(
                  text: "حنا ندور لك سيارتك ",
                  style: TextStyle(
                    color: Color(0xFF4A63F6),
                    fontWeight: FontWeight.bold,
                  ),
                ),
                TextSpan(
                  text: "و نجمع لك العروض",
                  style: TextStyle(
                    color: Color(0xFF4A63F6),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 20),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.25,
            child: Image.asset("assets/images/download.png"),
          ),
          SizedBox(height: 20),

          StartButton(onPressed: launchAppStore, text: "حمل التطبيق"),
        ],
      ),
    );
  }
}
