import 'dart:convert';
import 'package:flutter/services.dart';

class JsonParser {
  late Map<String, dynamic> jsonMap;
  late List<String> keys;

  void parse(String json) async {
    String data = await rootBundle.loadString(json);
    jsonMap = jsonDecode(data);
    keys = [];

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
              buildTextComponent(map);
              break;
            case 'AT':
              buildAnimatedText(map);
              break;
            case 'AI':
              buildAnimatedImage(map);
              break;
            case 'IM':
              buildImage(map);
              break;
            case 'SP':
              buildSpirit(map);
              break;
            case 'MI':
              buildMovableImage(map);
              break;
            default:
              print('No type found');
          }
        }
      });
    });
  }

  void buildTextComponent(Map<String, dynamic> map) {
    print(map);
  }

  void buildAnimatedText(Map<String, dynamic> map) {
    print(map);
  }

  void buildAnimatedImage(Map<String, dynamic> map) {
    print(map);
  }

  void buildImage(Map<String, dynamic> map) {
    print(map);
  }

  void buildSpirit(Map<String, dynamic> map) {
    print(map);
  }

  void buildMovableImage(Map<String, dynamic> map) {
    print(map);
  }
}
