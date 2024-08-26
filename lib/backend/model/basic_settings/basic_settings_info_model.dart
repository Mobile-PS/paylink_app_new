import '../../../widgets/drop_down/custom_drop_down.dart';

class BasicSettingsInfoModel {
  final Message message;
  final Data data;

  BasicSettingsInfoModel({
    required this.message,
    required this.data,
  });

  factory BasicSettingsInfoModel.fromJson(Map<String, dynamic> json) => BasicSettingsInfoModel(
    message: Message.fromJson(json["message"]),
    data: Data.fromJson(json["data"]),
  );

}

class Data {
  final String defaultLogo;
  final String logoImagePath;
  final String imagePath;
  final List<OnboardScreen> onboardScreen;
  final SplashScreen splashScreen;
  final WebLinks webLinks;
  final AllLogo allLogo;
  final List<ExchangeRate> exchangeRate;

  Data({
    required this.defaultLogo,
    required this.logoImagePath,
    required this.imagePath,
    required this.onboardScreen,
    required this.splashScreen,
    required this.webLinks,
    required this.allLogo,
    required this.exchangeRate,
  });

  factory Data.fromJson(Map<String, dynamic> json) => Data(
    defaultLogo: json["default_logo"],
    logoImagePath: json["logo_image_path"],
    imagePath: json["image_path"],
    onboardScreen: List<OnboardScreen>.from(json["onboard_screen"].map((x) => OnboardScreen.fromJson(x))),
    splashScreen: SplashScreen.fromJson(json["splash_screen"]),
    webLinks: WebLinks.fromJson(json["web_links"]),
    allLogo: AllLogo.fromJson(json["all_logo"]),
    exchangeRate: List<ExchangeRate>.from(json["exchange_rate"].map((x) => ExchangeRate.fromJson(x))),
  );

}

class AllLogo {
  final String siteLogoDark;
  final String siteLogo;
  final String siteFavDark;
  final String siteFav;

  AllLogo({
    required this.siteLogoDark,
    required this.siteLogo,
    required this.siteFavDark,
    required this.siteFav,
  });

  factory AllLogo.fromJson(Map<String, dynamic> json) => AllLogo(
    siteLogoDark: json["site_logo_dark"],
    siteLogo: json["site_logo"],
    siteFavDark: json["site_fav_dark"],
    siteFav: json["site_fav"],
  );


}

class ExchangeRate implements  DropdownModel{
  final int id;
  final String name;
  final String mobileCode;
  final String currencyName;
  final String currencyCode;
  final String currencySymbol;
  final dynamic flag;
  final String rate;
  final int status;

  ExchangeRate({
    required this.id,
    required this.name,
    required this.mobileCode,
    required this.currencyName,
    required this.currencyCode,
    required this.currencySymbol,
    required this.flag,
    required this.rate,
    required this.status,
  });

  factory ExchangeRate.fromJson(Map<String, dynamic> json) => ExchangeRate(
    id: json["id"],
    name: json["name"],
    mobileCode: json["mobile_code"],
    currencyName: json["currency_name"],
    currencyCode: json["currency_code"],
    currencySymbol: json["currency_symbol"],
    flag: json["flag"],
    rate: json["rate"],
    status: json["status"],
  );

  @override
  // TODO: implement title
  String get title => name;


}

class OnboardScreen {
  final int id;
  final String image;
  final String title;
  final String subTitle;
  final int status;
  final DateTime createdAt;
  final DateTime updatedAt;

  OnboardScreen({
    required this.id,
    required this.image,
    required this.title,
    required this.subTitle,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  factory OnboardScreen.fromJson(Map<String, dynamic> json) => OnboardScreen(
    id: json["id"],
    image: json["image"],
    title: json["title"],
    subTitle: json["sub_title"],
    status: json["status"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );

}

class SplashScreen {
  final int id;
  final String splashScreenImage;
  final String version;
  final DateTime createdAt;
  final DateTime updatedAt;

  SplashScreen({
    required this.id,
    required this.splashScreenImage,
    required this.version,
    required this.createdAt,
    required this.updatedAt,
  });

  factory SplashScreen.fromJson(Map<String, dynamic> json) => SplashScreen(
    id: json["id"],
    splashScreenImage: json["splash_screen_image"],
    version: json["version"],
    createdAt: DateTime.parse(json["created_at"]),
    updatedAt: DateTime.parse(json["updated_at"]),
  );


}

class WebLinks {
  final String privacyPolicy;
  final String aboutUs;
  final String contactUs;

  WebLinks({
    required this.privacyPolicy,
    required this.aboutUs,
    required this.contactUs,
  });

  factory WebLinks.fromJson(Map<String, dynamic> json) => WebLinks(
    privacyPolicy: json["privacy-policy"],
    aboutUs: json["about-us"],
    contactUs: json["contact-us"],
  );

  Map<String, dynamic> toJson() => {
    "privacy-policy": privacyPolicy,
    "about-us": aboutUs,
    "contact-us": contactUs,
  };
}

class Message {
  final List<String> success;

  Message({
    required this.success,
  });

  factory Message.fromJson(Map<String, dynamic> json) => Message(
    success: List<String>.from(json["success"].map((x) => x)),
  );

  Map<String, dynamic> toJson() => {
    "success": List<dynamic>.from(success.map((x) => x)),
  };
}