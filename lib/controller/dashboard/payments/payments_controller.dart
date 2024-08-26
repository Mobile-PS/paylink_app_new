// ignore_for_file: avoid_function_literals_in_foreach_calls

import 'package:flutter/services.dart';
import 'package:paylink/controller/kyc_verification_controller/kyc_verification_controller.dart';
import 'package:paylink/extensions/custom_extensions.dart';

import '../../../../../../controller/dashboard/payments/upload_image_controller/upload_image_controller.dart';
import '../../../../../views/share_link/share_link_screen.dart';
import '../../../backend/model/common/common_success_model.dart';
import '../../../backend/model/payment_link/payment_link_model.dart';
import '../../../backend/model/payment_link/payment_link_store_model.dart';
import '../../../backend/services/api_services/payment_link/payment_link_api_services.dart';
import '../../../backend/utils/api_method.dart';
import '../../../model/drop_down_model/type_selection_drop_down.dart';
import '../../../routes/routes.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../widgets/others/custom_snack_bar.dart';

class PaymentsController extends GetxController {
  final imageController = Get.put(UploadImageController());
  final kycVerificationController = Get.put(KycVerificationController());
  final titleController = TextEditingController();

  final descriptionController = TextEditingController();
  final minimumAmountController = TextEditingController();
  final maximumAmountController = TextEditingController();

  final productsAndSubscriptionTitleController = TextEditingController();
  final amountController = TextEditingController();
  final quantityController = TextEditingController();
  final createNewLinkController = TextEditingController();
  final copyLinkController = TextEditingController();

  final RxString defaultImage = ''.obs;
  final RxString paymentImage = ''.obs;
  final RxString amount = ''.obs;
  RxBool setLimit = false.obs;
  RxString typeSelection = ''.obs;
  RxString currencySelection = ''.obs;
  RxInt selectedLinkId = 0.obs;

  get onPayments => Routes.paymentsScreen.toNamed;

  onCreateNewLink() {
    if (kycVerificationController.kycInfoModel.data.kycStatus == 0) {
      CustomSnackBar.error(Strings.kycUnverifiedText.tr);
    } else if (kycVerificationController.kycInfoModel.data.kycStatus == 2) {
      CustomSnackBar.error(Strings.kycPendingText.tr);
    } else if (kycVerificationController.kycInfoModel.data.kycStatus == 3) {
      CustomSnackBar.error(Strings.kycRejectedText.tr);
    } else {
      imageController.isImagePathSet.value
          ? paymentLinkStoreWithImageProcess()
          : paymentLinkStoreWithOutImageProcess();
    }
  }

  get onCopyTap => _onCopyTap();

  final List<CurrencyDatum> currencyList = [];
  RxString currencyCode = ''.obs;
  RxString currencySymbol = ''.obs;
  RxString currencyCountry = ''.obs;
  RxString currencyName = ''.obs;
  List<TypeSelectionModel> typeSelectionList = [
    TypeSelectionModel(
      Strings.customerChoose,
    ),
    TypeSelectionModel(
      Strings.productsOrSubscriptions,
    ),
  ];

  @override
  onInit() {
    super.onInit();
    getPaymentLinkProcess();
  }

  //=> set loading process & payment link Model
  final _isLoading = false.obs;
  late PaymentLinkModel _paymentLinkModel;

  //=> get loading process & payment link Model
  bool get isLoading => _isLoading.value;

  PaymentLinkModel get paymentLinkModel => _paymentLinkModel;

  //=> get payment link api Process
  Future<PaymentLinkModel> getPaymentLinkProcess() async {
    _isLoading.value = true;
    update();
    await PaymentLinkApiServices.getPaymentLinkProcessApi().then((value) {
      _paymentLinkModel = value!;
      _setData(_paymentLinkModel);
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _paymentLinkModel;
  }

  _setData(PaymentLinkModel paymentLinkModel) {
    defaultImage.value =
        "${_paymentLinkModel.data.baseUrl}/${_paymentLinkModel.data.defaultImage}";
    _paymentLinkModel.data.currencyData.forEach((element) {
      currencyList.add(CurrencyDatum(
        currencyName: element.currencyName,
        currencyCode: element.currencyCode,
        country: element.country,
        currencySymbol: element.currencySymbol,
      ));
      currencySelection.value = currencyList.first.currencyCode +
          '-' +
          currencyList.first.currencyName!;
      currencyCode.value = currencyList.first.currencyCode;
      currencySymbol.value = currencyList.first.currencySymbol;
      currencyCountry.value = currencyList.first.country;
      currencyName.value = currencyList.first.currencyName!;
    });
  }

  ///=> set loading process and  payment link Model
  final _isStatusLoading = false.obs;
  late CommonSuccessModel _commonSuccessModel;

  ///=> get loading process and  payment link Model
  bool get isStatusLoading => _isStatusLoading.value;

  CommonSuccessModel get commonSuccessModel => _commonSuccessModel;

  Future<CommonSuccessModel> updateStatusProcess({required dynamic id}) async {
    _isStatusLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'target': id,
    };
    await PaymentLinkApiServices.updatePaymentLinkStatusApi(body: inputBody)
        .then((value) {
      _commonSuccessModel = value!;
      _isStatusLoading.value = false;
      getPaymentLinkProcess();
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isStatusLoading.value = false;
    update();
    return _commonSuccessModel;
  }

  /// >> set loading process & Payment LinkStore Model
  final _isUpdateLoading = false.obs;
  late PaymentLinkStoreModel _paymentLinkStoreModel;

  /// >> get loading process & Payment LinkStore Model
  bool get isUpdateLoading => _isUpdateLoading.value;

  PaymentLinkStoreModel get paymentLinkStoreModel => _paymentLinkStoreModel;

  Future<PaymentLinkStoreModel> paymentLinkStoreWithImageProcess() async {
    _isUpdateLoading.value = true;
    update();

    Map<String, String> payInputBody = {
      'currency': currencyCode.value,
      'currency_name': currencyName.value,
      'currency_symbol': currencySymbol.value,
      'country': currencyCountry.value,
      'type': 'pay',
      'title': titleController.text,
      'details': descriptionController.text,
      'limit': setLimit.value == true ? 'on' : '',
      'min_amount': setLimit.value == true ? minimumAmountController.text : '',
      'max_amount': setLimit.value == true ? maximumAmountController.text : '',
    };

    Map<String, String> subInputBody = {
      'sub_currency': currencyCode.value,
      'currency_name': currencyName.value,
      'currency_symbol': currencySymbol.value,
      'country': currencyCountry.value,
      'type': 'sub',
      'sub_title': productsAndSubscriptionTitleController.text,
      'price': amountController.text,
      'qty': quantityController.text,
    };

    await PaymentLinkApiServices.paymentLinkStoreWithImageApi(
      body: typeSelection.value == Strings.customerChoose
          ? payInputBody
          : subInputBody,
      filepath: imageController.userImagePath.value,
    ).then((value) {
      _paymentLinkStoreModel = value!;
      createNewLinkController.text =
          _paymentLinkStoreModel.data.paymentLink.shareLink;
      _onCreateNewLink();
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isUpdateLoading.value = false;
    update();
    return _paymentLinkStoreModel;
  }

  //without image
  Future<PaymentLinkStoreModel> paymentLinkStoreWithOutImageProcess() async {
    _isUpdateLoading.value = true;
    update();

    Map<String, String> payInputBody = {
      'currency': currencyCode.value,
      'currency_name': currencyName.value,
      'currency_symbol': currencySymbol.value,
      'country': currencyCountry.value,
      'type': 'pay',
      'title': titleController.text,
      'details': descriptionController.text,
      'limit': setLimit.value == true ? 'on' : '',
      'min_amount': setLimit.value == true ? minimumAmountController.text : '',
      'max_amount': setLimit.value == true ? maximumAmountController.text : '',
    };
    Map<String, String> subInputBody = {
      'sub_currency': currencyCode.value,
      'currency_name': currencyName.value,
      'currency_symbol': currencySymbol.value,
      'country': currencyCountry.value,
      'type': 'sub',
      'sub_title': productsAndSubscriptionTitleController.text,
      'price': amountController.text,
      'qty': quantityController.text,
    };

    await PaymentLinkApiServices.paymentLinkStoreWithoutImageApi(
      body: typeSelection.value == Strings.customerChoose
          ? payInputBody
          : subInputBody,
    ).then((value) {
      _paymentLinkStoreModel = value!;
      createNewLinkController.text =
          _paymentLinkStoreModel.data.paymentLink.shareLink;
      _onCreateNewLink();
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isUpdateLoading.value = false;
    update();
    return _paymentLinkStoreModel;
  }

  _onCreateNewLink() {
    Get.to(
      () => ShareLinkScreen(
        title: Strings.paymentLinkCreatedSuccessfully.tr,
        controller: createNewLinkController,
        btnName: Strings.createAnotherLink.tr,
        onTap: () async {
          await Clipboard.setData(
            ClipboardData(text: createNewLinkController.text),
          );
          CustomSnackBar.success(Strings.linkCopiedSuccessfully.tr);
        },
        onButtonTap: () {
          Get.offAllNamed(Routes.paymentLogScreen);
        },
      ),
    );
  }

  _onCopyTap() async {
    await Clipboard.setData(
      ClipboardData(text: copyLinkController.text),
    );
    CustomSnackBar.success(Strings.linkCopiedSuccessfully.tr);
  }
}