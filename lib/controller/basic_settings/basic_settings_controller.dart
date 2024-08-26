import 'package:get/get.dart';

import '../../backend/local_storage/local_storage.dart';
import '../../backend/model/basic_settings/basic_settings_info_model.dart';
import '../../backend/services/api_endpoint.dart';
import '../../backend/services/api_services/basic_settings/basic_settings_api_services.dart';
import '../../backend/utils/api_method.dart';

class BasicSettingsController extends GetxController {
  final List<OnboardScreen> onboardScreen = [];
  RxString splashImage = ''.obs;
  RxString onboardImage = ''.obs;
  RxString onBoardTitle = ''.obs;
  RxString onBoardSubTitle = ''.obs;
  RxString appBasicLogo = ''.obs;
  RxString appBasicIcon = ''.obs;
  RxString privacyPolicy = ''.obs;
  RxString contactUs = ''.obs;
  RxString aboutUs = ''.obs;
  RxString path = ''.obs;
  final List<ExchangeRate> countryList = [];
  RxString countrySelection = ''.obs;

  @override
  void onInit() {
    getBasicSettingsApiProcess();
    super.onInit();
  }

  final _isLoading = false.obs;

  bool get isLoading => _isLoading.value;
  late BasicSettingsInfoModel _appSettingsModel;

  BasicSettingsInfoModel get appSettingsModel => _appSettingsModel;

  Future<BasicSettingsInfoModel> getBasicSettingsApiProcess() async {
    _isLoading.value = true;
    update();
    await BasicSettingsApiServices.getBasicSettingProcessApi().then((value) {
      _appSettingsModel = value!;
      saveInfo();
      update();
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
      _isLoading.value = false;
    });
    _isLoading.value = false;
    update();
    return _appSettingsModel;
  }

  void saveInfo() {
    /// >>> get splash & onboard data
    var onBoardData = _appSettingsModel.data.onboardScreen.first;
    var imageSplash = _appSettingsModel.data.splashScreen.splashScreenImage;
    var imageOnboard = onBoardData.image;
    var imagePath = _appSettingsModel.data.imagePath;
    splashImage.value = "${ApiEndpoint.mainDomain}/$imagePath/$imageSplash";
    onboardImage.value = "${ApiEndpoint.mainDomain}/$imagePath/$imageOnboard";
    onBoardTitle.value = onBoardData.title;
    onBoardSubTitle.value = onBoardData.subTitle;
    appBasicLogo.value =
        "${ApiEndpoint.mainDomain}/${_appSettingsModel.data.logoImagePath}/${_appSettingsModel.data.allLogo.siteLogo}";
    LocalStorage.appBasicLogo(logo: appBasicLogo.value);
    appBasicIcon.value =
        "${ApiEndpoint.mainDomain}/${_appSettingsModel.data.logoImagePath}/${_appSettingsModel.data.allLogo.siteFav}";
    LocalStorage.appBasicIcon(logoIcon: appBasicIcon.value);
    privacyPolicy.value = _appSettingsModel.data.webLinks.privacyPolicy;
    contactUs.value = _appSettingsModel.data.webLinks.contactUs;
    aboutUs.value = _appSettingsModel.data.webLinks.aboutUs;
    for (var element in _appSettingsModel.data.onboardScreen) {
      onboardScreen.add(
        OnboardScreen(
          id: element.id,
          title: element.title,
          subTitle: element.subTitle,
          image: element.image,
          status: element.status,
          createdAt: element.createdAt,
          updatedAt: element.updatedAt,
        ),
      );
    }
    for (var element in _appSettingsModel.data.exchangeRate) {
      countryList.add(
        ExchangeRate(
            id: element.id,
            name: element.name,
            currencyCode: element.currencyCode,
            currencyName: element.currencyName,
            currencySymbol: element.currencySymbol,
            flag: element.flag,
            mobileCode: element.mobileCode,
            rate: element.rate,
            status: element.status),
      );
    }
    countrySelection.value = countryList.first.name;
  }
}