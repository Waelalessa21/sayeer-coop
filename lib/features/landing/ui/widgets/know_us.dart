import 'package:flutter/material.dart';
import 'package:sayeercoop/common/layout/responsive.dart';
import 'package:sayeercoop/common/theme/colors.dart';

class KnowUs extends StatelessWidget {
  const KnowUs({super.key});

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 32, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RichText(
            textAlign: TextAlign.center,
            text: TextSpan(
              text: 'تعرف على ',
              style: TextStyle(
                fontSize: 30,
                color: Colors.black,
                fontFamily: "IBMPlexSansArabic",
              ),
              children: [
                TextSpan(
                  text: 'ساير؟',
                  style: TextStyle(
                    color: TColors.SbuttomColor,
                    fontWeight: FontWeight.bold,
                    fontFamily: "IBMPlexSansArabic",
                  ),
                ),
              ],
            ),
          ),

          const SizedBox(height: 12),

          Text(
            'ساير تطبيق يجمع عروض السيارات من الوكالات والمعارض في مكان واحد ليسهّل عليك عملية البحث والاختيار.',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontSize: isDesktop ? 18 : 16,
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
    );
  }
}
