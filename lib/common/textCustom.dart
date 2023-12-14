import 'dart:async';

import 'package:ames/game_manager.dart';
import 'package:flame/components.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';

class TextCustom extends TextComponent with HasGameRef<GameManager> {
  String textToPrint;
  List<String> nextText;
  Vector2? positionInput;
  Anchor? anchorInput;
  TextRenderer? textRendererInput;
  double? printSpeed;
  bool isRenderFinish = false;

  double timeCount = 0;
  int letterToPrint = 0;

  TextCustom(
    this.textToPrint,
    this.nextText, {
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
    if (timeCount >= printSpeed! && letterToPrint <= textToPrint.length) {
      if (letterToPrint == textToPrint.length) {
        text = textToPrint.characters.getRange(0, letterToPrint).toString();
      } else {
        text =
            textToPrint.characters.getRange(0, letterToPrint).toString() + "-";
      }
      letterToPrint += 1;
      timeCount = 0;
      if (letterToPrint > textToPrint.length) {
        isRenderFinish = true;
      }
    }
  }

  void printNextText() {
    textToPrint = nextText[0];
    letterToPrint = 0;
    nextText.removeAt(0);
  }
}
