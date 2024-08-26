import '../../../../backend/model/product/product_link_info_model.dart';
import '../../../../backend/utils/custom_loading_api.dart';
import '../../../../routes/routes.dart';
import '../../../../widgets/drop_down/custom_drop_down.dart';
import '/controller/product/product_controller.dart';

import '../../../../utils/basic_screen_imports.dart';
import '../../../../widgets/inputs/primary_input_widget.dart';

class ProductLinkStoreScreenMobile extends StatelessWidget {
  ProductLinkStoreScreenMobile({super.key});

  final controller = Get.put(ProductController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return PopScope(
        canPop: false,
        onPopInvoked: (can) {
          Get.toNamed(Routes.productLinkListScreen);
        },
        child: Scaffold(
          appBar: PrimaryAppBar(
            Strings.addProductLinks,
            onTap: () {
              Get.toNamed(Routes.productLinkListScreen);
            },
          ),
          body: _bodyWidget(context),
        ));
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
            _currencyDropdownWidget(context),
            verticalSpace(Dimensions.heightSize),
            PrimaryInputWidget(
              controller: controller.productLinkPriceController,
              hintText: Strings.enterAmount,
              label: Strings.price,
              textInputType: TextInputType.number,
              fillColor: CustomColor.whiteColor,
            ),
            verticalSpace(Dimensions.heightSize),
            PrimaryInputWidget(
              controller: controller.productLinkQuantityController,
              hintText: Strings.enterQuantity,
              label: Strings.quantity,
              textInputType: TextInputType.number,
              fillColor: CustomColor.whiteColor,
            ),
            verticalSpace(Dimensions.heightSize * 2.5),
            _storeButtonWidget(context),
            verticalSpace(
              Dimensions.heightSize * 0.5,
            ),
          ],
        ));
  }

  _currencyDropdownWidget(BuildContext context) {
    return CustomDropDown<CurrencyDatum>(
      items: controller.productLinkCurrencyList,
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

  _storeButtonWidget(BuildContext context) {
    return Obx(
      () => controller.isProductLinkLoading
          ? const CustomLoadingAPI()
          : PrimaryButton(
              title: Strings.addProductLinks,
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  controller.linkStoreProcess();
                }
              },
            ),
    );
  }
}
