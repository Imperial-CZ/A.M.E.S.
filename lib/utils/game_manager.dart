import 'dart:async';

import 'package:ames/ui/main/intro_screen.dart';
import 'package:ames/ui/main/start_screen.dart';
import 'package:ames/ui/main/test_screen.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/src/gestures/events.dart';

class GameManager extends FlameGame with TapDetector {
  List<Component> scene = [TestScreen(), StartScreen(), IntroPage1Screen()];

  @override
  FutureOr<void> onLoad() {
    add(scene[0]);
  }

  @override
  void onTapDown(TapDownInfo info) {
    super.onTapDown(info);
    if (scene[0] is StartScreen) {
      (scene[0] as StartScreen).tapEvent(info.eventPosition.global);
    } else if (scene[0] is IntroPage1Screen) {
      (scene[0] as IntroPage1Screen).tapEvent(info.eventPosition.global);
    } else if (scene[0] is TestScreen) {
      (scene[0] as TestScreen).tapEvent(info.eventPosition.global);
    }
  }

  @override
  void update(double dt) {
    super.update(dt);

    if (scene[0].isRemoved == true) {
      print("TEST");
      scene.removeAt(0);
      add(scene[0]);
    }
  }
}
