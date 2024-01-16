import 'dart:async';

import 'package:ames/utils/game_manager.dart';
import 'package:flame/components.dart';

class AnimatedImage extends SpriteComponent with HasGameRef<GameManager> {
  String filename;
  int nbImage;
  bool loop;
  Vector2 imageSize;
  Vector2 coord;
  double framerate;

  int nextImage = 0;
  double timeCount = 0;
  bool isFinish = false;

  AnimatedImage({
    required this.filename,
    required this.nbImage,
    required this.loop,
    required this.imageSize,
    required this.framerate,
    required this.coord,
  });

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    sprite = await Sprite.load(
      "$filename$nextImage.png",
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
    if (timeCount >= framerate && nextImage < nbImage) {
      sprite = await Sprite.load(
        "$filename$nextImage.png",
        srcSize: imageSize,
        srcPosition: coord,
      );
      nextImage++;
      timeCount = 0;
    } else if (timeCount >= framerate && nextImage >= nbImage) {
      if (loop = false) {
        removeFromParent();
      } else {
        nextImage = 0;
      }
    }
  }
}
