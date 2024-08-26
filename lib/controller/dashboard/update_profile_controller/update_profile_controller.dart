import 'dart:io';

import 'package:image_picker/image_picker.dart';

import '../../../backend/local_storage/local_storage.dart';
import '../../../backend/model/common/common_success_model.dart';
import '../../../backend/model/profile/profile_info_model.dart';
import '../../../backend/services/api_endpoint.dart';
import '../../../backend/services/api_services/profile/profile_api_services.dart';
import '../../../backend/utils/api_method.dart';
import '../../../routes/routes.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../basic_settings/basic_settings_controller.dart';

class UpdateProfileController extends GetxController {
  final basicSettingsController = Get.put(BasicSettingsController());

  /// >>> Text Editing Controller for update profile
  final firstNameController = TextEditingController();
  final lastNameController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final companyNameController = TextEditingController();

  final addressController = TextEditingController();
  final cityController = TextEditingController();
  final sateController = TextEditingController();
  final zipCodeController = TextEditingController();
  final countrySelection = TextEditingController();

  /// >>> set value for country
  RxString selectCountryCode = ''.obs;

  RxString userImagePath = ''.obs;
  RxString userEmailAddress = ''.obs;
  RxString userFullName = ''.obs;
  RxString userImage = ''.obs;
  RxString defaultImage = ''.obs;

  //-> Image Picker
  RxBool isImagePathSet = false.obs;
  File? image;
  ImagePicker picker = ImagePicker();

  chooseImageFromGallery() async {
    var pickImage = await picker.pickImage(source: ImageSource.gallery);
    image = File(pickImage!.path);
    if (image!.path.isNotEmpty) {
      userImagePath.value = image!.path;
      isImagePathSet.value = true;
    }
  }

  chooseImageFromCamera() async {
    var pickImage = await picker.pickImage(source: ImageSource.camera);
    image = File(pickImage!.path);
    if (image!.path.isNotEmpty) {
      userImagePath.value = image!.path;
      isImagePathSet.value = true;
    }
  }

  get onUpdateProfile => isImagePathSet.value
      ? profileUpdateWithImageProcess()
      : profileUpdateWithOutImageProcess();

  @override
  void onInit() {
    getProfileInfoProcess();
    super.onInit();
  }

  /// >> set loading process & Profile Info Model
  final _isLoading = false.obs;
  late ProfileInfoModel _profileInfoModel;

  /// >> get loading process & Profile Info Model
  bool get isLoading => _isLoading.value;

  ProfileInfoModel get profileInfoModel => _profileInfoModel;

  ///* Get profile info api process
  Future<ProfileInfoModel> getProfileInfoProcess() async {
    _isLoading.value = true;
    update();

    await ProfileApiServices.getProfileInfoProcessApi().then((value) {
      _profileInfoModel = value!;
      _setData(_profileInfoModel);
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isLoading.value = false;
    update();
    return _profileInfoModel;
  }

  void _setData(ProfileInfoModel profileModel) {
    var data = profileModel.data;
    userFullName.value = '${data.user.firstName} ${data.user.lastName}';
    firstNameController.text = data.user.firstName;
    lastNameController.text = data.user.lastName;
    userEmailAddress.value = data.user.email;
    phoneNumberController.text = data.user.mobile;
    companyNameController.text = data.user.address.companyName;
    addressController.text = data.user.address.address;
    cityController.text = data.user.address.city;
    sateController.text = data.user.address.state;
    zipCodeController.text = data.user.address.zipCode;
    countrySelection.text = data.user.address.country;
    debugPrint(data.user.address.country);
    LocalStorage.saveEmail(email: data.user.email);
    LocalStorage.saveName(name: userFullName.value);
    LocalStorage.saveNumber(num: data.user.fullMobile);
    if (data.user.image != '') {
      userImage.value =
          '${ApiEndpoint.mainDomain}/${data.imagePath}/${data.user.image}';
    } else {
      userImage.value = '${ApiEndpoint.mainDomain}/${data.defaultImage}';
    }

    debugPrint(data.user.emailVerified.toString());
    if (data.user.emailVerified == 1 && data.user.kycVerified == 1) {
      LocalStorage.saveUserVerified(value: true);
    } else {
      LocalStorage.saveUserVerified(value: false);
    }

    update();
  }

  /// >> set loading process & profile update model
  final _isUpdateLoading = false.obs;
  late CommonSuccessModel _profileUpdateModel;

  /// >> get loading process & profile update model
  bool get isUpdateLoading => _isUpdateLoading.value;

  CommonSuccessModel get profileUpdateModel => _profileUpdateModel;

  Future<CommonSuccessModel> profileUpdateWithOutImageProcess() async {
    _isUpdateLoading.value = true;
    update();

    Map<String, dynamic> inputBody = {
      'first_name': firstNameController.text,
      'last_name': lastNameController.text,
      'phone': phoneNumberController.text,
      'company_name': companyNameController.text,
      'country': countrySelection.text,
      'city': cityController.text,
      'state': sateController.text,
      'address': addressController.text,
      'phone_code': selectCountryCode.value,
      'zip_code': zipCodeController.text,
    };

    await ProfileApiServices.updateProfileWithoutImageApi(body: inputBody)
        .then((value) {
      _profileUpdateModel = value!;
      getProfileInfoProcess();
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isUpdateLoading.value = false;
    update();
    return _profileUpdateModel;
  }

  // Profile update process with image
  Future<CommonSuccessModel> profileUpdateWithImageProcess() async {
    _isUpdateLoading.value = true;
    update();

    Map<String, String> inputBody = {
      'first_name': firstNameController.text,
      'last_name': lastNameController.text,
      'country': countrySelection.text,
      'state': sateController.text,
      'address': addressController.text,
      'city': cityController.text,
      'zip_code': zipCodeController.text,
      'phone_code': selectCountryCode.value,
      'phone': phoneNumberController.text,
      'company_name': companyNameController.text,
    };

    await ProfileApiServices.updateProfileWithImageApi(
      body: inputBody,
      filepath: userImagePath.value,
    ).then((value) {
      _profileUpdateModel = value!;
      getProfileInfoProcess();
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isUpdateLoading.value = false;
    update();
    return _profileUpdateModel;
  }

  get onDeleteAccount => deleteAccountProcess();

  /// >> set loading process & profile delete
  final _isDeleteAccountLoading = false.obs;
  late CommonSuccessModel _deleteAccountModel;

  /// >> get loading process & profile update model
  bool get isDeleteAccountLoading => _isDeleteAccountLoading.value;

  CommonSuccessModel get deleteAccountModel => _deleteAccountModel;

  Future<CommonSuccessModel> deleteAccountProcess() async {
    _isDeleteAccountLoading.value = true;
    update();

    await ProfileApiServices.deleteAccountPostApi(body: {}).then((value) {
      _deleteAccountModel = value!;
      LocalStorage.signOut();
      Get.offAllNamed(Routes.signInScreen);
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isDeleteAccountLoading.value = false;
    update();
    return _deleteAccountModel;
  }
}
