import 'dart:async';

import 'package:flutter/services.dart';

class DynamicQrcodeScannner {

  static const MethodChannel _dqsChannel =
      const MethodChannel('dynamic_qrcode_scannner');

  static Future<String> get scanQrCodeAction async {
    final String version = await _dqsChannel.invokeMethod('scanQrCode');
    return version;
  }
}
