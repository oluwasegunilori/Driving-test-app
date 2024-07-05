import 'package:dri_learn/simulation/configs.dart';
import 'package:dri_learn/simulation/model/custom_sprites.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flutter/material.dart';

class MyGame extends FlameGame with TapDetector {
  late CustomSpriteComponent sprite1;
  late CustomSpriteComponent sprite2;
  late SpriteComponent spriteComponent1;
  late SpriteComponent spriteComponent2;
  double elapsedTime = 0;
  final double duration = 5.0; // Duration in seconds
  bool started = false;
  @override
  Color backgroundColor() {
    return Colors.transparent;
  }

  @override
  Future<void> onLoad() async {
    super.onLoad();

    sprite1 = CustomSpriteComponent(
        startPosition: Vector2(size.x / 2, size.y),
        endPosition: Vector2(size.x / 2, 2),
        sprite: await loadSprite('sedan-sports.png'));

    sprite2 = CustomSpriteComponent(
        // ignore: use_build_context_synchronously
        startPosition: Vector2(size.x / 2 - 50, 0),
        endPosition:
            Vector2(size.x / 2 - 50, size.y - roadWidthPercent * size.y),
        sprite: await loadSprite('sedan-sports.png'));

    spriteComponent1 = sprite1.getSpriteComponent();
    spriteComponent2 = sprite2.getSpriteComponent();

    addAll([spriteComponent1, spriteComponent2]);
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (started) {
      elapsedTime += dt;

      // Calculate the percentage of completion
      final progress = (elapsedTime / duration).clamp(0.0, 1.0);

      // Linearly interpolate between the start and end positions
      spriteComponent1.position = sprite1.startPosition +
          (sprite1.endPosition - sprite1.startPosition) * progress;

      // spriteComponent2.position = sprite2.startPosition +
      //     (sprite2.endPosition - sprite2.startPosition) * progress;

      // Reset the animation after it completes
      if (progress >= 1.0) {
        started = false;
        elapsedTime = 0.0; // Reset elapsed time for continuous animation
        // Optionally swap start and end positions for back-and-forth animation
        // final temp = sprite1.startPosition;
        // sprite1.startPosition = sprite1.endPosition;
        // sprite1.endPosition = temp;
      }
    }
  }

  @override
  void onTapDown(TapDownInfo info) {
    super.onTapDown(info);
    double distance =
        info.eventPosition.widget.distanceTo(spriteComponent1.absoluteCenter);
    print(distance);
    if (distance < 16) {
      started = true;
    }
  }
}
