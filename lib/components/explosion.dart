import 'dart:math' as math;
import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter/physics.dart';

class ExplosionFirework extends StatefulWidget {
  final Offset explosionCenter; // 터지는 지점

  ExplosionFirework({Key? key, required this.explosionCenter})
      : super(key: key);

  @override
  _ExplosionFireworkState createState() => _ExplosionFireworkState();
}

class _ExplosionFireworkState extends State<ExplosionFirework>
    with TickerProviderStateMixin {
  late AnimationController _explosionController;
  List<Particle> _particles = [];

  @override
  void initState() {
    super.initState();
    _explosionController = AnimationController(
      duration: const Duration(seconds: 2),
      vsync: this,
    )..forward();

    _generateParticles();
  }

  void _generateParticles() {
    // 불꽃 파티클 생성
    for (int i = 0; i < 100; i++) {
      final double speed = Random().nextDouble() * 600 + 200; // 초기 속도
      final double angle = Random().nextDouble() * 2 * math.pi; // 방향
      final double gravity = 300; // 중력 가속도
      final Particle particle = Particle(
        speed: speed,
        angle: angle,
        gravity: gravity,
        startTime: _explosionController.duration! * Random().nextDouble(),
      );
      _particles.add(particle);
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _explosionController,
      builder: (context, child) {
        return CustomPaint(
          painter: ExplosionPainter(
              particles: _particles,
              time: _explosionController.value,
              explosionCenter: widget.explosionCenter),
          child: Container(),
        );
      },
    );
  }

  @override
  void dispose() {
    _explosionController.dispose();
    super.dispose();
  }
}

class Particle {
  double speed;
  double angle;
  double gravity;
  Duration startTime;

  Particle(
      {required this.speed,
      required this.angle,
      required this.gravity,
      required this.startTime});
}

class ExplosionPainter extends CustomPainter {
  List<Particle> particles;
  double time;
  Offset explosionCenter;

  ExplosionPainter(
      {required this.particles,
      required this.time,
      required this.explosionCenter});

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = Colors.yellow;
    particles.forEach((particle) {
      final progress = time - particle.startTime.inMilliseconds / 1000.0;
      // 중력 영향을 받는 위치 계산
      final x = explosionCenter.dx +
          particle.speed * progress * math.cos(particle.angle);
      final y = explosionCenter.dy +
          particle.speed * progress * math.sin(particle.angle) +
          0.5 * particle.gravity * progress * progress;
      canvas.drawCircle(Offset(x, y), 2.0, paint);
    });
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
