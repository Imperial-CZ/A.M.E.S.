import 'dart:async';

import 'package:ames/utils/widgets/animatedText.dart';
import 'package:ames/utils/widgets/animatedImage.dart';
import 'package:ames/utils/game_manager.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class IntroPage1Screen extends Component with HasGameRef<GameManager> {
  late AnimatedText animatedText;
  late TextComponent titleText;
  late TextComponent versionText;
  late AnimatedImage background;

  @override
  FutureOr<void> onLoad() {
    titleText = TextComponent(
      text: "a·m·e·s·",
      position: Vector2(
        gameRef.size.toRect().width / 2,
        gameRef.size.toRect().height / 7,
      ),
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 130.0,
          color: Colors.red,
        ),
      ),
    );

    versionText = TextComponent(
      text: "version 3.0",
      position: Vector2(
        gameRef.size.toRect().width / 3,
        gameRef.size.toRect().height / 7 + 70,
      ),
      anchor: Anchor.center,
      textRenderer: TextPaint(
        style: const TextStyle(
          fontSize: 35.0,
          color: Colors.white,
        ),
      ),
    );

    animatedText = AnimatedText(
      "Bonjour chers utilisateurs de l'A M E S (Amplificateur Mediumnique\nExtrasensoriel) Version trois point zéro. Vous avez été sélectionné par\nL'Agence pour notre programme de recherche sur le potentiel médiumnique\nde la population.\n\nTapez pour continuer.",
      positionInput: Vector2(
        gameRef.size.toRect().width / 8,
        gameRef.size.toRect().height / 2.5,
      ),
      anchorInput: Anchor.topLeft,
    );

    background = AnimatedImage("fond_", 47, true, Vector2(480, 320), 0.5);

    add(background);

    add(titleText);

    add(versionText);

    add(animatedText);
  }

  void tapEvent(Vector2 tapPosition) {}
}
