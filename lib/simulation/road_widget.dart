import 'dart:async';

import 'package:ontario_g1_test_2024/simulation/dragger.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

import 'rough_it.dart';

class RoadIntersectionWidget extends StatefulWidget {
  const RoadIntersectionWidget({super.key});

  @override
  _RoadIntersectionWidgetState createState() => _RoadIntersectionWidgetState();
}

class _RoadIntersectionWidgetState extends State<RoadIntersectionWidget>
    with SingleTickerProviderStateMixin {
  List<int> lights = [2, 1, 0];
  int _currentLight = 0;
  late Timer _timer;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 1),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.9, end: 1.0).animate(_controller);

    _timer = Timer.periodic(const Duration(seconds: 4), (timer) {
      setState(() {
        if (_currentLight >= lights.length - 1) {
          _currentLight = 0;
        } else {
          _currentLight++;
        }
      });
    });
  }

  @override
  void dispose() {
    _timer.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Stack(children: [
      AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomPaint(
                  size: Size(
                      MediaQuery.of(context).size.width,
                      MediaQuery.of(context).size.height *
                          0.6), // You can specify the size of the canvas here
                  painter: RoadIntersectionPainter(
                      lights[_currentLight], _animation.value),
                ),
              ],
            );
          }),
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
              height: MediaQuery.of(context).size.height * 0.6,
              child: GameWidget(
                  game: MyGame(),
                  backgroundBuilder: (context) => Container(
                        color: Colors.transparent,
                      ))),
        ],
      ),
    ]));
  }
}
