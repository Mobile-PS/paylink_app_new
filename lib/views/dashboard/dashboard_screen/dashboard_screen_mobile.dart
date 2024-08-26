// ignore_for_file: avoid_print, must_be_immutable

import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:iconsax/iconsax.dart';
import 'package:intl/intl.dart';
import 'package:paylink/backend/utils/custom_loading_api.dart';
import 'package:paylink/widgets/common/no_data_widget.dart';

import '../../../../controller/dashboard/dashboard_controller/dashboard_controller.dart';
import '../../../../custom_assets/assets.gen.dart';
import '../../../../routes/routes.dart';
import '../../../../utils/basic_screen_imports.dart';
import '../../../../widgets/dashboard/card_widget.dart';
import '../../../../widgets/drawer/drawer_widget.dart';
import '../../../../widgets/others/custom_image_widget.dart';
import '../../../backend/local_storage/local_storage.dart';
import '../../../widgets/animation/custom_listview_animation.dart';

import '../../../widgets/dashboard/transaction_log_widget.dart';

class DashboardScreenMobile extends StatelessWidget {
  DashboardScreenMobile({super.key});

  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey();

  final controller = Get.put(DashBoardController());

  @override
  Widget build(BuildContext context) {
    return PopScope(
      onPopInvoked: (value) async {},
      canPop: true,
      child: Scaffold(
        drawerEdgeDragWidth: 50,
        drawer: SafeArea(child: DrawerWidget()),
        key: scaffoldKey,
        extendBody: false,
        backgroundColor: CustomColor.primaryLightScaffoldBackgroundColor,
        appBar: appBarWidget(context),
        body: Obx(() => controller.isLoading
            ? const CustomLoadingAPI()
            : _bodyWidget(context)),
      ),
    );
  }

  appBarWidget(BuildContext context) {
    bool isTablet() {
      return MediaQuery.of(context).size.shortestSide >= 600;
    }

    return AppBar(
      backgroundColor: CustomColor.primaryLightScaffoldBackgroundColor,
      elevation: 0,
      scrolledUnderElevation: 0,
      centerTitle: true,
      leading: GestureDetector(
        onTap: () {
          scaffoldKey.currentState!.openDrawer();
        },
        child: Padding(
            padding: EdgeInsets.only(
                left: isTablet()
                    ? Dimensions.paddingHorizontalSize * .5
                    : Dimensions.paddingHorizontalSize * .6,
                right: isTablet()
                    ? Dimensions.paddingHorizontalSize * 0.001
                    : Dimensions.paddingHorizontalSize * 0.2),
            child: const Icon(Iconsax.element_4)),
      ),
      title: Image.network(
        LocalStorage.getAppBasicLogo(),
        height: isTablet()
            ? MediaQuery.of(context).size.height * .20
            : MediaQuery.of(context).size.height * .30,
        width: isTablet()
            ? MediaQuery.of(context).size.width * .20
            : MediaQuery.of(context).size.width * .35,
      ),
      actions: [
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: Dimensions.paddingHorizontalSize * 0.6),
          child: GestureDetector(
            onTap: () {
              Get.toNamed(Routes.updateProfileScreen);
            },
            child: Padding(
              padding: EdgeInsets.symmetric(
                  vertical: isTablet()
                      ? Dimensions.paddingHorizontalSize * .18
                      : Dimensions.paddingHorizontalSize * .5),
              child: Padding(
                padding: EdgeInsets.only(
                    right: Dimensions.paddingHorizontalSize * .25),
                child: CustomImageWidget(
                  path: Assets.icon.profile,
                  height: Dimensions.heightSize * 2,
                  width: Dimensions.widthSize * 3,
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  _bodyWidget(BuildContext context) {
    return SafeArea(
      child: RefreshIndicator(
        color: CustomColor.primaryLightColor,
        onRefresh: () async {
          controller.getDashboardInfoProcess();
        },
        child: SizedBox(
          height: MediaQuery.of(context).size.height,
          child: ListView(
            shrinkWrap: true,
            children: [
              verticalSpace(Dimensions.heightSize),
              _cardWidget(context),
              _categoryButtonWidget(context),
              _transactionsLogTextWidget(context),
              _transactionsLogWidget(context),
            ],
          ),
        ),
      ),
    );
  }

  _cardWidget(BuildContext context) {
    bool isTablet() {
      return MediaQuery.of(context).size.shortestSide >= 600;
    }

    return SizedBox(
      height: isTablet()
          ? MediaQuery.sizeOf(context).height * .21
          : MediaQuery.sizeOf(context).height * .15,
      child: ListView(
        shrinkWrap: true,
        scrollDirection: Axis.horizontal,
        children: [
          Padding(
            padding:
                EdgeInsets.only(left: Dimensions.paddingHorizontalSize * 0.7),
            child: CardWidget(
              title: Strings.balance.tr,
              balance: "${controller.balance.value} ${controller.code.value}",
              cardAssetLogo: Assets.icon.collectWithLinkIcon,
            ),
          ),
          CardWidget(
            title: Strings.collectPaymentWithLink.tr,
            balance:
                "${controller.collectionPayment.value} ${controller.code.value}",
            cardAssetLogo: Assets.icon.collectWithInvoiceIcon,
          ),
          CardWidget(
            title: Strings.collectPaymentWithInvoice.tr,
            balance:
                "${controller.collectionInvoice.value} ${controller.code.value}",
            cardAssetLogo: Assets.icon.dueIcon,
          ),
          CardWidget(
            title: Strings.moneyOut.tr,
            balance: "${controller.moneyOut.value} ${controller.code.value}",
            cardAssetLogo: Assets.icon.dueIcon,
          ),
          CardWidget(
            title: Strings.totalPaymentLink.tr,
            balance: controller.totalPaymentLink.value,
            cardAssetLogo: Assets.icon.collectWithLinkIcon,
          ),
          CardWidget(
            title: Strings.totalInvoice.tr,
            balance: controller.totalInvoice.value,
            cardAssetLogo: Assets.icon.collectWithLinkIcon,
          ),
        ],
      ),
    );
  }

  _categoryButtonWidget(BuildContext context) {
    bool isTablet() {
      return MediaQuery.of(context).size.shortestSide >= 600;
    }

    return Padding(
      padding: EdgeInsets.symmetric(
          horizontal: Dimensions.paddingHorizontalSize * .6,
          vertical: Dimensions.paddingVerticalSize * .75),
      child: Row(
        children: [
          Expanded(
            child: PrimaryButton(
              height: isTablet()
                  ? Dimensions.buttonHeight * 0.85
                  : Dimensions.buttonHeight * 0.7,
              icon: const Icon(
                Icons.attach_money,
                color: CustomColor.whiteColor,
              ),
              title: Strings.payments,
              onPressed: () {
                controller.onPayments;
              },
            ),
          ),
          horizontalSpace(Dimensions.widthSize),
          Expanded(
            child: PrimaryButton(
              height: isTablet()
                  ? Dimensions.buttonHeight * 0.85
                  : Dimensions.buttonHeight * 0.7,
              icon: CustomImageWidget(
                path: Assets.icon.collectWithInvoiceIcon,
              ).paddingOnly(
                right: Dimensions.paddingHorizontalSize * .1,
              ),
              borderWidth: Dimensions.widthSize * .2,
              buttonColor: CustomColor.primaryLightScaffoldBackgroundColor,
              buttonTextColor: CustomColor.primaryLightColor,
              title: Strings.invoice,
              onPressed: () {
                controller.onInvoice;
              },
            ),
          ),
        ],
      ),
    );
  }

  _transactionsLogTextWidget(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(
        horizontal: Dimensions.paddingHorizontalSize * .6,
      ),
      child: Row(
        mainAxisAlignment: mainStart,
        children: [
          TitleHeading2Widget(
            text: Strings.transactionsLog,
            fontWeight: FontWeight.w600,
            padding:
                EdgeInsets.only(bottom: Dimensions.paddingVerticalSize * .5),
          ),
        ],
      ),
    );
  }

  bool hasNavigatedToTransactionLog = false;

  _transactionsLogWidget(BuildContext context) {
    var data = controller.dashboardModel.data.transactions;
    return data.isNotEmpty
        ? AnimationLimiter(
            child: SizedBox(
              height: MediaQuery.of(context).size.height * .58,
              child: NotificationListener<ScrollNotification>(
                onNotification: (ScrollNotification scrollInfo) {
                  if (scrollInfo.metrics.atEdge) {
                    if (scrollInfo.metrics.pixels == 0.0) {
                      // User reached the top
                    } else if (scrollInfo.metrics.extentAfter == 0.0) {
                      // User reached the bottom

                      Get.offAllNamed(Routes.transactionLogScreen);
                    }
                  }
                  return true;
                },
                child: ListView.builder(
                  shrinkWrap: true,
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
          )
        : SizedBox(
            height: MediaQuery.of(context).size.height * .58,
            child: const NoDataWidget(
              text: Strings.noTransactionYet,
            ),
          );
  }
}
