import 'package:get/get.dart';
import 'package:paylink/backend/model/notifications/notifications_model.dart';
import 'package:paylink/backend/services/api_services/notidications/notifications_api_services.dart';

import '../../../backend/utils/api_method.dart';

class NotificationsController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getNotificationsProcess();
  }

  //=> set loading process & payment link Model
  final _isLoading = false.obs;
  late NotificationsModel _notificationsModel;

  //=> get loading process & payment link Model
  bool get isLoading => _isLoading.value;

  NotificationsModel get notificationsModel => _notificationsModel;

  //=> get payment link api Process
  Future<NotificationsModel> getNotificationsProcess() async {
    _isLoading.value = true;
    update();
    await NotificationsApiServices.getPaymentLinkProcessApi().then((value) {
      _notificationsModel = value!;
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _notificationsModel;
  }
}