import '../../../../widgets/others/custom_snack_bar.dart';
import '../../../model/dashboard/dashboard_model.dart';
import '../../../utils/api_method.dart';
import '../../api_endpoint.dart';

class DashboardApiServices {
  ///* get dashboard process api
  static Future<DashboardModel?> getDashboardProcessApi() async {
    Map<String, dynamic>? mapResponse;
    try {
      mapResponse = await ApiMethod(isBasic: false).get(
        ApiEndpoint.dashboardGetURL,
        code: 200,
        showResult: true
      );
      if (mapResponse != null) {
        DashboardModel result = DashboardModel.fromJson(mapResponse);

        return result;
      }
    } catch (e) {
      log.e('🐞🐞🐞 err from  Get dashboard process api service ==> $e 🐞🐞🐞');
      CustomSnackBar.error('Something went Wrong! in Dashboard Model');
      return null;
    }
    return null;
  }
}