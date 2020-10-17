
  import 'dart:io';

  class AdManager {

  static String get appId {
  if (Platform.isAndroid) {
  return "ca-app-pub-2609542594798987~6272674437";
  } else if (Platform.isIOS) {
  return "ca-app-pub-2609542594798987~6081102745";
  } else {
  throw new UnsupportedError("Unsupported platform");
  }
  }

  // static String get bannerAdUnitId {
  // if (Platform.isAndroid) {
  // return "ca-app-pub-2609542594798987/4549990698";
  // } else if (Platform.isIOS) {
  // return "ca-app-pub-3940256099942544/4339318960";
  // } else {
  // throw new UnsupportedError("Unsupported platform");
  // }
  // }
  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-2609542594798987/1446372092";
    } else if (Platform.isIOS) {
      return "ca-app-pub-2609542594798987/4455678818";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  }