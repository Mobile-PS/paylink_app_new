import 'dart:ui';

import 'package:paylink/controller/basic_settings/basic_settings_controller.dart';

import '../../../../controller/dashboard/update_profile_controller/update_profile_controller.dart';
import '../../../../custom_assets/assets.gen.dart';
import '../../../../utils/basic_screen_imports.dart';
import '../../../../widgets/inputs/primary_input_widget.dart';
import '../../../../widgets/others/custom_image_widget.dart';
import '../../../../widgets/others/image_picker_sheet.dart';
import '../../../../widgets/others/image_picker_widget.dart';
import '../../../backend/utils/custom_loading_api.dart';
import '../../../widgets/common/custom_container.dart';

class UpdateProfileScreenMobile extends StatelessWidget {
  UpdateProfileScreenMobile({super.key});

  final controller = Get.put(UpdateProfileController());
  final basicSettingsController = Get.put(BasicSettingsController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    bool isTablet() {
      return MediaQuery.of(context).size.shortestSide >= 600;
    }

    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: PrimaryAppBar(
        Strings.profile.tr,
        appbarSize: isTablet()
            ? Dimensions.heightSize * 1.8
            : Dimensions.heightSize * 2.5,
        action: [
          InkWell(
            onTap: () {
              _showDeleteDialog(context);
            },
            child: Container(
              height: Dimensions.heightSize * 2,
              alignment: Alignment.center,
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.marginSizeHorizontal * 0.375,
              ),
              margin: EdgeInsets.only(right: Dimensions.marginSizeHorizontal),
              decoration: ShapeDecoration(
                color: CustomColor.redColor,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
                ),
              ),
              child: const TitleHeading5Widget(
                text: Strings.delete,
                color: CustomColor.whiteColor,
              ),
            ),
          )
        ],
      ),
      body: Obx(
        () => controller.isUpdateLoading || controller.isLoading
            ? const CustomLoadingAPI()
            : _bodyWidget(context),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        _updateProfileInfoWidget(context),
        _updateProfileFieldsWidget(context),
      ],
    );
  }

  _updateProfileInfoWidget(BuildContext context) {
    return Column(
      children: [
        Obx(
          () => ImagePickerWidget(
            isImagePathSet: controller.isImagePathSet.value,
            imagePath: controller.userImagePath.value,
            onImagePick: () {
              _showImagePickerBottomSheet(context);
            },
          ),
        ),
        _nameAndEmailWidget()
      ],
    ).paddingOnly(top: Dimensions.paddingVerticalSize * 2);
  }

  _showImagePickerBottomSheet(BuildContext context) {
    showModalBottomSheet(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          width: double.infinity,
          child: ImagePickerSheet(
            fromCamera: () {
              Get.back();
              controller.chooseImageFromCamera();
            },
            fromGallery: () {
              Get.back();
              controller.chooseImageFromGallery();
            },
          ),
        );
      },
    );
  }

  _nameAndEmailWidget() {
    return Column(
      children: [
        TitleHeading3Widget(
          text: controller.userFullName.value,
          fontWeight: FontWeight.w600,
        ).paddingOnly(
          top: Dimensions.paddingVerticalSize * 0.5,
          bottom: Dimensions.paddingVerticalSize * 0.1,
        ),
        Row(
          mainAxisAlignment: mainCenter,
          children: [
            TitleHeading4Widget(
              text: controller.userEmailAddress.value,
              opacity: 0.60,
              fontWeight: FontWeight.w500,
              fontSize: Dimensions.headingTextSize3,
            ),
            horizontalSpace(Dimensions.widthSize),
            CustomImageWidget(
              path: Assets.icon.checkMarkGreen,
              height: Dimensions.heightSize,
            )
          ],
        )
      ],
    );
  }

//   padding: EdgeInsets.only(left:Dimensions.paddingHorizontalSize,right: Dimensions.paddingHorizontalSize,top: Dimensions.paddingVerticalSize),
  _updateProfileFieldsWidget(BuildContext context) {
    return Form(
      key: formKey,
      child: ListView(
        shrinkWrap: true,
        physics: const NeverScrollableScrollPhysics(),
        children: [
          _firstNameAndLastNameWidget(context),
          _countryWidget(context),
          _phoneNumberWidget(context),
          _companyNameWidget(context),
          _addressAndCityWidget(context),
          _stateAndZipCodeWidget(context),
          _updateButtonWidget(context),
        ],
      ),
    );
  }

  _firstNameAndLastNameWidget(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PrimaryInputWidget(
            controller: controller.firstNameController,
            hintText: Strings.firstName,
            label: Strings.firstName,
            fillColor: CustomColor.whiteColor,
            textInputType: TextInputType.text,
          ),
        ),
        horizontalSpace(Dimensions.widthSize),
        Expanded(
          child: PrimaryInputWidget(
            controller: controller.lastNameController,
            hintText: Strings.lastName,
            label: Strings.lastName,
            fillColor: CustomColor.whiteColor,
            textInputType: TextInputType.text,
          ),
        ),
      ],
    ).paddingOnly(
        bottom: Dimensions.paddingVerticalSize * 0.5,
        left: Dimensions.paddingHorizontalSize,
        right: Dimensions.paddingHorizontalSize,
        top: Dimensions.paddingVerticalSize);
  }

  _countryWidget(BuildContext context) {
    return PrimaryInputWidget(
      controller: controller.countrySelection,
      hintText: controller.countrySelection.text,
      label: Strings.country,
      fillColor: CustomColor.whiteColor,
      readOnly: true,
    ).paddingSymmetric(
      horizontal: Dimensions.paddingHorizontalSize,
    );
  }

  _phoneNumberWidget(BuildContext context) {
    return PrimaryInputWidget(
      controller: controller.phoneNumberController,
      hintText: Strings.demoPhoneNumber,
      label: Strings.phoneNumber,
      fillColor: CustomColor.whiteColor,
      textInputType: TextInputType.number,
      phoneCode: controller.selectCountryCode.value,
    ).paddingSymmetric(
        horizontal: Dimensions.paddingHorizontalSize,
        vertical: Dimensions.paddingVerticalSize * 0.25);
  }

  _companyNameWidget(BuildContext context) {
    return PrimaryInputWidget(
      controller: controller.companyNameController,
      hintText: Strings.enterCompanyName,
      label: Strings.companyName,
      fillColor: CustomColor.whiteColor,
    ).paddingSymmetric(
        horizontal: Dimensions.paddingHorizontalSize,
        vertical: Dimensions.paddingVerticalSize * 0.25);
  }

  _addressAndCityWidget(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PrimaryInputWidget(
            controller: controller.addressController,
            hintText: Strings.enterAddress,
            label: Strings.address,
            fillColor: CustomColor.whiteColor,
            textInputType: TextInputType.text,
          ),
        ),
        horizontalSpace(Dimensions.widthSize),
        Expanded(
          child: PrimaryInputWidget(
            controller: controller.cityController,
            hintText: Strings.enterCity,
            label: Strings.city,
            fillColor: CustomColor.whiteColor,
            textInputType: TextInputType.text,
          ),
        ),
      ],
    ).paddingSymmetric(
        horizontal: Dimensions.paddingHorizontalSize,
        vertical: Dimensions.paddingVerticalSize * 0.25);
  }

  _stateAndZipCodeWidget(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: PrimaryInputWidget(
            controller: controller.sateController,
            hintText: Strings.enterState,
            label: Strings.state,
            fillColor: CustomColor.whiteColor,
            textInputType: TextInputType.text,
          ),
        ),
        horizontalSpace(Dimensions.widthSize),
        Expanded(
          child: PrimaryInputWidget(
            controller: controller.zipCodeController,
            hintText: Strings.zipCode,
            label: Strings.zipCode,
            fillColor: CustomColor.whiteColor,
            textInputType: TextInputType.number,
          ),
        ),
      ],
    ).paddingSymmetric(
        horizontal: Dimensions.paddingHorizontalSize,
        vertical: Dimensions.paddingVerticalSize * 0.25);
  }

  _updateButtonWidget(BuildContext context) {
    return Obx(
      () => controller.isUpdateLoading
          ? const CustomLoadingAPI()
          : PrimaryButton(
              title: Strings.updateProfile,
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  controller.onUpdateProfile;
                }
              },
            ),
    ).paddingOnly(
        right: Dimensions.paddingHorizontalSize,
        left: Dimensions.paddingHorizontalSize,
        top: Dimensions.paddingVerticalSize * 0.5,
        bottom: Dimensions.paddingVerticalSize * 1.5);
  }

  _showDeleteDialog(BuildContext context) {
    return showDialog(
      context: context,
      barrierDismissible: true,
      builder: (BuildContext context) {
        return BackdropFilter(
          filter: ImageFilter.blur(
            sigmaX: 5,
            sigmaY: 5,
          ),
          child: Dialog(
            backgroundColor: CustomColor.whiteColor,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(Dimensions.radius),
            ),
            child: Padding(
              padding: EdgeInsets.symmetric(
                  horizontal: Dimensions.paddingHorizontalSize,
                  vertical: Dimensions.paddingVerticalSize),
              child: Column(
                crossAxisAlignment: crossCenter,
                mainAxisSize: mainMin,
                children: [
                  const TitleHeading1Widget(
                    text: Strings.deleteAccount,
                    textAlign: TextAlign.center,
                  ),
                  verticalSpace(Dimensions.heightSize),
                  const TitleHeading3Widget(
                    text: Strings.deleteAccountContent,
                    textAlign: TextAlign.center,
                    opacity: 0.60,
                  ),
                  verticalSpace(Dimensions.heightSize),
                  Row(
                    children: [
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            Get.back();
                          },
                          child: CustomContainer(
                            height: Dimensions.buttonHeight * 0.7,
                            borderRadius: Dimensions.radius * 0.8,
                            color: Get.isDarkMode
                                ? CustomColor.primaryBGLightColor
                                    .withOpacity(0.15)
                                : CustomColor.primaryBGDarkColor
                                    .withOpacity(0.15),
                            child: const TitleHeading4Widget(
                              text: Strings.cancel,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                      horizontalSpace(Dimensions.widthSize),
                      Expanded(
                        child: InkWell(
                          onTap: () {
                            controller.onDeleteAccount();
                            controller.deleteAccountProcess();
                          },
                          child: Obx(
                            () => controller.isDeleteAccountLoading
                                ? const CustomLoadingAPI()
                                : CustomContainer(
                                    height: Dimensions.buttonHeight * 0.7,
                                    borderRadius: Dimensions.radius * 0.8,
                                    color: Theme.of(context).primaryColor,
                                    child: const TitleHeading4Widget(
                                      text: Strings.okay,
                                      color: CustomColor.whiteColor,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                          ),
                        ),
                      ),
                    ],
                  ).paddingSymmetric(
                      horizontal: Dimensions.paddingHorizontalSize * 0.5,
                      vertical: Dimensions.paddingVerticalSize * 0.5),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}