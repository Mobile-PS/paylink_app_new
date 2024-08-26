
import '../../../../../controller/drawer/change_password_controller/change_password_controller.dart';
import '../../../../../views/dashboard/drawer_menu_items/change_password/change_password_screen_mobile.dart';
import '../../../../../utils/basic_screen_imports.dart';
import '../../../../../utils/responsive_layout.dart';

class ChangePasswordScreen extends StatelessWidget {
   ChangePasswordScreen({super.key});
  final controller = Get.put(ChangePasswordController());


  @override
  Widget build(BuildContext context) {
    return ResponsiveLayout(
      mobileScaffold: ChangePasswordScreenMobile(
        controller: controller,
      ),
    );
  }
}