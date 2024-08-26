import '../../../../backend/model/product/product_link_edit_info_model.dart';
import '../../../../backend/utils/custom_loading_api.dart';
import '../../../../widgets/drop_down/custom_drop_down.dart';
import '/controller/product/product_controller.dart';

import '../../../../utils/basic_screen_imports.dart';
import '../../../../widgets/inputs/primary_input_widget.dart';

class ProductLinkEditScreenMobile extends StatelessWidget {
  ProductLinkEditScreenMobile({super.key});

  final controller = Get.put(ProductController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimaryAppBar(
        Strings.editProductLinks,
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
            _currencyDropdownWidget(context),
            verticalSpace(Dimensions.heightSize),
            PrimaryInputWidget(
              controller: controller.productLinkEditPriceController,
              hintText: Strings.enterAmount,
              label: Strings.price,
              textInputType: TextInputType.number,
              fillColor: CustomColor.whiteColor,
            ),
            verticalSpace(Dimensions.heightSize),
            PrimaryInputWidget(
              controller: controller.productLinkEditQuantityController,
              hintText: Strings.enterQuantity,
              label: Strings.quantity,
              textInputType: TextInputType.number,
              fillColor: CustomColor.whiteColor,
            ),
            verticalSpace(Dimensions.heightSize),
            _storeButtonWidget(context),
            verticalSpace(
              Dimensions.heightSize * 0.5,
            ),
          ],
        ));
  }

  _currencyDropdownWidget(BuildContext context) {
    return CustomDropDown<CurrencyDatum>(
      items: controller.productLinkEditCurrencyList,
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
      () => controller.isLinkUpdateLoading
          ? const CustomLoadingAPI()
          : PrimaryButton(
              title: Strings.editProductLinks,
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  controller.productUpdateLinkProcess();
                }
              },
            ),
    );
  }
}
