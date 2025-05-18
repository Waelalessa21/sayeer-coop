import 'package:flutter/material.dart';
import 'package:sayeercoop/common/layout/responsive.dart';

class DoneImage extends StatelessWidget {
  final Animation<Offset> animation;
  final double width;
  final double height;

  const DoneImage({
    super.key,
    required this.animation,
    required this.width,
    required this.height,
  });

  @override
  Widget build(BuildContext context) {
    final isDesktop = Responsive.isDesktop(context);

    return SlideTransition(
      position: animation,
      child: SizedBox(
        width: isDesktop ? width * 0.3 : width * 0.7,
        height: isDesktop ? height * 0.5 : height * 0.5,
        child: Image.asset('assets/images/JoinSayeer.png'),
      ),
    );
  }
}
