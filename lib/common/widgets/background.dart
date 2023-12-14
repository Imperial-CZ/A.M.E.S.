import 'dart:async';

import 'package:ames/utils/game_manager.dart';
import 'package:flame/components.dart';

class Background extends Component with HasGameRef<GameManager> {
  int nbWoman;

  Background(this.nbWoman);

  @override
  FutureOr<void> onLoad() {}

  @override
  void update(double dt) {
    super.update(dt);
  }
}
