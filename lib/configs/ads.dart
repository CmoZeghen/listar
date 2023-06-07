import 'dart:io';

class Ads {
  static String get appId {
    if (Platform.isAndroid) {
      return "ca-app-pub-8318136058462894~6297476501";
    } else if (Platform.isIOS) {
      return "ca-app-pub-8318136058462894~6779680472";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-8318136058462894/7418986484";
    } else if (Platform.isIOS) {
      return "ca-app-pub-8318136058462894/6894681801";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }

  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "";
    } else if (Platform.isIOS) {
      return "";
    } else {
      throw UnsupportedError("Unsupported platform");
    }
  }
}
