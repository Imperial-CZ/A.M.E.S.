import 'dart:async';
import 'dart:convert';

import 'package:ames/utils/widgets/customSpirit.dart';
import 'package:ames/utils/widgets/animatedImage.dart';
import 'package:ames/utils/game_manager.dart';
import 'package:flame/components.dart';
import 'package:flutter/services.dart';

class TestScreen extends Component with HasGameRef<GameManager> {
  late Function(Vector2 tapPosition) onTapEvent;
  Map<String, dynamic> listComponent = {
    "background": AnimatedImage("fond_", 47, true, Vector2(480, 320), 0.5),
  };
  late final data;

  @override
  FutureOr<void> onLoad() async {
    add(CustomSpirit("fond_1", Vector2(32, 320), Vector2(480, 320), null));
  }

  void tapEvent(Vector2 tapPosition) {
    (listComponent["fond"] as AnimatedImage).frameRate = 0.1;
  }

  void nextPrint(
    List<Component> componentsToModify,
    List<Component> componentsToDelete,
    Map<String, dynamic> order,
    Function(Vector2) tapEventFunction,
  ) {
    onTapEvent = tapEventFunction;
    for (int i = 0; i != order.length; i++) {}
  }
}
