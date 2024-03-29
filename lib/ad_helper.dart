import 'dart:io';

class AdHelper {
  static String get bannerAdUnitId {
    if (Platform.isAndroid) {
      return 'ca-app-pub-1955915681676898/6514020697';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-1955915681676898/6514020697';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }

  static String get interstitialAd {
    if (Platform.isAndroid) {
      return 'ca-app-pub-1955915681676898/2185324063';
    } else if (Platform.isIOS) {
      return 'ca-app-pub-1955915681676898/2185324063';
    } else {
      throw UnsupportedError('Unsupported platform');
    }
  }
}
