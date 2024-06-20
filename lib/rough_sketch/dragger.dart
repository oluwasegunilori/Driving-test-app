import 'dart:ui';

import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/src/gestures/events.dart';
import 'package:flutter/material.dart';

class MyGame extends FlameGame with TapDetector {
  late SpriteComponent spriteComponent;
  late Vector2 startPosition;
  late Vector2 endPosition;
  double elapsedTime = 0;
  final double duration = 5.0; // Duration in seconds
  bool started = false;
  @override
  Color backgroundColor() {
    // TODO: implement backgroundColor
    return Colors.transparent;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();

    // Load the sprite image
    final sprite = await loadSprite('sedan-sports.png');

    // Initial position of the sprite
    startPosition = Vector2(size.x / 2, size.y);
    endPosition = Vector2(size.x / 2, 2); // Moving to bottom-right

    // Create a sprite component
    spriteComponent = SpriteComponent()
      ..sprite = sprite
      ..size = Vector2(25, 25) // Set the size of the sprite
      ..position = startPosition;

    add(spriteComponent);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (started) {
      elapsedTime += dt;

      // Calculate the percentage of completion
      final progress = (elapsedTime / duration).clamp(0.0, 1.0);

      // Linearly interpolate between the start and end positions
      spriteComponent.position =
          startPosition + (endPosition - startPosition) * progress;

      // Reset the animation after it completes
      if (progress >= 1.0) {
        elapsedTime = 0.0; // Reset elapsed time for continuous animation
        // Optionally swap start and end positions for back-and-forth animation
        final temp = startPosition;
        startPosition = endPosition;
        endPosition = temp;
      }
    }
  }

  @override
  void onTapDown(TapDownInfo info) {
    // TODO: implement onTapDown
    super.onTapDown(info);
    double distance =
        info.eventPosition.widget.distanceTo(spriteComponent.absoluteCenter);
    print(distance);
    if (distance < 16) {
      started = true;
    }
  }
}
