import 'package:flutter/material.dart';
import 'package:mm_proyecto_final/main.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<double> _fadeAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 800),
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(_controller);
    _controller.forward();

    Future.delayed(const Duration(seconds: 2, milliseconds: 500), () {
      if (mounted) {
        Navigator.of(
          context,
        ).pushReplacement(MaterialPageRoute(builder: (_) => const AppRoot()));
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: FadeTransition(
          opacity: _fadeAnimation,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomPaint(size: const Size(80, 80), painter: _DropsPainter()),
              const SizedBox(height: 24),
              Text(
                'Nutritionism',
                style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  color: AppTheme.darkGreen,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(height: 8),
              Text(
                'Un respiro digital de aire fresco',
                style: Theme.of(
                  context,
                ).textTheme.bodyMedium?.copyWith(color: AppTheme.textSecondary),
              ),
              const SizedBox(height: 32),
              SizedBox(
                width: 120,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: const LinearProgressIndicator(
                    value: 0.6,
                    backgroundColor: Color(0xFFE5E7EB),
                    valueColor: AlwaysStoppedAnimation<Color>(
                      AppTheme.primaryGreen,
                    ),
                    minHeight: 4,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _DropsPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final drop1Paint = Paint()..color = const Color(0xFFA8DADC);
    final drop2Paint = Paint()..color = AppTheme.waterBlue;

    final path1 = Path();
    path1.moveTo(size.width * 0.35, size.height * 0.2);
    path1.quadraticBezierTo(
      size.width * 0.45,
      size.height * 0.5,
      size.width * 0.35,
      size.height * 0.6,
    );
    path1.arcToPoint(
      Offset(size.width * 0.25, size.height * 0.6),
      radius: const Radius.circular(12),
      clockwise: false,
    );
    path1.quadraticBezierTo(
      size.width * 0.15,
      size.height * 0.5,
      size.width * 0.35,
      size.height * 0.2,
    );
    path1.close();

    final path2 = Path();
    path2.moveTo(size.width * 0.55, size.height * 0.1);
    path2.quadraticBezierTo(
      size.width * 0.75,
      size.height * 0.55,
      size.width * 0.55,
      size.height * 0.8,
    );
    path2.arcToPoint(
      Offset(size.width * 0.35, size.height * 0.8),
      radius: const Radius.circular(20),
      clockwise: false,
    );
    path2.quadraticBezierTo(
      size.width * 0.15,
      size.height * 0.55,
      size.width * 0.55,
      size.height * 0.1,
    );
    path2.close();

    canvas.drawPath(path1, drop1Paint);
    canvas.drawPath(path2, drop2Paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}
