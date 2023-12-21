import 'dart:async';

import 'package:ames/utils/game_manager.dart';
import 'package:flame/components.dart';

class AnimatedImage extends SpriteComponent with HasGameRef<GameManager> {
  String fileName;
  int nbImage;
  bool loop;
  Vector2 imageSize;
  double frameRate;

  int nextImage = 0;
  double timeCount = 0;
  bool isFinish = false;

  AnimatedImage(
    this.fileName,
    this.nbImage,
    this.loop,
    this.imageSize,
    this.frameRate,
  );

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    sprite = await Sprite.load(
      "$fileName$nextImage.png",
      srcSize: imageSize,
    );
    nextImage++;

    double x = (gameRef.size.toRect().width / 2).toDouble();
    double y = (gameRef.size.toRect().height / 2).toDouble();

    width = imageSize[0];
    height = imageSize[1];
    position = Vector2(x, y);
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
