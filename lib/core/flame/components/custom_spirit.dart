import 'dart:async';

import 'package:ames/core/flame/gamemanager/game_manager.dart';
import 'package:ames/core/enum/on_click_button_event.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';

class CustomSprite extends SpriteComponent
    with HasGameRef<GameManager>, TapCallbacks {
  String path;

  Vector2 coord;

  Vector2 imageSize;

  Anchor anchorInput;

  bool activateCallback;

  bool isButtonTrigger = false;

  OnClickButtonEventName onClickButtonEvent;

  Stream<bool> trigger = Stream.value(false);

  CustomSprite({
    required this.path,
    required this.coord,
    required this.imageSize,
    required this.anchorInput,
    required this.activateCallback,
    required this.onClickButtonEvent,
  });

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    sprite = await Sprite.load(
      "$path.png",
      srcSize: imageSize,
    );
    width = imageSize[0];
    height = imageSize[1];
    position = coord;
    anchor = anchorInput ?? Anchor.center;
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (activateCallback == true) {
      isButtonTrigger = true;
      print("Custom Spirit tap down");
    }
  }
}
