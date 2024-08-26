import 'package:flutter/services.dart';

import '../../../backend/model/common/common_success_model.dart';
import '../../../backend/model/money_out/money_out_bank_info_model.dart';
import '../../../backend/model/money_out/money_out_info_model.dart';
import '../../../backend/model/money_out/money_out_insert_model.dart';
import '../../../backend/services/api_services/money_out/money_out_api_services.dart';
import '../../../backend/utils/api_method.dart';
import '../../../backend/utils/custom_snackbar.dart';
import '../../../routes/routes.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../views/congratulation/congratulation_screen.dart';
import '../../../widgets/inputs/manual_payment_image_widget.dart';
import '../../../widgets/inputs/primary_input_widget.dart';
import '../../kyc_verification_controller/kyc_verification_controller.dart';

class MoneyOutController extends GetxController {
  final kycVerificationController = Get.put(KycVerificationController());
  final amountTextController = TextEditingController();
  RxString selectWallet = ''.obs;
  RxString selectAlias = ''.obs;
  RxString currencyCode = ''.obs;
  RxString selectedCurrencyType = ''.obs;
  RxString selectRate = ''.obs;
  RxDouble limitMin = 0.0.obs;
  RxDouble limitMax = 0.0.obs;
  RxDouble fixedCharge = 0.0.obs;
  RxString transferFee = ''.obs;
  RxString youWillGet = ''.obs;
  RxString payAble = ''.obs;
  RxString baseCurrencyRate = ''.obs;
  RxString trx = ''.obs;
  RxString transactionId = ''.obs;
  RxString accountName = ''.obs;
  RxString accountNumber = ''.obs;

  RxDouble percentCharge = 0.0.obs;
  List<String> totalAmount = [];
  List<Currency> currencyList = [];
  RxString baseCurrency = ''.obs;
  RxString exchangeRate = ''.obs;
  List<TextEditingController> inputFieldControllers = [];
  RxList inputFields = [].obs;
  List<String> listImagePath = [];
  List<String> listFieldName = [];
  RxBool hasFile = false.obs;

  List<String> keyboardItemList = [
    '1',
    '2',
    '3',
    '4',
    '5',
    '6',
    '7',
    '8',
    '9',
    '.',
    '0',
    '<'
  ];

  inputItem(int index) {
    return InkWell(
      overlayColor: MaterialStateProperty.all(Colors.transparent),
      onLongPress: () {
        if (index == 11) {
          if (totalAmount.isNotEmpty) {
            totalAmount.clear();
            amountTextController.text = totalAmount.join('');
          } else {
            return;
          }
        }
      },
      onTap: () {
        if (index == 11) {
          if (totalAmount.isNotEmpty) {
            totalAmount.removeLast();
            amountTextController.text = totalAmount.join('');
          } else {
            return;
          }
        } else {
          if (totalAmount.contains('.') && index == 9) {
            return;
          } else {
            totalAmount.add(keyboardItemList[index]);
            amountTextController.text = totalAmount.join('');
            debugPrint(totalAmount.join(''));
          }
        }
      },
      child: Center(
        child: CustomTitleHeadingWidget(
          text: keyboardItemList[index],
          style: Get.isDarkMode
              ? CustomStyle.lightHeading2TextStyle.copyWith(
                  fontSize: Dimensions.headingTextSize3 * 2,
                )
              : CustomStyle.darkHeading2TextStyle.copyWith(
                  color: CustomColor.primaryLightTextColor,
                  fontSize: Dimensions.headingTextSize3 * 2,
                ),
        ),
      ),
    );
  }

  @override
  void onInit() {
    getMoneyOutInfoProcess();
    amountTextController.clear();
    super.onInit();
  }

  moneyOutConfirmProcess() {
    if (kycVerificationController.kycInfoModel.data.kycStatus == 0) {
      CustomSnackBar.error(Strings.kycUnverifiedText.tr);
    } else if (kycVerificationController.kycInfoModel.data.kycStatus == 2) {
      CustomSnackBar.error(Strings.kycPendingText.tr);
    } else if (kycVerificationController.kycInfoModel.data.kycStatus == 3) {
      CustomSnackBar.error(Strings.kycRejectedText.tr);
    } else {
      confirmProcess();
    }
  }

  /// >> set loading process & money out Info Model
  final _isLoading = false.obs;
  late MoneyOutInfoModel _moneyOutInfoModel;

  /// >> get loading process & Profile Info Model
  bool get isLoading => _isLoading.value;

  MoneyOutInfoModel get profileInfoModel => _moneyOutInfoModel;

  ///* Get Money Out Info api process
  Future<MoneyOutInfoModel> getMoneyOutInfoProcess() async {
    _isLoading.value = true;
    update();

    await MoneyOutApiServices.getMoneyOutInfoProcessApi().then((value) {
      _moneyOutInfoModel = value!;

      _setData(_moneyOutInfoModel);
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isLoading.value = false;
    update();
    return _moneyOutInfoModel;
  }

  void _setData(MoneyOutInfoModel moneyOutInfoModel) {
    var data = moneyOutInfoModel.data;
    selectWallet.value = data.gateways.first.name;
    currencyCode.value = data.gateways.first.currencies.first.currencyCode;
    selectAlias.value = data.gateways.first.currencies.first.alias;
    selectedCurrencyType.value = data.gateways.first.currencies.first.type;
    baseCurrencyRate.value = data.baseCurrRate;
    selectRate.value =
        (double.parse(data.gateways.first.currencies.first.rate) /
                double.parse(data.baseCurrRate))
            .toStringAsFixed(4);
    limitMin.value =
        double.parse(data.gateways.first.currencies.first.minLimit);
    limitMax.value =
        double.parse(data.gateways.first.currencies.first.maxLimit);
    exchangeRate.value = double.parse(data.gateways.first.currencies.first.rate)
        .toStringAsFixed(2);
    fixedCharge.value =
        double.parse(data.gateways.first.currencies.first.fixedCharge);
    percentCharge.value =
        double.parse(data.gateways.first.currencies.first.percentCharge);

    baseCurrency.value = data.baseCurr;

    for (var element in _moneyOutInfoModel.data.gateways) {
      for (var element in element.currencies) {
        currencyList.add(
          Currency(
            id: element.id,
            paymentGatewayId: element.paymentGatewayId,
            type: element.type,
            name: element.name,
            alias: element.alias,
            currencyCode: element.currencyCode,
            currencySymbol: element.currencySymbol,
            image: element.image,
            minLimit: element.minLimit,
            maxLimit: element.maxLimit,
            percentCharge: element.percentCharge,
            fixedCharge: element.fixedCharge,
            rate: element.rate,
          ),
        );
      }
    }
  }

  /// >> set loading process & money out insert Model
  final _isInsertLoading = false.obs;
  late MoneyOutInsertModel _moneyOutInsertModel;

  /// >> get loading process & Money out insert Model
  bool get isInsertLoading => _isInsertLoading.value;

  MoneyOutInsertModel get moneyOutInsertModel => _moneyOutInsertModel;

  ///* Get Money Out Insert api process
  Future<MoneyOutInsertModel> getMoneyOutInsertProcess() async {
    _isInsertLoading.value = true;
    inputFields.clear();

    update();

    await MoneyOutApiServices.getMoneyOutInsertProcessApi(body: {
      "amount": amountTextController.text,
      "gateway": selectAlias.value,
    }).then((value) {
      _moneyOutInsertModel = value!;
      _setInsertData(_moneyOutInsertModel);
      _isInsertLoading.value = false;
      Get.toNamed(Routes.moneyOutManualScreen);
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isInsertLoading.value = false;
    update();
    return _moneyOutInsertModel;
  }

  void _setInsertData(MoneyOutInsertModel moneyOutInsertModel) {
    var data = _moneyOutInsertModel.data;
    trx.value = data.paymentInformation.trx;
    transferFee.value = data.paymentInformation.totalCharge;
    youWillGet.value = data.paymentInformation.willGet;
    payAble.value = data.paymentInformation.payable;

    for (int item = 0; item < data.inputFields.length; item++) {
      var textEditingController = TextEditingController();
      inputFieldControllers.add(textEditingController);
      if (data.inputFields[item].type.contains('file')) {
        hasFile.value = true;
        inputFields.add(
          Padding(
            padding: const EdgeInsets.only(bottom: 8.0),
            child: ManualPaymentImageWidget(
              labelName: data.inputFields[item].label,
              fieldName: data.inputFields[item].name,
            ),
          ),
        );
      } else if (data.inputFields[item].type.contains('text') ||
          data.inputFields[item].type.contains('textarea')) {
        inputFields.add(
          Column(
            children: [
              Padding(
                padding: EdgeInsets.only(
                    left: Dimensions.widthSize,
                    right: Dimensions.widthSize,
                    top: Dimensions.heightSize * 0.5),
                child: PrimaryInputWidget(
                  controller: inputFieldControllers[item],
                  label: data.inputFields[item].label,
                  hintText: data.inputFields[item].label,
                  isValidator: data.inputFields[item].required,
                  fillColor: CustomColor.whiteColor,
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(int.parse(
                        data.inputFields[item].validation.max.toString())),
                  ],
                ),
              ),
            ],
          ),
        );
      }
    }
  }

  /// >> set loading process & money out insert Model
  final _isInsertAutomaticLoading = false.obs;
  late MoneyOutInsertModel _moneyOutAutomaticInsertModel;

  /// >> get loading process & Money out insert Model
  bool get isAutomaticInsertLoading => _isInsertAutomaticLoading.value;

  MoneyOutInsertModel get moneyOutAutomaticInsertModel =>
      _moneyOutAutomaticInsertModel;

  ///* Get Money Out Insert api process
  Future<MoneyOutInsertModel> getMoneyOutAutomaticInsertProcess() async {
    _isInsertAutomaticLoading.value = true;
    inputFields.clear();

    update();

    await MoneyOutApiServices.getMoneyOutInsertProcessApi(body: {
      "amount": amountTextController.text,
      "gateway": selectAlias.value,
    }).then((value) {
      _moneyOutAutomaticInsertModel = value!;
      getMoneyOutBankInfoProcess(
          _moneyOutAutomaticInsertModel.data.paymentInformation.trx);
      _isInsertAutomaticLoading.value = false;
      Get.toNamed(Routes.moneyOutAutomaticScreen);
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isInsertAutomaticLoading.value = false;
    update();
    return _moneyOutAutomaticInsertModel;
  }

  final accountNumberController = TextEditingController();

  /// >> set loading process & money out insert Model
  final _isAutomaticConfirmLoading = false.obs;
  late CommonSuccessModel _moneyOutAutomaticConfirmModel;

  /// >> get loading process & Money out insert Model
  bool get isAutomaticConfirmLoading => _isAutomaticConfirmLoading.value;

  CommonSuccessModel get moneyOutAutomaticConfirmModel =>
      _moneyOutAutomaticConfirmModel;

  ///* Get Money Out Insert api process
  Future<CommonSuccessModel> moneyOutAutomaticConfirmProcess() async {
    _isAutomaticConfirmLoading.value = true;
    inputFields.clear();
    update();
    await MoneyOutApiServices.moneyOutAutomaticConfirmApi(body: {
      "trx": _moneyOutAutomaticInsertModel.data.paymentInformation.trx,
      "bank_name": selectBankCode.value,
      "account_number": accountNumberController.text,
    }).then((value) {
      _moneyOutAutomaticConfirmModel = value!;
      _isAutomaticConfirmLoading.value = false;
      goToCongratulationScreen();
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isAutomaticConfirmLoading.value = false;
    update();
    return _moneyOutAutomaticConfirmModel;
  }

  final _isConfirmLoading = false.obs;

  bool get isConfirmLoading => _isConfirmLoading.value;

  //! ---------------------------- Add Money Manual Payment Process -------------------------
  late CommonSuccessModel _manualPaymentConfirmModel;

  CommonSuccessModel get manualPaymentConfirmModel =>
      _manualPaymentConfirmModel;

  Future<CommonSuccessModel> confirmProcess() async {
    _isConfirmLoading.value = true;
    Map<String, String> inputBody = {
      'trx': trx.value,
    };
    final data = moneyOutInsertModel.data.inputFields;
    for (int i = 0; i < data.length; i += 1) {
      if (data[i].type != 'file') {
        inputBody[data[i].name] = inputFieldControllers[i].text;
      }
    }
    await MoneyOutApiServices.withdrawSubmitApi(
            body: inputBody, fieldList: listFieldName, pathList: listImagePath)
        .then((value) {
      _manualPaymentConfirmModel = value!;
      //_goToSuccessScreen(context);
      goToCongratulationScreen();
      _isConfirmLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isConfirmLoading.value = false;
    update();
    return _manualPaymentConfirmModel;
  }

  List<BankInfo> bankInfoList = [];
  RxString selectBank = ''.obs;
  RxString selectBankCode = ''.obs;
  RxString selectBankId = ''.obs;

  /// >> set loading process & money out Info Model
  final _isBankInfoLoading = false.obs;
  late MoneyOutBankInfoModel _moneyOutBankInfoModel;

  /// >> get loading process & Profile Info Model
  bool get isBankLoading => _isBankInfoLoading.value;

  MoneyOutBankInfoModel get bankInfoModel => _moneyOutBankInfoModel;

  ///* Get Money Out Info api process
  Future<MoneyOutBankInfoModel> getMoneyOutBankInfoProcess(String trx) async {
    _isBankInfoLoading.value = true;
    update();

    await MoneyOutApiServices.getBankInfoApi(trx).then((value) {
      _moneyOutBankInfoModel = value!;
      selectBank.value = _moneyOutBankInfoModel.message.bankInfo.first.name;
      for (var element in bankInfoModel.message.bankInfo) {
        bankInfoList.add(
            BankInfo(id: element.id, code: element.code, name: element.name));
      }
      _isBankInfoLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isBankInfoLoading.value = false;
    update();
    return _moneyOutBankInfoModel;
  }

  void goToCongratulationScreen() {
    Get.to(
      () => CongratulationScreen(
        route: Routes.dashboardScreen,
        subTitle: Strings.requestSentSuccessfully,
        title: Strings.congratulations,
        onWillPop: () async {
          Get.offNamed(Routes.dashboardScreen);
          return true;
        },
      ),
    );
  }
}
