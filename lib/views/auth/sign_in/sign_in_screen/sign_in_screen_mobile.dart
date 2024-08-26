import 'dart:ui';

import 'package:flutter/gestures.dart';
import 'package:paylink/backend/local_storage/local_storage.dart';

import '../../../../backend/utils/custom_loading_api.dart';
import '../../../../controller/auth/sign_in/sign_in_controller/sign_in_controller.dart';
import '../../../../utils/basic_screen_imports.dart';
import '../../../../widgets/inputs/primary_input_widget.dart';
import '../../../../widgets/others/title_subtitle_widget.dart';

class SignInScreenMobile extends StatelessWidget {
  SignInScreenMobile({super.key});

  final signInformKey = GlobalKey<FormState>();
  final forgotPasswordFormKey = GlobalKey<FormState>();
  final controller = Get.put(SignInController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.primaryLightScaffoldBackgroundColor,
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
    return ListView(
      padding: EdgeInsets.only(top: Dimensions.paddingVerticalSize),
      children: [
        _appLogoWidget(context),
        _welcomeTextWidget(context),
        _inputAndButtonWidget(context),
      ],
    );
  }

  _appLogoWidget(BuildContext context) {
    return Image.network(
      LocalStorage.getAppBasicLogo(),
      fit: BoxFit.contain,
      height: MediaQuery.of(context).size.height * .065,
    ).marginSymmetric(vertical: Dimensions.marginSizeVertical * 1.6);
  }

  _welcomeTextWidget(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: Dimensions.paddingHorizontalSize),
      child: TitleSubTitleWidget(
        title: Strings.signInInformation.tr,
        subTitle: Strings.signInSubtitle.tr,
      ),
    );
  }

  _inputAndButtonWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _loginWidget(context),
      ],
    );
  }

  _loginWidget(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(horizontal: Dimensions.paddingHorizontalSize),
      child: Form(
        key: signInformKey,
        child: Padding(
          padding: EdgeInsets.only(top: Dimensions.paddingVerticalSize),
          child: Column(
            children: [
              PrimaryInputWidget(
                controller: controller.emailController,
                hintText: Strings.enterEmailAddress,
                label: Strings.emailAddress,
                fillColor: CustomColor.whiteColor,
                textInputType: TextInputType.emailAddress,
              ),
              verticalSpace(Dimensions.heightSize * 1.6),
              PrimaryInputWidget(
                controller: controller.passwordController,
                hintText: Strings.enterPassword,
                label: Strings.password,
                fillColor: CustomColor.whiteColor,
                isPasswordField: true,
                textInputType: TextInputType.text,
              ),
              _isRememberMeWidget(context),
              _buttonWidget(context),
              _doNotHaveAnAccount(context)
            ],
          ),
        ),
      ),
    );
  }

  _isRememberMeWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Dimensions.heightSize * 0.66),
      child: Row(
        mainAxisAlignment: mainSpaceBet,
        children: [
          Row(
            children: [
              Obx(
                () => Transform.scale(
                  scale: .7,
                  child: SizedBox(
                    height: 12.0.h,
                    width: 12.0.w,
                    child: Checkbox(
                      value: controller.isRemember.value,
                      onChanged: (value) {
                        controller.isRemember.value = value!;
                        LocalStorage.isLoginSuccess(isLoggedIn: controller.isRemember.value);
                      },
                      activeColor: Theme.of(context).primaryColor,
                      checkColor: controller.isRemember.value
                          ? Theme.of(context).colorScheme.background
                          : null,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(Dimensions.radius * 0.25),
                      ),
                      side: BorderSide(
                        color: Get.isDarkMode
                            ? CustomColor.primaryDarkTextColor.withOpacity(0.40)
                            : CustomColor.primaryLightTextColor.withOpacity(0.40),
                      ),
                    ),
                  ),
                ),
              ),
              horizontalSpace(Dimensions.widthSize * 0.75),
              InkWell(
                onTap: () {
                  if (controller.isRemember.value) {
                    controller.isRemember.value = false;
                  } else {
                    controller.isRemember.value = true;
                  }
                },
                child: const TitleHeading5Widget(
                  text: Strings.rememberMe,
                  fontWeight: FontWeight.w600,
                  opacity: 0.60,
                ),
              ),
            ],
          ),
          InkWell(
            onTap: () {
              _showForgotPasswordDialog(context);
            },
            child: TitleHeading5Widget(
              text: Strings.forgotPassword,
              fontWeight: FontWeight.w600,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ],
      ),
    );
  }

  _showForgotPasswordDialog(BuildContext context) {
    Get.dialog(
      BackdropFilter(
        filter: ImageFilter.blur(
          sigmaX: 5,
          sigmaY: 5,
        ),
        child: Dialog(
          backgroundColor: Theme.of(context).scaffoldBackgroundColor,
          surfaceTintColor: Theme.of(context).scaffoldBackgroundColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius),
          ),
          child: Form(
            key: forgotPasswordFormKey,
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                Column(
                  mainAxisSize: mainMin,
                  children: [
                    TitleSubTitleWidget(
                      title: Strings.forgotPasswordTitle,
                      subTitle: Strings.forgotPasswordSubtitle,
                      subTitleFontSize: Dimensions.headingTextSize5,
                    ).paddingOnly(
                      right: Dimensions.paddingHorizontalSize * 0.5,
                      left: Dimensions.paddingHorizontalSize * 0.5,
                      top: Dimensions.paddingVerticalSize,
                      bottom: Dimensions.paddingVerticalSize * 0.68,
                    ),
                    PrimaryInputWidget(
                      controller: controller.forgotPasswordEmailController,
                      hintText: Strings.enterEmailAddress,
                      label: Strings.emailAddress,
                      fillColor: CustomColor.whiteColor,
                      textInputType: TextInputType.emailAddress,
                    ).paddingOnly(
                      right: Dimensions.paddingHorizontalSize * 0.75,
                      left: Dimensions.paddingHorizontalSize * 0.75,
                    ),
                    verticalSpace(Dimensions.marginBetweenInputBox),
                    Obx(
                      () => controller.isForgotPasswordLoading
                          ? const CustomLoadingAPI()
                          : PrimaryButton(
                              title: Strings.forgotPassword.replaceAll('?', ''),
                              onPressed: () {
                                if (forgotPasswordFormKey.currentState!
                                    .validate()) {
                                  LocalStorage.saveEmail(
                                      email: controller
                                          .forgotPasswordEmailController.text);
                                  controller.onForgotPassword;
                                }
                              },
                            ),
                    ).paddingOnly(
                      right: Dimensions.paddingHorizontalSize * 0.75,
                      left: Dimensions.paddingHorizontalSize * 0.75,
                      bottom: Dimensions.paddingVerticalSize * 0.75,
                    ),
                  ],
                ),
                Positioned(
                  right: -15,
                  top: -15,
                  child: InkWell(
                    onTap: () {
                      Get.close(1);
                    },
                    child: CircleAvatar(
                      radius: Dimensions.radius * 1.4,
                      backgroundColor: Theme.of(context).primaryColor,
                      child: const Icon(
                        Icons.close_rounded,
                        color: CustomColor.whiteColor,
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      barrierDismissible: true,
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
                title: Strings.logIn,
                onPressed: () {
                  if (signInformKey.currentState!.validate()) {
                    controller.onSignIn;
                  }
                },
              ),
      ),
    );
  }

  _doNotHaveAnAccount(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: Strings.doNotHaveAnAccount,
        style: Get.isDarkMode
            ? CustomStyle.darkHeading5TextStyle.copyWith(
                fontWeight: FontWeight.w600,
                color: CustomColor.primaryDarkTextColor.withOpacity(.45),
              )
            : CustomStyle.lightHeading5TextStyle.copyWith(
                fontWeight: FontWeight.w600,
                color: CustomColor.primaryLightTextColor.withOpacity(.45),
              ),
        children: [
          TextSpan(
            text: Strings.registration,
            style: Get.isDarkMode
                ? CustomStyle.darkHeading5TextStyle.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600,
                  )
                : CustomStyle.lightHeading5TextStyle.copyWith(
                    color: Theme.of(context).primaryColor,
                    fontWeight: FontWeight.w600,
                  ),
            recognizer: TapGestureRecognizer()
              ..onTap = () {
                controller.onSignUp;
              },
          )
        ],
      ),
    );
  }
}