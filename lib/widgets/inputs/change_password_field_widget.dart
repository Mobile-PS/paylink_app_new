
import '../../../../../widgets/inputs/primary_input_widget.dart';

import '../../controller/drawer/change_password_controller/change_password_controller.dart';
import '../../utils/basic_screen_imports.dart';

class ChangePasswordFieldsWidget extends StatelessWidget {
  const ChangePasswordFieldsWidget({super.key, required this.controller});
  final ChangePasswordController controller;
  @override
  Widget build(BuildContext context) {
    Color fillColor = CustomColor.whiteColor;
    return Column(
      children: [
        PrimaryInputWidget(
          controller: controller.oldPasswordController,
          hintText: "${Strings.enter} ${Strings.oldPassword}",
          label: Strings.oldPassword,
          isPasswordField: true,
          fillColor: fillColor,
          textInputType: TextInputType.text,
        ).paddingOnly(bottom: Dimensions.marginSizeVertical * 0.75),
        PrimaryInputWidget(
          controller: controller.newPasswordController,
          hintText: "${Strings.enter} ${Strings.newPassword}",
          label: Strings.newPassword,
          isPasswordField: true,
          fillColor: fillColor,
          textInputType: TextInputType.text,
        ).paddingOnly(bottom: Dimensions.marginSizeVertical * 0.75),
        PrimaryInputWidget(
          controller: controller.confirmPasswordController,
          hintText: "${Strings.enter} ${Strings.confirmPassword}",
          label: Strings.confirmPassword,
          isPasswordField: true,
          fillColor: fillColor,
          textInputType: TextInputType.text,
        ).paddingOnly(bottom: Dimensions.marginSizeVertical * 1.666),
      ],
    );
  }
}