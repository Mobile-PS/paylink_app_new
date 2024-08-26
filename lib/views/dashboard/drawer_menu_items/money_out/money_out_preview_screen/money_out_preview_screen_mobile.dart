import 'dart:io';

import 'package:paylink/widgets/others/information_amount_widget.dart';

import '../../../../../backend/utils/custom_loading_api.dart';
import '../../../../../controller/drawer/money_out_controller/money_out_controller.dart';
import '../../../../../utils/basic_screen_imports.dart';

class MoneyOutPreviewScreenMobile extends StatelessWidget {
  MoneyOutPreviewScreenMobile({super.key});

  final controller = Get.put(MoneyOutController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimaryAppBar(
        Strings.preview,
      ),
      body: _bodyWidget(context),
    );
  }

  _bodyWidget(BuildContext context) {
    return ListView(
      physics: const AlwaysScrollableScrollPhysics(),
      children: [
        _enteredAmountWidget(context),
        _amountInformationWidget(context),
        _buttonWidget(context),
      ],
    );
  }

  _enteredAmountWidget(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: Dimensions.marginSizeHorizontal * 0.5,
        right: Dimensions.marginSizeHorizontal * 0.5,
      ),
      height: MediaQuery.sizeOf(context).height * 0.15,
      width: double.infinity,
      decoration: BoxDecoration(
        color: CustomColor.whiteColor,
        borderRadius: BorderRadius.circular(Dimensions.radius * 2),
        boxShadow: [
          BoxShadow(
            color: CustomColor.blackColor.withOpacity(0.1),
            spreadRadius: 1,
            blurRadius: 1,
            offset: const Offset(0, 1),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          TitleHeading1Widget(
            text: "${controller.amountTextController.text} ${controller.baseCurrency.value}",
            textAlign: TextAlign.center,
            fontSize: Dimensions.headingTextSize1 + 4,
            color: CustomColor.primaryLightColor,
          ),
          verticalSpace(Dimensions.heightSize * 0.5),
          TitleHeading5Widget(
            text: Strings.enteredAmount,
            fontWeight: FontWeight.w500,
            fontSize: Dimensions.headingTextSize4,
            textAlign: TextAlign.center,
            opacity: 0.5,
          ),
        ],
      ),
    );
  }

  _amountInformationWidget(BuildContext context) {
    return amountInformationWidget(
        information: Strings.amountInformation,
        enterAmount: Strings.enterAmount,
        enterAmountRow:" ${controller.amountTextController.text} ${controller.baseCurrency.value}",
        fee: Strings.transferFee,
        feeRow: controller.transferFee.value,
        received: Strings.youWillGet,
        receivedRow: controller.youWillGet.value,
        total: Strings.totalPayable,
        totalRow: controller.payAble.value);
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
              () => controller.isConfirmLoading
                  ? const CustomLoadingAPI()
                  : PrimaryButton(
                      title: Strings.confirm.tr,
                      onPressed: () {
                        controller.moneyOutConfirmProcess();
                      },
                    ),
            ),
          ),
        ],
      ),
    );
  }
}