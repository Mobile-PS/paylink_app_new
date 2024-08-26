import '../../utils/basic_screen_imports.dart';
import 'log_information_widget.dart';

class TransactionLogWidget extends StatelessWidget {
  const TransactionLogWidget({
    super.key,
    required this.title,
    required this.via,
    required this.amount,
    required this.dateAndTime,
    required this.transactionId,
    required this.exchangeRate,
    required this.feesAndCharge,
    required this.availableBalance,
    required this.senderEmail,
    required this.cardHolderName,
    required this.senderCardNumber,
    required this.monthText,
    required this.dateText,
    required this.status,
    required this.gatewayName,
    required this.paymentType,
    required this.paymentTypeTitle,
    required this.senderFullName,
  });

  final String title,
      via,
      gatewayName,
      amount,
      dateAndTime,
      transactionId,
      exchangeRate,
      feesAndCharge,
      availableBalance,
      senderEmail,
      cardHolderName,
      senderCardNumber,
      monthText,
      dateText,
      paymentType,
      paymentTypeTitle,
      senderFullName,
      status;

  @override
  Widget build(BuildContext context) {
    bool isTablet() {
      return MediaQuery.of(context).size.shortestSide >= 600;
    }

    return Padding(
      padding: EdgeInsets.only(bottom: Dimensions.paddingVerticalSize * 0.08),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
          color: CustomColor.whiteColor,
        ),
        padding: EdgeInsets.only(right: Dimensions.paddingHorizontalSize * 0.0),
        child: ExpansionTile(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(Dimensions.radius),
          ),
          backgroundColor: CustomColor.whiteColor,
          tilePadding: EdgeInsets.zero,
          childrenPadding: EdgeInsets.zero,
          trailing: const SizedBox(),
          title: Row(
            children: [
              Expanded(
                flex: 3,
                child: Container(
                  margin: EdgeInsets.only(
                    left: Dimensions.marginSizeHorizontal * 0.4,
                    top: Dimensions.marginSizeVertical * 0.1,
                    bottom: Dimensions.marginSizeVertical * 0.1,
                    right: Dimensions.marginSizeHorizontal * 0.2,
                  ),
                  padding: EdgeInsets.symmetric(
                    vertical: isTablet()
                        ? Dimensions.paddingVerticalSize * 0.5
                        : Dimensions.paddingVerticalSize * 0.2,
                    horizontal: Dimensions.paddingHorizontalSize * 0.2,
                  ),
                  decoration: BoxDecoration(
                      color: CustomColor.primaryLightScaffoldBackgroundColor,
                      borderRadius: BorderRadius.circular(Dimensions.radius)),
                  alignment: Alignment.center,
                  child: Column(
                    mainAxisAlignment: mainCenter,
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: crossCenter,
                    children: [
                      TitleHeading1Widget(
                        text: dateText,
                        fontSize: isTablet()
                            ? Dimensions.headingTextSize1 * 1.7
                            : Dimensions.headingTextSize1 * 1.5,
                        fontWeight: FontWeight.w600,
                        color: CustomColor.primaryLightColor,
                      ),
                      TitleHeading5Widget(
                        text: monthText,
                        fontWeight: FontWeight.w600,
                        fontSize: isTablet()
                            ? Dimensions.headingTextSize5
                            : Dimensions.headingTextSize6,
                        color: CustomColor.primaryLightColor,
                      ),
                    ],
                  ),
                ),
              ),
              horizontalSpace(Dimensions.widthSize),
              Expanded(
                flex: 6,
                child: Column(
                  crossAxisAlignment: crossStart,
                  mainAxisAlignment: mainCenter,
                  children: [
                    Row(
                      children: [
                        TitleHeading5Widget(
                          text: title,
                          fontWeight: FontWeight.w600,
                          fontSize: Dimensions.headingTextSize3,
                          color: CustomColor.blackColor,
                        ),
                        verticalSpace(Dimensions.widthSize * 0.4),
                        TitleHeading5Widget(
                          text: gatewayName.isNotEmpty
                              ? " ($gatewayName)"
                              : " ($via)",
                          fontWeight: FontWeight.w600,
                          color: CustomColor.orangeColor,
                        ),
                      ],
                    ),
                    verticalSpace(Dimensions.widthSize * 0.4),
                    Row(
                      children: [
                        TitleHeading5Widget(
                          padding: EdgeInsets.only(
                            right: Dimensions.paddingHorizontalSize * .05,
                          ),
                          maxLines: 1,
                          text: amount,
                          fontSize: Dimensions.headingTextSize5,
                          fontWeight: FontWeight.w600,
                          color: CustomColor.primaryLightColor,
                        ),
                        statusInfo(),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
          children: [
            Card(
              color: CustomColor.whiteColor,
              surfaceTintColor: CustomColor.whiteColor,
              //shadowColor: CustomColor.primaryLightTextColor.withOpacity(.50),
              elevation: 3,
              child: Column(
                children: [
                  LogInformationWidget(
                    variable: Strings.timeAndDate.tr,
                    value: dateAndTime,
                  ),
                  LogInformationWidget(
                    variable: Strings.transactionId.tr,
                    value: transactionId,
                  ),
                  LogInformationWidget(
                    variable: Strings.exchangeRate.tr,
                    value: exchangeRate,
                  ),
                  LogInformationWidget(
                    variable: Strings.feesAndCharge.tr,
                    value: feesAndCharge,
                  ),
                  LogInformationWidget(
                    variable: Strings.availableBalance.tr,
                    value: availableBalance,
                  ),
                  Visibility(
                    visible: paymentTypeTitle.isNotEmpty,
                    child: LogInformationWidget(
                      variable: Strings.paymentMethod.tr,
                      value: paymentTypeTitle,
                    ),
                  ),
                  Visibility(
                    visible: senderFullName.isNotEmpty,
                    child: LogInformationWidget(
                      variable: Strings.senderFullName.tr,
                      value: senderFullName,
                    ),
                  ),
                  Visibility(
                    visible: senderEmail.isNotEmpty,
                    child: LogInformationWidget(
                      variable: Strings.senderEmail.tr,
                      value: senderEmail,
                    ),
                  ),
                  Visibility(
                    visible: cardHolderName.isNotEmpty,
                    child: LogInformationWidget(
                      variable: Strings.cardHolderName.tr,
                      value: cardHolderName,
                    ),
                  ),
                  Visibility(
                    visible: senderCardNumber.isNotEmpty,
                    child: LogInformationWidget(
                      variable: Strings.senderCardNumber.tr,
                      value: senderCardNumber,
                    ),
                  ),
                  LogInformationWidget(
                    variable: Strings.status.tr,
                    value: status,
                    stoke: false,
                    isStatus: true,
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  statusInfo() {
    switch (status) {
      case 'Pending':
        return _customStatusWidget(color: CustomColor.orangeColor);
      case 'Rejected':
        return _customStatusWidget(color: CustomColor.redColor);
      case 'success':
        return _customStatusWidget(color: CustomColor.greenColor);
      default:
        return _customStatusWidget(color: CustomColor.redColor);
    }
  }

  _customStatusWidget({required Color color}) {
    return Row(
      children: [
        Padding(
          padding: EdgeInsets.symmetric(
            horizontal: Dimensions.paddingHorizontalSize * .15,
          ),
          child: CircleAvatar(
            radius: Dimensions.radius * .25,
            backgroundColor: color,
          ),
        ),
        TitleHeading5Widget(
          maxLines: 1,
          text: status == "success" ? "Success" : status,
          fontSize: Dimensions.headingTextSize5,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ],
    );
  }
}
