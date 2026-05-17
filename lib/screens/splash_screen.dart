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
  late Animation<double> _progressAnimation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 2500),
    );
    _fadeAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0, 0.3, curve: Curves.easeOut)),
    );
    _progressAnimation = Tween<double>(begin: 0, end: 1).animate(
      CurvedAnimation(parent: _controller, curve: const Interval(0.1, 0.9, curve: Curves.easeInOut)),
    );

    _controller.addStatusListener((status) {
      if (status == AnimationStatus.completed && mounted) {
        Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (_) => const AppRoot()),
        );
      }
    });

    _controller.forward();
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
                  child: AnimatedBuilder(
                    animation: _progressAnimation,
                    builder: (context, child) {
                      return LinearProgressIndicator(
                        value: _progressAnimation.value,
                        backgroundColor: const Color(0xFFE5E7EB),
                        valueColor: const AlwaysStoppedAnimation<Color>(
                          AppTheme.primaryGreen,
                        ),
                        minHeight: 4,
                      );
                    },
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
