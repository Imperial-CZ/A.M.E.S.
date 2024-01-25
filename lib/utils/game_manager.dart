import 'dart:async';
import 'package:ames/utils/jsonParser.dart';
import 'package:ames/utils/waiting.dart';
import 'package:ames/utils/widgets/animatedImage.dart';
import 'package:ames/utils/widgets/customSpirit.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/src/gestures/events.dart';
import 'package:flutter/services.dart';

class GameManager extends FlameGame with TapDetector {
  Map<String, dynamic> listComponent = {
    "background": AnimatedImage(
        fileName: "fond_",
        nbImage: 47,
        loop: true,
        imageSize: Vector2(480, 320),
        sizeMultiplicator: 1.0,
        coord: Vector2(200, 200),
        frameRate: 0.5),
  };

  GameManager({required this.jsonParser});

  JsonParser jsonParser;
  Function()? tapEventFunction;

  Future<void> waitingToDelete(String elementName, int duration) async {
    print("DELAYED");
    await Future.delayed(Duration(seconds: duration));
    remove(jsonParser.widgetQueue[elementName]);
  }

  void continueDraw() {}

  @override
  FutureOr<void> onLoad() async {
    jsonParser.widgetQueue.keys.forEach((element) async {
      if (jsonParser.widgetQueue[element] is Waiting) {
        await Future.delayed(
          Duration(
            seconds: (jsonParser.widgetQueue[element] as Waiting).duration,
          ),
        );
      } else if (jsonParser.widgetQueue[element] is Function()) {
      } else {
        print("VALUE : " + jsonParser.widgetQueue[element].toString());
        add(jsonParser.widgetQueue[element] as Component);
      }
    });
  }

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
