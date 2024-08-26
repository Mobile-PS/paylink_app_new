import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:intl/intl.dart';
import 'package:paylink/backend/utils/custom_loading_api.dart';
import 'package:paylink/widgets/common/no_data_widget.dart';

import '../../../../backend/services/api_endpoint.dart';
import '../../../../controller/dashboard/payments/payments_controller.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/basic_widget_imports.dart';
import '../../../../widgets/animation/custom_listview_animation.dart';
import '../../../../widgets/appbar/primary_appbar.dart';
import '../../../../widgets/dashboard/payment_log_widget.dart';

class PaymentLogScreenMobile extends StatelessWidget {
  PaymentLogScreenMobile({super.key});

  final controller = Get.put(PaymentsController());

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (value) async {
        Get.offAllNamed(Routes.dashboardScreen);

      },
      child: Scaffold(
          appBar: PrimaryAppBar(
            Strings.paymentsLog,
            onTap: () {
              Get.offAllNamed(Routes.dashboardScreen);
            },
          ),
          floatingActionButton: Obx(() {
            return Visibility(
              visible: !controller.isLoading,
              child: FloatingActionButton(
                elevation: 3,
                backgroundColor: CustomColor.primaryLightColor,
                shape: const CircleBorder(),
                onPressed: () {
                  controller.typeSelection.value =
                      controller.typeSelectionList.first.title;
                  controller.onPayments;
                },
                child: Icon(
                  Icons.add,
                  size: Dimensions.iconSizeLarge,
                  color: Colors.white,
                ),
              ),
            );
          }),
          body: Obx(() => controller.isLoading || controller.isStatusLoading
              ? const CustomLoadingAPI()
              : _bodyWidget(context))),
    );
  }

  _bodyWidget(BuildContext context) {
    var data = controller.paymentLinkModel.data.paymentLinks;
    return data.isNotEmpty
        ? RefreshIndicator(
            color: CustomColor.primaryLightColor,
            onRefresh: () async {
              controller.getPaymentLinkProcess();
            },
            child: Column(
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
                          child: PaymentLogWidget(
                            title: data[index].title,
                            dateText: data[index].createdAt.day.toString(),
                            status: data[index].stringStatus,
                            monthText: DateFormat("MMMM")
                                .format(data[index].createdAt),
                            amount: data[index].type == "pay" &&
                                    data[index].limit == 2
                                ? Strings.unlimited.tr
                                : data[index].limit == 1
                                    ? "${data[index].minAmount} - ${data[index].maxAmount} ${data[index].currency}"
                                    : data[index].type == "sub"
                                        ? "${data[index].price}(${data[index].qty}) ${data[index].currency}"
                                        : "${data[index].price} ${data[index].currency}",
                            onEditTap: () {
                              Get.toNamed(Routes.paymentsEditScreen,
                                  arguments: data[index].id);
                            },
                            onCopyTap: () {
                              controller.copyLinkController.text =
                                  "${ApiEndpoint.mainDomain}/payment-link/share/${data[index].token}";
                              controller.onCopyTap;
                            },
                            onActiveTap: () {
                              Get.close(1);
                              controller.updateStatusProcess(
                                  id: data[index].id);
                            },
                            onCloseTap: () {
                              Get.close(1);

                              controller.updateStatusProcess(
                                  id: data[index].id);
                            },
                          ).paddingSymmetric(
                            horizontal: Dimensions.paddingHorizontalSize * .6,
                          ),
                        );
                      },
                    ),
                  ),
                ),
              ],
            ),
          )
        : NoDataWidget(text: Strings.noPaymentCreatedYet.tr);
  }
}