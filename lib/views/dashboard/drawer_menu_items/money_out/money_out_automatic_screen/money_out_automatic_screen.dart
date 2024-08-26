import 'package:paylink/backend/utils/custom_loading_api.dart';

import '../../../../../widgets/inputs/primary_input_widget.dart';
import '/backend/model/money_out/money_out_bank_info_model.dart';

import '../../../../../controller/drawer/money_out_controller/money_out_controller.dart';
import '../../../../../utils/basic_screen_imports.dart';
import '../../../../../widgets/drop_down/custom_drop_down.dart';

class MoneyOutAutomaticInsertScreen extends StatelessWidget {
  MoneyOutAutomaticInsertScreen({super.key});

  final controller = Get.put(MoneyOutController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PrimaryAppBar(Strings.evidenceNote),
      body: Obx(() => controller.isBankLoading
          ? const CustomLoadingAPI()
          : _bodyWidget(context)),
    );
  }

  _bodyWidget(BuildContext context) {
    return ListView(
      padding: EdgeInsets.symmetric(horizontal: Dimensions.widthSize * 1.5),
      children: [
        Column(
          children: [
            _customDropDown(context),
            verticalSpace(Dimensions.heightSize * 2),
            PrimaryInputWidget(
              controller: controller.accountNumberController,
              hintText: Strings.enterAccountNumber,
              label: Strings.accountNumber,
              fillColor: CustomColor.whiteColor,
              textInputType: TextInputType.text,
            ),
            verticalSpace(Dimensions.heightSize * 3.33),
            _buttonWidget(context),
          ],
        ),
      ],
    );
  }

  _customDropDown(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(top: Dimensions.marginSizeVertical * 1.8),
      height: Dimensions.inputBoxHeight * 0.6,
      child: Obx(() {
        return CustomDropDown<BankInfo>(
          isCurrencyDropDown: true,
          items: controller.bankInfoList,
          hint: controller.selectBank.value,
          onChanged: (value) {
            controller.selectBank.value = value!.title;
            controller.selectBankCode.value = value.code;
            controller.selectBankId.value = value.id.toString();
          },
          isExpanded: true,
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
    );
  }

  _buttonWidget(BuildContext context) {
    return Obx(
      () => controller.isAutomaticConfirmLoading
          ? const CustomLoadingAPI()
          : PrimaryButton(
              title: Strings.moneyOut,
              onPressed: () {
                controller.moneyOutAutomaticConfirmProcess();
              },
            ),
    );
  }
}
