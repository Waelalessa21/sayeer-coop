import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:sayeercoop/common/layout/responsive.dart';
import 'package:sayeercoop/common/routing/routes.dart';
import 'package:sayeercoop/common/theme/colors.dart';

class WhySayerCard extends StatefulWidget {
  final IconData icon;
  final String label;
  final String description;

  const WhySayerCard({
    super.key,
    required this.icon,
    required this.label,
    required this.description,
  });

  @override
  State<WhySayerCard> createState() => _WhySayerCardState();
}

class _WhySayerCardState extends State<WhySayerCard> {
  bool _isHovered = false;

  @override
  Widget build(BuildContext context) {
    final isMobile = Responsive.isMobile(context);

    final iconSize = isMobile ? 36.0 : 40.0;
    final titleFontSize = isMobile ? 18.0 : 20.0;
    final descriptionFontSize = isMobile ? 14.0 : 15.0;

    return MouseRegion(
      onEnter: (_) => setState(() => _isHovered = true),
      onExit: (_) => setState(() => _isHovered = false),
      child: GestureDetector(
        onTap: () {
          context.push(Routes.registerScreen);
        },
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            color:
                _isHovered
                    ? TColors.SbuttomColor
                    : TColors.light.withOpacity(0.4),
            borderRadius: BorderRadius.circular(12),
            border: Border.all(color: TColors.primary.withOpacity(0.2)),
          ),
          child: Stack(
            children: [
              Positioned(
                top: 10,
                right: 20,
                child: _buildDecorativeElement(
                  12,
                  Colors.white.withOpacity(0.2),
                ),
              ),
              Positioned(
                bottom: 15,
                left: 20,
                child: _buildDecorativeElement(
                  8,
                  Colors.white.withOpacity(0.3),
                ),
              ),
              Positioned(
                top: 30,
                left: 35,
                child: _buildDecorativeElement(
                  15,
                  Colors.white.withOpacity(0.1),
                ),
              ),
              Positioned(
                bottom: 10,
                right: 40,
                child: _buildDecorativeElement(
                  20,
                  Colors.white.withOpacity(0.15),
                ),
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Icon(
                    widget.icon,
                    size: iconSize,
                    color: _isHovered ? Colors.white : TColors.Ssecondery,
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          widget.label,
                          style: TextStyle(
                            fontSize: titleFontSize,
                            fontWeight: FontWeight.bold,
                            color:
                                _isHovered ? Colors.white : TColors.Ssecondery,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          widget.description,
                          style: TextStyle(
                            fontSize: descriptionFontSize,
                            color:
                                _isHovered ? Colors.white : TColors.Ssecondery,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildDecorativeElement(double size, Color color) {
    return Container(
      width: size,
      height: size,
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
    );
  }
}
