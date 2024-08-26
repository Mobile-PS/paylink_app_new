import 'package:paylink/routes/routes.dart';

import '../../../../../widgets/inputs/primary_input_widget.dart';

import '../../../../backend/model/payment_link/payment_edit_link_model.dart';
import '../../../../backend/utils/custom_loading_api.dart';
import '../../../../controller/dashboard/payments/payments_edit_controller.dart';
import '../../../../controller/dashboard/payments/upload_image_controller/upload_image_controller.dart';
import '../../../../model/drop_down_model/type_selection_drop_down.dart';
import '../../../../utils/basic_screen_imports.dart';
import '../../../../widgets/drop_down/custom_drop_down.dart';
import '../../../../widgets/others/image_picker_sheet.dart';
import '../../../../widgets/others/upload_image_widget.dart';

class PaymentsEditScreenMobile extends StatelessWidget {
  PaymentsEditScreenMobile({super.key});

  final controller = Get.put(PaymentsEditController());
  final uploadImageController = Get.put(UploadImageController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (value) async {
        Get.offAllNamed(Routes.dashboardScreen);

      },
      child: Scaffold(
        appBar: PrimaryAppBar(
          Strings.paymentLinkEdit.tr,
          onTap: () {
            Get.offAllNamed(Routes.paymentLogScreen);
          },
        ),
        body: Obx(
          () => controller.isEditLoading
              ? const CustomLoadingAPI()
              : _bodyWidget(context),
        ),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return ListView(
      padding:
          EdgeInsets.symmetric(horizontal: Dimensions.paddingHorizontalSize),
      physics: const BouncingScrollPhysics(),
      children: [
        _typeSelectionDropdownWidget(context),
        _customerChooseWidget(context),
        _productsAndSubscriptionsWidget(context),
        _createNewLinkButtonWidget(context),
      ],
    );
  }

  _customerChooseWidget(BuildContext context) {
    return Obx(() {
      return Visibility(
        visible: controller.typeSelection.value == Strings.customerChoose.tr,
        child: SingleChildScrollView(
          child: Form(
            key: formKey,
            child: Column(
              children: [
                _optionalImageUploadWidget(context),
                _titleWidget(context),
                _descriptionWidget(context),
                _currencyDropdownWidget(context),
                _setLimitCheckBoxWidget(context),
                _amountLimitInputWidget(context),
              ],
            ),
          ),
        ),
      );
    });
  }

  _typeSelectionDropdownWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(bottom: Dimensions.paddingVerticalSize * 0.5),
      child: CustomDropDown<TypeSelectionModel>(
        items: controller.typeSelectionList,
        onChanged: (value) {
          controller.typeSelection.value = value!.title;
        },
        isExpanded: true,
        hint: controller.typeSelection.value,
        padding: EdgeInsets.only(
          left: Dimensions.paddingHorizontalSize * 0.25,
        ),
        titleTextColor: CustomColor.primaryLightTextColor.withOpacity(.15),
        titleStyle: CustomStyle.darkHeading3TextStyle.copyWith(
          fontWeight: FontWeight.w400,
          fontSize: Dimensions.headingTextSize3,
          color: CustomColor.primaryLightColor,
        ),
        title: Strings.selectType,
        dropDownColor: CustomColor.whiteColor,
        borderEnable: false,
        dropDownFieldColor: CustomColor.whiteColor,
        dropDownIconColor: CustomColor.primaryLightTextColor.withOpacity(0.30),
      ),
    );
  }

  _optionalImageUploadWidget(BuildContext context) {
    return Obx(
      () => UploadImageWidget(
        isImagePathSet: uploadImageController.isImagePathSet.value,
        imagePath: uploadImageController.userImagePath.value,
        onImagePick: () {
          _showImagePickerBottomSheet(context);
        },
        title: Strings.uploadImage.tr,
        partName: Strings.image.tr,
        isVisible: true,
        defaultImage: controller.defaultImage.value,
        networkImage: controller.networkImage.value,
      ),
    );
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
              uploadImageController.chooseImageFromCamera();
            },
            fromGallery: () {
              Get.back();
              uploadImageController.chooseImageFromGallery();
            },
          ),
        );
      },
    );
  }

  _titleWidget(BuildContext context) {
    return PrimaryInputWidget(
      fillColor: CustomColor.whiteColor,
      controller: controller.titleController,
      hintText: Strings.nameOfCauseOrService.tr,
      label: Strings.title.tr,
    );
  }

  _descriptionWidget(BuildContext context) {
    return Padding(
      padding:
          EdgeInsets.symmetric(vertical: Dimensions.paddingVerticalSize * 0.5),
      child: PrimaryInputWidget(
        fillColor: CustomColor.whiteColor,
        controller: controller.descriptionController,
        hintText: Strings.descriptionHint.tr,
        label: Strings.description.tr,
        isValidator: false,
        optionalLabel: " (${Strings.optional.tr})",
        maxLines: 5,
      ),
    );
  }

  _currencyDropdownWidget(BuildContext context) {
    return CustomDropDown<CurrencyDatum>(
      items: controller.currencyList,
      hint: controller.currencySelection.value,
      onChanged: (value) {
        controller.currencySelection.value = value!.currencyName;
        controller.currencyName.value = value.currencyName;
        controller.currencyCode.value = value.currencyCode;
        controller.currencySymbol.value = value.currencySymbol;
        controller.currencyCountry.value = value.country;
      },
      isExpanded: true,
      padding: EdgeInsets.only(
        left: Dimensions.paddingHorizontalSize * 0.25,
      ),
      titleTextColor: CustomColor.primaryLightTextColor.withOpacity(.30),
      titleStyle: CustomStyle.darkHeading3TextStyle.copyWith(
        fontWeight: FontWeight.w400,
        fontSize: Dimensions.headingTextSize3,
        color: CustomColor.primaryLightColor,
      ),
      title: Strings.currency.tr,
      dropDownColor: CustomColor.whiteColor,
      borderEnable: false,
      dropDownFieldColor: CustomColor.whiteColor,
      dropDownIconColor: CustomColor.primaryLightTextColor.withOpacity(0.30),
    );
  }

  _setLimitCheckBoxWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Dimensions.heightSize * 0.66),
      child: Row(
        children: [
          Obx(
            () => SizedBox(
              height: 20.0.h,
              width: 20.0.w,
              child: Checkbox(
                value: controller.setLimit.value,
                onChanged: (value) {
                  controller.setLimit.value = value!;
                },
                activeColor: Theme.of(context).primaryColor,
                checkColor:
                    controller.setLimit.value ? CustomColor.whiteColor : null,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(Dimensions.radius * 0.3),
                ),
                side: BorderSide(
                  color: Get.isDarkMode
                      ? CustomColor.primaryDarkTextColor.withOpacity(0.50)
                      : CustomColor.primaryLightTextColor.withOpacity(0.50),
                ),
              ),
            ),
          ),
          horizontalSpace(Dimensions.widthSize * 0.4),
          TitleHeading5Widget(
            text: Strings.setLimit,
            fontWeight: FontWeight.w500,
            color: CustomColor.primaryLightTextColor.withOpacity(.6),
          ),
        ],
      ),
    );
  }

  _amountLimitInputWidget(BuildContext context) {
    return Obx(
      () => Visibility(
        visible: controller.setLimit.value,
        child: Padding(
          padding: EdgeInsets.only(
            top: Dimensions.paddingVerticalSize * 0.5,
            bottom: Dimensions.paddingVerticalSize * 0.5,
          ),
          child: Row(
            children: [
              Expanded(
                child: PrimaryInputWidget(
                  fillColor: CustomColor.whiteColor,
                  controller: controller.minimumAmountController,
                  hintText: '1.00',
                  label: Strings.minimumAmount.tr,
                  textInputType: TextInputType.number,
                  suffixIcon:
                      _customCurrencyWidget(controller.currencyCode.value),
                ),
              ),
              horizontalSpace(Dimensions.widthSize * 0.5),
              Expanded(
                child: PrimaryInputWidget(
                  fillColor: CustomColor.whiteColor,
                  controller: controller.maximumAmountController,
                  hintText: '100 0.00',
                  label: Strings.maximumAmount.tr,
                  textInputType: TextInputType.number,
                  suffixIcon:
                      _customCurrencyWidget(controller.currencyCode.value),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  _customCurrencyWidget(currency) {
    return Container(
      width: Dimensions.widthSize * 6,
      alignment: Alignment.center,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(Dimensions.radius * 0.5),
          bottomRight: Radius.circular(Dimensions.radius * 0.5),
        ),
        color: Theme.of(Get.context!).primaryColor,
      ),
      child: Text(
        currency,
        style: CustomStyle.darkHeading3TextStyle.copyWith(
            fontWeight: FontWeight.w500, color: CustomColor.whiteColor),
      ),
    );
  }

  _productsAndSubscriptionsWidget(BuildContext context) {
    return Obx(
      () => Visibility(
        visible: controller.typeSelection.value ==
            Strings.productsOrSubscriptions.tr,
        child: Form(
          key: formKey,
          child: Column(
            children: [
              _productsAndSubscriptionsTitleWidget(context),
              _currencyDropdownWidget(context),
              _productsAndSubscriptionsPriceWidget(context),
              _quantityWidget(context),
            ],
          ),
        ),
      ),
    );
  }

  _productsAndSubscriptionsTitleWidget(BuildContext context) {
    return PrimaryInputWidget(
      fillColor: CustomColor.whiteColor,
      controller: controller.productsAndSubscriptionTitleController,
      hintText: Strings.enterYourProductName.tr,
      label: Strings.title.tr,
    );
  }

  _productsAndSubscriptionsPriceWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: Dimensions.paddingVerticalSize * 0.5,
        bottom: Dimensions.paddingVerticalSize * 0.5,
      ),
      child: PrimaryInputWidget(
        fillColor: CustomColor.whiteColor,
        controller: controller.amountController,
        hintText: '0.00',
        label: Strings.amountText.tr,
        textInputType: TextInputType.number,
        suffixIcon: _customCurrencyWidget(controller.currencyCode.value),
      ),
    );
  }

  _quantityWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: Dimensions.paddingVerticalSize * 0.5,
        bottom: Dimensions.paddingVerticalSize * 0.5,
      ),
      child: PrimaryInputWidget(
        fillColor: CustomColor.whiteColor,
        controller: controller.quantityController,
        hintText: Strings.zero,
        label: Strings.quantity.tr,
        textInputType: TextInputType.number,
      ),
    );
  }

  _createNewLinkButtonWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        vertical: Dimensions.marginSizeVertical,
      ),
      child: Obx(
        () => controller.isEditUpdateLoading
            ? const CustomLoadingAPI()
            : PrimaryButton(
                title: Strings.updateLink,
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    controller.imageController.isImagePathSet.value
                        ? controller.paymentLinkUpdateWithImageProcess()
                        :
                    controller.paymentLinkUpdateWithOutImageProcess();
                  }
                },
              ),
      ),
    );
  }
}