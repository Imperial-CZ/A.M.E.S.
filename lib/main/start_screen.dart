import 'dart:async';

import 'package:ames/common/textCustom.dart';
import 'package:ames/game_manager.dart';
import 'package:flame/components.dart';

class StartScreen extends Component with HasGameRef<GameManager> {
  // Background background = Background(1);

  @override
  FutureOr<void> onLoad() async {
    // add(background);
    add(TextCustom("AMES is ready, press start", []));
    add(SpriteComponent(
      sprite: await Sprite.load("Bed_1.png", srcSize: Vector2(300, 300)),
      size: Vector2(100, 100),
      anchor: Anchor.center,
      position: Vector2(
        (gameRef.size.toRect().width - 100 / 2).toDouble(),
        (gameRef.size.toRect().height - 100 / 2).toDouble(),
      ),
    ));
  }

  void tapEvent(Vector2 tapPosition) {
    print("tapPosition.x = " + tapPosition.x.toString());
    print("tapPosition.y = " + tapPosition.y.toString());

    print("gameRef.size.toRect().width / 2 = " +
        (gameRef.size.toRect().width / 2).toString());
    print("gameRef.size.toRect().height / 2 = " +
        (gameRef.size.toRect().height / 2).toString());

    if (tapPosition.x >= gameRef.size.toRect().width / 2 &&
        tapPosition.y >= gameRef.size.toRect().height / 2) {
      removeFromParent();
    }
  }
}
