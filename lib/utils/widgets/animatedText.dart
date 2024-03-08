import 'dart:async';

import 'package:ames/utils/game_manager.dart';
import 'package:flame/components.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';

class AnimatedText extends TextComponent with HasGameRef<GameManager> {
  String allText;
  Vector2? positionInput;
  Anchor? anchorInput;
  TextRenderer? textRendererInput;
  double? printSpeed;
  bool isRenderFinish = false;

  double timeCount = 0;
  int letterToPrint = 0;

  AnimatedText(
    this.allText, {
    this.positionInput,
    this.anchorInput,
    this.textRendererInput,
    this.printSpeed,
  }) {
    printSpeed ??= 0.05;
  }

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    text = "";

    position = positionInput == null
        ? Vector2(
            gameRef.size.toRect().width / 2, gameRef.size.toRect().height / 2)
        : positionInput!;

    anchor = anchorInput == null ? Anchor.center : anchorInput!;

    textRenderer = textRendererInput == null
        ? TextPaint(
            style: const TextStyle(
              fontSize: 20.0,
              color: Colors.white,
            ),
          )
        : textRendererInput!;
  }

  @override
  void update(double dt) {
    super.update(dt);
    timeCount += dt;
    if (timeCount >= printSpeed! && letterToPrint <= allText.length) {
      if (letterToPrint == allText.length) {
        text = allText.characters.getRange(0, letterToPrint).toString();
      } else {
        print("writting in route");
        text = "${allText.characters.getRange(0, letterToPrint)}-";
      }
      letterToPrint += 1;
      timeCount = 0;
      if (letterToPrint > allText.length) {
        isRenderFinish = true;
      }
    }
  }
}
