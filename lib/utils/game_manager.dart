import 'dart:async';
import 'package:ames/utils/widgets/animatedImage.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/src/gestures/events.dart';

class GameManager extends FlameGame with TapDetector {
  Map<String, dynamic> listComponent = {
    "background": AnimatedImage(fileName: "fond_", nbImage: 47, loop:  true, imageSize: Vector2(480, 320), coord: Vector2(200,200), frameRate: 0.5),
  };

  @override
  FutureOr<void> onLoad() {}

  @override
  void onTapDown(TapDownInfo info) {
    super.onTapDown(info);
    introTapEvent(info.eventPosition.global);
  }

  void testTapEvent(Vector2 tapPosition) {
    (listComponent["fond"] as AnimatedImage).frameRate = 0.1;
  }

  void introTapEvent(Vector2 tapPosition) {}

  void startTapEvent(Vector2 tapPosition) {
    print("tapPosition.x = ${tapPosition.x}");
    print("tapPosition.y = ${tapPosition.y}");

    print("gameRef.size.toRect().width / 2 = ${size.toRect().width / 2}");
    print("gameRef.size.toRect().height / 2 = ${size.toRect().height / 2}");

    if (tapPosition.x >= size.toRect().width / 2 &&
        tapPosition.y >= size.toRect().height / 2) {
      removeFromParent();
    }
  }
}
