import 'dart:math';

import 'package:flutter/material.dart';
import 'package:portfolio_web/components/explosion.dart';
import 'package:portfolio_web/components/firework2.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'components/building.dart';
import 'components/firework.dart';
part 'main_vm.g.dart';

@riverpod
class MainVM extends _$MainVM {
  @override
  List<Widget> build() {
    List<Widget> stackList = [
      Building(
        height: 200,
        width: 80,
        startPoint: 100,
      ),
      Building(
        height: 150,
        width: 80,
        startPoint: 150,
      ),
      Building(
        height: 240,
        width: 120,
        startPoint: 300,
      ),
    ];
    return stackList;
  }

  void addAnimation() {
    List baseList = List.generate(30, (index) => index);
    List<Widget> baseWidgetList = baseList
        .map((i) => FireWork2(
              xOrigin: 0.5,
              yOrigin: 0.5,
              angle: Random().nextDouble() * 2 * pi,
              distance: 150,
              color: Colors.yellow,
            ))
        .toList();
    List<Widget> baseWidgetList2 = baseList
        .map((i) => FireWork2(
            xOrigin: 0.3,
            yOrigin: 0.3,
            angle: Random().nextDouble() * 2 * pi,
            distance: 150,
            color: Colors.red))
        .toList();
    List<Widget> baseWidgetList3 = baseList
        .map((i) => FireWork2(
            xOrigin: 0.3,
            yOrigin: 0.7,
            angle: Random().nextDouble() * 2 * pi,
            distance: 150,
            color: Colors.green))
        .toList();

    List<Widget> newStack = List.from(state);
    // newStack.add(FireWork2(
    //   xOrigin: 0.5,
    //   yOrigin: 0.5,
    //   angle: pi / 4,
    //   distance: 800,
    // ));
    newStack.addAll(baseWidgetList);
    newStack.addAll(baseWidgetList2);
    newStack.addAll(baseWidgetList3);
    // newStack.add(FireWork2(
    //   xOrigin: 0.5,
    //   yOrigin: 0.0,
    //   angle: pi / 2,
    //   distance: 2000,
    // ));

    state = newStack;
  }
}
