import 'dart:convert';
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
            case 'IM':
              widget = buildImage(map);
              break;
            case 'SP':
              widget = buildSpirit(map);
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

  String buildTextComponent(Map<String, dynamic> map) {
    print(map);
    return "a";
  }

  String buildAnimatedText(Map<String, dynamic> map) {
    print(map);
    return "a";
  }

  String buildAnimatedImage(Map<String, dynamic> map) {
    print(map);
    return "a";
  }

  String buildImage(Map<String, dynamic> map) {
    print(map);
    return "a";
  }

  String buildSpirit(Map<String, dynamic> map) {
    print(map);
    return "a";
  }

  String buildMovableImage(Map<String, dynamic> map) {
    print(map);
    return "a";
  }
}
