import 'dart:async';
import 'dart:io';
import 'package:ames/core/enum/gamemode_name.dart';
import 'package:ames/core/json_parser/custom_type/camera.dart';
import 'package:ames/core/json_parser/custom_type/gamemode.dart';
import 'package:ames/core/json_parser/custom_type/sound.dart';
import 'package:ames/core/json_parser/custom_type/stop_sound.dart';
import 'package:ames/core/json_parser/json_parser.dart';
import 'package:ames/core/json_parser/custom_type/waiting.dart';
import 'package:ames/core/flame/components/animated_image.dart';
import 'package:ames/core/flame/components/animated_text.dart';
import 'package:ames/core/flame/components/custom_spirit.dart';
import 'package:ames/core/flame/components/movable_image.dart';
import 'package:ames/core/enum/on_click_button_event.dart';
import 'package:ames/core/json_parser/custom_type/remove.dart';
import 'package:ames/core/json_parser/custom_type/remove_all.dart';
import 'package:ames/core/json_parser/custom_type/stop_read.dart';
import 'package:ames/ui/game/cubit/game_cubit.dart';
import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/input.dart';
import 'package:flame/src/gestures/events.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class GameManager extends FlameGame with TapDetector {
  GameManager({
    required this.jsonParser,
    required this.context,
  });

  JsonParser jsonParser;
  BuildContext context;

  Map<String, AudioPlayer> audioPlayers = {};

  var gamemode = GamemodeName.empty;
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

      BlocProvider.of<GameCubit>(context).changeCameraState(true);

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
      } else if (element is Gamemode) {
        gamemode = element.name;
      } else if (element is Remove) {
        removeComponent(element.name);
      } else if (element is RemoveAll) {
        removeAllComponent();
      } else if (element is Camera) {
      } else if (element is CustomSprite ||
          element is AnimatedImage ||
          element is TextComponent ||
          element is AnimatedText ||
          element is MovableImage) {
        elementsOnScreen
            .add(jsonParser.widgetQueue.keys.elementAt(currentPosition));
        add(element as Component);
      } else if (element is Sound) {
        String jsonParserElementName =
            jsonParser.widgetQueue.keys.elementAt(currentPosition);
        audioPlayers.addAll({jsonParserElementName: AudioPlayer()});
        AssetSource source = AssetSource("sounds/${element.filename}.mp3");
        audioPlayers[jsonParserElementName]!.play(source);
        if (element.loop == true) {
          audioPlayers[jsonParserElementName]!.setReleaseMode(ReleaseMode.loop);
        }
      } else if (element is StopSound) {
        if (audioPlayers[element.name] != null) {
          audioPlayers[element.name]!.setReleaseMode(ReleaseMode.stop);
          audioPlayers[element.name]!.dispose();
        }
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
            case OnClickButtonEventName.empty:
              return;
            case OnClickButtonEventName.continueDraw:
              onTapDownSpriteContinueDraw();
              return;
            case OnClickButtonEventName.killApp:
              onTapDownSpriteKillApp();
              return;
          }
        }
      }
    }
    switch (gamemode) {
      case GamemodeName.empty:
        emptyGameMode(info.eventPosition.global);
      case GamemodeName.onClickRightBottomCornerContinueDrawEvent:
        onClickRightBottomCornerContinueDrawEvent(info.eventPosition.global);
      case GamemodeName.onClickOnScreenContinueDrawEvent:
        onClickOnScreenContinueDrawEvent(info.eventPosition.global);
      case GamemodeName
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
    bool animatedTextEncounterNotRender = false;
    for (int i = 0; i != elementsOnScreen.length; i++) {
      if (jsonParser.widgetQueue[elementsOnScreen[i]] is AnimatedText &&
          (jsonParser.widgetQueue[elementsOnScreen[i]] as AnimatedText)
                  .isRenderFinish ==
              false) {
        animatedTextEncounterNotRender = true;
        (jsonParser.widgetQueue[elementsOnScreen[i]] as AnimatedText).printAll =
            true;
      }
    }
    if (isReadStop == true && animatedTextEncounterNotRender == false) {
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
