// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:math';

import 'package:flutter/material.dart';

class FireWork2 extends StatefulWidget {
  const FireWork2({
    Key? key,
    required this.xOrigin,
    required this.yOrigin,
    required this.angle,
    required this.distance,
    required this.color,
  }) : super(key: key);

  final double xOrigin;
  final double yOrigin;
  final double angle;
  final int distance;
  final Color color;

  @override
  _FireWork2State createState() => _FireWork2State();
}

class _FireWork2State extends State<FireWork2>
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

  void addReflection(
      {required double left, required double bottom, required double radius}) {
    final ReflectionPoint trail = ReflectionPoint(
      height: radius,
      width: radius,
      left: left,
      bottom: bottom,
      color: widget.color,
    );
    _trails.add(trail);
  }

  void moveX() {
    // 시작점 기준(x,y origin)
    // 속력(애니메이션 밸류) 설정
    // x 좌표 수정
    // y 좌표 수정
  }
  void moveY() {}

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
        addReflection(
          radius: width,
          left: MediaQuery.of(context).size.width * widget.xOrigin +
              _animation.value * widget.distance * cos(widget.angle) -
              random.nextInt((width.toInt() / 4).round()) -
              -width / 2,
          bottom: MediaQuery.of(context).size.height * widget.yOrigin +
              _animation.value * widget.distance * sin(widget.angle) -
              random.nextInt((width.toInt() / 4).round()) -
              width / 2 -
              _animation.value * _animation.value * _animation.value * 1000,
        );
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
              // x 좌표
              // 초기값 + 변화 결과값
              // 초기값 = 미디어쿼리 사이즈 width * xOrigin
              // 변화 결과값 =
              left: MediaQuery.of(context).size.width * widget.xOrigin +
                  _animation.value * widget.distance * cos(widget.angle) -
                  random.nextInt((width.toInt() / 4).round()), // 이 컨테이너의 width
              bottom: MediaQuery.of(context).size.height * widget.yOrigin +
                  _animation.value * widget.distance * sin(widget.angle) -
                  random.nextInt((width.toInt() / 4).round()) -
                  _animation.value *
                      _animation.value *
                      _animation.value *
                      1000, // 이 컨테이너의 height
              child: Opacity(
                opacity: 1 - 1.0 * _animation.value,
                child: Container(
                  width: 100,
                  height: 100,
                  decoration: BoxDecoration(
                    gradient: RadialGradient(
                        colors: [widget.color, Colors.transparent]),
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
    required this.color,
    this.onEnd,
  });

  final void Function()? onEnd;
  final double width;
  final double height;
  final double left;
  final double bottom;
  final Color color;
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
                color: color,
                gradient: RadialGradient(colors: [color, Colors.transparent]),
              ),
            ),
          );
        });
  }
}
