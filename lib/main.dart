import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio_web/components/building.dart';
import 'package:portfolio_web/components/firework.dart';
import 'package:portfolio_web/main_vm.dart';

void main() =>
    runApp(ProviderScope(child: MaterialApp(home: FireworkAnimationApp())));

class FireworkAnimationApp extends ConsumerWidget {
  FireworkAnimationApp({super.key});

  @override
  Widget build(BuildContext context, ref) {
    final controller = ref.watch(mainVMProvider.notifier);
    final stackList = ref.watch(mainVMProvider);

    return Scaffold(
      floatingActionButton: FloatingActionButton.small(onPressed: () {
        controller.addAnimation();
      }),
      backgroundColor: Colors.black,
      body: TweenAnimationBuilder(
        onEnd: () => controller.addAnimation(),
        tween: ColorTween(
            begin: const Color.fromARGB(255, 249, 247, 228),
            end: Colors.transparent),
        duration: Duration(milliseconds: 3),
        builder: (context, value, child) {
          return ColorFiltered(
              colorFilter: ColorFilter.mode(value!, BlendMode.color),
              child: Stack(children: stackList));
        },
      ),
    );
  }
}

// // import 'dart:math';
// // import 'package:flutter/material.dart';

// // void main() => runApp(MyApp());

// // class MyApp extends StatelessWidget {
// //   @override
// //   Widget build(BuildContext context) {
// //     return MaterialApp(home: FireworksAnimationPage());
// //   }
// // }

// // class FireworksAnimationPage extends StatefulWidget {
// //   @override
// //   _FireworksAnimationPageState createState() => _FireworksAnimationPageState();
// // }

// // class _FireworksAnimationPageState extends State<FireworksAnimationPage>
// //     with SingleTickerProviderStateMixin {
// //   late AnimationController _controller;
// //   late List<ParticleModel> _particles;

// //   @override
// //   void initState() {
// //     super.initState();
// //     final int numberOfParticles = 100;
// //     _particles = List.generate(numberOfParticles, (_) => ParticleModel());
// //     _controller =
// //         AnimationController(vsync: this, duration: Duration(seconds: 2))
// //           ..addListener(() {
// //             setState(() {
// //               _particles.forEach((particle) => particle.move());
// //             });
// //           })
// //           ..addStatusListener((status) {
// //             if (status == AnimationStatus.completed) {
// //               _controller.reset();
// //               _particles.forEach((particle) => particle.reset());
// //               _controller.forward();
// //             }
// //           });
// //     _controller.forward();
// //   }

// //   @override
// //   void dispose() {
// //     _controller.dispose();
// //     super.dispose();
// //   }

// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       appBar: AppBar(title: Text('Fireworks Animation')),
// //       body: CustomPaint(
// //         painter: FireworksPainter(particles: _particles),
// //         child: Container(),
// //       ),
// //     );
// //   }
// // }

// // class ParticleModel {
// //   Offset position = Offset(0, 0);
// //   double speed = Random().nextDouble() * 4 + 2; // Speed range: 2 to 6
// //   double angle = Random().nextDouble() * 2 * pi; // Angle in radians
// //   double radius = 0;

// //   void move() {
// //     position = Offset(
// //         position.dx + speed * cos(angle), position.dy + speed * sin(angle));
// //     radius += 1;
// //   }

// //   void reset() {
// //     position = Offset(0, 0);
// //     speed = Random().nextDouble() * 4 + 2;
// //     angle = Random().nextDouble() * 2 * pi;
// //     radius = 0;
// //   }
// // }

// // class FireworksPainter extends CustomPainter {
// //   final List<ParticleModel> particles;

// //   FireworksPainter({required this.particles});

// //   @override
// //   void paint(Canvas canvas, Size size) {
// //     final paint = Paint()..color = Colors.red;
// //     final center = Offset(size.width / 2, size.height / 2);
// //     particles.forEach((particle) {
// //       final particlePosition = center + particle.position;
// //       canvas.drawCircle(particlePosition, particle.radius, paint);
// //     });
// //   }

// //   @override
// //   bool shouldRepaint(covariant CustomPainter oldDelegate) => true;
// // }
