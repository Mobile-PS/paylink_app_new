import 'package:intl/intl.dart';
import 'package:paylink/backend/services/api_services/dashboard_api_services/dashboard_api_services.dart';

import '../../../../../extensions/custom_extensions.dart';
import '../../../backend/model/dashboard/dashboard_model.dart';
import '../../../backend/utils/api_method.dart';
import '../../../routes/routes.dart';
import '../../../utils/basic_screen_imports.dart';

class DashBoardController extends GetxController {
  //=>card data
  RxString balance = ''.obs;
  RxString collectionPayment = ''.obs;
  RxString collectionInvoice = ''.obs;
  RxString moneyOut = ''.obs;
  RxString totalPaymentLink = ''.obs;
  RxString totalInvoice = ''.obs;
  RxString code = ''.obs;

  //=> get onSwipeUp and rich to bottom
  get onSwipeUp => Routes.transactionLogScreen.toNamed;

  get onPayments => Routes.paymentLogScreen.toNamed;


  get onInvoice => Routes.invoiceLogScreen.toNamed;



  get onCopyTap => Get.close(1);

  final nameController = TextEditingController();
  final emailAddressController = TextEditingController();
  final amountController = TextEditingController();
  final dateController = TextEditingController();

  onDateTap() async {
    final date = await showDatePicker(
      context: Get.context!,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2100),
    );
    if (date != null) {
      final formattedDate = DateFormat('MMMM d, y').format(date);
      dateController.text = formattedDate;
    }
  }

  @override
  void onInit() {
    getDashboardInfoProcess();
    super.onInit();
  }

  //=> set loading process & Dashboard Info Model
  final _isLoading = false.obs;
  late DashboardModel _dashboardModel;

  //=> get loading process & Dashboard Info Model
  bool get isLoading => _isLoading.value;

  DashboardModel get dashboardModel => _dashboardModel;

  //=> get Dashboard Info api Process
  Future<DashboardModel> getDashboardInfoProcess() async {
    _isLoading.value = true;
    update();
    await DashboardApiServices.getDashboardProcessApi().then((value) {
      _dashboardModel = value!;
      _setData(_dashboardModel);
      _isLoading.value = false;
      update();
    }).catchError((onError) {
      log.e(onError);
    });
    _isLoading.value = false;
    update();
    return _dashboardModel;
  }

  void _setData(DashboardModel dashboardModel) {
    var data = dashboardModel.data;
    balance.value = data.wallet.balance;
    code.value = data.wallet.code;
    collectionPayment.value = data.collectionPayment;
    collectionInvoice.value = data.collectionInvoice;
    moneyOut.value = data.moneyOut;
    totalPaymentLink.value = data.totalPaymentLink;
    totalInvoice.value = data.totalInvoice;
    update();
  }
}