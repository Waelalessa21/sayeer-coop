import 'package:flutter/material.dart';
import 'package:sayeercoop/common/widgets/buttons/download_button.dart';

class TextContent extends StatelessWidget {
  final bool isDesktop;

  const TextContent({super.key, required this.isDesktop});

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
          DownloadButton(isDesktop: isDesktop),
        ],
      ),
    );
  }
}
