import 'package:flutter/material.dart';
import 'package:mm_proyecto_final/main.dart';

class CustomLineChart extends StatelessWidget {
  final List<double> data;
  final List<String> labels;
  final Color lineColor;
  final double maxY;

  const CustomLineChart({
    super.key,
    required this.data,
    required this.labels,
    this.lineColor = AppTheme.waterBlue,
    this.maxY = 3.5,
  });

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return SizedBox(
          height: 220,
          child: CustomPaint(
            size: Size(constraints.maxWidth, 220),
            painter: _LineChartPainter(
              data: data,
              labels: labels,
              lineColor: lineColor,
              maxY: maxY,
            ),
          ),
        );
      },
    );
  }
}

class _LineChartPainter extends CustomPainter {
  final List<double> data;
  final List<String> labels;
  final Color lineColor;
  final double maxY;

  _LineChartPainter({
    required this.data,
    required this.labels,
    required this.lineColor,
    required this.maxY,
  });

  @override
  void paint(Canvas canvas, Size size) {
    const padding = EdgeInsets.only(left: 32, right: 16, top: 20, bottom: 30);
    final chartWidth = size.width - padding.horizontal;
    final chartHeight = size.height - padding.vertical;

    final gridPaint = Paint()
      ..color = const Color(0xFFE5E7EB)
      ..strokeWidth = 1;

    // Horizontal grid lines
    for (int i = 0; i <= 3; i++) {
      final y = padding.top + chartHeight - (i / 3) * chartHeight;
      canvas.drawLine(
        Offset(padding.left, y),
        Offset(size.width - padding.right, y),
        gridPaint,
      );
      final label = '${i}L';
      final textPainter = _createTextPainter(label, 10, AppTheme.textSecondary);
      textPainter.paint(canvas, Offset(padding.left - 28, y - 6));
    }

    // Points
    final points = <Offset>[];
    final dx = chartWidth / (data.length - 1);
    for (int i = 0; i < data.length; i++) {
      final x = padding.left + i * dx;
      final y = padding.top + chartHeight - (data[i] / maxY) * chartHeight;
      points.add(Offset(x, y));
    }

    // Area under curve
    final areaPath = Path();
    areaPath.moveTo(points.first.dx, padding.top + chartHeight);
    for (int i = 0; i < points.length - 1; i++) {
      final p0 = points[i];
      final p1 = points[i + 1];
      final cp1 = Offset((p0.dx + p1.dx) / 2, p0.dy);
      final cp2 = Offset((p0.dx + p1.dx) / 2, p1.dy);
      areaPath.cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, p1.dx, p1.dy);
    }
    areaPath.lineTo(points.last.dx, padding.top + chartHeight);
    areaPath.close();
    final areaPaint = Paint()
      ..shader = LinearGradient(
        colors: [lineColor.withOpacity(0.2), lineColor.withOpacity(0.0)],
        begin: Alignment.topCenter,
        end: Alignment.bottomCenter,
      ).createShader(Rect.fromLTWH(padding.left, padding.top, chartWidth, chartHeight));
    canvas.drawPath(areaPath, areaPaint);

    // Smooth line
    final linePath = Path();
    linePath.moveTo(points.first.dx, points.first.dy);
    for (int i = 0; i < points.length - 1; i++) {
      final p0 = points[i];
      final p1 = points[i + 1];
      final cp1 = Offset((p0.dx + p1.dx) / 2, p0.dy);
      final cp2 = Offset((p0.dx + p1.dx) / 2, p1.dy);
      linePath.cubicTo(cp1.dx, cp1.dy, cp2.dx, cp2.dy, p1.dx, p1.dy);
    }
    final linePaint = Paint()
      ..color = lineColor
      ..strokeWidth = 3
      ..style = PaintingStyle.stroke
      ..strokeCap = StrokeCap.round;
    canvas.drawPath(linePath, linePaint);

    // Dots
    for (int i = 0; i < points.length; i++) {
      final pt = points[i];
      canvas.drawCircle(pt, 4, Paint()..color = lineColor);
      canvas.drawCircle(pt, 2, Paint()..color = Colors.white);

      final textPainter = _createTextPainter(labels[i], 11, AppTheme.textSecondary);
      textPainter.paint(canvas, Offset(pt.dx - textPainter.width / 2, size.height - 20));
    }

    // Highlight Saturday (index 5)
    if (points.length > 5) {
      final saturdayPt = points[5];
      canvas.drawCircle(saturdayPt, 8, Paint()..color = Colors.white);
      canvas.drawCircle(saturdayPt, 6, Paint()..color = lineColor);
    }
  }

  TextPainter _createTextPainter(String text, double fontSize, Color color) {
    final span = TextSpan(
      text: text,
      style: TextStyle(
        fontSize: fontSize,
        color: color,
        fontWeight: FontWeight.w500,
      ),
    );
    final tp = TextPainter(text: span, textDirection: TextDirection.ltr);
    tp.layout();
    return tp;
  }

  @override
  bool shouldRepaint(covariant _LineChartPainter old) => old.data != data;
}
