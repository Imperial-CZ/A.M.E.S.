import 'dart:async';
import 'dart:io';
import 'package:ames/utils/gameplay.dart';
import 'package:ames/utils/jsonParser.dart';
import 'package:ames/utils/waiting.dart';
import 'package:ames/utils/widgets/animatedImage.dart';
import 'package:ames/utils/widgets/animatedText.dart';
import 'package:ames/utils/widgets/customSpirit.dart';
import 'package:ames/utils/widgets/movableImage.dart';
import 'package:ames/utils/widgets/onClickButtonEvent.dart';
import 'package:ames/utils/widgets/remove.dart';
import 'package:ames/utils/widgets/removeAll.dart';
import 'package:ames/utils/widgets/stopRead.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/src/gestures/events.dart';

class GameManager extends FlameGame with TapDetector {
  GameManager({required this.jsonParser});

  JsonParser jsonParser;
  var gamemode = GameplayName.empty;
  List<String> elementsOnScreen = [];
  int currentPosition = 0;
  bool isReadStop = false;

  void removeComponent(String componentName, {bool isRemoveAll = false}) {
    if (elementsOnScreen.contains(componentName)) {
      remove(jsonParser.widgetQueue[componentName]);
      if (!isRemoveAll) {
        elementsOnScreen.remove(componentName);
      }
    }
  }

  void removeAllComponent() {
    for (int i = 0; i != elementsOnScreen.length; i++) {
      print("i : " + i.toString() + " Value : " + elementsOnScreen[i]);
      removeComponent(elementsOnScreen[i], isRemoveAll: true);
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
      } else if (element is StopRead) {
        isReadStop = true;
        currentPosition++;
        return;
      } else if (element is Gameplay) {
        gamemode = element.name;
      } else if (element is Remove) {
        removeComponent(element.name);
      } else if (element is RemoveAll) {
        removeAllComponent();
      } else if (element is CustomSprite ||
          element is AnimatedImage ||
          element is TextComponent ||
          element is AnimatedText ||
          element is MovableImage) {
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
    for (int i = 0; i != elementsOnScreen.length; i++) {
      if (jsonParser.widgetQueue[elementsOnScreen[i]] is CustomSprite) {
        if ((jsonParser.widgetQueue[elementsOnScreen[i]] as CustomSprite)
                    .isButtonTrigger ==
                true &&
            (jsonParser.widgetQueue[elementsOnScreen[i]] as CustomSprite)
                    .activateCallback ==
                true) {
          switch ((jsonParser.widgetQueue[elementsOnScreen[i]] as CustomSprite)
              .onClickButtonEvent) {
            case OnClickButtonEvent.empty:
              return;
            case OnClickButtonEvent.continueDraw:
              onTapDownSpriteContinueDraw();
              return;
            case OnClickButtonEvent.killApp:
              onTapDownSpriteKillApp();
              return;
          }
        }
      }
    }
    switch (gamemode) {
      case GameplayName.empty:
        emptyGameMode(info.eventPosition.global);
      case GameplayName.onClickRightBottomCornerContinueDrawEvent:
        onClickRightBottomCornerContinueDrawEvent(info.eventPosition.global);
      case GameplayName.onClickOnScreenContinueDrawEvent:
        onClickOnScreenContinueDrawEvent(info.eventPosition.global);
      case GameplayName
            .onClickRightSideContinueDrawOnClickLeftSideCloseAppEvent:
        onClickRightSideContinueDrawOnClickLeftSideCloseAppEvent(
            info.eventPosition.global);
    }
  }

  void emptyGameMode(Vector2 tapPosition) {}

  void onClickRightBottomCornerContinueDrawEvent(Vector2 tapPosition) {
    print("tapPosition.x = ${tapPosition.x}");
    print("tapPosition.y = ${tapPosition.y}");

    print("gameRef.size.toRect().width / 2 = ${size.toRect().width / 2}");
    print("gameRef.size.toRect().height / 2 = ${size.toRect().height / 2}");

    if (tapPosition.x >= size.toRect().width / 2 &&
        tapPosition.y >= size.toRect().height / 2 &&
        isReadStop == true) {
      isReadStop = false;
      continueDraw();
    }
  }

  void onClickOnScreenContinueDrawEvent(Vector2 tapPosition) {
    if (isReadStop == true) {
      isReadStop = false;
      continueDraw();
    }
  }

  void onClickRightSideContinueDrawOnClickLeftSideCloseAppEvent(
      Vector2 tapPosition) {
    if (isReadStop == true) {
      if (tapPosition.x < size.toRect().width / 2 &&
          tapPosition.y < size.toRect().height / 2) {
        isReadStop = false;
        continueDraw();
      }
      if (tapPosition.x >= size.toRect().width / 2 &&
          tapPosition.y >= size.toRect().height / 2) {
        exit(0);
      }
    }
  }

  void onTapDownSpriteContinueDraw() {
    if (isReadStop == true) {
      continueDraw();
    }
  }

  void onTapDownSpriteKillApp() {
    if (isReadStop == true) {
      exit(0);
    }
  }
}
