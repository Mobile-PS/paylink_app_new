import '../../../../backend/utils/custom_loading_api.dart';
import '../../../../controller/auth/sign_in/reset_password/reset_password_controller.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/basic_screen_imports.dart';
import '../../../../widgets/inputs/primary_input_widget.dart';

class ResetPasswordScreenMobile extends StatelessWidget {
  ResetPasswordScreenMobile({super.key});

  final controller = Get.put(ResetPasswordController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (value) async {
        Get.offNamedUntil(Routes.signInScreen, (route) => false);

      },
      canPop: true,
      child: Scaffold(
        appBar: const PrimaryAppBar(
          Strings.resetPassword,
          showBackButton: false,
        ),
        body: _bodyWidget(context),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: crossCenter,
      children: [
        _inputFieldWidget(context),
        _buttonWidget(context),
      ],
    );
  }

  _inputFieldWidget(BuildContext context) {
    return Form(
      key: formKey,
      child: Column(
        children: [
          PrimaryInputWidget(
            controller: controller.newPasswordController,
            hintText: Strings.enterNewPassword,
            label: Strings.newPassword,
            fillColor: CustomColor.whiteColor,
            isPasswordField: true,
            textInputType: TextInputType.text,
          ).marginSymmetric(
            horizontal: Dimensions.marginSizeHorizontal,
          ),
          verticalSpace(Dimensions.heightSize * 1.6),
          PrimaryInputWidget(
            controller: controller.confirmPasswordController,
            hintText: Strings.enterConfirmPassword,
            label: Strings.confirmPassword,
            fillColor: CustomColor.whiteColor,
            isPasswordField: true,
            textInputType: TextInputType.text,
          ).marginSymmetric(
            horizontal: Dimensions.marginSizeHorizontal,
          ),
        ],
      ),
    );
  }

  _buttonWidget(context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Dimensions.marginSizeVertical * 1.66,
      ),
      child: Obx(() =>
        controller.isLoading?const CustomLoadingAPI():
         PrimaryButton(
          title: Strings.resetPassword,
          onPressed: () {
            if (formKey.currentState!.validate()) {
              controller.onResetPassword;
            }
          },
        ),
      ).marginSymmetric(horizontal: Dimensions.marginSizeHorizontal),
    );
  }
}