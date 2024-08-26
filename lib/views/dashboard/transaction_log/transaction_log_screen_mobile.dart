import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:paylink/widgets/common/no_data_widget.dart';
import 'package:paylink/widgets/dashboard/transaction_log_widget.dart';

import '../../../backend/utils/custom_loading_api.dart';
import '../../../controller/dashboard/dashboard_controller/dashboard_controller.dart';
import '../../../routes/routes.dart';
import '../../../utils/basic_widget_imports.dart';
import '../../../widgets/animation/custom_listview_animation.dart';
import '../../../widgets/appbar/primary_appbar.dart';

class TransactionLogScreenMobile extends StatelessWidget {
  TransactionLogScreenMobile({super.key});

  final controller = Get.put(DashBoardController());

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (value) async {
        Get.offAllNamed(Routes.dashboardScreen);
      },
      child: Scaffold(
        appBar: PrimaryAppBar(
          Strings.transactionsLog,
          appbarSize: Dimensions.heightSize * 3.75,
          onTap: () {
            Get.offAllNamed(Routes.dashboardScreen);
          },
        ),
        body: Obx(() => controller.isLoading
            ? const CustomLoadingAPI()
            : _bodyWidget(context)),
      ),
    );
  }

  _bodyWidget(BuildContext context) {
    var data = controller.dashboardModel.data.transactions;
    return data.isNotEmpty
        ? Column(
            children: [
              AnimationLimiter(
                child: Expanded(
                  child: ListView.builder(
                    physics: const BouncingScrollPhysics(
                      parent: AlwaysScrollableScrollPhysics(),
                    ),
                    itemCount: data.length,
                    itemBuilder: (context, index) {
                      return CustomListViewAnimation(
                        index: index,
                        child: TransactionLogWidget(
                          title: data[index].transactionType == 'PAY-INVOICE' ||
                                  data[index].transactionType == 'PAY-LINK'
                              ? Strings.addBalanceVia.tr
                              : data[index].transactionType ==
                                      'ADD-SUBTRACT-BALANCE'
                                  ? Strings.addMoneyByAdmin.tr
                                  : Strings.moneyOut.tr,
                          via: data[index].transactionType ==
                                  'ADD-SUBTRACT-BALANCE'
                              ? ''
                              : data[index].transactionType,
                          amount: data[index].transactionType ==
                                  'ADD-SUBTRACT-BALANCE'
                              ? data[index].receiveAmount
                              : data[index].payable ?? '',
                          dateAndTime: DateFormat("d MMM y, hh:mm a")
                              .format(data[index].dateTime),
                          transactionId: data[index].trx,
                          exchangeRate: data[index].exchangeRate,
                          feesAndCharge: data[index].totalCharge,
                          availableBalance: data[index].currentBalance,
                          senderEmail: data[index].senderEmail,
                          cardHolderName: data[index].cardHolderName,
                          senderCardNumber: data[index].senderCardNumber,
                          monthText:
                              DateFormat("MMMM").format(data[index].dateTime),
                          dateText: data[index].dateTime.day.toString(),
                          status: data[index].status,
                          gatewayName: data[index].gatewayName ?? '',
                          paymentType: '',
                          paymentTypeTitle: data[index].paymentTypeTitle!,
                          senderFullName: data[index].senderFullName,
                        ).paddingSymmetric(
                          horizontal: Dimensions.paddingHorizontalSize * .6,
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          )
        : NoDataWidget(text: Strings.noTransactionYet.tr);
  }
}
