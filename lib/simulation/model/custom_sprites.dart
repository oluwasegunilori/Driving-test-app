import 'package:flame/components.dart';

class CustomSpriteComponent {
  Vector2 startPosition;
  Vector2 endPosition;
  final Sprite sprite;

  CustomSpriteComponent(
      {required this.startPosition,
      required this.endPosition,
      required this.sprite});

  SpriteComponent getSpriteComponent() {
    return SpriteComponent()
      ..sprite = sprite
      ..size = Vector2(25, 25) // Set the size of the sprite
      ..position = startPosition;
  }
}
