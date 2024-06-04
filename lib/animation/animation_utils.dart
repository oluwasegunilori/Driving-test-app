import 'package:flutter/material.dart';

Widget futureWidget(
    {required Duration delayDuration,
    required Duration animationDuration,
    required ValueGetter<Widget> child}) {
  return FutureBuilder(
    future: Future.delayed(delayDuration),
    builder: (context, snapshot) {
      return AnimatedOpacity(
        opacity: snapshot.connectionState == ConnectionState.done ? 1.0 : 0.0,
        duration: animationDuration,
        child: child(),
      );
    },
  );
}
