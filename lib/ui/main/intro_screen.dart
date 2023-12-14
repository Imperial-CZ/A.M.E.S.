import 'dart:async';

import 'package:ames/common/widgets/textCustom.dart';
import 'package:ames/common/widgets/woman.dart';
import 'package:ames/game_manager.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';

class IntroPage1Screen extends Component with HasGameRef<GameManager> {
  late TextCustom animatedText;
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

    animatedText = TextCustom(
      "Bonjour chers utilisateurs de l'A M E S (Amplificateur Mediumnique\nExtrasensoriel) Version trois point zéro. Vous avez été sélectionné par\nL'Agence pour notre programme de recherche sur le potentiel médiumnique\nde la population.\n\nTapez pour continuer.",
      [
        "Le programme A M E S que vous venez d'installer transforme votre téléphone\nen véritable antenne à auras. Si votre sensibilité médiumnique est assez\nélevée, l'Agence vous recontactera pour de plus amples informations et de\nnouvelles consignes.\n\nTapez pour continuer.",
        "Nous allons maintenant procéder à quelques étapes préparatoires pour le\ntest. Veuillez répondre aux questions suivantes. Confirmez vous que vous êtes\nbien à votre domicile ?"
      ],
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

  void tapEvent(Vector2 tapPosition) {
    if (animatedText.isRenderFinish == true) {
      if (animatedText.nextText != null && animatedText.nextText!.length != 0) {
        animatedText.isRenderFinish = false;
        animatedText.printNextText();
      } else {
        removeFromParent();
      }
    }
  }
}
