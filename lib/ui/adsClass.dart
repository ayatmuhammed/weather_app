
  import 'dart:io';

  class AdManager {

  static String get appId {
  if (Platform.isAndroid) {
  return "ca-app-pub-2609542594798987~5330743414";
  } else if (Platform.isIOS) {
  return "ca-app-pub-3940256099942544~2594085930";
  } else {
  throw new UnsupportedError("Unsupported platform");
  }
  }

  static String get bannerAdUnitId {
  if (Platform.isAndroid) {
  return "ca-app-pub-2609542594798987/4549990698";
  } else if (Platform.isIOS) {
  return "ca-app-pub-3940256099942544/4339318960";
  } else {
  throw new UnsupportedError("Unsupported platform");
  }
  }
  static String get interstitialAdUnitId {
    if (Platform.isAndroid) {
      return "ca-app-pub-3940256099942544/7049598008";
    } else if (Platform.isIOS) {
      return "ca-app-pub-3940256099942544/3964253750";
    } else {
      throw new UnsupportedError("Unsupported platform");
    }
  }

  }