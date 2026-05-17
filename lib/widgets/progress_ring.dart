import 'package:flutter/material.dart';
import 'package:mm_proyecto_final/main.dart';

class ProgressRing extends StatelessWidget {
  final double progress;
  final double goal;
  final double size;
  final double strokeWidth;
  final Color color;
  final Widget? child;

  const ProgressRing({
    super.key,
    required this.progress,
    required this.goal,
    this.size = 160,
    this.strokeWidth = 14,
    this.color = AppTheme.waterBlue,
    this.child,
  });

  double get _percentage => (progress / goal).clamp(0.0, 1.0);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size,
      height: size,
      child: Stack(
        fit: StackFit.expand,
        children: [
          CustomPaint(
            painter: _RingPainter(
              percentage: _percentage,
              strokeWidth: strokeWidth,
              color: color,
              backgroundColor: const Color(0xFFE8F4FD),
            ),
          ),
          if (child != null) Center(child: child),
        ],
      ),
    );
  }
}

class _RingPainter extends CustomPainter {
  final double percentage;
  final double strokeWidth;
  final Color color;
  final Color backgroundColor;

  _RingPainter({
    required this.percentage,
    required this.strokeWidth,
    required this.color,
    required this.backgroundColor,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final center = Offset(size.width / 2, size.height / 2);
    final radius = (size.width - strokeWidth) / 2;

    final bgPaint = Paint()
      ..color = backgroundColor
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    canvas.drawCircle(center, radius, bgPaint);

    final progressPaint = Paint()
      ..shader = LinearGradient(
        colors: [color.withValues(alpha: 0.7), color],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromCircle(center: center, radius: radius))
      ..strokeWidth = strokeWidth
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;

    final sweepAngle = 2 * 3.141592653589793 * percentage;
    canvas.drawArc(
      Rect.fromCircle(center: center, radius: radius),
      -3.141592653589793 / 2,
      sweepAngle,
      false,
      progressPaint,
    );
  }

  @override
  bool shouldRepaint(covariant _RingPainter old) =>
      old.percentage != percentage;
}
