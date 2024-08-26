import '../../../../utils/basic_screen_imports.dart';
import '../../../../utils/responsive_layout.dart';
import '../../backend/utils/custom_loading_api.dart';
import '../../controller/basic_settings/basic_settings_controller.dart';


class SplashScreen extends StatelessWidget {
  SplashScreen({super.key});
  final controller = Get.put(BasicSettingsController());
  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: Scaffold(
        body: Obx(
              () => controller.isLoading
              ? const CustomLoadingAPI()
              : _bodyWidget(context),
        ),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return Image.network(
      controller.splashImage.value,
      fit: BoxFit.cover,
      height: MediaQuery.sizeOf(context).height,
      width: MediaQuery.sizeOf(context).width,
    );
  }
}