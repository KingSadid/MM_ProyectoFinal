import 'package:flutter/material.dart';
import 'package:mm_proyecto_final/main.dart';

class ProgressBar extends StatelessWidget {
  final double current;
  final double max;
  final double height;
  final Color backgroundColor;
  final Color foregroundColor;
  final BorderRadius? borderRadius;

  const ProgressBar({
    super.key,
    required this.current,
    required this.max,
    this.height = 8,
    this.backgroundColor = const Color(0xFFE5E7EB),
    this.foregroundColor = AppTheme.primaryGreen,
    this.borderRadius,
  });

  double get _progress => max == 0 ? 0 : (current / max).clamp(0.0, 1.0);

  @override
  Widget build(BuildContext context) {
    final br = borderRadius ?? BorderRadius.circular(height / 2);
    return ClipRRect(
      borderRadius: br,
      child: Container(
        height: height,
        decoration: BoxDecoration(
          color: backgroundColor,
          borderRadius: br,
        ),
        child: FractionallySizedBox(
          alignment: Alignment.centerLeft,
          widthFactor: _progress,
          child: Container(
            decoration: BoxDecoration(
              color: foregroundColor,
              borderRadius: br,
            ),
          ),
        ),
      ),
    );
  }
}
