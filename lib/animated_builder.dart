import 'dart:math';

import 'package:vector_math/vector_math_64.dart' as m;
import 'package:flutter/material.dart';

class AnimatedBuilderExample extends StatefulWidget {
  const AnimatedBuilderExample({Key? key}) : super(key: key);

  @override
  State<AnimatedBuilderExample> createState() => _AnimatedBuilderExampleState();
}

class _AnimatedBuilderExampleState extends State<AnimatedBuilderExample>
    with SingleTickerProviderStateMixin {
  late AnimationController _animationController;

  @override
  void initState() {
    super.initState();

    _animationController = AnimationController(
        duration: const Duration(milliseconds: 3000), vsync: this)
      ..addStatusListener((status) {
        if (status == AnimationStatus.completed) {
          _animationController.reverse();
        } else if (status == AnimationStatus.dismissed) {
          _animationController.forward();
        }
      })
      ..forward();
  }

  @override
  Widget build(BuildContext context) {
    final colorTween = ColorTween(begin: Colors.yellow, end: Colors.red);
    final movementTween =
        Tween<double>(begin: 0.0, end: MediaQuery.of(context).size.width);
    final scaleTween = Tween<double>(begin: 1.0, end: 2.0);
    final rotationTween = Tween<double>(begin: 0.0, end: 2 * pi);

    return Align(
      alignment: Alignment.centerLeft,
      child: AnimatedBuilder(
        animation: _animationController,
        builder: (context, _) {
          // Return the widget using animation controller's value in builder
          return Transform(
            origin: const Offset(25, 25),
            transform: Matrix4.identity()
              ..translate(movementTween.transform(_animationController.value))
              ..scale(scaleTween.transform(_animationController.value))
              ..rotateZ(rotationTween.transform(_animationController.value)),
            child: Container(
              height: 50,
              width: 50,
              color: colorTween.transform(_animationController.value) as Color,
            ),
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
