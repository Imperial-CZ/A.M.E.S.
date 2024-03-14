import 'dart:async';

import 'package:ames/core/flame/gamemanager/game_manager.dart';
import 'package:flame/components.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';

class DatetimeText extends TextComponent with HasGameRef<GameManager> {
  Vector2? positionInput;
  Anchor? anchorInput;
  TextRenderer? textRendererInput;

  DateTime printedDatetime = DateTime.now();

  DatetimeText({
    this.positionInput,
    this.anchorInput,
    this.textRendererInput,
  });

  @override
  FutureOr<void> onLoad() async {
    await super.onLoad();

    refreshTime();

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
    if (printedDatetime.minute != (DateTime.now()).minute) {
      print("time is refresh");
      refreshTime();
    }
  }

  void refreshTime() {
    printedDatetime = DateTime.now();
    text =
        "${printedDatetime.day < 10 ? "0${printedDatetime.day}" : printedDatetime.day}/${printedDatetime.month < 10 ? "0${printedDatetime.month}" : printedDatetime.month}/${printedDatetime.year} ${printedDatetime.hour < 10 ? "0${printedDatetime.hour}" : printedDatetime.hour}:${printedDatetime.minute < 10 ? "0${printedDatetime.minute}" : printedDatetime.minute}";
  }
}
