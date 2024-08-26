import 'package:get/get.dart';

import '../../../backend/local_storage/local_storage.dart';
import '../../../backend/model/common/common_success_model.dart';
import '../../../backend/services/api_services/auth/auth_api_services.dart';
import '../../../backend/utils/api_method.dart';
import '../../../routes/routes.dart';

class LogOutController extends GetxController {
  /// >> set loading process & model
  final _isLoading = false.obs;
  late CommonSuccessModel _signOutModel;

  /// >> get loading process & model
  bool get isLoading => _isLoading.value;
  CommonSuccessModel get signOutModel => _signOutModel;

  ///* Sign out process
  Future<CommonSuccessModel> signOutProcess() async {
    _isLoading.value = true;
    update();

    await AuthApiServices.signOutProcessApi().then((value) {
      _signOutModel = value!;
      _whenSignOutCompleted();
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isLoading.value = false;
    update();
    return _signOutModel;
  }

  void _whenSignOutCompleted() {
    LocalStorage.signOut();
    Get.offNamedUntil(Routes.signInScreen, (route) => false);
  }
}