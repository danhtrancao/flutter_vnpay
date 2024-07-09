import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';
import 'flutter_vnpay_platform_interface.dart';

/// An implementation of [FlutterVnpayPlatform] that uses method channels.
class MethodChannelFlutterVnpay extends FlutterVnpayPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('flutter_vnpay');
  final StreamController<MethodCall> _methodStreamController =
      StreamController.broadcast();
  Stream<MethodCall> get _methodStream => _methodStreamController.stream;

  MethodChannelFlutterVnpay._() {
    methodChannel.setMethodCallHandler((MethodCall call) async {
      debugPrint('[setMethodCallHandler] call = $call');
      _methodStreamController.add(call);
    });
  }

  static final MethodChannelFlutterVnpay _instance =
      MethodChannelFlutterVnpay._();
  static MethodChannelFlutterVnpay get instance => _instance;

  @override
  Future<String?> getPlatformVersion() async {
    final version =
        await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }

  @override
  Future<int?> show({
    required String paymentUrl,
    required String tmnCode,
    String scheme = '',
    bool isSandbox = false,
    String backAlert = 'Bạn có chắc chắn trở lại ko?',
    String title = 'Nạp tiền qua VNPay',
    String iconBackName = 'ic_back',
    String beginColor = '#438ff5',
    String endColor = '#438ff5',
    String titleColor = '#FFFFFF',
    void Function(int?)? codeCallback,
  }) async {
    final params = <String, dynamic>{
      "scheme": scheme,
      "isSandbox": isSandbox,
      "paymentUrl": paymentUrl,
      "tmn_code": tmnCode,
      "backAlert": backAlert,
      "title": title,
      "iconBackName": iconBackName,
      "beginColor": beginColor,
      "endColor": endColor,
      "titleColor": titleColor,
    };
    await methodChannel.invokeMethod('show', params);
    await for (MethodCall m in _methodStream) {
      if (m.method == "PaymentBack") {
        final resultCode = m.arguments['resultCode'] as int?;
        codeCallback?.call(resultCode);
        return resultCode;
      }
    }
    return null;
  }
}
