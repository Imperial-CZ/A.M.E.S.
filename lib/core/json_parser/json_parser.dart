import 'dart:convert';
import 'package:ames/core/enum/gamemode_name.dart';
import 'package:ames/core/flame/components/datetime_text.dart';
import 'package:ames/core/json_parser/custom_type/camera.dart';
import 'package:ames/core/json_parser/custom_type/gamemode.dart';
import 'package:ames/core/json_parser/custom_type/stop_sound.dart';
import 'package:ames/core/json_parser/custom_type/waiting.dart';
import 'package:ames/core/flame/components/animated_image.dart';
import 'package:ames/core/flame/components/animated_text.dart';
import 'package:ames/core/flame/components/custom_spirit.dart';
import 'package:ames/core/flame/components/movable_image.dart';
import 'package:ames/core/enum/on_click_button_event.dart';
import 'package:ames/core/json_parser/custom_type/remove.dart';
import 'package:ames/core/json_parser/custom_type/remove_all.dart';
import 'package:ames/core/json_parser/custom_type/sound.dart';
import 'package:ames/core/json_parser/custom_type/stop_read.dart';
import 'package:flame/components.dart';
import 'package:flame/text.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class JsonParser {
  late Map<String, dynamic> jsonMap;
  late List<String> keys;
  late Map<String, dynamic> widgetQueue = {};

  Future<void> parse(String json) async {
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
      map.forEach((key, value) async {
        if (key == 'type') {
          switch (value) {
            case 'TC':
              widget = buildTextComponent(map);
            case 'AT':
              widget = buildAnimatedText(map);
            case 'AI':
              widget = buildAnimatedImage(map);
            case 'SP':
              widget = buildSprite(map);
            case 'MI':
              widget = buildMovableImage(map);
            case 'GM':
              widget = buildGameplay(map);
            case 'SR':
              widget = buildStopRead(map);
            case 'RMA':
              widget = buildRemoveAll(map);
            case 'RM':
              widget = buildRemove(map);
            case 'SO':
              widget = buildSound(map);
            case 'STS':
              widget = buildStopSound(map);
            case 'DT':
              widget = buildDateTimeText(map);
            case 'CA':
              widget = buildCameraState(map);
            case 'CH':
              widget = checkHeadphone(map);
            case 'CL':
              widget = checkLight(map);
            case 'WA':
              widget = Waiting(duration: map["duration"]);
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
            color: parseColor(map['color']),
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
          color: parseColor(map['color']),
          fontSize: map['fontSize'], //? type : Double
        ),
      ),
      printSpeed: map["printSpeed"],
    );
  }

  AnimatedImage buildAnimatedImage(Map<String, dynamic> map) {
    return AnimatedImage(
      fileName: map['filename'], //? entete du nom
      nbImage: map['nbImage'], //? compteur
      loop: map['loop'], //? true / false => animation en boucle ou non
      imageSize: Vector2(map['imageWidth'], map['imageHeight']),
      modifiedImageSize:
          makeImageSize(map['modifiedWidth'], map['modifiedHeight']),
      sizeMultiplicator: map["sizeMultiplicator"] ?? 1.0,
      coord: Vector2(map['x'], map['y']),
      frameRate: map['framerate'],
      activateCallback: map['isTapable'],
      anchorInput: parseAnchor(map['anchor'] ?? ""),
    );
  }

  CustomSprite buildSprite(Map<String, dynamic> map) {
    return CustomSprite(
      path: map['filename'],
      coord: Vector2(map['x'], map['y']),
      imageOrigineSize: Vector2(map['originWidth'], map['originHeight']),
      modifiedImageSize: makeImageSize(map['width'], map['height']),
      sizeMultiplicator: map['sizeMultiplicator'] ?? 1.0,
      anchorInput: parseAnchor(map['anchor']),
      activateCallback: map['isTapable'],
      onClickButtonEvent: parseButtonEvent(map['eventName']),
    );
  }

  MovableImage buildMovableImage(Map<String, dynamic> map) {
    return MovableImage(
      path: map['filename'],
      initialCoord: Vector2(map['xBegin'], map['yBegin']),
      finalCoord: Vector2(map['xEnd'], map['yEnd']),
      imageSize: Vector2(map['width'], map['height']),
      modifiedImageSize:
          makeImageSize(map['modifiedWidth'], map['modifiedHeight']),
      anchorInput: parseAnchor(map['anchor']),
      speedMultiplicator: map['speedMultiplicator'],
      loop: map['loop'],
    );
  }

  Gamemode buildGameplay(Map<String, dynamic> map) {
    switch (map['name']) {
      case "empty":
        return Gamemode(
          name: GamemodeName.empty,
        );
      case "onClickRightBottomCornerContinueDrawEvent":
        return Gamemode(
          name: GamemodeName.onClickRightBottomCornerContinueDrawEvent,
        );
      case "onClickOnScreenContinueDrawEvent":
        return Gamemode(
          name: GamemodeName.onClickOnScreenContinueDrawEvent,
        );
      case "onClickRightSideContinueDrawOnClickLeftSideCloseAppEvent":
        return Gamemode(
          name: GamemodeName
              .onClickRightSideContinueDrawOnClickLeftSideCloseAppEvent,
        );
    }
    return Gamemode(name: GamemodeName.empty);
  }

  StopRead buildStopRead(Map<String, dynamic> map) {
    return StopRead();
  }

  RemoveAll buildRemoveAll(Map<String, dynamic> map) {
    return RemoveAll();
  }

  Remove buildRemove(Map<String, dynamic> map) {
    return Remove(name: map['name']);
  }

  Sound buildSound(Map<String, dynamic> map) {
    return Sound(
      filename: map['filename'],
      loop: map['loop'],
      volume: map['volume'],
    );
  }

  StopSound buildStopSound(Map<String, dynamic> map) {
    return StopSound(name: map['name']);
  }

  TextComponent buildDateTimeText(Map<String, dynamic> map) {
    return DatetimeText(
        positionInput: Vector2(map['x'], map['y']),
        anchorInput: parseAnchor(map['anchor']),
        textRendererInput: TextPaint(
          style: TextStyle(
            color: parseColor(map['color']),
            fontSize: map['fontSize'], //? type : Double
          ),
        ));
  }

  Camera buildCameraState(Map<String, dynamic> map) {
    return Camera(activate: map['activate']);
  }

  checkHeadphone(Map<String, dynamic> map) {}

  checkLight(Map<String, dynamic> map) {}

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

  OnClickButtonEventName parseButtonEvent(String? onClickButtonEventName) {
    switch (onClickButtonEventName) {
      case 'empty':
        return OnClickButtonEventName.empty;
      case 'continueDraw':
        return OnClickButtonEventName.continueDraw;
      case 'killApp':
        return OnClickButtonEventName.killApp;
    }

    return OnClickButtonEventName.empty;
  }

  Color parseColor(String? colorName) {
    switch (colorName) {
      case 'white':
        return Colors.white;
      case 'red':
        return Colors.red;
      case 'blue':
        return Colors.blue;
    }

    return Colors.white;
  }

  Vector2? makeImageSize(double? width, double? height) {
    if (width == null || height == null) {
      return null;
    } else {
      return Vector2(width, height);
    }
  }
}
