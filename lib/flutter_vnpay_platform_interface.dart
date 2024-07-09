import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'flutter_vnpay_method_channel.dart';

abstract class FlutterVnpayPlatform extends PlatformInterface {
  /// Constructs a FlutterVnpayPlatform.
  FlutterVnpayPlatform() : super(token: _token);

  static final Object _token = Object();

  static FlutterVnpayPlatform _instance =
      MethodChannelFlutterVnpay.instance;

  /// The default instance of [FlutterVnpayPlatform] to use.
  ///
  /// Defaults to [MethodChannelFlutterVnpay].
  static FlutterVnpayPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [FlutterVnpayPlatform] when
  /// they register themselves.
  static set instance(FlutterVnpayPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<String?> getPlatformVersion() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }

  Future<int?> show({
    required String paymentUrl,
    required String tmnCode,
    String scheme = '',
    bool isSandbox = false,
    String backAlert = 'Bạn có chắc chắn trở lại ko?',
    String title = 'Nạp tiền qua VNPay',
    String iconBackName = 'ic_back',
    String beginColor = '#00B14F',
    String endColor = '#00B14F',
    String titleColor = '#FFFFFF',
    void Function(int?)? codeCallback,
  }) {
    throw UnimplementedError('show() has not been implemented.');
  }
}
