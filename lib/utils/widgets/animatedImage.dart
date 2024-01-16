import 'dart:async';

import 'package:ames/utils/game_manager.dart';
import 'package:flame/components.dart';

class AnimatedImage extends SpriteComponent with HasGameRef<GameManager> {
  String fileName;
  int nbImage;
  bool loop;
  Vector2 imageSize;
  Vector2 coord;
  double frameRate;

  int nextImage = 0;
  double timeCount = 0;
  bool isFinish = false;

  AnimatedImage({
    required this.fileName,
    required this.nbImage,
    required this.loop,
    required this.imageSize,
    required this.frameRate,
    required this.coord,
  });

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    sprite = await Sprite.load(
      "$fileName$nextImage.png",
      srcSize: imageSize,
      srcPosition: coord,
    );
    nextImage++;

    width = imageSize[0];
    height = imageSize[1];
    anchor = Anchor.center;
  }

  @override
  void update(double dt) async {
    super.update(dt);
    timeCount += dt;
    if (timeCount >= frameRate && nextImage < nbImage) {
      sprite = await Sprite.load(
        "$fileName$nextImage.png",
        srcSize: imageSize,
        srcPosition: coord,
      );
      nextImage++;
      timeCount = 0;
    } else if (timeCount >= frameRate && nextImage >= nbImage) {
      if (loop = false) {
        removeFromParent();
      } else {
        nextImage = 0;
      }
    }
  }
}
