import 'dart:io';

import 'package:flutter/services.dart';
import 'package:http/http.dart' as http;
import 'package:path_provider/path_provider.dart';
import 'package:paylink/backend/model/invoice/invoice_items_model.dart';
import 'package:paylink/backend/model/invoice/invoice_model.dart';
import 'package:paylink/backend/services/api_services/invoice/invoice_api_services.dart';
import 'package:paylink/controller/kyc_verification_controller/kyc_verification_controller.dart';
import 'package:permission_handler/permission_handler.dart';

import '../../../../extensions/custom_extensions.dart';
import '../../../backend/model/common/common_success_model.dart';
import '../../../backend/model/invoice/invoice_download_model.dart';
import '../../../backend/model/invoice/invoice_edit_model.dart';
import '../../../backend/model/invoice/invoice_store_model.dart';
import '../../../backend/services/api_endpoint.dart';
import '../../../backend/utils/api_method.dart';
import '../../../routes/routes.dart';
import '../../../utils/basic_screen_imports.dart';
import '../../../utils/basic_widget_imports.dart';
import '../../../views/share_link/share_link_screen.dart';
import '../../../widgets/others/custom_snack_bar.dart';

class InvoiceController extends GetxController {
  final kycVerificationController = Get.put(KycVerificationController());
  RxString currencySelection = ''.obs;

  final titleController = TextEditingController();
  final nameController = TextEditingController();
  final emailController = TextEditingController();
  final phoneNumberController = TextEditingController();
  final quantityController = TextEditingController();
  final priceController = TextEditingController();
  final copyInvoiceLinkController = TextEditingController();
  final invoiceId = TextEditingController();
  final invoiceStatusUnpaid = TextEditingController();
  final invoiceDownloadController = TextEditingController();
  late String pdfFileName;

  get onCreateInvoice => Routes.invoiceScreen.toNamed;

  createInvoice() {
    if (kycVerificationController.kycInfoModel.data.kycStatus == 0) {
      CustomSnackBar.error(Strings.kycUnverifiedText.tr);
    } else if (kycVerificationController.kycInfoModel.data.kycStatus == 2) {
      CustomSnackBar.error(Strings.kycPendingText.tr);
    } else if (kycVerificationController.kycInfoModel.data.kycStatus == 3) {
      CustomSnackBar.error(Strings.kycRejectedText.tr);
    } else {
      invoiceStoreProcess();
    }
  }

  get onEditInvoice => invoiceUpdateProcess();

  get onPublishInvoice => _onPublishInvoice();

  get onCopyInvoice => _onCopyInvoice();

  final List<CurrencyDatum> currencyList = [];
  RxString currencyCode = ''.obs;
  RxString currencySymbol = ''.obs;
  RxString currencyCountry = ''.obs;
  RxString currencyName = ''.obs;
  RxInt selectedInvoiceLinkId = 0.obs;

  final RxList<InvoiceItemModel> invoiceItems = <InvoiceItemModel>[].obs;

  void addItem() {
    invoiceItems.add(InvoiceItemModel());
  }

  void removeItem(int index) {
    invoiceItems.removeAt(index);
    update();
  }

  int get totalItems => invoiceItems.fold(
      0,
      (total, item) =>
          total + (int.tryParse(item.quantityController.text) ?? 0));

  double get totalPrice => invoiceItems.fold(
      0.0,
      (total, item) =>
          total +
          (double.tryParse(item.priceController.text) ?? 0.0) *
              (int.tryParse(item.quantityController.text) ?? 0));

  @override
  void onInit() {
    getInvoiceProcess();
    super.onInit();
  }

  onDownloadInvoice() async {
    await getInvoiceDownloadProcess();
    await downloadPDF(url: invoiceDownloadController.text);
  }

  ///=>************************** get invoice api (for invoice log) ***********************************/

  //=> set loading process & Invoice Model
  final _isLoading = false.obs;
  late InvoiceModel _invoiceModel;

  //=> get loading process & Invoice Model
  bool get isLoading => _isLoading.value;

  InvoiceModel get invoiceModel => _invoiceModel;

  //=> get Invoice  api Process
  Future<InvoiceModel> getInvoiceProcess() async {
    _isLoading.value = true;
    update();
    await InvoiceApiServices.getInvoiceProcessApi().then((value) {
      _invoiceModel = value!;
      _setData(_invoiceModel);
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _invoiceModel;
  }

  _setData(InvoiceModel invoiceModel) {
    currencyList.clear();
    for (var element in _invoiceModel.data.currencyData) {
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
      invoiceStatusUnpaid.text = _invoiceModel.data.status.unpaid.toString();
      debugPrint(
          "........ ${_invoiceModel.data.currencyData.first.currencySymbol}");
    }
  }

  _onPublishInvoice() {
    updateStatusProcess();
  }

  _onCopyInvoice() async {
    await Clipboard.setData(
      ClipboardData(text: copyInvoiceLinkController.text),
    );
    CustomSnackBar.success(Strings.linkCopiedSuccessfully.tr);
  }

  ///****************************** invoice store or in another word create post api process  ********************************** */
  /// >> set Invoice Store loading process & Invoice Store Model
  final _isInvoiceStoreLoading = false.obs;
  late InvoiceStoreModel _invoiceStoreModel;

  /// >> get Invoice Store loading process & Invoice Store Model
  bool get isInvoiceStoreLoading => _isInvoiceStoreLoading.value;

  InvoiceStoreModel get invoiceStoreModel => _invoiceStoreModel;

  ///* Invoice Store process or in another word create invoice process
  Future<InvoiceStoreModel> invoiceStoreProcess() async {
    _isInvoiceStoreLoading.value = true;
    update();
    final List<String> itemTitles =
        invoiceItems.map((item) => item.titleController.text).toList();
    final List<String> itemQuantities =
        invoiceItems.map((item) => item.quantityController.text).toList();
    final List<String> itemPrices =
        invoiceItems.map((item) => item.priceController.text).toList();
    Map<String, dynamic> inputBody = {
      'currency': currencyCode.value,
      'currency_name': currencyName.value,
      'currency_symbol': currencySymbol.value,
      'country': currencyCountry.value,
      'title': titleController.text,
      'name': nameController.text,
      'email': emailController.text,
      'phone': phoneNumberController.text,
      'total_qty': totalItems,
      'total_price': totalPrice,
      'item_title': itemTitles.join(', '),
      'item_qty': itemQuantities.join(', '),
      'item_price': itemPrices.join(', '),
    };
    await InvoiceApiServices.postInvoiceStoreApi(body: inputBody).then((value) {
      _invoiceStoreModel = value!;
      _isInvoiceStoreLoading.value = false;
      _setInvoiceStoreData(_invoiceStoreModel);
      Get.toNamed(Routes.previewScreen);
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isInvoiceStoreLoading.value = false;
    update();
    return _invoiceStoreModel;
  }

  _setInvoiceStoreData(InvoiceStoreModel invoiceStoreModel) {
    copyInvoiceLinkController.text =
        "${ApiEndpoint.mainDomain}/invoice/share/${_invoiceStoreModel.data.invoice.token}";
    invoiceId.text = _invoiceStoreModel.data.invoice.id.toString();
  }

  ///=> set loading process and  invoice  Model
  final _isStatusLoading = false.obs;
  late CommonSuccessModel _commonSuccessModel;

  ///=> get loading process and  payment link Model
  bool get isStatusLoading => _isStatusLoading.value;

  CommonSuccessModel get commonSuccessModel => _commonSuccessModel;

  Future<CommonSuccessModel> updateStatusProcess() async {
    _isStatusLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'target': invoiceId.text,
      'status': invoiceStatusUnpaid.text,
    };
    await InvoiceApiServices.postUpdateInvoiceStatusApi(body: inputBody)
        .then((value) {
      _commonSuccessModel = value!;
      _isStatusLoading.value = false;
      _goToShareLinkScreen();
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isStatusLoading.value = false;
    update();
    return _commonSuccessModel;
  }

  ///****************************** invoice delete post api process  ********************************** */

  ///=> set loading process and  payment link Model
  final _isDeleteLoading = false.obs;
  late CommonSuccessModel _invoiceDeleteModel;

  ///=> get loading process and  payment link Model
  bool get isDeleteLoading => _isDeleteLoading.value;

  CommonSuccessModel get invoiceDeleteModel => _invoiceDeleteModel;

  Future<CommonSuccessModel> deleteInvoiceProcess({required dynamic id}) async {
    _isDeleteLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      'target': id,
    };
    await InvoiceApiServices.invoiceDeleteApi(body: inputBody).then((value) {
      _invoiceDeleteModel = value!;
      _isDeleteLoading.value = false;
      getInvoiceProcess();
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isDeleteLoading.value = false;
    update();
    return _invoiceDeleteModel;
  }

  ///****************************** invoice edit get api ********************************** */
  //=> set loading process & invoice link edit Model
  final _isEditLoading = false.obs;
  late InvoiceEditModel _invoiceEditModel;

  //=> get loading process & invoice link edit Model
  bool get isEditLoading => _isEditLoading.value;

  InvoiceEditModel get invoiceLinkEditModel => _invoiceEditModel;

  Future<InvoiceEditModel?> getInvoiceLinkEditProcess() async {
    _isEditLoading.value = true;
    update();
    await InvoiceApiServices.getInvoiceEditProcessApi(
      selectedInvoiceLinkId.value,
    ).then((value) {
      _invoiceEditModel = value!;
      _isEditLoading.value = false;
      _setInvoiceEditData(_invoiceEditModel);
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isEditLoading.value = false;
    update();
    return _invoiceEditModel;
  }

  _setInvoiceEditData(InvoiceEditModel invoiceEditModel) {
    invoiceItems.clear();
    for (var element in _invoiceModel.data.currencyData) {
      currencyList.add(CurrencyDatum(
        currencyName: element.currencyName,
        currencyCode: element.currencyCode,
        country: element.country,
        currencySymbol: element.currencySymbol,
      ));
    }
    var data = invoiceEditModel.data.invoice;
    titleController.text = data.title;

    nameController.text = data.name;
    emailController.text = data.email;
    phoneNumberController.text = data.phone;
    currencySelection.value = '${data.currency}-${data.currencyName}';
    currencyCode.value = data.currency;
    currencySymbol.value = data.currencySymbol;
    currencyCountry.value = data.country;
    currencyName.value = data.currencyName;
    for (var element in data.invoiceItems) {
      invoiceItems.add(
        InvoiceItemModel(
          title: element.title,
          quantity: element.qty,
          price: double.parse(element.price),
        ),
      );
    }
  }

  ///******************************************* invoice update process method ************************************************** */

  ///* Invoice update process or in another word  invoice edit process
  Future<InvoiceStoreModel> invoiceUpdateProcess() async {
    _isInvoiceStoreLoading.value = true;
    update();
    final List<String> itemTitles =
        invoiceItems.map((item) => item.titleController.text).toList();
    final List<String> itemQuantities =
        invoiceItems.map((item) => item.quantityController.text).toList();
    final List<String> itemPrices =
        invoiceItems.map((item) => item.priceController.text).toList();
    Map<String, dynamic> inputBody = {
      'target': selectedInvoiceLinkId.value,
      'currency': currencyCode.value,
      'currency_name': currencyName.value,
      'currency_symbol': currencySymbol.value,
      'country': currencyCountry.value,
      'title': titleController.text,
      'name': nameController.text,
      'email': emailController.text,
      'phone': phoneNumberController.text,
      'total_qty': totalItems,
      'total_price': totalPrice,
      'item_title': itemTitles.join(', '),
      'item_qty': itemQuantities.join(', '),
      'item_price': itemPrices.join(', '),
    };
    await InvoiceApiServices.postInvoiceUpdateProcessApi(body: inputBody)
        .then((value) {
      _invoiceStoreModel = value!;

      _setInvoiceUpdateData(_invoiceStoreModel);

      Get.toNamed(Routes.previewScreen);
      _isInvoiceStoreLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isInvoiceStoreLoading.value = false;
    update();
    return _invoiceStoreModel;
  }

  _setInvoiceUpdateData(InvoiceStoreModel invoiceUpdateModel) {
    copyInvoiceLinkController.text =
        "${ApiEndpoint.mainDomain}/payment-link/share/${_invoiceStoreModel.data.invoice.token}";
    invoiceId.text = _invoiceStoreModel.data.invoice.id.toString();
  }

  ///****************************** download pdf get api process  ***********************************/
  final _isDownloadLoading = false.obs;
  late InvoiceDownloadModel _invoiceDownloadModel;

  //=> get loading process and  invoice download Model
  bool get isDownloadLoading => _isDownloadLoading.value;

  InvoiceDownloadModel get invoiceDownloadModel => _invoiceDownloadModel;

  Future<InvoiceDownloadModel?> getInvoiceDownloadProcess() async {
    _isDownloadLoading.value = true;
    update();
    await InvoiceApiServices.getInvoiceDownloadProcessApi(
            selectedInvoiceLinkId.value)
        .then((value) {
      _invoiceDownloadModel = value!;
      _isDownloadLoading.value = false;
      _setInvoiceDownloadData(_invoiceDownloadModel);
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isDownloadLoading.value = false;
    update();
    return _invoiceDownloadModel;
  }

  _setInvoiceDownloadData(InvoiceDownloadModel invoiceDownloadModel) {
    invoiceDownloadController.text = _invoiceDownloadModel.data.downloadUrl;
  }

  _goToShareLinkScreen() {
    Get.to(
      () => ShareLinkScreen(
        title: Strings.invoiceCreatedSuccessfully.tr,
        controller: copyInvoiceLinkController,
        btnName: Strings.createAnotherInvoice.tr,
        onTap: () async {
          await Clipboard.setData(
            ClipboardData(text: copyInvoiceLinkController.text),
          );
          CustomSnackBar.success(Strings.linkCopiedSuccessfully.tr);
        },
        onButtonTap: () {
          getInvoiceProcess();
          Get.offAllNamed(Routes.invoiceLogScreen);
        },
      ),
    );
  }

  Future<void> downloadPDF({required String url}) async {
    // Check and request storage permission
    var status = await Permission.storage.status;
    if (!status.isGranted) {
      status = await Permission.storage.request();
      if (!status.isGranted) {
        // Permission denied by user
        CustomSnackBar.error('Permission denied. Unable to download the file.');
        return;
      }
    }
    final http.Response response = await http.get(Uri.parse(url));
    final String fileName = '${DateTime.now().millisecondsSinceEpoch}.pdf';
    // Keep the file name in the global variable pdfFilename
    pdfFileName = fileName;
    if (response.statusCode == 200) {
      Directory? downloadsDirectory = await getExternalStorageDirectory();
      if (downloadsDirectory != null) {
        final File file = File('${downloadsDirectory.path}/$pdfFileName');
        try {
          await file.writeAsBytes(response.bodyBytes);
          CustomSnackBar.success(
              'File downloaded successfully at ${file.path}!');
        } catch (e) {
          CustomSnackBar.error('Failed to write the file: $e');
        }
      } else {
        CustomSnackBar.error('Failed to get the downloads directory.');
      }
    } else {
      CustomSnackBar.error(
          'Failed to download the file. Status Code: ${response.statusCode}');
    }
  }
}
