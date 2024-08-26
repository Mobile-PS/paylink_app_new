// ignore_for_file: must_be_immutable

import 'package:paylink/backend/utils/custom_loading_api.dart';

import '../../../../../widgets/inputs/custom_divider.dart';
import '../../../../../widgets/inputs/primary_input_widget.dart';
import '../../../../backend/model/invoice/invoice_model.dart';
import '../../../../controller/dashboard/invoice/invoice_controller.dart';
import '../../../../utils/basic_screen_imports.dart';
import '../../../../widgets/drop_down/custom_drop_down.dart';

class InvoiceScreenMobile extends StatelessWidget {
  InvoiceScreenMobile({super.key});

  final controller = Get.put(InvoiceController());
  final createInvoiceFormKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimaryAppBar(Strings.invoice),
      body: _bodyWidget(context),
      bottomNavigationBar: _createInvoiceButtonWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
    return Obx(() {
      return Form(
        key: createInvoiceFormKey,
        child: ListView(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.paddingHorizontalSize),
          physics: const BouncingScrollPhysics(),
          children: [
            _customerWidget(context),
            _itemsWidget(context),
            _addItemWidget(context),
          ],
        ),
      );
    });
  }

  _customerWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const TitleHeading2Widget(text: Strings.customer),
        const CustomDivider(),
        _customerInputWidget(context),
      ],
    );
  }

  _customerInputWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(top: Dimensions.paddingVerticalSize * 0.25),
          child: PrimaryInputWidget(
            controller: controller.titleController,
            hintText: Strings.title,
            label: Strings.enterTitle,
            fillColor: CustomColor.whiteColor,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: Dimensions.paddingVerticalSize * 0.25),
          child: PrimaryInputWidget(
            controller: controller.nameController,
            hintText: Strings.enterName,
            label: Strings.name,
            fillColor: CustomColor.whiteColor,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: Dimensions.paddingVerticalSize * 0.25),
          child: PrimaryInputWidget(
            controller: controller.emailController,
            hintText: Strings.enterEmailAddress,
            label: Strings.emailAddress,
            fillColor: CustomColor.whiteColor,
            textInputType: TextInputType.emailAddress,
          ),
        ),
        Padding(
          padding: EdgeInsets.only(top: Dimensions.paddingVerticalSize * 0.25),
          child: PrimaryInputWidget(
            controller: controller.phoneNumberController,
            hintText: Strings.enterPhoneNumber,
            label: Strings.phoneNumber,
            fillColor: CustomColor.whiteColor,
            textInputType: TextInputType.phone,
          ),
        ),
        _currencyDropdownWidget(context),
      ],
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
        debugPrint(">>>>>>>>>>>---= ${controller.currencySelection.value}");
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

  _itemsWidget(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.only(
            top: Dimensions.paddingVerticalSize * 0.75,
            bottom: Dimensions.paddingVerticalSize * 0.25,
          ),
          child: Row(
            mainAxisAlignment: mainSpaceBet,
            children: [
              const TitleHeading2Widget(text: Strings.items),
              InkWell(
                onTap: () {
                  controller.addItem();
                },
                child: TitleHeading4Widget(
                  text: Strings.addNewItem,
                  fontWeight: FontWeight.w600,
                  color: CustomColor.primaryLightColor,
                  padding: EdgeInsets.only(
                      right: Dimensions.paddingHorizontalSize * .5),
                ),
              )
            ],
          ),
        ),
        const CustomDivider(),
      ],
    );
  }

  _addItemWidget(BuildContext context) {
    return Obx(
      () => Container(
        margin: EdgeInsets.only(top: Dimensions.marginSizeVertical * .25),
        padding: EdgeInsets.symmetric(
            horizontal: Dimensions.paddingHorizontalSize,
            vertical: Dimensions.paddingVerticalSize * 0.25),
        decoration: BoxDecoration(
          color: CustomColor.whiteColor,
          borderRadius: BorderRadius.circular(Dimensions.radius),
        ),
        child: ListView.builder(
          itemBuilder: (context, index) {
            return Column(
              mainAxisAlignment: mainStart,
              children: [
                Padding(
                  padding: EdgeInsets.only(
                      top: Dimensions.paddingVerticalSize * 0.25),
                  child: PrimaryInputWidget(
                    controller: controller.invoiceItems[index].titleController,
                    hintText: Strings.enterTitle,
                    label: Strings.title,
                    fillColor: CustomColor.primaryLightScaffoldBackgroundColor,
                  ),
                ),
                Row(
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: Dimensions.paddingVerticalSize * 0.25),
                        child: PrimaryInputWidget(
                          controller:
                              controller.invoiceItems[index].quantityController,
                          hintText: '0.00',
                          label: Strings.quantity,
                          textInputType: TextInputType.number,
                          fillColor:
                              CustomColor.primaryLightScaffoldBackgroundColor,
                        ),
                      ),
                    ),
                    horizontalSpace(Dimensions.widthSize),
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(
                            top: Dimensions.paddingVerticalSize * 0.25),
                        child: PrimaryInputWidget(
                          controller:
                              controller.invoiceItems[index].priceController,
                          hintText: "0.00",
                          label: Strings.price,
                          textInputType: TextInputType.number,
                          fillColor:
                              CustomColor.primaryLightScaffoldBackgroundColor,
                          suffixIcon: _priceCurrencyWidget(
                              controller.currencyCode.value),
                        ),
                      ),
                    ),
                  ],
                ),
                _removeButtonWidget(context, index),
              ],
            );
          },
          itemCount: controller.invoiceItems.length,
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
        ),
      ),
    );
  }

  _removeButtonWidget(context, index) {
    return Padding(
      padding: EdgeInsets.only(
        top: Dimensions.marginSizeVertical * .5,
        bottom: Dimensions.marginSizeVertical * .25,
      ),
      child: PrimaryButton(
          buttonColor: CustomColor.removeBtnColor,
          title: Strings.remove,
          onPressed: () {
            controller.removeItem(index);
          }),
    );
  }

  _priceCurrencyWidget(currency) {
    return Container(
      width: Dimensions.widthSize * 5,
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

  _createInvoiceButtonWidget(context) {
    return Padding(
      padding: EdgeInsets.only(
        top: Dimensions.marginSizeVertical * .5,
        bottom: Dimensions.marginSizeVertical * .5,
        left: Dimensions.marginSizeHorizontal * .75,
        right: Dimensions.marginSizeHorizontal * .75,
      ),
      child: Obx(() => controller.isInvoiceStoreLoading
          ? const CustomLoadingAPI()
          : PrimaryButton(
              title: controller.selectedInvoiceLinkId.value != 0
                  ? Strings.updateInvoice
                  : Strings.createInvoice,
              onPressed: () {
                if (createInvoiceFormKey.currentState!.validate()) {
                  controller.selectedInvoiceLinkId.value != 0
                      ? controller.invoiceUpdateProcess()
                      : controller.createInvoice();
                }
              },
            )),
    );
  }
}
