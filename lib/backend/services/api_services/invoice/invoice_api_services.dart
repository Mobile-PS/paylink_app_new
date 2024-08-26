import 'package:paylink/backend/model/common/common_success_model.dart';
import 'package:paylink/backend/model/invoice/invoice_model.dart';

import '../../../../widgets/others/custom_snack_bar.dart';
import '../../../model/invoice/invoice_download_model.dart';
import '../../../model/invoice/invoice_edit_model.dart';
import '../../../model/invoice/invoice_store_model.dart';
import '../../../utils/api_method.dart';
import '../../api_endpoint.dart';

class InvoiceApiServices {
  ///* Get Invoice info process api
  static Future<InvoiceModel?> getInvoiceProcessApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        ApiEndpoint.invoiceGetURL,
        showResult: true,
        code: 200,
      );
      if (mapResponse != null) {
        InvoiceModel result = InvoiceModel.fromJson(mapResponse);

        return result;
      }
    } catch (e) {
      log.e(
          '🐞🐞🐞 err from  Get Invoice info process api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong! in Invoice Info Model');
      return null;
    }
    return null;
  }

  ///*************************** post Create Invoice process api ******************************/

  static Future<InvoiceStoreModel?> postInvoiceStoreApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false)
          .post(ApiEndpoint.invoiceStoreURL, body, code: 200);
      if (mapResponse != null) {
        InvoiceStoreModel result = InvoiceStoreModel.fromJson(mapResponse);
        CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e('err from post Invoice Store Api service ==> $e');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///*********************** post update Invoice status process api ***************************/
  static Future<CommonSuccessModel?> postUpdateInvoiceStatusApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false)
          .post(ApiEndpoint.invoiceStatusUpdateURL, body, code: 200);
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);
        CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e('err from post Invoice Status Update Api service ==> $e');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///************************** post invoice Delete api *****************************/

  static Future<CommonSuccessModel?> invoiceDeleteApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false)
          .post(ApiEndpoint.invoiceDeleteURL, body, code: 200);
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);
        CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e('err from invoice Delete Api service ==> $e');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///****************************** invoice edit get api ********************************** */
  ///* Get Invoice edit info process api
  static Future<InvoiceEditModel?> getInvoiceEditProcessApi(int target) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        "${ApiEndpoint.invoiceLinkEditGetURL}$target",
        code: 200,
      );
      if (mapResponse != null) {
        InvoiceEditModel result = InvoiceEditModel.fromJson(mapResponse);

        return result;
      }
    } catch (e) {
      log.e(
          '🐞🐞🐞 err from  Get Invoice info process api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong! in Invoice Info Model');
      return null;
    }
    return null;
  }

  ///**************************** post update Invoice process api ******************************/
  static Future<InvoiceStoreModel?> postInvoiceUpdateProcessApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false)
          .post(ApiEndpoint.invoiceLinkEditPostURL, body, code: 200);
      if (mapResponse != null) {
        InvoiceStoreModel result = InvoiceStoreModel.fromJson(mapResponse);
        CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e('err from post Invoice Update Api service ==> $e');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///****************************** invoice download api ********************************** */
  static Future<InvoiceDownloadModel?> getInvoiceDownloadProcessApi(
      int target) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false)
          .get("${ApiEndpoint.invoiceDownloadPostURL}$target", code: 200);
      if (mapResponse != null) {
        InvoiceDownloadModel result =
            InvoiceDownloadModel.fromJson(mapResponse);
        CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from post Invoice Download Api service ==>  $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong! in Invoice Download Model');
      return null;
    }
    return null;
  }
}
