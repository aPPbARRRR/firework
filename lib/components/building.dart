// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';

class Building extends StatelessWidget {
  const Building(
      {Key? key,
      required this.height,
      required this.width,
      required this.startPoint})
      : super(key: key);

  final int height;
  final int width;
  final int startPoint;

  @override
  Widget build(BuildContext context) {
    return TweenAnimationBuilder(
      tween: IntTween(begin: -height, end: 0),
      duration: Duration(milliseconds: 1000),
      builder: (context, value, child) => Positioned(
          bottom: value.toDouble(), left: startPoint.toDouble(), child: child!),
      child: Container(
        width: width.toDouble(),
        height: height.toDouble(),
        decoration: BoxDecoration(
            color: Colors.grey[800],
            boxShadow: [BoxShadow(blurRadius: 20, color: Colors.black)]),
        child: Padding(
          padding: EdgeInsets.all(15),
          child: GridView.builder(
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 4, crossAxisSpacing: 10, mainAxisSpacing: 5),
            itemCount: 20,
            itemBuilder: (context, index) => Container(
              width: 5,
              height: 5,
              decoration: BoxDecoration(color: Colors.yellow[600], boxShadow: [
                BoxShadow(
                  blurRadius: 5,
                  color: Colors.black,
                )
              ]),
            ),
          ),
        ),
      ),
    );
  }
}
