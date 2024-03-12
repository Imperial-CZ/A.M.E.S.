import 'dart:async';

import 'package:ames/core/flame/gamemanager/game_manager.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';

class AnimatedImage extends SpriteComponent
    with HasGameRef<GameManager>, TapCallbacks {
  String fileName;
  int nbImage;
  bool loop;
  Vector2 imageSize;
  Vector2? modifiedImageSize;
  double sizeMultiplicator;
  Vector2 coord;
  double frameRate;
  bool activateCallback;
  Anchor? anchorInput;

  int nextImage = 0;
  double timeCount = 0;
  bool isFinish = false;

  AnimatedImage({
    required this.fileName,
    required this.nbImage,
    required this.loop,
    required this.imageSize,
    this.modifiedImageSize,
    this.anchorInput,
    required this.sizeMultiplicator,
    required this.frameRate,
    required this.coord,
    required this.activateCallback,
  });

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    print("imageSize : " + imageSize.toString());

    sprite = await Sprite.load(
      "$fileName$nextImage.png",
      srcSize: imageSize,
    );

    if (modifiedImageSize != null) {
      width = modifiedImageSize![0];
      height = modifiedImageSize![1];
    } else {
      width = imageSize[0] * sizeMultiplicator;
      height = imageSize[1] * sizeMultiplicator;
    }
    position = coord;
    anchor = anchorInput ?? Anchor.center;
  }

  @override
  void onTapDown(TapDownEvent event) {
    if (activateCallback == true) {
      print("TAP ON ANIMATED");
    }
  }

  @override
  void update(double dt) async {
    super.update(dt);
    timeCount += dt;
    if (timeCount >= frameRate && nextImage + 1 < nbImage) {
      nextImage++;
      print("image : " + nextImage.toString());
      sprite = await Sprite.load(
        "$fileName$nextImage.png",
        srcSize: imageSize,
      );
      timeCount = 0;
    } else if (timeCount >= frameRate &&
        nextImage + 1 >= nbImage &&
        loop == true) {
      nextImage = 0;
    }
  }
}
