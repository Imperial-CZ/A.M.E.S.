import 'dart:async';
import 'dart:convert';

import 'package:ames/utils/widgets/woman.dart';
import 'package:ames/game_manager.dart';
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
    final String response = await rootBundle.loadString('assets/test.json');
    print("response : " + response);
    data = await json.decode(response) as Map<String, dynamic>;
    print("data : " + data.toString());
    Map<String, dynamic> test = data["A"] as Map<String, dynamic>;
    test.forEach((keyParent, value) {
      print("======================" + keyParent + "======================");
      Map<String, dynamic> test2 = value as Map<String, dynamic>;
      if (test2["type"] == "AI") {
        // MapEntry temp = MapEntry(
        //         keyParent,
        //         AnimatedImage(
        //             test2["mainTitle"],
        //             test2["nbImage"],
        //             test2["loop"],
        //             Vector2(test2["width"], test2["height"]),
        //             test2["frameRate"]));
        print("KEY PARENT : " + keyParent);
        listComponent.addAll({
          keyParent: AnimatedImage(
              test2["mainTitle"],
              test2["nbImage"],
              test2["loop"],
              Vector2(test2["width"], test2["height"]),
              test2["frameRate"])
        });
        print("listComponent : " + listComponent[keyParent].toString());
      }
      print("==================================");
    });
    add(listComponent["fond"] as AnimatedImage);
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
