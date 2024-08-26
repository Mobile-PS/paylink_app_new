import 'package:iconsax/iconsax.dart';

import '../../../../../widgets/inputs/custom_divider.dart';
import '../../utils/basic_screen_imports.dart';

class ProductLinkItemWidget extends StatelessWidget {
  const ProductLinkItemWidget({
    super.key,
    required this.status,
    required this.title,
    required this.amount,
    required this.onEditInvoice,
    required this.onDeleteInvoice,
    required this.onCopyInvoice,
    this.onStatusUpdate,
    this.onLinkList,
    required this.quantity,
  });

  final String status, title, amount, quantity;

  final VoidCallback? onEditInvoice;
  final VoidCallback? onDeleteInvoice;
  final VoidCallback? onCopyInvoice;
  final VoidCallback? onStatusUpdate;
  final VoidCallback? onLinkList;

  @override
  Widget build(BuildContext context) {
    bool isTablet() {
      return MediaQuery.of(context).size.shortestSide >= 600;
    }

    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(Dimensions.radius * 0.5),
        color: CustomColor.whiteColor,
      ),
      padding: EdgeInsets.symmetric(horizontal: Dimensions.widthSize),
      margin: EdgeInsets.symmetric(
          horizontal: Dimensions.widthSize,
          vertical: Dimensions.heightSize * 0.5),
      child: Row(
        children: [
          Expanded(
            flex: 13,
            child: Row(
              crossAxisAlignment: crossCenter,
              mainAxisAlignment: mainSpaceBet,
              children: [
                Row(
                  children: [
                    TitleHeading5Widget(
                      text: title,
                      fontWeight: FontWeight.w600,
                      fontSize: Dimensions.headingTextSize3,
                      color: CustomColor.blackColor,
                    ),
                    horizontalSpace(Dimensions.widthSize * 0.3),
                    TitleHeading5Widget(
                      maxLines: 1,
                      text: amount,
                      fontWeight: FontWeight.w600,
                      fontSize: Dimensions.headingTextSize3,
                      color: CustomColor.blackColor,
                    ),
                  ],
                ),
                TitleHeading5Widget(
                  maxLines: 1,
                  text: quantity,
                  fontWeight: FontWeight.w600,
                  fontSize: Dimensions.headingTextSize3,
                  color: CustomColor.blackColor,
                ),
                _statusWidget(context),
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
                        // visible: status != 'Paid' && status != 'Draft',
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
                          ],
                        ),
                      ),
                      Visibility(
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
    );
  }

  _statusWidget(BuildContext context) {
    return Card(
      elevation: 2,
      child: GestureDetector(
        onTap: onStatusUpdate,
        child: Row(
          children: [
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.widthSize,
                vertical: Dimensions.heightSize * 0.25,
              ),
              decoration: BoxDecoration(
                color: status == "Active"
                    ? CustomColor.primaryLightColor
                    : CustomColor.whiteColor,
                borderRadius: BorderRadius.only(
                  bottomLeft: Radius.circular(Dimensions.radius * 0.5),
                  topLeft: Radius.circular(Dimensions.radius * 0.5),
                ),
              ),
              child: TitleHeading5Widget(
                text: "Active",
                color: status == "Active"
                    ? CustomColor.whiteColor
                    : CustomColor.blackColor,
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(
                horizontal: Dimensions.widthSize,
                vertical: Dimensions.heightSize * 0.25,
              ),
              decoration: BoxDecoration(
                color: status == "Inactive"
                    ? CustomColor.primaryLightColor
                    : CustomColor.whiteColor,
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.circular(Dimensions.radius * 0.5),
                  topRight: Radius.circular(Dimensions.radius * 0.5),
                ),
              ),
              child: TitleHeading5Widget(
                text: "Inactive",
                color: status == "Inactive"
                    ? CustomColor.whiteColor
                    : CustomColor.blackColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
