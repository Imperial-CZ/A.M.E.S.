import 'dart:async';

import 'package:ames/core/flame/gamemanager/game_manager.dart';
import 'package:ames/core/enum/on_click_button_event.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';

class CustomSprite extends SpriteComponent
    with HasGameRef<GameManager>, TapCallbacks {
  String path;

  Vector2 coord;

  Vector2 imageOrigineSize;

  Vector2? modifiedImageSize;

  double sizeMultiplicator;

  Anchor anchorInput;

  bool activateCallback;

  bool isButtonTrigger = false;

  OnClickButtonEventName onClickButtonEvent;

  Stream<bool> trigger = Stream.value(false);

  CustomSprite({
    required this.path,
    required this.coord,
    required this.imageOrigineSize,
    this.modifiedImageSize,
    this.sizeMultiplicator = 1.0,
    required this.anchorInput,
    required this.activateCallback,
    required this.onClickButtonEvent,
  });

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    sprite = await Sprite.load(
      "$path.png",
      srcSize: imageOrigineSize,
    );
    if (modifiedImageSize == null) {
      imageOrigineSize = Vector2(imageOrigineSize.x * sizeMultiplicator,
          imageOrigineSize.y * sizeMultiplicator);
      width = imageOrigineSize[0];
      height = imageOrigineSize[1];
    } else {
      width = modifiedImageSize![0];
      height = modifiedImageSize![1];
    }
    position = coord;
    anchor = anchorInput;
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (activateCallback == true) {
      isButtonTrigger = true;
      print("Custom Spirit tap down");
    }
  }
}
