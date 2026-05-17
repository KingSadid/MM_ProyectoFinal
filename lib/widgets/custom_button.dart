import 'package:flutter/material.dart';
import 'package:mm_proyecto_final/main.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed;
  final IconData? icon;
  final bool isPrimary;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? width;
  final EdgeInsets? padding;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.icon,
    this.isPrimary = true,
    this.backgroundColor,
    this.foregroundColor,
    this.width,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final child = Row(
      mainAxisSize: MainAxisSize.min,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        if (icon != null) ...[
          Icon(icon, size: 18),
          const SizedBox(width: 8),
        ],
        Text(text),
      ],
    );

    if (isPrimary) {
      return SizedBox(
        width: width,
        child: ElevatedButton(
          onPressed: onPressed,
          style: ElevatedButton.styleFrom(
            backgroundColor: backgroundColor ?? AppTheme.primaryGreen,
            foregroundColor: foregroundColor ?? Colors.white,
            padding: padding ?? const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
          ),
          child: child,
        ),
      );
    }

    return SizedBox(
      width: width,
      child: OutlinedButton(
        onPressed: onPressed,
        style: OutlinedButton.styleFrom(
          foregroundColor: foregroundColor ?? AppTheme.textPrimary,
          padding: padding ?? const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
        ),
        child: child,
      ),
    );
  }
}
