import 'dart:async';

import 'package:ames/utils/game_manager.dart';
import 'package:flame/components.dart';

class AnimatedImage extends SpriteComponent with HasGameRef<GameManager> {
  String fileName;
  int nbImage;
  bool loop;
  Vector2 imageSize;
  double sizeMultiplicator;
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
    required this.sizeMultiplicator,
    required this.frameRate,
    required this.coord,
  });

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    print("imageSize : " + imageSize.toString());

    sprite = await Sprite.load(
      "$fileName$nextImage.png",
      srcSize: imageSize,
    );
    nextImage++;

    double x = (gameRef.size.toRect().width / 2).toDouble() + coord[0];
    double y = (gameRef.size.toRect().height / 2).toDouble() + coord[1];

    width = imageSize[0] * sizeMultiplicator;
    height = imageSize[1] * sizeMultiplicator;
    position = Vector2(x, y);
    anchor = Anchor.center;
  }

  @override
  void update(double dt) async {
    super.update(dt);
    timeCount += dt;
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
