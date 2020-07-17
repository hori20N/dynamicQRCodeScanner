import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dynamic_qrcode_scannner/dynamic_qrcode_scannner.dart';

void main() {
  const MethodChannel channel = MethodChannel('dynamic_qrcode_scannner');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await DynamicQrcodeScannner.platformVersion, '42');
  });
}
