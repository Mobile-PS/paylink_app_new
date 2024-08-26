import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../../backend/utils/custom_snackbar.dart';
import '../../language/english.dart';
import '../../routes/routes.dart';
import '/backend/services/api_endpoint.dart';
import '../../backend/model/common/common_success_model.dart';
import '../../backend/model/product/product_edit_info_model.dart' as edit_info;
import '../../backend/model/product/product_link_info_model.dart' as link;
import '../../backend/model/product/product_link_edit_info_model.dart'
    as edit_link;
import '/backend/services/api_services/product/product_services.dart';
import '../../backend/model/common/new_common_sucess_model.dart';
import '../../backend/model/product/product_list_info_model.dart';
import '../../backend/utils/api_method.dart';

class ProductController extends GetxController with ProductServices {
  @override
  void onInit() {
    productListInfoGetProcess();
    super.onInit();
  }

  final currencyController = TextEditingController();
  final productNameController = TextEditingController();
  final descController = TextEditingController();
  final priceController = TextEditingController();
  final productLinkPriceController = TextEditingController();
  final productLinkQuantityController = TextEditingController();
  final editProductNameController = TextEditingController();
  final editDescController = TextEditingController();
  final editPriceController = TextEditingController();
  RxString currencySelection = ''.obs;
  RxString currencyCode = ''.obs;
  RxString currencySymbol = ''.obs;
  RxString currencyCountry = ''.obs;
  RxString currencyName = ''.obs;
  RxString currencyId = ''.obs;
  RxString productId = ''.obs;

  //-> Image Picker
  RxBool isImagePathSet = false.obs;
  RxBool isImagePathSetStore = false.obs;
  RxString userImagePath = ''.obs;
  RxString userImagePathStore = ''.obs;
  File? image;
  RxString userImage = ''.obs;
  RxString defaultImage = ''.obs;
  ImagePicker picker = ImagePicker();

  chooseImageFromGallery() async {
    var pickImage = await picker.pickImage(source: ImageSource.gallery);
    image = File(pickImage!.path);
    if (image!.path.isNotEmpty) {
      userImagePath.value = image!.path;
      isImagePathSet.value = true;
    }
  }

  chooseImageFromCamera() async {
    var pickImage = await picker.pickImage(source: ImageSource.camera);
    image = File(pickImage!.path);
    if (image!.path.isNotEmpty) {
      userImagePath.value = image!.path;
      isImagePathSet.value = true;
    }
  }

  chooseImageFromGalleryStore() async {
    var pickImage = await picker.pickImage(source: ImageSource.gallery);
    image = File(pickImage!.path);
    if (image!.path.isNotEmpty) {
      userImagePathStore.value = image!.path;
      isImagePathSetStore.value = true;
    }
  }

  chooseImageFromCameraStore() async {
    var pickImage = await picker.pickImage(source: ImageSource.camera);
    image = File(pickImage!.path);
    if (image!.path.isNotEmpty) {
      userImagePathStore.value = image!.path;
      isImagePathSetStore.value = true;
    }
  }

  final List<CurrencyDatum> currencyList = [];
  final List<link.CurrencyDatum> productLinkCurrencyList = [];
  final List<edit_link.CurrencyDatum> productLinkEditCurrencyList = [];
  final List<edit_info.CurrencyDatum> currencyListEdit = [];

  final _isLoading = false.obs;
  late ProductListInfoModel _productListInfoModel;

  /// >> get loading process & ProductListInfo Model
  bool get isLoading => _isLoading.value;

  ProductListInfoModel get productListInfoModel => _productListInfoModel;

  /// >> Get ProductListInfo in process
  Future<ProductListInfoModel> productListInfoGetProcess() async {
    _isLoading.value = true;
    update();
    await productListInfoGetProcessApi().then((value) {
      _productListInfoModel = value!;
      _setData(_productListInfoModel);
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _productListInfoModel;
  }

  _setData(ProductListInfoModel productInfoListModel) {
    currencyList.clear();
    for (var element in _productListInfoModel.data.currencyData) {
      currencyList.add(CurrencyDatum(
        name: element.name,
        code: element.code,
        symbol: element.symbol,
        type: element.type,
        country: element.country,
        id: element.id,
      ));
      currencySelection.value =
          currencyList.first.code + '-' + currencyList.first.name!;
      currencyCode.value = currencyList.first.code;
      currencySymbol.value = currencyList.first.symbol;
      currencyCountry.value = currencyList.first.country;
      currencyName.value = currencyList.first.name!;
    }
  }

  /// >> set loading process & CommonSuccess Model
  final _isStatusLoading = false.obs;
  late NewCommonSuccessModel _commonSuccessModel;

  /// >> get loading process & CommonSuccess Model
  bool get isStatusLoading => _isStatusLoading.value;

  NewCommonSuccessModel get commonSuccessModel => _commonSuccessModel;

  ///* CommonSuccess in process
  Future<NewCommonSuccessModel> statusUpdateProcess(String id) async {
    _isStatusLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {"target": id};
    await statusUpdateProcessApi(body: inputBody).then((value) {
      _commonSuccessModel = value!;
      _isStatusLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isStatusLoading.value = false;
    update();
    return _commonSuccessModel;
  }

  /// >> set loading process & CommonSuccess Model
  final _isDeleteLoading = false.obs;
  late NewCommonSuccessModel _deleteModel;

  /// >> get loading process & CommonSuccess Model
  bool get isDeleteLoading => _isDeleteLoading.value;

  NewCommonSuccessModel get deleteModel => _deleteModel;

  ///* CommonSuccess in process
  Future<NewCommonSuccessModel> deleteProcess(String id) async {
    _isDeleteLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {"target": id};
    await productDeleteApi(body: inputBody).then((value) {
      _deleteModel = value!;
      _isDeleteLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isDeleteLoading.value = false;
    update();
    return _deleteModel;
  }

  get onStoreProfile => isImagePathSetStore.value
      ? productStoreWithImage()
      : productStoreWithoutImage();

  /// >> set loading process & profile update model
  final _isStoreLoading = false.obs;
  late CommonSuccessModel _profileUpdateModel;

  /// >> get loading process & profile update model
  bool get isStoreLoading => _isStoreLoading.value;

  CommonSuccessModel get profileUpdateModel => _profileUpdateModel;

  Future<CommonSuccessModel> productStoreWithoutImage() async {
    _isStoreLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      "currency": currencyId.value,
      "product_name": productNameController.text,
      "desc": descController.text,
      "price": priceController.text,
    };

    await productStoreWithoutImageApi(body: inputBody).then((value) {
      _profileUpdateModel = value!;
      Get.offAllNamed(Routes.productListScreen);
      productListInfoGetProcess();
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isStoreLoading.value = false;
    update();
    return _profileUpdateModel;
  }

  // Profile update process with image
  Future<CommonSuccessModel> productStoreWithImage() async {
    _isStoreLoading.value = true;
    update();

    Map<String, String> inputBody = {
      "currency": currencyId.value,
      "product_name": productNameController.text,
      "desc": descController.text,
      "price": priceController.text,
    };

    await productStoreWithImageApi(
      body: inputBody,
      filepath: userImagePathStore.value,
    ).then((value) {
      _profileUpdateModel = value!;
      Get.offAllNamed(Routes.productListScreen);
      productListInfoGetProcess();
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isStoreLoading.value = false;
    update();
    return _profileUpdateModel;
  }

  get onUpdateProduct => isImagePathSet.value
      ? productUpdateWithImage()
      : productUpdateWithoutImage();

  /// >> set loading process & profile update model
  final _isUpdateLoading = false.obs;
  late CommonSuccessModel _productUpdateModel;

  /// >> get loading process & profile update model
  bool get isUpdateLoading => _isUpdateLoading.value;

  CommonSuccessModel get productUpdateModel => _productUpdateModel;

  Future<CommonSuccessModel> productUpdateWithoutImage() async {
    _isUpdateLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      "target": productEditInfoModel.data.product.id.toString(),
      "currency": currencyId.value,
      "product_name": editProductNameController.text,
      "desc": editDescController.text,
      "price": editPriceController.text.replaceAll(",", ""),
    };

    await productUpdateWithoutImageApi(body: inputBody).then((value) {
      _productUpdateModel = value!;
      productListInfoGetProcess();
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isUpdateLoading.value = false;
    update();
    return _productUpdateModel;
  }

  // Profile update process with image
  Future<CommonSuccessModel> productUpdateWithImage() async {
    _isUpdateLoading.value = true;
    update();
    Map<String, String> inputBody = {
      "target": productEditInfoModel.data.product.id.toString(),
      "currency": currencyId.value,
      "product_name": editProductNameController.text,
      "desc": editDescController.text,
      "price": editPriceController.text.replaceAll(",", ""),
    };

    await productUpdateWithImageApi(
      body: inputBody,
      filepath: userImagePath.value,
    ).then((value) {
      _productUpdateModel = value!;
      productListInfoGetProcess();
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isUpdateLoading.value = false;
    update();
    return _productUpdateModel;
  }

  final _isEditInfoLoading = false.obs;
  late edit_info.EditInfoModel _productEditInfoModel;

  /// >> get loading process & ProductListInfo Model
  bool get isEditLoading => _isEditInfoLoading.value;

  edit_info.EditInfoModel get productEditInfoModel => _productEditInfoModel;

  /// >> Get ProductListInfo in process
  Future<edit_info.EditInfoModel> productEditInfoProcess(String target) async {
    _isEditInfoLoading.value = true;
    update();
    await productEditInfoApi(target).then((value) {
      _productEditInfoModel = value!;
      _setEditData(_productEditInfoModel);
      _isEditInfoLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isEditInfoLoading.value = false;
    update();
    return _productEditInfoModel;
  }

  _setEditData(edit_info.EditInfoModel editInfoModel) {
    currencyListEdit.clear();
    for (var element in editInfoModel.data.currencyData) {
      currencyListEdit.add(
        edit_info.CurrencyDatum(
          id: element.id,
          country: element.country,
          name: element.name,
          code: element.code,
          symbol: element.symbol,
          type: element.type,
        ),
      );
      currencySelection.value = editInfoModel.data.product.currency +
          '-' +
          editInfoModel.data.product.currencyName!;
      currencyCode.value = currencyListEdit.first.code;
      currencySymbol.value = editInfoModel.data.product.currencySymbol;
      for (int i = 0; i < currencyListEdit.length; i++) {
        if (editInfoModel.data.product.currencyName ==
            currencyListEdit[i].name) {
          currencyId.value = currencyListEdit[i].id.toString();
        }
      }

      currencyCountry.value = editInfoModel.data.product.country;
      currencyName.value = editInfoModel.data.product.currencyName;
      editProductNameController.text = editInfoModel.data.product.productName;
      editPriceController.text = editInfoModel.data.product.price;
      editDescController.text = editInfoModel.data.product.desc;
      userImage.value = editInfoModel.data.product.image == ''
          ? "${ApiEndpoint.mainDomain}/${editInfoModel.data.defaultImage}"
          : "${ApiEndpoint.mainDomain}/${editInfoModel.data.imagePath}/${editInfoModel.data.product.image}";
      debugPrint("..............${userImage.value}");
    }
  }

  /// >> get loading process & ProductListInfo Model
  final _isProductLinkLoading = false.obs;

  bool get isProductLinkLoading => _isProductLinkLoading.value;

  late link.ProductLinkInfoModel _productLinkListModel;

  link.ProductLinkInfoModel get productLinkListModel => _productLinkListModel;

  /// >> Get ProductListInfo in process
  Future<link.ProductLinkInfoModel> productLinkGetProcess(
      String productId) async {
    _isProductLinkLoading.value = true;
    update();
    await productLinkListInfoApiProcess(productId).then((value) {
      _productLinkListModel = value!;
      _setLinkData(_productLinkListModel);
      _isProductLinkLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isProductLinkLoading.value = false;
    update();
    return _productLinkListModel;
  }

  /// >> set loading process & CommonSuccess Model
  final _isLinkStatusLoading = false.obs;
  late NewCommonSuccessModel _productLinkStatusUpdateModel;

  /// >> get loading process & CommonSuccess Model
  bool get isLinkStatusLoading => _isLinkStatusLoading.value;

  NewCommonSuccessModel get productLinkStatusUpdateModel =>
      _productLinkStatusUpdateModel;

  ///* CommonSuccess in process
  Future<NewCommonSuccessModel> productLinkStatusUpdateProcess(
      String id, status) async {
    _isLinkStatusLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {"data_target": id, "status": status};
    await productLinkStatusUpdateApi(body: inputBody).then((value) {
      _productLinkStatusUpdateModel = value!;

      // productLinkGetProcess(_productLinkStatusUpdateModel.message);
      _isLinkStatusLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLinkStatusLoading.value = false;
    update();
    return _productLinkStatusUpdateModel;
  }

  /// >> set loading process & Product Link Delete Model
  final _isLinkDeleteLoading = false.obs;
  late NewCommonSuccessModel _productLinkDeleteModel;

  /// >> get loading process & Product Link Delete Model
  bool get isLinkDeleteLoading => _isLinkDeleteLoading.value;

  NewCommonSuccessModel get productLinkDeleteModel => _productLinkDeleteModel;

  ///* Product Link Delete in process
  Future<NewCommonSuccessModel> productLinkDeleteProcess(String id) async {
    _isLinkDeleteLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {"target": id};
    await productLinkDeleteApi(body: inputBody).then((value) {
      _productLinkDeleteModel = value!;
      _isLinkDeleteLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLinkDeleteLoading.value = false;
    update();
    return _productLinkDeleteModel;
  }

  _setLinkData(link.ProductLinkInfoModel linkInfoModel) {
    productLinkCurrencyList.clear();
    debugPrint(
        ">>>>>>>>>>>>>  ${linkInfoModel.data.currencyData.length.toString()}");
    for (var element in linkInfoModel.data.currencyData) {
      productLinkCurrencyList.add(
        link.CurrencyDatum(
          id: element.id,
          country: element.country,
          name: element.name,
          code: element.code,
          symbol: element.symbol,
          type: element.type,
        ),
      );
    }
    currencySelection.value =
        '${linkInfoModel.data.productLinks.first.productLinks.currency}-${linkInfoModel.data.productLinks.first.productLinks.currencyName}';
    currencyCode.value = productLinkCurrencyList.first.code;
    currencySymbol.value =
        linkInfoModel.data.productLinks.first.productLinks.currencySymbol;
    for (int i = 0; i < productLinkCurrencyList.length; i++) {
      if (linkInfoModel.data.productLinks.first.productLinks.currencyName ==
          productLinkCurrencyList[i].name) {
        currencyId.value = productLinkCurrencyList[i].id.toString();
      }
    }
    currencyCountry.value =
        linkInfoModel.data.productLinks.first.productLinks.country;
    currencyName.value =
        linkInfoModel.data.productLinks.first.productLinks.currencyName;
  }

  /// >> set loading process & profile update model
  final _isLinkStoreLoading = false.obs;
  late CommonSuccessModel _linkStoreModel;

  /// >> get loading process & profile update model
  bool get isLinkStoreLoading => _isLinkStoreLoading.value;

  CommonSuccessModel get linkStoreModel => _linkStoreModel;

  Future<CommonSuccessModel> linkStoreProcess() async {
    _isLinkStoreLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      "currency": currencyId.value,
      "product_id": productId.value,
      "price": productLinkPriceController.text,
      "quantity": productLinkQuantityController.text,
    };

    await linkStoreApi(body: inputBody).then((value) {
      _linkStoreModel = value!;
      productLinkGetProcess(productId.value)
          .then((value) => Get.toNamed(Routes.productLinkListScreen));

      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isLinkStoreLoading.value = false;
    update();
    return _linkStoreModel;
  }

  final _isEditLinkInfoLoading = false.obs;
  late edit_link.ProductLinkEditInfoModel _editLinkInfoModel;

  /// >> get loading process & ProductListInfo Model
  bool get isEditLinkInfoLoading => _isEditLinkInfoLoading.value;

  edit_link.ProductLinkEditInfoModel get editLinkInfoModel =>
      _editLinkInfoModel;

  /// >> Get ProductListInfo in process
  Future<edit_link.ProductLinkEditInfoModel> linkEditInfoProcess(
      String target) async {
    _isEditLinkInfoLoading.value = true;
    update();
    await productLinkEditInfoApi(target).then((value) {
      _editLinkInfoModel = value!;
      _setLinkEditData(_editLinkInfoModel);
      _isEditLinkInfoLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isEditLinkInfoLoading.value = false;
    update();
    return _editLinkInfoModel;
  }

  final productLinkEditPriceController = TextEditingController();
  final productLinkEditQuantityController = TextEditingController();

  _setLinkEditData(edit_link.ProductLinkEditInfoModel editLinkInfoData) {
    productLinkEditCurrencyList.clear();
    for (var element in editLinkInfoData.data.currencyData) {
      productLinkEditCurrencyList.add(
        edit_link.CurrencyDatum(
          id: element.id,
          country: element.country,
          name: element.name,
          code: element.code,
          symbol: element.symbol,
          type: element.type,
        ),
      );
      productLinkEditPriceController.text =
          double.parse(editLinkInfoData.data.product.price).toStringAsFixed(2);
      productLinkEditQuantityController.text =
          editLinkInfoData.data.product.quantity.toString();
      '${editLinkInfoData.data.product.currency}-${editLinkInfoData.data.product.currencyName}';
      currencyCode.value = productLinkEditCurrencyList.first.code;
      currencySymbol.value = editLinkInfoData.data.product.currencySymbol;
      for (int i = 0; i < productLinkEditCurrencyList.length; i++) {
        if (editLinkInfoData.data.product.currencyName ==
            productLinkEditCurrencyList[i].name) {
          currencyId.value = productLinkEditCurrencyList[i].id.toString();
        }
      }
      currencyCountry.value = editLinkInfoData.data.product.country;
      currencyName.value = editLinkInfoData.data.product.currencyName;
    }
  }

  /// >> set loading process & profile update model
  final _isLinkUpdateLoading = false.obs;
  late CommonSuccessModel _productLinkUpdateModel;

  /// >> get loading process & profile update model
  bool get isLinkUpdateLoading => _isLinkUpdateLoading.value;

  CommonSuccessModel get productLinkUpdateModel => _productLinkUpdateModel;

  Future<CommonSuccessModel> productUpdateLinkProcess() async {
    _isLinkUpdateLoading.value = true;
    update();
    Map<String, dynamic> inputBody = {
      "target": _editLinkInfoModel.data.product.id.toString(),
      "currency": currencyId.value,
      "quantity": productLinkEditQuantityController.text,
      "price": productLinkEditPriceController.text.replaceAll(",", ""),
    };

    await productLinkUpdateApi(body: inputBody).then((value) {
      _productLinkUpdateModel = value!;
      productListInfoGetProcess();
      update();
    }).catchError((onError) {
      log.e(onError);
    });

    _isLinkUpdateLoading.value = false;
    update();
    return _productLinkUpdateModel;
  }

  final copyLinkController = TextEditingController();

  get onCopyTap => _onCopyTap();

  _onCopyTap() async {
    await Clipboard.setData(
      ClipboardData(text: copyLinkController.text),
    );
    CustomSnackBar.success(Strings.linkCopiedSuccessfully.tr);
  }
}
