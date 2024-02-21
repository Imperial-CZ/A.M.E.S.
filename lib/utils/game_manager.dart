import 'dart:async';
import 'package:ames/core/gamemode.dart';
import 'package:ames/utils/gameplay.dart';
import 'package:ames/utils/jsonParser.dart';
import 'package:ames/utils/waiting.dart';
import 'package:ames/utils/widgets/animatedImage.dart';
import 'package:ames/utils/widgets/customSpirit.dart';
import 'package:ames/utils/widgets/remove.dart';
import 'package:ames/utils/widgets/removeAll.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/src/gestures/events.dart';

class GameManager extends FlameGame with TapDetector {
  // Map<String, dynamic> listComponent = {
  //   "background": AnimatedImage(
  //     fileName: "fond_",
  //     nbImage: 47,
  //     loop: true,
  //     imageSize: Vector2(480, 320),
  //     sizeMultiplicator: 1.0,
  //     coord: Vector2(200, 200),
  //     frameRate: 0.5,
  //   ),
  // };

  GameManager({required this.jsonParser});

  JsonParser jsonParser;
  GameMode gamemode = GameMode();
  List<String> elementsOnScreen = [];
  int currentPosition = 0;

  Future<void> waitingToDelete(String elementName, int duration) async {
    print("DELAYED");
    await Future.delayed(Duration(seconds: duration));
    remove(jsonParser.widgetQueue[elementName]);
  }

  void removeAllComponent() {
    for (int i = 0; i != elementsOnScreen.length; i++) {
      print("i : " + i.toString() + " Value : " + elementsOnScreen[i]);
      remove(jsonParser.widgetQueue[elementsOnScreen[i]]);
    }
    elementsOnScreen.clear();
  }

  void continueDraw() async {
    for (currentPosition;
        currentPosition != jsonParser.widgetQueue.keys.length;
        currentPosition++) {
      dynamic element =
          jsonParser.widgetQueue.values.elementAt(currentPosition);
      if (element is Waiting) {
        await Future.delayed(
          Duration(
            seconds: (element as Waiting).duration,
          ),
        );
      } else if (element is Gameplay ||
          element is Remove ||
          element is RemoveAll) {
      } else if (element is CustomSpirit || element is AnimatedImage) {
        // if (element is CustomSpirit) {
        //   // Stream stream;
        //   // stream.listen((event) { })
        //   // element.
        // }
        // element.add(element as Component);
        print("VALUE : " + element.toString());
        elementsOnScreen
            .add(jsonParser.widgetQueue.keys.elementAt(currentPosition));
        add(element as Component);
      } else {
        print("VALUE : " + element.toString());
        elementsOnScreen
            .add(jsonParser.widgetQueue.keys.elementAt(currentPosition));
        add(element as Component);
      }
    }
  }

  @override
  FutureOr<void> onLoad() async {
    print("KEYS 2 : " + jsonParser.widgetQueue.keys.toString());
    continueDraw();
  }

  @override
  void onTapDown(TapDownInfo info) {
    super.onTapDown(info);
    removeAllComponent();
    // if (gamemode.currentGameMode!(info) == true) {
    //   continueDraw();
    // }
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
