import 'package:flutter/material.dart';
import 'package:sayeercoop/common/theme/colors.dart';

class HeaderLink extends StatefulWidget {
  final String label;
  final VoidCallback onTap;

  const HeaderLink({super.key, required this.label, required this.onTap});

  @override
  State<HeaderLink> createState() => _HeaderLinkState();
}

class _HeaderLinkState extends State<HeaderLink>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;
  bool hovering = false;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 200),
    );
    _animation = Tween<double>(begin: 0, end: 1).animate(_controller);
  }

  void _onEnter(bool hover) {
    setState(() => hovering = hover);
    if (hover) {
      _controller.forward();
    } else {
      _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.bodyLarge;

    return MouseRegion(
      onEnter: (_) => _onEnter(true),
      onExit: (_) => _onEnter(false),
      child: GestureDetector(
        onTap: widget.onTap,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              widget.label,
              style: textStyle?.copyWith(
                color: hovering ? TColors.Ssecondery : textStyle.color,
                fontWeight: hovering ? FontWeight.bold : textStyle.fontWeight,
              ),
            ),
            SizeTransition(
              sizeFactor: _animation,
              axis: Axis.horizontal,
              axisAlignment: -1,
              child: Container(
                margin: const EdgeInsets.only(top: 2),
                height: 2,
                width: 38,
                color: TColors.primary,
              ),
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
