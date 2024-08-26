import 'dart:io';

import 'package:flutter/services.dart';

import '../../../../../backend/model/money_out/money_out_info_model.dart';
import '../../../../../backend/utils/custom_loading_api.dart';
import '../../../../../controller/drawer/money_out_controller/money_out_controller.dart';
import '../../../../../utils/basic_screen_imports.dart';
import '../../../../../widgets/drop_down/custom_drop_down.dart';

class MoneyOutScreenMobile extends StatelessWidget {
  MoneyOutScreenMobile({super.key});

  final controller = Get.put(MoneyOutController());
  final formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimaryAppBar(Strings.moneyOut),
      body: Obx(
        () => controller.isLoading
            ? const CustomLoadingAPI()
            : _bodyWidget(context),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    return ListView(
      physics: const BouncingScrollPhysics(),
      children: [
        _inputFieldWidget(context),
        _paymentGatewayWidget(context),
        _customNumKeyBoardWidget(context),
        _buttonWidget(context)
      ],
    );
  }

  _inputFieldWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        right: Dimensions.marginSizeHorizontal * 0.5,
        top: Dimensions.marginSizeVertical * 2,
      ),
      alignment: Alignment.topCenter,
      height: Dimensions.inputBoxHeight,
      width: double.infinity,
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(width: Dimensions.widthSize * 0.7),
                Expanded(
                  child: Directionality(
                    textDirection: TextDirection.rtl,
                    child: TextFormField(
                      style: Get.isDarkMode
                          ? CustomStyle.lightHeading2TextStyle.copyWith(
                              fontSize: Dimensions.headingTextSize3 * 2,
                            )
                          : CustomStyle.darkHeading2TextStyle.copyWith(
                              color: CustomColor.primaryLightTextColor,
                              fontSize: Dimensions.headingTextSize3 * 2,
                            ),
                      readOnly: true,
                      controller: controller.amountTextController,
                      keyboardType:
                          const TextInputType.numberWithOptions(decimal: true),
                      inputFormatters: <TextInputFormatter>[
                        FilteringTextInputFormatter.allow(
                            RegExp(r'(^-?\d*\.?\d*)')),
                        LengthLimitingTextInputFormatter(
                          6,
                        ),
                      ],
                      validator: (String? value) {
                        if (value!.isEmpty) {
                          return Strings.pleaseFillOutTheField;
                        } else {
                          return null;
                        }
                      },
                      decoration: const InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                        errorBorder: InputBorder.none,
                        focusedErrorBorder: InputBorder.none,
                        contentPadding: EdgeInsets.zero,
                        hintText: '0.0',
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  width: Dimensions.widthSize * 0.5,
                ),
              ],
            ),
          ),
          SizedBox(
            width: Dimensions.widthSize * 0.7,
          ),
          currencyWidget(context),
        ],
      ),
    );
  }

  _customNumKeyBoardWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Dimensions.marginSizeVertical),
      child: GridView.count(
        physics: const NeverScrollableScrollPhysics(),
        crossAxisCount: 3,
        crossAxisSpacing: 10.0,
        mainAxisSpacing: 10.0,
        childAspectRatio: 3 / 1.5,
        shrinkWrap: true,
        children: List.generate(
          controller.keyboardItemList.length,
          (index) {
            return controller.inputItem(index);
          },
        ),
      ),
    );
  }

  _buttonWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: Dimensions.marginSizeHorizontal * 0.8,
        right: Dimensions.marginSizeHorizontal * 0.8,
        top: Platform.isAndroid ? Dimensions.marginSizeVertical * 1.8 : 0.0,
        bottom: Dimensions.marginSizeVertical,
      ),
      child: Row(
        children: [
          Expanded(
            child: Obx(
              () => controller.isInsertLoading
                  ? const CustomLoadingAPI()
                  : PrimaryButton(
                      title: Strings.moneyOut,
                      onPressed: () {
                        if (controller.selectedCurrencyType.value
                            .contains("AUTOMATIC")) {
                          controller.getMoneyOutAutomaticInsertProcess();
                        } else {
                          controller.getMoneyOutInsertProcess();
                        }
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }

  currencyWidget(BuildContext context) {
    return Chip(
      backgroundColor: Theme.of(context).primaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(Dimensions.radius * 2.5),
      ),
      label: TitleHeading3Widget(
        text: controller.baseCurrency.value,
        color: CustomColor.whiteColor,
        fontWeight: FontWeight.w600,
      ),
    );
  }

  _paymentGatewayWidget(BuildContext context) {
    return Column(
      children: [
        verticalSpace(Dimensions.heightSize * 0.5),
        TitleHeading5Widget(
          text:
              "${Strings.limit} ${controller.limitMin.value.toStringAsFixed(2)} ${controller.baseCurrency.value} - ${controller.limitMax.value.toStringAsFixed(2)} ${controller.baseCurrency.value} ",
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w500,
        ),
        verticalSpace(Dimensions.heightSize * 0.2),
        TitleHeading5Widget(
          text:
              "${Strings.feesAndCharge}: ${controller.fixedCharge.value.toStringAsFixed(2)} ${controller.currencyCode.value} + ${controller.percentCharge.value.toStringAsFixed(2)}%",
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w500,
        ),
        verticalSpace(Dimensions.heightSize * 0.2),
        TitleHeading5Widget(
          text:
              "${Strings.exchangeRate}: ${"1"} ${controller.baseCurrency.value} = ${controller.selectRate.value} ${controller.currencyCode.value} ",
          color: Theme.of(context).primaryColor,
          fontWeight: FontWeight.w500,
        ),
        Container(
          margin: EdgeInsets.only(top: Dimensions.marginSizeVertical * 1.8),
          height: Dimensions.inputBoxHeight * 0.6,
          child: Obx(() {
            return CustomDropDown<Currency>(
              isCurrencyDropDown: true,
              items: controller.currencyList,
              hint: controller.selectWallet.value,
              onChanged: (value) {
                controller.selectWallet.value = value!.title;
                controller.selectAlias.value = value.alias;
                controller.selectedCurrencyType.value = value.type;
                controller.selectRate.value = (double.parse(value.rate) /
                        double.parse(controller.baseCurrencyRate.value))
                    .toStringAsFixed(4);
                controller.limitMin.value = double.parse(value.minLimit);
                controller.exchangeRate.value =
                    double.parse(value.rate).toStringAsFixed(2);
                controller.limitMax.value = double.parse(value.maxLimit);
                controller.currencyCode.value = value.currencyCode;
                controller.fixedCharge.value = double.parse(value.fixedCharge);
                controller.percentCharge.value =
                    double.parse(value.percentCharge);
                debugPrint(
                    "---------------A: ${controller.selectWallet.value}, B: ${controller.selectAlias.value}, C: ${controller.selectedCurrencyType.value} ,D: ${controller.selectRate.value}-----------");
              },
              isExpanded: false,
              padding: EdgeInsets.only(
                left: Dimensions.paddingHorizontalSize * 0.25,
              ),
              titleTextColor: CustomColor.whiteColor,
              titleStyle: Get.isDarkMode
                  ? CustomStyle.lightHeading3TextStyle.copyWith(
                      fontWeight: FontWeight.w500,
                    )
                  : CustomStyle.darkHeading3TextStyle.copyWith(
                      fontWeight: FontWeight.w500,
                      color: CustomColor.whiteColor,
                    ),
              dropDownColor: Theme.of(context).primaryColor,
              dropDownFieldColor: Theme.of(context).primaryColor,
              dropDownIconColor: CustomColor.whiteColor,
              customBorderRadius: BorderRadius.circular(Dimensions.radius * 4),
            );
          }),
        ),
      ],
    );
  }
}
