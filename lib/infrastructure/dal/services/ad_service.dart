// import 'dart:io';


// class AdsService {
//  // final navigationService = locator<NavigationService>();
//   final _firestoreService = FirestoreService();

//   /* native ads */
//   NativeAd? nativeAd;
//   bool nativeAdIsLoaded = false;
//   // final double _adAspectRatioSmall = (91 / 355);
//   final double adAspectRatioMedium = (370 / 355);
//   final String nativeAdUnitId = Platform.isAndroid
//       ? 'ca-app-pub-7233265523334598/6537366452'
//       : 'ca-app-pub-7233265523334598/2314762400';

//   // Loads native ad
//   Future<void> loadNativeAd() async {
//     final log = getLogger('NativeAdService');

//     try {
//       final user = await _firestoreService.getUserData();

//       // if the user is not subscribed, load the native ad
//       if (!(user?.isSubscribed ?? false)) {
//         nativeAd = NativeAd(
//           adUnitId: nativeAdUnitId,
//           listener: NativeAdListener(
//             onAdLoaded: (ad) {
//               nativeAdIsLoaded = true;
//               log.e('Native Ad loaded: $ad');
//             },
//             onAdFailedToLoad: (ad, error) {
//               nativeAdIsLoaded = false;
//               ad.dispose();
//               log.e('Native Ad failed to load: $error');
//             },
//           ),
//           request: const AdRequest(),
//           nativeTemplateStyle: NativeTemplateStyle(
//             templateType: TemplateType.medium,
//             mainBackgroundColor: Colors.white,
//             callToActionTextStyle: NativeTemplateTextStyle(
//               textColor: Colors.white,
//               style: NativeTemplateFontStyle.monospace,
//               size: 16.0,
//             ),
//             primaryTextStyle: NativeTemplateTextStyle(
//               textColor: Colors.black,
//               style: NativeTemplateFontStyle.bold,
//               size: 16.0,
//             ),
//             secondaryTextStyle: NativeTemplateTextStyle(
//               textColor: Colors.black,
//               style: NativeTemplateFontStyle.italic,
//               size: 16.0,
//             ),
//             tertiaryTextStyle: NativeTemplateTextStyle(
//               textColor: Colors.black,
//               style: NativeTemplateFontStyle.normal,
//               size: 16.0,
//             ),
//           ),
//         )..load();
//       }
//     } on Exception catch (e) {
//       log.e('Native Ad failed to load: $e');
//     }
//   }

//   /* interstitial ad */
//   InterstitialAd? interstitialAd;
//   bool isInterstitialAdLoaded = false;
//   final String _interstitialAdUnitId = Platform.isAndroid
//       ? 'ca-app-pub-7233265523334598/3547861134'
//       : 'ca-app-pub-7233265523334598/6831240845';

//   // Loads interstitial ad
//   Future<void> loadInterstitialAd() async {
//     final log = getLogger('InterstitialAdService');

//     try {
//       final user = await _firestoreService.getUserData();

//       // if the user is not subscribed, load the interstitial ad
//       if (!(user?.isSubscribed ?? false)) {
//         InterstitialAd.load(
//           adUnitId: _interstitialAdUnitId,
//           request: const AdRequest(),
//           adLoadCallback: InterstitialAdLoadCallback(
//             onAdLoaded: (InterstitialAd ad) {
//               ad.fullScreenContentCallback = FullScreenContentCallback(
//                 onAdFailedToShowFullScreenContent: (ad, err) {
//                   isInterstitialAdLoaded = false;
//                   log.e('InterstitialAd failed to show: $err');
//                 },
//                 onAdDismissedFullScreenContent: (ad) {
//                   isInterstitialAdLoaded = false;
//                   log.e('InterstitialAd dismissed');
//                 },
//               );
//               interstitialAd = ad;
//               isInterstitialAdLoaded = true;
//               log.e('InterstitialAd loaded: $ad');
//             },
//             onAdFailedToLoad: (LoadAdError error) {
//               isInterstitialAdLoaded = false;
//               log.e('InterstitialAd failed to load: $error');
//             },
//           ),
//         );
//       }
//     } on Exception catch (e) {
//       log.e('InterstitialAd failed to load: $e');
//     }
//   }

//   /* banner ad */
//   BannerAd? bannerAd;
//   bool isBannerAdLoaded = false;

//   final String _bannerAdUnitId = Platform.isAndroid
//       ? 'ca-app-pub-7233265523334598/2889972318'
//       : 'ca-app-pub-7233265523334598/3593923166';

//   Future<void> loadBannerAd(context) async {
//     final log = getLogger('BannerAdService');
//     final size = await AdSize.getCurrentOrientationAnchoredAdaptiveBannerAdSize(
//       MediaQuery.sizeOf(context).width.truncate(),
//     );

//     if (size == null) {
//       return;
//     }

//     try {
//       final user = await _firestoreService.getUserData();

//       // if the user is not subscribed, load the banner ad
//       if (!(user?.isSubscribed ?? false)) {
//         bannerAd = BannerAd(
//           adUnitId: _bannerAdUnitId,
//           request: const AdRequest(
//             httpTimeoutMillis: 5000,
//           ),
//           size: size,
//           listener: BannerAdListener(
//             onAdLoaded: (ad) {
//               isBannerAdLoaded = true;
//               log.e('BannerAd loaded: $ad');
//             },
//             onAdFailedToLoad: (ad, err) {
//               isBannerAdLoaded = false;
//               ad.dispose();
//               log.e('BannerAd failed to load: $err');
//             },
//           ),
//         )..load();
//       }
//     } on Exception catch (e) {
//       isBannerAdLoaded = false;
//       log.e('BannerAd failed to load: $e');
//     }
//   }
// }
