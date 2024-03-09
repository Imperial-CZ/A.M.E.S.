import 'dart:async';
import 'package:flame/components.dart';
import '../gamemanager/game_manager.dart';

class MovableImage extends SpriteComponent with HasGameRef<GameManager> {
  String path;
  Vector2 initialCoord;
  Vector2 finalCoord;
  Vector2 imageSize;
  Anchor? anchorInput;

  //Initialisé à 1 pour éviter la division par 0, calcul dans le constructeur
  double ratioX = 1;
  double ratioY = 1;

  double speedMultiplicator;

  MovableImage({
    required this.path,
    required this.initialCoord,
    required this.finalCoord,
    required this.imageSize,
    this.speedMultiplicator = 1.0,
    this.anchorInput,
  }) {
    if (position.x - finalCoord.x < position.y - finalCoord.y) {
      ratioX = (position.x - finalCoord.x) / (position.y - finalCoord.y);
    } else {
      ratioY = (position.y - finalCoord.y) / (position.x - finalCoord.x);
    }
  }

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();
    sprite = await Sprite.load(
      "$path.png",
      srcSize: imageSize,
    );
    width = imageSize.x;
    height = imageSize.y;
    position = initialCoord;
    anchor = anchorInput ?? Anchor.center;
  }

  @override
  void update(double dt) {
    super.update(dt);
    if (position.x < finalCoord.x) {
      position.x += ratioX * speedMultiplicator;
    }
    if (position.y < finalCoord.y) {
      position.y += ratioY * speedMultiplicator;
    }
  }
}
