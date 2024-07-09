import 'flutter_vnpay_platform_interface.dart';

class FlutterVnpay {
  Future<String?> getPlatformVersion() {
    return FlutterVnpayPlatform.instance.getPlatformVersion();
  }

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
    return FlutterVnpayPlatform.instance.show(
      paymentUrl: paymentUrl,
      tmnCode: tmnCode,
      scheme: scheme,
      isSandbox: false,
      backAlert: backAlert,
      title: title,
      iconBackName: iconBackName,
      beginColor: beginColor,
      endColor: endColor,
      titleColor: titleColor,
      codeCallback: codeCallback,
    );
  }
}
