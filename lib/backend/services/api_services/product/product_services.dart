import '../../../../utils/basic_screen_imports.dart';
import '../../../../widgets/others/custom_snack_bar.dart';
import '../../../model/common/common_success_model.dart';
import '../../../model/common/new_common_sucess_model.dart';
import '../../../model/product/product_edit_info_model.dart';
import '../../../model/product/product_link_edit_info_model.dart';
import '../../../model/product/product_link_info_model.dart';
import '../../../model/product/product_list_info_model.dart';
import '../../../utils/api_method.dart';
import '../../api_endpoint.dart';

mixin ProductServices {
  ///* Get ProductListInfo api services
  Future<ProductListInfoModel?> productListInfoGetProcessApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        ApiEndpoint.productListURL,
      );
      if (mapResponse != null) {
        ProductListInfoModel result =
            ProductListInfoModel.fromJson(mapResponse);

        return result;
      }
    } catch (e) {
      log.e(
          ':ladybug::ladybug::ladybug: err from ProductListInfo api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* CommonSuccess api services
  Future<NewCommonSuccessModel?> statusUpdateProcessApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.statusUpdateURL,
        showResult: true,
        code: 200,
        body,
      );
      if (mapResponse != null) {
        NewCommonSuccessModel result =
            NewCommonSuccessModel.fromJson(mapResponse);
        CustomSnackBar.success(result.message.success.first.toString());
        debugPrint("this working");
        return result;
      }
    } catch (e) {
      log.e(
          ':ladybug::ladybug::ladybug: err from CommonSuccess api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* CommonSuccess api services
  Future<NewCommonSuccessModel?> productDeleteApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.productDeleteURL,
        showResult: true,
        code: 200,
        body,
      );
      if (mapResponse != null) {
        NewCommonSuccessModel result =
            NewCommonSuccessModel.fromJson(mapResponse);
        CustomSnackBar.success(result.message.success.first.toString());
        debugPrint("this working");
        return result;
      }
    } catch (e) {
      log.e(
          ':ladybug::ladybug::ladybug: err from CommonSuccess api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* update profile process api
  Future<CommonSuccessModel?> productStoreWithoutImageApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false)
          .post(ApiEndpoint.productStoreURL, body, code: 200);
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);
        CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e('err from update profile process api service ==> $e');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* update profile with img process api
  Future<CommonSuccessModel?> productStoreWithImageApi(
      {required Map<String, String> body, required String filepath}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).multipart(
          ApiEndpoint.productStoreURL, body, filepath, 'image',
          code: 200);

      if (mapResponse != null) {
        CommonSuccessModel profileUpdateModel =
            CommonSuccessModel.fromJson(mapResponse);
        CustomSnackBar.success(
            profileUpdateModel.message.success.first.toString());
        return profileUpdateModel;
      }
    } catch (e) {
      log.e('err from update profile with img process api service ==> $e');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* update profile process api
  Future<CommonSuccessModel?> productUpdateWithoutImageApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false)
          .post(ApiEndpoint.productUpdateURL, body, code: 200);
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);
        CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e('err from update profile process api service ==> $e');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* update profile with img process api
  Future<CommonSuccessModel?> productUpdateWithImageApi(
      {required Map<String, String> body, required String filepath}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).multipart(
          ApiEndpoint.productUpdateURL, body, filepath, 'image',
          code: 200);

      if (mapResponse != null) {
        CommonSuccessModel profileUpdateModel =
            CommonSuccessModel.fromJson(mapResponse);
        CustomSnackBar.success(
            profileUpdateModel.message.success.first.toString());
        return profileUpdateModel;
      }
    } catch (e) {
      log.e('err from update profile with img process api service ==> $e');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* Get ProductListInfo api services
  Future<EditInfoModel?> productEditInfoApi(String target) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false)
          .get("${ApiEndpoint.productEditURL}$target", showResult: true);
      if (mapResponse != null) {
        EditInfoModel result = EditInfoModel.fromJson(mapResponse);

        return result;
      }
    } catch (e) {
      log.e(
          ':ladybug::ladybug::ladybug: err from ProductListInfo api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* Get ProductListInfo api services
  Future<ProductLinkInfoModel?> productLinkListInfoApiProcess(
      String productID) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false)
          .get("${ApiEndpoint.productLinksURL}$productID", showResult: true);
      if (mapResponse != null) {
        ProductLinkInfoModel result =
            ProductLinkInfoModel.fromJson(mapResponse);

        return result;
      }
    } catch (e) {
      log.e(
          ':ladybug::ladybug::ladybug: err from ProductLinkListInfo api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* Product Link api services
  Future<NewCommonSuccessModel?> productLinkStatusUpdateApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.productLinkStatusUpdateURL,
        showResult: true,
        code: 200,
        body,
      );
      if (mapResponse != null) {
        NewCommonSuccessModel result =
            NewCommonSuccessModel.fromJson(mapResponse);
        CustomSnackBar.success(result.message.success.first.toString());
        debugPrint("this working");
        return result;
      }
    } catch (e) {
      log.e(
          ':ladybug::ladybug::ladybug: err from Product Link Status api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* productLink api services
  Future<NewCommonSuccessModel?> productLinkDeleteApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).post(
        ApiEndpoint.productLinkDeleteURL,
        showResult: true,
        code: 200,
        body,
      );
      if (mapResponse != null) {
        NewCommonSuccessModel result =
            NewCommonSuccessModel.fromJson(mapResponse);
        CustomSnackBar.success(result.message.success.first.toString());
        debugPrint("this working");
        return result;
      }
    } catch (e) {
      log.e(
          ':ladybug::ladybug::ladybug: err from CommonSuccess api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* link store process api
  Future<CommonSuccessModel?> linkStoreApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false)
          .post(ApiEndpoint.productLinkStoreURL, body, code: 200);
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);
        CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e('err from link store process api service ==> $e');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* Get Product List Edit api services
  Future<ProductLinkEditInfoModel?> productLinkEditInfoApi(
      String target) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false)
          .get("${ApiEndpoint.productEditInfoURL}$target", showResult: true);
      if (mapResponse != null) {
        ProductLinkEditInfoModel result =
            ProductLinkEditInfoModel.fromJson(mapResponse);

        return result;
      }
    } catch (e) {
      log.e(
          ':ladybug::ladybug::ladybug: err from Product List Edit api service ==> $e :ladybug::ladybug::ladybug:');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }

  ///* product link process api
  Future<CommonSuccessModel?> productLinkUpdateApi(
      {required Map<String, dynamic> body}) async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false)
          .post(ApiEndpoint.productLinkUpdateURL, body, code: 200);
      if (mapResponse != null) {
        CommonSuccessModel result = CommonSuccessModel.fromJson(mapResponse);
        CustomSnackBar.success(result.message.success.first.toString());
        return result;
      }
    } catch (e) {
      log.e('err from product link process api service ==> $e');
      CustomSnackBar.error('Something went Wrong!');
      return null;
    }
    return null;
  }
}
