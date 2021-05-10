import 'dart:async';

import 'package:flutter/services.dart';

class Basispaysdk {
  static const MethodChannel _channel = const MethodChannel('basispaysdk');

  static Future<Map<dynamic, dynamic>> startTransaction(
      String apiKey,
      String saltKey,
      String returnUrl,
      bool isTesting,
      Map<String, dynamic> paymentRequestDicitionary) async {
    print(apiKey);
    var sendMap = <String, dynamic>{
      "apiKey": apiKey,
      "saltKey": saltKey,
      "returnUrl": returnUrl,
      "endPoint": isTesting,
      "payDict": paymentRequestDicitionary,
    };
    print(sendMap.toString());
    Map<dynamic, dynamic> version =
        await _channel.invokeMethod('startTransaction', sendMap);

    return version;
  }
}
