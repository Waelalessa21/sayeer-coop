import 'dart:ui';

import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:sayeercoop/common/theme/colors.dart'; // إذا كنت تستخدم Lottie، وإلا احذف هذا السطر

class LoadingOverlay extends StatefulWidget {
  final String message;

  const LoadingOverlay({super.key, required this.message});

  @override
  State<LoadingOverlay> createState() => _LoadingOverlayState();
}

class _LoadingOverlayState extends State<LoadingOverlay>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(milliseconds: 1500),
      vsync: this,
    );
    _animation = Tween<double>(
      begin: 0,
      end: widget.message.length.toDouble(),
    ).animate(_controller);
    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: Stack(
        children: [
          BackdropFilter(
            filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
            child: Container(color: Colors.transparent),
          ),
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // استخدم Lottie إذا أردت:
                FadeInUp(
                  child: Lottie.asset(
                    'assets/icons/Animation - 1747132335531.json',
                    width: 160,
                    height: 160,
                  ),
                ),
                //const CircularProgressIndicator(color: Colors.white),
                const SizedBox(height: 20),
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),
                    boxShadow: [
                      BoxShadow(
                        color: TColors.primary.withOpacity(0.15),
                        blurRadius: 21,
                        offset: const Offset(0, 2),
                      ),
                    ],
                  ),
                  child: AnimatedBuilder(
                    animation: _animation,
                    builder: (context, child) {
                      final displayedLength = _animation.value.toInt();
                      final displayedText = widget.message.substring(
                        0,
                        displayedLength,
                      );
                      return Text(
                        displayedText,
                        style: const TextStyle(
                          fontSize: 18,
                          color: TColors.SbuttomColor,
                          fontWeight: FontWeight.bold,
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
