import 'package:flutter/services.dart';

class MapKeyIOS {
  static const platform = MethodChannel("com.asama.movieapp/map-key");

  Future setMapKey(String mapKey) async {
    try {
      final result = await platform.invokeMethod("setMapKey", {"mapKey": mapKey});
      return result;
    } catch (e) {}
    return false;
  }
}
