import 'package:flutter/material.dart';
import 'package:mm_proyecto_final/main.dart';

class CustomBarChart extends StatelessWidget {
  final List<int> values;
  final int activeIndex;
  final Color activeColor;
  final Color inactiveColor;
  final List<String> labels;

  const CustomBarChart({
    super.key,
    required this.values,
    required this.activeIndex,
    this.activeColor = AppTheme.primaryGreen,
    this.inactiveColor = const Color(0xFFE5E7EB),
    required this.labels,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: 160,
          child: CustomPaint(
            size: Size(constraints.maxWidth, 160),
            painter: _BarChartPainter(
              values: values,
              activeIndex: activeIndex,
              activeColor: activeColor,
              inactiveColor: inactiveColor,
              labels: labels,
            ),
          ),
        );
      },
    );
  }
}

class _BarChartPainter extends CustomPainter {
  final List<int> values;
  final int activeIndex;
  final Color activeColor;
  final Color inactiveColor;
  final List<String> labels;

  _BarChartPainter({
    required this.values,
    required this.activeIndex,
    required this.activeColor,
    required this.inactiveColor,
    required this.labels,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final maxVal = values.reduce((a, b) => a > b ? a : b).toDouble();
    const paddingBottom = 24.0;
    final barWidth = size.width / values.length * 0.5;
    final spacing = size.width / values.length;

    for (int i = 0; i < values.length; i++) {
      final barHeight =
          (values[i] / maxVal) * (size.height - paddingBottom - 10);
      final x = i * spacing + spacing / 2;
      final y = size.height - paddingBottom - barHeight;
      final isActive = i == activeIndex;

      final rect = RRect.fromRectAndRadius(
        Rect.fromCenter(
          center: Offset(x, y + barHeight / 2),
          width: barWidth,
          height: barHeight,
        ),
        const Radius.circular(6),
      );

      final paint = Paint()..color = isActive ? activeColor : inactiveColor;
      canvas.drawRRect(rect, paint);

      // Label
      final textPainter = _createTextPainter(
        labels[i],
        11,
        isActive ? activeColor : AppTheme.textSecondary,
        isActive ? FontWeight.w700 : FontWeight.w500,
      );
      textPainter.paint(
        canvas,
        Offset(x - textPainter.width / 2, size.height - 18),
      );
    }
  }

  TextPainter _createTextPainter(
    String text,
    double fontSize,
    Color color,
    FontWeight weight,
  ) {
    final span = TextSpan(
      text: text,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: weight,
      ),
    );
    final tp = TextPainter(text: span, textDirection: TextDirection.ltr);
    tp.layout();
    return tp;
  }

  @override
  bool shouldRepaint(covariant _BarChartPainter old) => old.values != values;
}
