import 'package:paylink/backend/model/money_out/money_out_info_model.dart';

import '../../../../widgets/others/custom_snack_bar.dart';
import '../../../model/common/common_success_model.dart';
import '../../../model/money_out/money_out_bank_info_model.dart';
import '../../../model/money_out/money_out_insert_model.dart';
import '../../../utils/api_method.dart';
import '../../api_endpoint.dart';

class MoneyOutApiServices{
  ///* Get money out info process api
  static Future<MoneyOutInfoModel?> getMoneyOutInfoProcessApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        ApiEndpoint.moneyOutGetURL,
        code: 200,
      );
      if (mapResponse != null) {
        MoneyOutInfoModel result = MoneyOutInfoModel.fromJson(mapResponse);

        return result;
      }
    } catch (e) {
      log.e(
          '🐞🐞🐞 err from  Get money out info process api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong! in money out Info Model');
      return null;
    }
    return null;
  }
  ///* post money out insert process api
   static Future<MoneyOutInsertModel?> getMoneyOutInsertProcessApi(
      {required Map<String, dynamic> body}) async {
     Map<String, dynamic>? mapResponse;
     try {
       mapResponse = await ApiMethod(isBasic: false)
           .post(ApiEndpoint.moneyOutInsertURL, body, code: 200);
       if (mapResponse != null) {
         MoneyOutInsertModel result = MoneyOutInsertModel.fromJson(mapResponse);
          CustomSnackBar.success(result.message.success.first.toString());
         return result;
       }
     } catch (e) {
       log.e('err post Money Out Insert Process api service ==> $e');
       CustomSnackBar.error('Something went Wrong!');
       return null;
     }
     return null;
   }
  ///* post money out manual confirmation process api
  static Future<CommonSuccessModel?> withdrawSubmitApi({
    required Map<String, String> body,
    required List<String> pathList,
    required List<String> fieldList,
  }) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: true).multipartMultiFile(
        ApiEndpoint.moneyOutManualConfirmURL,
        body,
        showResult: true,
        fieldList: fieldList,
        pathList: pathList,
      );
      if (mapResponse != null) {
        CommonSuccessModel result =
        CommonSuccessModel.fromJson(mapResponse);
        return result;
      }
    } catch (e) {
      log.e(' err from withdraw Submit Api api service ==> $e ');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* post money out insert process api
  static Future<CommonSuccessModel?> moneyOutAutomaticConfirmApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false)
          .post(ApiEndpoint.moneyOutAutomaticConfirmURL, body, code: 200);
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);
        CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e('err post Money Out Insert Process api service ==> $e');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  static Future<MoneyOutBankInfoModel?> getBankInfoApi( String trx) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        "${ApiEndpoint.moneyOutBanksInfoURL}$trx",
        code: 200,
      );
      if (mapResponse != null) {
        MoneyOutBankInfoModel result = MoneyOutBankInfoModel.fromJson(mapResponse);

        return result;
      }
    } catch (e) {
      log.e(
          '🐞🐞🐞 err from  Get money out info process api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong! in money out Info Model');
      return null;
    }
    return null;
  }

}