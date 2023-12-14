import 'package:ames/utils/game_manager.dart';
import 'package:flame/components.dart';

class CustomSpirit extends SpriteComponent with HasGameRef<GameManager>{

  String path;

  Vector2 coord;

  Vector2 imageSize;

  Anchor? anchorInput;

  CustomSpirit(this.path, this.coord, this.imageSize, this.anchorInput);

  @override
  Future<void> onLoad() async {
    super.onLoad();
    sprite = await Sprite.load(
      path,
      srcSize: imageSize,
    );
    width = imageSize[0];
    height = imageSize[1];
    position = coord;
    anchor = anchorInput ?? Anchor.center;
  }
}
