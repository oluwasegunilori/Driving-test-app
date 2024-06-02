import 'dart:async';

import 'package:flutter/material.dart';

import 'rough_it.dart';

class RoadIntersectionWidget extends StatefulWidget {
  const RoadIntersectionWidget({super.key});

  @override
  _RoadIntersectionWidgetState createState() => _RoadIntersectionWidgetState();
}

class _RoadIntersectionWidgetState extends State<RoadIntersectionWidget>
    with SingleTickerProviderStateMixin {
  int _currentLight = 0;
  late Timer _timer;
  late AnimationController _controller;
  late Animation<double> _animation;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      duration: const Duration(seconds: 4),
      vsync: this,
    )..repeat(reverse: true);

    _animation = Tween<double>(begin: 0.8, end: 1.0).animate(_controller);

    _timer = Timer.periodic(const Duration(seconds: 3), (timer) {
      setState(() {
        _currentLight = (_currentLight + 1) % 3;
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
      child: AnimatedBuilder(
          animation: _animation,
          builder: (context, child) {
            return Column(
              children: [
                CustomPaint(
                  size: Size(
                      MediaQuery.of(context).size.width,
                      MediaQuery.of(context).size.height /
                          2), // You can specify the size of the canvas here
                  painter:
                      RoadIntersectionPainter(_currentLight, _animation.value),
                ),
                const Expanded(
                  flex: 1,
                  child: Center(),
                ),
              ],
            );
          }),
    );
  }
}
