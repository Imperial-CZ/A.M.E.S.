import 'dart:convert';

class JsonParser {
  static Map<String, dynamic> parse(String json) {
    return jsonDecode(json);
  }
}
