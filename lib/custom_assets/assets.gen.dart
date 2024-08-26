/// GENERATED CODE - DO NOT MODIFY BY HAND
/// *****************************************************
///  FlutterGen
/// *****************************************************

// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: directives_ordering,unnecessary_import,implicit_dynamic_list_literal,deprecated_member_use

import 'package:flutter/widgets.dart';

class $AssetsClipartGen {
  const $AssetsClipartGen();

  /// File path: assets/clipart/congratulation_logo.svg
  String get congratulationLogo => 'assets/clipart/congratulation_logo.svg';

  /// File path: assets/clipart/sample_profile.png
  AssetGenImage get sampleProfile =>
      const AssetGenImage('assets/clipart/sample_profile.png');

  /// List of all assets
  List<dynamic> get values => [congratulationLogo, sampleProfile];
}

class $AssetsIconGen {
  const $AssetsIconGen();

  /// File path: assets/icon/about_us_icon.svg
  String get aboutUsIcon => 'assets/icon/about_us_icon.svg';

  /// File path: assets/icon/back.svg
  String get back => 'assets/icon/back.svg';

  /// File path: assets/icon/camera_icon.svg
  String get cameraIcon => 'assets/icon/camera_icon.svg';

  /// File path: assets/icon/check-mark_green.svg
  String get checkMarkGreen => 'assets/icon/check-mark_green.svg';

  /// File path: assets/icon/collect_with_invoice_icon.svg
  String get collectWithInvoiceIcon =>
      'assets/icon/collect_with_invoice_icon.svg';

  /// File path: assets/icon/collect_with_link_icon.svg
  String get collectWithLinkIcon => 'assets/icon/collect_with_link_icon.svg';

  /// File path: assets/icon/due_icon.svg
  String get dueIcon => 'assets/icon/due_icon.svg';

  /// File path: assets/icon/money_out.svg
  String get moneyOut => 'assets/icon/money_out.svg';

  /// File path: assets/icon/profile.svg
  String get profile => 'assets/icon/profile.svg';

  /// File path: assets/icon/totalReceive.svg
  String get totalReceive => 'assets/icon/totalReceive.svg';

  /// List of all assets
  List<String> get values => [
        aboutUsIcon,
        back,
        cameraIcon,
        checkMarkGreen,
        collectWithInvoiceIcon,
        collectWithLinkIcon,
        dueIcon,
        moneyOut,
        profile,
        totalReceive
      ];
}

class $AssetsLogoGen {
  const $AssetsLogoGen();

  /// File path: assets/logo/basic_icon.png
  AssetGenImage get basicIcon =>
      const AssetGenImage('assets/logo/basic_icon.png');

  /// File path: assets/logo/basic_logo.png
  AssetGenImage get basicLogo =>
      const AssetGenImage('assets/logo/basic_logo.png');

  /// List of all assets
  List<AssetGenImage> get values => [basicIcon, basicLogo];
}

class $AssetsSplashScreenGen {
  const $AssetsSplashScreenGen();

  /// File path: assets/splash_screen/splash_screen.png
  AssetGenImage get splashScreen =>
      const AssetGenImage('assets/splash_screen/splash_screen.png');

  /// List of all assets
  List<AssetGenImage> get values => [splashScreen];
}

class Assets {
  Assets._();

  static const $AssetsClipartGen clipart = $AssetsClipartGen();
  static const $AssetsIconGen icon = $AssetsIconGen();
  static const $AssetsLogoGen logo = $AssetsLogoGen();
  static const $AssetsSplashScreenGen splashScreen = $AssetsSplashScreenGen();
}

class AssetGenImage {
  const AssetGenImage(this._assetName);

  final String _assetName;

  Image image({
    Key? key,
    AssetBundle? bundle,
    ImageFrameBuilder? frameBuilder,
    ImageErrorWidgetBuilder? errorBuilder,
    String? semanticLabel,
    bool excludeFromSemantics = false,
    double? scale,
    double? width,
    double? height,
    Color? color,
    Animation<double>? opacity,
    BlendMode? colorBlendMode,
    BoxFit? fit,
    AlignmentGeometry alignment = Alignment.center,
    ImageRepeat repeat = ImageRepeat.noRepeat,
    Rect? centerSlice,
    bool matchTextDirection = false,
    bool gaplessPlayback = false,
    bool isAntiAlias = false,
    String? package,
    FilterQuality filterQuality = FilterQuality.low,
    int? cacheWidth,
    int? cacheHeight,
  }) {
    return Image.asset(
      _assetName,
      key: key,
      bundle: bundle,
      frameBuilder: frameBuilder,
      errorBuilder: errorBuilder,
      semanticLabel: semanticLabel,
      excludeFromSemantics: excludeFromSemantics,
      scale: scale,
      width: width,
      height: height,
      color: color,
      opacity: opacity,
      colorBlendMode: colorBlendMode,
      fit: fit,
      alignment: alignment,
      repeat: repeat,
      centerSlice: centerSlice,
      matchTextDirection: matchTextDirection,
      gaplessPlayback: gaplessPlayback,
      isAntiAlias: isAntiAlias,
      package: package,
      filterQuality: filterQuality,
      cacheWidth: cacheWidth,
      cacheHeight: cacheHeight,
    );
  }

  ImageProvider provider({
    AssetBundle? bundle,
    String? package,
  }) {
    return AssetImage(
      _assetName,
      bundle: bundle,
      package: package,
    );
  }

  String get path => _assetName;

  String get keyName => _assetName;
}
