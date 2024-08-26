import 'package:get/get.dart';
import 'package:paylink/controller/basic_settings/basic_settings_controller.dart';

import '../controller/splash_screen_controller.dart';

class SplashBinding extends Bindings {
  @override
  void dependencies() {
    Get.put(SplashController());
    Get.put(
      BasicSettingsController(),
      // permanent:  true
    );
  }
}
