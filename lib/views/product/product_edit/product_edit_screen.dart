import '../../../backend/model/product/product_edit_info_model.dart';
import '../../../backend/utils/custom_loading_api.dart';
import '/widgets/product/product_image_picker_widget.dart';

import '../../../controller/product/product_controller.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../widgets/drop_down/custom_drop_down.dart';
import '../../../widgets/inputs/primary_input_widget.dart';
import '../../../widgets/others/image_picker_sheet.dart';

class ProductEditScreenMobile extends StatelessWidget {
  ProductEditScreenMobile({super.key});

  final controller = Get.put(ProductController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
      appBar: const PrimaryAppBar(
        Strings.updateProduct,
      ),
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.widthSize * 1.5,
      ),
      children: [
        _inputWidget(context),
      ],
    );
  }

  _inputWidget(BuildContext context) {
    return Form(
        key: formKey,
        child: Column(
          children: [
            Obx(() => ProductImagePicker(
                  isImagePathSet: controller.isImagePathSet.value,
                  imagePath: controller.userImagePath.value,
                  onImagePick: () {
                    _showImagePickerBottomSheet(context);
                  },
                )),
            verticalSpace(Dimensions.heightSize * 3.3),
            PrimaryInputWidget(
              controller: controller.editProductNameController,
              hintText: Strings.enterProductName,
              label: Strings.productName,
              fillColor: CustomColor.primaryLightScaffoldBackgroundColor,
            ),
            PrimaryInputWidget(
              controller: controller.editPriceController,
              hintText: Strings.enterAmount,
              label: Strings.price,
              fillColor: CustomColor.primaryLightScaffoldBackgroundColor,
            ),
            PrimaryInputWidget(
              controller: controller.editDescController,
              hintText: Strings.writeHere,
              label: Strings.description,
              fillColor: CustomColor.primaryLightScaffoldBackgroundColor,
            ),
            verticalSpace(
              Dimensions.heightSize * 0.5,
            ),
            _currencyDropdownWidget(context),
            verticalSpace(
              Dimensions.heightSize,
            ),
            verticalSpace(
              Dimensions.heightSize,
            ),
            _updateButtonWidget(context)
          ],
        ));
  }

  _currencyDropdownWidget(BuildContext context) {
    return CustomDropDown<CurrencyDatum>(
      items: controller.currencyListEdit,
      hint: controller.currencySelection.value,
      onChanged: (value) {
        controller.currencySelection.value = value!.name;
        controller.currencyName.value = value.name;
        controller.currencyCode.value = value.code;
        controller.currencySymbol.value = value.symbol;
        controller.currencyCountry.value = value.country;
        controller.currencyId.value = value.id.toString();
      },
      isExpanded: true,
      padding: EdgeInsets.only(
        left: Dimensions.paddingHorizontalSize * 0.25,
      ),
      margin: EdgeInsets.only(
        right: Dimensions.paddingVerticalSize * 0.5,
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

  _updateButtonWidget(BuildContext context) {
    return Obx(
      () => controller.isUpdateLoading
          ? const CustomLoadingAPI()
          : PrimaryButton(
              title: Strings.updateProduct,
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  controller.onUpdateProduct;
                }
              },
            ),
    ).paddingOnly(
      right: Dimensions.paddingHorizontalSize,
      left: Dimensions.paddingHorizontalSize,
      top: Dimensions.paddingVerticalSize * 0.5,
      bottom: Dimensions.paddingVerticalSize * 1.5,
    );
  }
}
