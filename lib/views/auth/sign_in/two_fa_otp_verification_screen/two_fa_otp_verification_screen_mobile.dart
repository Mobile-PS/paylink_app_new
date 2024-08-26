import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../backend/utils/custom_loading_api.dart';
import '../../../../controller/auth/sign_in/two_fa_otp_verification_controller/two_fa_otp_verification_controller.dart';
import '../../../../custom_assets/assets.gen.dart';
import '../../../../utils/basic_widget_imports.dart';
import '../../../../widgets/appbar/primary_appbar.dart';
import '../../../../widgets/buttons/primary_button.dart';
import '../../../../widgets/others/custom_image_widget.dart';
import '../../../../widgets/others/title_subtitle_widget.dart';

class TwoFaOtpVerificationScreenMobile extends StatelessWidget {
  TwoFaOtpVerificationScreenMobile({super.key});

  final controller = Get.put(TwoFaOtpVerificationController());
  //final twoFaOtpFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimaryAppBar(Strings.twoFaVerification),
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: crossCenter,
        children: [
          _appLogoWidget(context),
          verticalSpace(Dimensions.heightSize * 2),
          _otpWidget(context),
        ],
      ),
    );
  }

  _buttonWidget(context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Dimensions.marginSizeVertical,
      ),
      child: Obx(
        () => controller.isLoading
            ? const CustomLoadingAPI()
            : PrimaryButton(
                title: Strings.submit,
                onPressed: () {
                  controller.onSubmit;
                },
              ),
      ),
    );
  }

  _appLogoWidget(BuildContext context) {
    return Center(
      child: CustomImageWidget(
        path: Assets.logo.basicIcon.path,
        height: MediaQuery.sizeOf(context).width * .25,
        width: MediaQuery.sizeOf(context).width * .25,
      ).paddingOnly(
        top: Dimensions.paddingVerticalSize * 2,
        bottom: Dimensions.paddingVerticalSize * .8,
      ),
    );
  }

  _otpWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: Dimensions.marginSizeHorizontal * 0.8,
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(Dimensions.radius * 4),
          topRight: Radius.circular(Dimensions.radius * 4),
        ),
      ),
      child: Column(
        children: [
          const TitleSubTitleWidget(
            title: Strings.twoFactorAuthorization,
            subTitle: Strings.enterTheTwoFaVerification,
            isCenterText: true,
          ),
          _otpInputWidget(context),
          _buttonWidget(context),
        ],
      ),
    );
  }

  _otpInputWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: Dimensions.paddingHorizontalSize * 1.5),
      child: Form(
        //key: twoFaOtpFormKey,
        child: PinCodeTextField(
          appContext: context,
          backgroundColor: Colors.transparent,
          textStyle: Get.isDarkMode
              ? CustomStyle.darkHeading2TextStyle
              : CustomStyle.lightHeading2TextStyle,
          enableActiveFill: true,
          pastedTextStyle: TextStyle(
            color: Colors.orange.shade600,
            fontWeight: FontWeight.bold,
          ),
          length: 6,
          obscureText: false,
          blinkWhenObscuring: true,
          animationType: AnimationType.fade,
          validator: (v) {
            if (v!.length < 3) {
              return Strings.pleaseFillOutTheField;
            } else {
              return null;
            }
          },
          pinTheme: PinTheme(
            shape: PinCodeFieldShape.box,
            fieldHeight: 48,
            fieldWidth: 50,
            inactiveColor: CustomColor.whiteColor,
            activeColor: CustomColor.whiteColor,
            selectedColor: Colors.transparent,
            inactiveFillColor: CustomColor.whiteColor,
            activeFillColor: CustomColor.whiteColor,
            selectedFillColor: CustomColor.whiteColor,
            borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
          ),
          cursorColor: Theme
              .of(context)
              .primaryColor,
          animationDuration: const Duration(milliseconds: 300),
          errorAnimationController: controller.errorController,
          controller: controller.pinCodeController,
          keyboardType: TextInputType.number,
          onCompleted: (v) {},
          onChanged: (value) {
            controller.changeCurrentText(value);
          },
          beforeTextPaste: (text) {
            return true;
          },
        ),
      ),
    );
  }
}