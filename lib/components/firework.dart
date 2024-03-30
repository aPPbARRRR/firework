import 'dart:math';

import 'package:flutter/material.dart';

class FireWork extends StatefulWidget {
  @override
  _FireWorkState createState() => _FireWorkState();
}

class _FireWorkState extends State<FireWork>
    with SingleTickerProviderStateMixin {
  final Random random = Random();

  late AnimationController _controller;
  late Animation<double> _animation;
  // late Animation<double> _curvedAnimation;
  double width = 10;
  List<ReflectionPoint> _trails = [];

  void removeReflection() {
    _trails.removeWhere((ReflectionPoint point) => point.isDone == true);
  }

  void addReflection() {
    final ReflectionPoint trail = ReflectionPoint(
      height: width,
      width: width,
      left: (MediaQuery.of(context).size.width) +
          random.nextInt((width.toInt() / 4).round()),
      bottom: MediaQuery.of(context).size.height * (_animation.value),
    );
    _trails.add(trail);
  }

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: Duration(seconds: 10),
      vsync: this,
    );

    // _curvedAnimation =
    //     CurvedAnimation(parent: _controller, curve: Curves.easeOutBack);

    _animation = Tween<double>(
      begin: 0.0,
      end: 0.7,
    ).animate(_controller)
      ..addListener(() {
        addReflection();
        // removeReflection();
        setState(() {});
      })
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          // width = 20;
          // _controller.repeat();
          setState(() {
            _trails.clear();
          });
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
    return Stack(
      children: [
        // reflections
        ..._trails
            .map((ReflectionPoint point) => Positioned(
                left: point.left, bottom: point.bottom, child: point))
            .toList(),

        // light
        AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Positioned(
              left: (MediaQuery.of(context).size.width / 2) +
                  random.nextInt((width.toInt() / 4).round()),
              bottom: MediaQuery.of(context).size.height * (_animation.value),
              child: Opacity(
                opacity: 1 - 1.0 * _animation.value,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                        colors: [Colors.yellow, Colors.transparent]),
                    shape: BoxShape.circle,
                  ),
                ),
              ),
            );
          },
        ),
      ],
    );
  }
}

class ReflectionPoint extends StatelessWidget {
  ReflectionPoint({
    super.key,
    required this.height,
    required this.width,
    required this.left,
    required this.bottom,
    this.onEnd,
  });

  final void Function()? onEnd;
  final double width;
  final double height;
  final double left;
  final double bottom;
  bool isDone = false;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
        // onEnd: () => isDone = true,
        tween: IntTween(begin: 100, end: 0),
        duration: Duration(milliseconds: 1000),
        builder: (_, int number, __) {
          return Opacity(
            opacity: (number / 100).toDouble(),
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.yellow,
                gradient: RadialGradient(
                    colors: [Colors.white, Colors.yellow, Colors.transparent]),
              ),
            ),
          );
        });
  }
}
