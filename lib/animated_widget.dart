import 'dart:math';

import 'package:flutter/material.dart';

class AnimatedWidgetExample extends StatefulWidget {
  const AnimatedWidgetExample({Key? key}) : super(key: key);

  @override
  State<AnimatedWidgetExample> createState() => _AnimatedWidgetExampleState();
}

class _AnimatedWidgetExampleState extends State<AnimatedWidgetExample>
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
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: DisplaceAndColorTransition(
        animatedController: _animationController,
      ),
    );
  }
}

class DisplaceAndColorTransition extends AnimatedWidget {
  DisplaceAndColorTransition({required Listenable animatedController})
      : super(listenable: animatedController);

  Animation<double> get animation => listenable as Animation<double>;

  @override
  Widget build(BuildContext context) {
    final colorTween = ColorTween(begin: Colors.yellow, end: Colors.red);
    final movementTween =
        Tween<double>(begin: 0.0, end: MediaQuery.of(context).size.width);
    final scaleTween = Tween<double>(begin: 1.0, end: 2.0);
    final rotationTween = Tween<double>(begin: 0.0, end: 2 * pi);

    return Transform(
      origin: const Offset(25, 25),
      transform: Matrix4.identity()
        ..translate(movementTween.transform(animation.value))
        ..scale(scaleTween.transform(animation.value))
        ..rotateZ(rotationTween.transform(animation.value)),
      child: Container(
        height: 50,
        width: 50,
        color: colorTween.transform(animation.value) as Color,
      ),
    );
  }
}
