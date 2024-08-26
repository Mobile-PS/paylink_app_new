import 'package:paylink/backend/utils/custom_loading_api.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../../../../controller/auth/sign_up/email_verification_controller/email_verification_controller.dart';
import '../../../../backend/local_storage/local_storage.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/basic_screen_imports.dart';
import '../../../../widgets/others/title_subtitle_widget.dart';

class EmailVerificationScreenMobile extends StatelessWidget {
  EmailVerificationScreenMobile({super.key});

  final controller = Get.put(EmailVerificationController());
  final emailVerificationKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PrimaryAppBar(
        Strings.emailVerification,
        onTap: () {
          Get.offAllNamed(Routes.signUpScreen);
        },
      ),
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

  _appLogoWidget(BuildContext context) {
    return Center(
      child: Image.network(
        LocalStorage.getAppBasicIcon(),
        fit: BoxFit.contain,
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
          TitleSubTitleWidget(
            title: Strings.pleaseEnterTheCode,
            subTitle: Strings.enterTheOtpVerification,
            subTitleFontSize: Dimensions.headingTextSize5,
            isCenterText: true,
          ),
          _otpInputWidget(context),
          _timerOrResendWidget(context),
          _buttonWidget(context),
        ],
      ),
    );
  }

  _timerOrResendWidget(BuildContext context) {
    return Obx(
      () => controller.enableResend.value
          ? _resendButton(context)
          : _timeWidget(context),
    );
  }

  _timeWidget(BuildContext context) {
    return Obx(
      () => Padding(
        padding: EdgeInsets.only(
          top: Dimensions.paddingVerticalSize,
          bottom: Dimensions.paddingVerticalSize,
        ),
        child: Row(
          mainAxisAlignment: mainCenter,
          children: [
            Icon(
              Icons.watch_later_outlined,
              color: Theme.of(context).primaryColor,
            ),
            horizontalSpace(Dimensions.widthSize * 0.5),
            TitleHeading4Widget(
              text: controller.secondsRemaining.value >= 0 &&
                      controller.secondsRemaining.value <= 9
                  ? '00:0${controller.secondsRemaining.value}'
                  : '00:${controller.secondsRemaining.value}',
              fontWeight: FontWeight.w600,
            )
          ],
        ),
      ),
    );
  }

  _otpInputWidget(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(top: Dimensions.paddingHorizontalSize * 1.5),
      child: Form(
        key: emailVerificationKey,
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
          cursorColor: Theme.of(context).primaryColor,
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

  _resendButton(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: Dimensions.paddingVerticalSize,
        bottom: Dimensions.paddingVerticalSize,
      ),
      child: InkWell(
        onTap: () {
          controller.resendCode();
        },
        child: Container(
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor.withOpacity(.1),
            borderRadius: BorderRadius.circular(Dimensions.radius * 2),
          ),
          child: TitleHeading3Widget(
            padding: EdgeInsets.symmetric(
                vertical: Dimensions.paddingVerticalSize * .35,
                horizontal: Dimensions.paddingHorizontalSize * .65),
            text: Strings.resend,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }

  _buttonWidget(context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Dimensions.marginSizeVertical,
      ),
      child: Obx(() => controller.isLoading
          ? const CustomLoadingAPI()
          : PrimaryButton(
              title: Strings.submit,
              onPressed: () {
                if (emailVerificationKey.currentState!.validate()) {
                  controller.onSubmit;
                }
              },
            )),
    );
  }
}