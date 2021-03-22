import 'package:google_mobile_ads/google_mobile_ads.dart';

class AdsApp{

  Future<InitializationStatus> initialization;
  AdsApp(this.initialization);

  String get bannerAdUnitId => "ca-app-pub-3940256099942544/6300978111";
  
}