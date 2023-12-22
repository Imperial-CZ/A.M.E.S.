import 'dart:convert';
import 'package:ames/utils/widgets/animatedImage.dart';
import 'package:ames/utils/widgets/animatedText.dart';
import 'package:ames/utils/widgets/movableImage.dart';
import 'package:flame/components.dart';
import 'package:flame/text.dart';
import 'package:flutter/services.dart';

class JsonParser {
  late Map<String, dynamic> jsonMap;
  late List<String> keys;
  late Map<String, dynamic> widgetQueue;

  void parse(String json) async {
    String data = await rootBundle.loadString(json);
    jsonMap = jsonDecode(data);
    keys = [];
    dynamic widget;

    // Make array of keys
    jsonMap.forEach((key, value) {
      keys.add(key);
    });
    keys.forEach((element) {
      Map<String, dynamic> map = jsonMap[element];
      map.forEach((key, value) {
        if (key == 'type') {
          switch (value) {
            case 'TC':
              widget = buildTextComponent(map);
              break;
            case 'AT':
              widget = buildAnimatedText(map);
              break;
            case 'AI':
              widget = buildAnimatedImage(map);
              break;
            case 'SP':
              widget = buildSprite(map);
              break;
            case 'MI':
              widget = buildMovableImage(map);
              break;
            default:
              print('No type found');
          }
          if (widget != null) {
            widgetQueue.addAll({element: widget});
          }
        }
      });
    });
  }

  TextComponent buildTextComponent(Map<String, dynamic> map) {
    return TextComponent(
        text: map['text'],
        position: Vector2(map['x'], map['y']),
        anchor: parseAnchor(map['anchor']),
        textRenderer: TextPaint(
          style: TextStyle(
            color: Color(map['color']),
            fontSize: map['fontSize'], //? type : Double
          ),
        ));
  }

  AnimatedText buildAnimatedText(Map<String, dynamic> map) {
    return AnimatedText(
      map['text'],
      positionInput: Vector2(map['x'], map['y']),
      anchorInput: parseAnchor(map['anchor']),
      textRendererInput: TextPaint(
        style: TextStyle(
          color: Color(map['color']),
          fontSize: map['fontSize'], //? type : Double
        ),
      ),
    );
  }

  AnimatedImage buildAnimatedImage(Map<String, dynamic> map) {
    return AnimatedImage(
      map['filename'], //? entete du nom
      map['nbImage'], //? compteur
      map['loop'], //? true / false => animation en boucle ou non
      Vector2(map['width'], map['height']),
      map['frameRate'],
    );
  }

  Future<SpriteComponent> buildSprite(Map<String, dynamic> map) async {
    return SpriteComponent(
        sprite: await Sprite.load(
          map['filename'],
          srcSize: Vector2(map['width'], map['height']),
        ),
        position: Vector2(map['x'], map['y']),
        anchor: parseAnchor(map['anchor']));
  }

  MovableImage buildMovableImage(Map<String, dynamic> map) {
    return MovableImage(
        path: map['filename'],
        initialCoord: Vector2(map['xBegin'], map['yBegin']),
        finalCoord: Vector2(map['xEnd'], map['yEnd']),
        imageSize: Vector2(map['width'], map['end']),
        anchorInput: parseAnchor(map['anchor']));
  }

  Anchor parseAnchor(String anchor) {
    switch (anchor) {
      case 'topLeft':
        return Anchor.topLeft;
      case 'topCenter':
        return Anchor.topCenter;
      case 'topRight':
        return Anchor.topRight;
      case 'centerLeft':
        return Anchor.centerLeft;
      case 'center':
        return Anchor.center;
      case 'centerRight':
        return Anchor.centerRight;
      case 'bottomLeft':
        return Anchor.bottomLeft;
      case 'bottomCenter':
        return Anchor.bottomCenter;
      case 'bottomRight':
        return Anchor.bottomRight;
      default:
        print('Anchor is not found, default value is center');
        return Anchor.center;
    }
  }
}
