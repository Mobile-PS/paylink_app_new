import 'package:paylink/backend/model/notifications/notifications_model.dart';

import '../../../../widgets/others/custom_snack_bar.dart';
import '../../../utils/api_method.dart';
import '../../api_endpoint.dart';

class NotificationsApiServices{

  ///* get Notifications process api
  static Future<NotificationsModel?> getPaymentLinkProcessApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        ApiEndpoint.notificationsGetURL,
        code: 200,
      );
      if (mapResponse != null) {
        NotificationsModel result = NotificationsModel.fromJson(mapResponse);

        return result;
      }
    } catch (e) {
      log.e(
          '🐞🐞🐞 err from  Get Notifications process api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong! in Notifications Model');
      return null;
    }
    return null;
  }
}