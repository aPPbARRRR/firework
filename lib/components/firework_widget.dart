// import 'dart:math';

// import 'package:flutter/material.dart';
// import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:portfolio_web/components/firework.dart';
// import 'package:portfolio_web/providers/fire_points.dart';

// class FireworkWidget extends ConsumerStatefulWidget {
//   const FireworkWidget({super.key});

//   @override
//   ConsumerState<ConsumerStatefulWidget> createState() => _FireworkWidgetState();
// }

// class _FireworkWidgetState extends ConsumerState<FireworkWidget>
//     with SingleTickerProviderStateMixin {
  

//   final Random random = Random();

//   late AnimationController _controller;
//   late Animation<double> _animation;

//   @override
//   void initState() {
//     super.initState();    
//     _controller = AnimationController(
//       duration: Duration(seconds: 10),
//       vsync: this,
//     );

//     _animation = Tween<double>(
//       begin: 0.0,
//       end: 0.7,
//     ).animate(_controller)
//       ..addListener(() {
//         setState(() {
//           // 잔상 추가 로직
//           final Widget trail = Positioned(
//               left:
//                   (MediaQuery.of(context).size.width / 2) + random.nextDouble(),
//               bottom: MediaQuery.of(context).size.height * (_animation.value) -
//                   width,
//               child: ReflectionPoint(
//                   onEnd: () => _trails.remove(trail),
//                   height: width - width * _animation.value,
//                   width: width - width * _animation.value));
//           _trails.add(trail);
//         });
//       })
//       ..addStatusListener((status) {
//         if (status == AnimationStatus.completed) {
//           // width = 20;
//           _controller.repeat();
//           setState(() {
//             _trails.clear(); // 애니메이션이 끝나면 잔상을 지웁니다 (필요에 따라 조정)
//           });
//         }
//       });

//     _controller.forward();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final firePoints = ref.watch(firePointsProvider);

//     return Container();
//   }
// }
