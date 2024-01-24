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
      srcSize: Vector2(
        (gameRef.size.toRect().width / 2).toDouble(),
        (gameRef.size.toRect().height / 2).toDouble(),
      ),
    );
    nextImage++;

    position = Vector2(
      (gameRef.size.toRect().width / 2).toDouble(),
      (gameRef.size.toRect().height / 2).toDouble(),
    );
    width = 480;
    height = 320;
    anchor = Anchor.center;
  }

  @override
  void update(double dt) async {
    super.update(dt);
    timeCount += dt;
    print("timeCount : " +
        timeCount.toString() +
        " frameRate : " +
        frameRate.toString() +
        " nbImage : " +
        nbImage.toString() +
        " nextImage : " +
        nextImage.toString());
    if (timeCount >= frameRate && nextImage < nbImage) {
      print("nextImage : " + nextImage.toString());
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
