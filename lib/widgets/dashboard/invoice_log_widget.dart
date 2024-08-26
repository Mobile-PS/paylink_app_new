import 'package:iconsax/iconsax.dart';

import '../../../../../widgets/inputs/custom_divider.dart';
import '../../utils/basic_screen_imports.dart';

class InvoiceLogWidget extends StatelessWidget {
  const InvoiceLogWidget({
    super.key,
    required this.dateText,
    required this.status,
    required this.monthText,
    required this.title,
    required this.amount,
    required this.onShowInvoice,
    required this.onDownload,
    required this.onEditInvoice,
    required this.onDeleteInvoice,
    required this.onCopyInvoice,
  });

  final String monthText, dateText, status, title, amount;

  final VoidCallback onShowInvoice;
  final VoidCallback? onDownload;
  final VoidCallback? onEditInvoice;
  final VoidCallback? onDeleteInvoice;
  final VoidCallback? onCopyInvoice;

  @override
  Widget build(BuildContext context) {
    bool isTablet() {
      return MediaQuery.of(context).size.shortestSide >= 600;
    }

    return Padding(
      padding: EdgeInsets.only(
          bottom: Dimensions.paddingVerticalSize * 0.08,
          left: Dimensions.paddingHorizontalSize * 0.5,
          right: Dimensions.paddingHorizontalSize * 0.5),
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
          color: CustomColor.whiteColor,
        ),
        padding: EdgeInsets.only(right: Dimensions.paddingHorizontalSize * 0.2),
        child: Row(
          children: [
            Expanded(
              flex: 5,
              child: Container(
                margin: EdgeInsets.only(
                  left: Dimensions.marginSizeHorizontal * 0.4,
                  top: Dimensions.marginSizeVertical * 0.4,
                  bottom: Dimensions.marginSizeVertical * 0.4,
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
              flex: 13,
              child: Column(
                crossAxisAlignment: crossStart,
                mainAxisAlignment: mainCenter,
                children: [
                  TitleHeading5Widget(
                    text: title,
                    fontWeight: FontWeight.w600,
                    fontSize: Dimensions.headingTextSize3,
                    color: CustomColor.blackColor,
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
            Expanded(
              flex: 2,
              child: PopupMenuButton(
                elevation: Dimensions.widthSize * 2,
                color: CustomColor.whiteColor,
                surfaceTintColor: CustomColor.whiteColor,
                icon: Icon(
                  Icons.more_vert_outlined,
                  size: isTablet()
                      ? Dimensions.heightSize * 2.5
                      : Dimensions.heightSize * 1.5,
                  color: CustomColor.primaryLightTextColor.withOpacity(.20),
                ),
                itemBuilder: (BuildContext context) => [
                  PopupMenuItem(
                    padding: EdgeInsets.only(
                        right: Dimensions.paddingHorizontalSize * .20),
                    child: Column(
                      mainAxisAlignment: mainCenter,
                      children: [
                        Visibility(
                          visible: status != 'Paid' && status != 'Draft',
                          child: Column(
                            children: [
                              InkWell(
                                onTap: onCopyInvoice,
                                child: Row(
                                  mainAxisAlignment: mainCenter,
                                  children: [
                                    Icon(
                                      Iconsax.copy_success,
                                      color: CustomColor.primaryLightTextColor
                                          .withOpacity(.5),
                                    ),
                                    horizontalSpace(Dimensions.widthSize * .5),
                                    TitleHeading5Widget(
                                      text: Strings.copy.tr,
                                      fontWeight: FontWeight.w500,
                                      color: CustomColor.primaryLightTextColor,
                                      opacity: .5,
                                    )
                                  ],
                                ),
                              ),
                              const CustomDivider(),
                            ],
                          ),
                        ),
                        Visibility(
                          visible: status != 'Paid',
                          child: Column(
                            children: [
                              InkWell(
                                onTap: onEditInvoice,
                                child: Row(
                                  mainAxisAlignment: mainCenter,
                                  children: [
                                    Icon(
                                      Iconsax.edit_2,
                                      color: CustomColor.primaryLightTextColor
                                          .withOpacity(.5),
                                    ),
                                    horizontalSpace(Dimensions.widthSize * .5),
                                    TitleHeading5Widget(
                                      text: Strings.edit.tr,
                                      fontWeight: FontWeight.w500,
                                      color: CustomColor.primaryLightTextColor,
                                      opacity: .5,
                                    )
                                  ],
                                ),
                              ),
                              const CustomDivider(),
                            ],
                          ),
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap: onShowInvoice,
                              child: Row(
                                mainAxisAlignment: mainCenter,
                                children: [
                                  Icon(
                                    Iconsax.eye,
                                    color: CustomColor.primaryLightTextColor
                                        .withOpacity(.5),
                                  ),
                                  horizontalSpace(Dimensions.widthSize * .5),
                                  TitleHeading5Widget(
                                    text: Strings.showInvoice.tr,
                                    fontWeight: FontWeight.w500,
                                    color: CustomColor.primaryLightTextColor,
                                    opacity: .5,
                                  )
                                ],
                              ),
                            ),
                            const CustomDivider(),
                          ],
                        ),
                        Column(
                          children: [
                            InkWell(
                              onTap: onDownload,
                              child: Row(
                                mainAxisAlignment: mainCenter,
                                children: [
                                  Icon(
                                    Icons.download_for_offline_outlined,
                                    color: CustomColor.primaryLightTextColor
                                        .withOpacity(.5),
                                  ),
                                  horizontalSpace(Dimensions.widthSize * .5),
                                  TitleHeading5Widget(
                                    text: Strings.download.tr,
                                    fontWeight: FontWeight.w500,
                                    color: CustomColor.primaryLightTextColor,
                                    opacity: .5,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        Visibility(
                          visible: status != 'Paid'  && status != 'Draft',
                          child: Column(
                            children: [
                              const CustomDivider(),
                              InkWell(
                                onTap: onDeleteInvoice,
                                child: Row(
                                  mainAxisAlignment: mainCenter,
                                  children: [
                                    Icon(
                                      Icons.delete_outline_outlined,
                                      color: CustomColor.primaryLightTextColor
                                          .withOpacity(.5),
                                    ),
                                    horizontalSpace(Dimensions.widthSize * .5),
                                    TitleHeading5Widget(
                                      text: Strings.delete.tr,
                                      fontWeight: FontWeight.w500,
                                      color: CustomColor.primaryLightTextColor,
                                      opacity: .5,
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  )
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
      case 'Unpaid':
        return _customStatusWidget(color: CustomColor.redColor);
      case 'Paid':
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
          text: status,
          fontSize: Dimensions.headingTextSize5,
          fontWeight: FontWeight.w600,
          color: color,
        ),
      ],
    );
  }
}