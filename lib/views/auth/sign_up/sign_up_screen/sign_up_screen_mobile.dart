import 'package:flutter/gestures.dart';
import 'package:paylink/controller/basic_settings/basic_settings_controller.dart';
import 'package:paylink/widgets/drop_down/custom_drop_down.dart';

import '../../../../../controller/auth/sign_up/sign_up_controller/sign_up_controller.dart';
import '../../../../backend/local_storage/local_storage.dart';
import '../../../../backend/model/basic_settings/basic_settings_info_model.dart';
import '../../../../backend/utils/custom_loading_api.dart';
import '../../../../utils/basic_screen_imports.dart';
import '../../../../widgets/inputs/check_box_widget.dart';
import '../../../../widgets/inputs/primary_input_widget.dart';
import '../../../../widgets/others/custom_snack_bar.dart';
import '../../../../widgets/others/title_subtitle_widget.dart';

class SignUpScreenMobile extends StatelessWidget {
  SignUpScreenMobile({super.key});

  final controller = Get.put(SignUpController());
  final basicSettingsController = Get.put(BasicSettingsController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(


      backgroundColor: CustomColor.primaryLightScaffoldBackgroundColor,
      body: SafeArea(
        child: _bodyWidget(context),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    bool isTablet() {
      return MediaQuery.of(context).size.shortestSide >= 600;
    }
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        verticalSpace(isTablet()
            ? Dimensions.marginSizeVertical * .01
            : Dimensions.marginSizeVertical),
        _appLogoWidget(context),
        _welcomeTextWidget(context),
        _fieldsWidget(context),
      ],
    );
  }

  _appLogoWidget(BuildContext context) {
    bool isTablet() {
      return MediaQuery.of(context).size.shortestSide >= 600;
    }

    return Image.network(
      LocalStorage.getAppBasicLogo(),
      fit: BoxFit.contain,
      height: MediaQuery.of(context).size.height * .065,
    ).marginOnly(
      top: isTablet()
          ? Dimensions.marginSizeVertical * .10
          : Dimensions.marginSizeVertical * 1.7,
      bottom: isTablet()
          ? Dimensions.marginSizeVertical * .10
          : Dimensions.marginSizeVertical * 1.3,
    );
  }

  _welcomeTextWidget(BuildContext context) {
    bool isTablet() {
      return MediaQuery.of(context).size.shortestSide >= 600;
    }

    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.paddingHorizontalSize,
      ),
      child: TitleSubTitleWidget(
        title: Strings.signUpInformation.tr,
        subTitle: Strings.signUpSubtitle.tr,
        subTitleFontSize: isTablet()
            ? Dimensions.headingTextSize5
            : Dimensions.headingTextSize4,
        subTitleColor: CustomColor.primaryLightTextColor.withOpacity(.35),
      ),
    );
  }

  _fieldsWidget(BuildContext context) {
    return Form(
      key: formKey,
      child: Padding(
        padding: EdgeInsets.only(
          top: Dimensions.paddingHorizontalSize,
        ),
        child: ListView(
          shrinkWrap: true,
          physics: const BouncingScrollPhysics(),
          children: [
            _inputFieldWidget(context),
            _agreedWidget(context),
            _buttonWidget(context),
            _alreadyHaveAccountWidget(context),
            verticalSpace(Dimensions.heightSize),
          ],
        ),
      ),
    );
  }

  _inputFieldWidget(BuildContext context) {
    return Column(
      children: [
        Row(
          children: [
            Expanded(
                child: PrimaryInputWidget(
              controller: controller.firstNameController,
              hintText: Strings.enterName,
              label: Strings.firstName,
              textInputType: TextInputType.text,
              fillColor: CustomColor.whiteColor,
            )),
            horizontalSpace(Dimensions.widthSize),
            Expanded(
              child: PrimaryInputWidget(
                controller: controller.lastNameController,
                hintText: Strings.enterName,
                label: Strings.lastName,
                textInputType: TextInputType.text,
                fillColor: CustomColor.whiteColor,
              ),
            ),
          ],
        ).paddingSymmetric(
          horizontal: Dimensions.paddingHorizontalSize,
        ),
        verticalSpace(Dimensions.heightSize * 1.6),
        PrimaryInputWidget(
          controller: controller.emailAddressController,
          hintText: Strings.enterEmailAddress,
          label: Strings.emailAddress,
          textInputType: TextInputType.emailAddress,
          fillColor: CustomColor.whiteColor,
        ).paddingSymmetric(
          horizontal: Dimensions.paddingHorizontalSize,
        ),
        verticalSpace(Dimensions.heightSize * 1.6),
        Obx(
          () => basicSettingsController.isLoading
              ? CustomDropDown<ExchangeRate>(
                  items: basicSettingsController.countryList,
                  hint: basicSettingsController.countrySelection.value,
                  onChanged: (value) {
                    basicSettingsController.countrySelection.value =
                        value!.name;
                  },
                  isExpanded: true,
                  padding: EdgeInsets.only(
                    left: Dimensions.paddingHorizontalSize * 0.25,
                  ),

                  titleTextColor:
                      CustomColor.primaryLightTextColor.withOpacity(.30),
                  titleStyle: CustomStyle.darkHeading3TextStyle.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: Dimensions.headingTextSize3,
                    color: CustomColor.primaryLightColor,
                  ),
                  title: Strings.country.tr,
                  dropDownColor: CustomColor.whiteColor,
                  borderEnable: false,
                  dropDownFieldColor: CustomColor.whiteColor,
                  dropDownIconColor:
                      CustomColor.primaryLightTextColor.withOpacity(0.30),
                )
              : CustomDropDown<ExchangeRate>(
                  items: basicSettingsController.countryList,
                  hint: basicSettingsController.countrySelection.value,
                  onChanged: (value) {
                    basicSettingsController.countrySelection.value =
                        value!.name;
                  },
                  isExpanded: true,
                  padding: EdgeInsets.only(
                    left: Dimensions.paddingHorizontalSize * 0.25,
                  ),

                  titleTextColor:
                      CustomColor.primaryLightTextColor.withOpacity(.30),
                  titleStyle: CustomStyle.darkHeading3TextStyle.copyWith(
                    fontWeight: FontWeight.w400,
                    fontSize: Dimensions.headingTextSize3,
                    color: CustomColor.primaryLightColor,
                  ),
                  title: Strings.country.tr,
                  dropDownColor: CustomColor.whiteColor,
                  borderEnable: false,
                  dropDownFieldColor: CustomColor.whiteColor,
                  dropDownIconColor:
                      CustomColor.primaryLightTextColor.withOpacity(0.30),
                ),
        ).paddingSymmetric(
          horizontal: Dimensions.paddingHorizontalSize,
        ),
        verticalSpace(Dimensions.heightSize * 1.6),
        PrimaryInputWidget(
          controller: controller.companyNameController,
          hintText: Strings.enterCompanyName,
          label: Strings.companyName,
          fillColor: CustomColor.whiteColor,
        ).paddingSymmetric(
          horizontal: Dimensions.paddingHorizontalSize,
        ),
        verticalSpace(Dimensions.heightSize * 1.6),
        PrimaryInputWidget(
          controller: controller.passwordController,
          hintText: Strings.enterPassword,
          label: Strings.password,
          fillColor: CustomColor.whiteColor,
          isPasswordField: true,
          textInputType: TextInputType.text,
        ).paddingSymmetric(
          horizontal: Dimensions.paddingHorizontalSize,
        ),
      ],
    );
  }

  _agreedWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
          top: Dimensions.paddingVerticalSize * .5,
          left: Dimensions.paddingVerticalSize * .9),
      child: FittedBox(
        child: Row(
          crossAxisAlignment: crossStart,
          children: [
            CheckBoxWidget(
              isChecked: controller.agreed,
              onChecked: (value) {
                controller.agreed.value = value;
              },
            ),
          ],
        ),
      ),
    );
  }

  _alreadyHaveAccountWidget(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          text: Strings.alreadyHaveAnAccount,
          style: Get.isDarkMode
              ? CustomStyle.darkHeading5TextStyle.copyWith(
                  color: CustomColor.primaryLightTextColor.withOpacity(.45),
                  fontWeight: FontWeight.w600)
              : CustomStyle.lightHeading5TextStyle.copyWith(
                  color: CustomColor.primaryLightTextColor.withOpacity(.45),
                  fontWeight: FontWeight.w600),
          children: [
            TextSpan(
              text: Strings.logIn,
              style: Get.isDarkMode
                  ? CustomStyle.darkHeading5TextStyle.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600)
                  : CustomStyle.lightHeading5TextStyle.copyWith(
                      color: Theme.of(context).primaryColor,
                      fontWeight: FontWeight.w600),
              recognizer: TapGestureRecognizer()
                ..onTap = () {
                  controller.onSignIn;
                },
            )
          ],
        ),
      ),
    );
  }

  _buttonWidget(context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Dimensions.marginSizeVertical,
        horizontal: Dimensions.paddingHorizontalSize,
      ),
      child: Obx(
        () => controller.isLoading
            ? const CustomLoadingAPI()
            : PrimaryButton(
                title: Strings.registration,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    if (controller.agreed.value == true) {
                      controller.onSignUp;
                    } else {
                      CustomSnackBar.error(
                          Strings.pleaseAcceptTermsAndConditions.tr);
                    }
                  }
                },
              ),
      ),
    );
  }
}