import 'dart:convert';
import 'dart:typed_data';

class StringUtils {
  static Uint8List base64ToUint8List(String string) {
    return base64.decode(string);
  }

  static String uint8ListToBase64(Uint8List bytes) {
    return base64.encode(bytes);
  }
}
